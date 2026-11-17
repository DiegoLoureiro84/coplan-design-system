import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import 'package:central_web/Auth/Models/ContaLembrada.dart';
import 'package:central_web/Auth/Models/Municipio.dart';
import 'package:central_web/Auth/Services/AuthService.dart';
import 'package:central_web/Auth/Services/ContaLembradaStorage.dart';
import 'package:central_web/Compartilhado/Components/ToastComponent.dart';
import 'package:central_web/Compartilhado/Rotas/AppRotas.dart';
import 'package:central_web/Compartilhado/Utils/DocumentoUtils.dart';

/// Estado e regras da tela de login. A página só desenha o que está aqui.
///
/// Regras (iguais ao protótipo, passo 1 do roteiro):
/// - CPF ou CNPJ com máscara automática e validação dos dígitos.
/// - Erro do documento aparece ao sair do campo ou ao tentar entrar.
/// - Senha vazia: "Informe sua senha." Senha recusada: informa as tentativas.
/// - Caps Lock ligado mostra aviso (não bloqueia).
/// - "Lembrar este dispositivo" guarda nome e documento, nunca a senha.
/// - Recuperar senha é inline, no lugar do formulário (sem janela modal).
class LoginController extends GetxController {
  LoginController({required AuthService service, required ContaLembradaStorage storage})
      : _service = service,
        _storage = storage;

  final AuthService _service;
  final ContaLembradaStorage _storage;

  final documentoController = TextEditingController();
  final senhaController = TextEditingController();
  final documentoFocus = FocusNode();
  final senhaFocus = FocusNode();

  final municipios = <Municipio>[].obs;
  final municipio = Rxn<Municipio>();

  final contaLembrada = Rxn<ContaLembrada>();
  final mostrarContaLembrada = true.obs;

  final documentoValido = false.obs;
  final erroDocumento = RxnString();
  final erroSenha = RxnString();
  final capsLock = false.obs;
  final senhaVisivel = false.obs;
  final lembrarDispositivo = true.obs;
  final carregando = false.obs;

  final recuperandoSenha = false.obs;
  final enviandoLink = false.obs;

  @override
  void onInit() {
    super.onInit();
    documentoFocus.addListener(() {
      if (!documentoFocus.hasFocus) _validarDocumentoAoSair();
    });
    _carregarContaLembrada();
    _carregarMunicipios();
  }

  Future<void> _carregarContaLembrada() async {
    contaLembrada.value = await _storage.ler();
    mostrarContaLembrada.value = contaLembrada.value != null;
  }

  Future<void> _carregarMunicipios() async {
    final lista = await _service.listarMunicipios();
    municipios.assignAll(lista);
    municipio.value ??= lista.isNotEmpty ? lista.first : null;
  }

  void selecionarMunicipio(Municipio m) => municipio.value = m;

  // ---------- documento ----------

  void aoDigitarDocumento(String valor) {
    final digitos = DocumentoUtils.somenteDigitos(valor);
    documentoValido.value = DocumentoUtils.documentoValido(digitos);
    if (documentoValido.value || digitos.length < 11) erroDocumento.value = null;
  }

  void _validarDocumentoAoSair() {
    final digitos = DocumentoUtils.somenteDigitos(documentoController.text);
    if (digitos.isEmpty) return;
    erroDocumento.value =
        DocumentoUtils.documentoValido(digitos) ? null : 'CPF ou CNPJ inválido. Confira os números.';
  }

  void usarContaLembrada() {
    final conta = contaLembrada.value;
    if (conta == null) return;
    mostrarContaLembrada.value = false;
    documentoController.text = DocumentoUtils.mascarar(conta.documento);
    aoDigitarDocumento(documentoController.text);
    senhaFocus.requestFocus();
  }

  // ---------- senha ----------

  void aoDigitarSenha(String _) => erroSenha.value = null;

  void alternarSenhaVisivel() => senhaVisivel.toggle();

  /// Chamado a cada tecla no campo de senha.
  void atualizarCapsLock() {
    capsLock.value = HardwareKeyboard.instance.lockModesEnabled.contains(KeyboardLockMode.capsLock);
  }

  // ---------- entrar ----------

  Future<void> entrar() async {
    if (carregando.value) return;

    final documento = DocumentoUtils.somenteDigitos(documentoController.text);
    final senha = senhaController.text;
    var invalido = false;

    if (!DocumentoUtils.documentoValido(documento)) {
      erroDocumento.value = 'Informe um CPF ou CNPJ válido.';
      invalido = true;
    }
    if (senha.isEmpty) {
      erroSenha.value = 'Informe sua senha.';
      invalido = true;
    }
    if (invalido) {
      ToastComponent.show(title: 'Não foi possível entrar', message: 'Revise os campos destacados.', type: ToastType.error);
      return;
    }

    carregando.value = true;
    try {
      final sessao = await _service.entrar(
        municipioId: municipio.value?.id ?? '',
        documento: documento,
        senha: senha,
      );
      if (lembrarDispositivo.value) {
        await _storage.salvar(ContaLembrada(nome: sessao.nomeUsuario, documento: documento));
      } else {
        await _storage.limpar();
      }
      // TODO: guardar a sessão (token) no storage padrão do projeto.
      // Navegação web (Navigator 2.0), igual aos portais: Get.rootDelegate.
      Get.rootDelegate.offNamed(AppRotas.sistemas);
    } on FalhaLogin catch (falha) {
      final restantes = falha.tentativasRestantes;
      erroSenha.value = restantes == null
          ? falha.mensagem
          : '${falha.mensagem} Você tem mais $restantes ${restantes == 1 ? 'tentativa' : 'tentativas'}.';
      ToastComponent.show(title: 'Não foi possível entrar', message: 'Revise os campos destacados.', type: ToastType.error);
    } finally {
      carregando.value = false;
    }
  }

  /// Certificado digital e gov.br. O protótipo só simula o redirecionamento.
  void entrarCom(String metodo) {
    ToastComponent.show(title: 'Redirecionando', message: 'Abrindo o acesso por $metodo...', type: ToastType.info);
    // TODO: integrar com o login unificado do Central (certificado A1 e gov.br).
  }

  // ---------- recuperar senha (inline) ----------

  void abrirRecuperacao() {
    erroDocumento.value = null;
    recuperandoSenha.value = true;
  }

  void fecharRecuperacao() => recuperandoSenha.value = false;

  Future<void> enviarLinkRecuperacao() async {
    final documento = DocumentoUtils.somenteDigitos(documentoController.text);
    if (!DocumentoUtils.documentoValido(documento)) {
      erroDocumento.value = 'Informe um CPF ou CNPJ válido.';
      return;
    }
    enviandoLink.value = true;
    try {
      await _service.enviarLinkRecuperacao(municipioId: municipio.value?.id ?? '', documento: documento);
      // O e-mail mascarado deve vir da API. Texto igual ao protótipo.
      ToastComponent.show(title: 'Link enviado', message: 'Confira a caixa de entrada de d***@exemplo.gov.br.', type: ToastType.success);
      recuperandoSenha.value = false;
    } finally {
      enviandoLink.value = false;
    }
  }

  @override
  void onClose() {
    documentoController.dispose();
    senhaController.dispose();
    documentoFocus.dispose();
    senhaFocus.dispose();
    super.onClose();
  }
}
