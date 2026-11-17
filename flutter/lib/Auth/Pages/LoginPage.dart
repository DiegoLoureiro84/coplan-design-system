import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:central_web/Auth/Components/ContaLembradaComponent.dart';
import 'package:central_web/Auth/Components/PainelMarcaComponent.dart';
import 'package:central_web/Auth/Components/SeletorMunicipioComponent.dart';
import 'package:central_web/Auth/Controllers/LoginController.dart';
import 'package:central_web/Compartilhado/AppColors.dart';
import 'package:central_web/Compartilhado/AppIcons.dart';
import 'package:central_web/Compartilhado/AppTheme.dart';
import 'package:central_web/Compartilhado/Components/BotaoComponent.dart';
import 'package:central_web/Compartilhado/Components/CampoComponent.dart';
import 'package:central_web/Compartilhado/Components/DivisorTextoComponent.dart';
import 'package:central_web/Compartilhado/Utils/DocumentoUtils.dart';

/// Tela de login. Referência visual:
/// https://diegoloureiro84.github.io/prototipo-central/#login
///
/// Desktop: painel de marca (11/21 da largura) + formulário (10/21).
/// Abaixo de 899px: só o topo do painel, formulário embaixo.
class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final controller = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    // Title define o título da aba do navegador.
    return Title(
      title: 'Entrar · Coplan',
      color: AppColors.primary,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: LayoutBuilder(
          builder: (context, c) {
            final compacto = c.maxWidth <= AppLayout.bpTablet;
            final painel = Obx(() => PainelMarcaComponent(municipio: controller.municipio.value, compacto: compacto));

            if (compacto) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [painel, _LadoFormulario(controller: controller, rolavel: false)],
                ),
              );
            }
            return Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(flex: 11, child: painel),
                Expanded(flex: 10, child: _LadoFormulario(controller: controller, rolavel: true)),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _LadoFormulario extends StatelessWidget {
  const _LadoFormulario({required this.controller, required this.rolavel});

  final LoginController controller;
  final bool rolavel;

  @override
  Widget build(BuildContext context) {
    final conteudo = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: Obx(
            () => controller.recuperandoSenha.value
                ? _RecuperarSenha(controller: controller)
                : _Formulario(controller: controller),
          ),
        ),
      ),
    );

    return Container(
      color: AppColors.background,
      child: rolavel
          ? Center(child: SingleChildScrollView(child: conteudo))
          : conteudo,
    );
  }
}

class _Formulario extends StatelessWidget {
  const _Formulario({required this.controller});

  final LoginController controller;

  @override
  Widget build(BuildContext context) {
    return AutofillGroup(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text('Entrar', style: AppText.loginTitle),
          const SizedBox(height: 4),
          const Text('Use sua conta para acessar os sistemas.', style: AppText.subtitle),
          const SizedBox(height: 24),

          Obx(() {
            final conta = controller.contaLembrada.value;
            if (conta == null || !controller.mostrarContaLembrada.value) return const SizedBox.shrink();
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ContaLembradaComponent(conta: conta, onTap: controller.usarContaLembrada),
                const SizedBox(height: 20),
                const DivisorTextoComponent(texto: 'ou entre com outra conta'),
                const SizedBox(height: 20),
              ],
            );
          }),

          Obx(() => SeletorMunicipioComponent(
                municipios: controller.municipios.toList(),
                selecionado: controller.municipio.value,
                onSelecionar: controller.selecionarMunicipio,
              )),
          const SizedBox(height: 16),

          Obx(() => CampoComponent(
                rotulo: 'CPF ou CNPJ',
                controller: controller.documentoController,
                focusNode: controller.documentoFocus,
                icone: AppIcons.user,
                placeholder: '000.000.000-00',
                keyboardType: TextInputType.number,
                inputFormatters: [DocumentoInputFormatter()],
                autofillHints: const [AutofillHints.username],
                textInputAction: TextInputAction.next,
                valido: controller.documentoValido.value,
                erro: controller.erroDocumento.value,
                onChanged: controller.aoDigitarDocumento,
                onSubmitted: (_) => controller.senhaFocus.requestFocus(),
              )),
          const SizedBox(height: 16),

          // O Focus de fora escuta as teclas para detectar o Caps Lock.
          Focus(
            canRequestFocus: false,
            skipTraversal: true,
            onKeyEvent: (_, __) {
              controller.atualizarCapsLock();
              return KeyEventResult.ignored;
            },
            child: Obx(() => CampoComponent(
                  rotulo: 'Senha',
                  controller: controller.senhaController,
                  focusNode: controller.senhaFocus,
                  icone: AppIcons.lock,
                  placeholder: 'Digite sua senha',
                  obscureText: !controller.senhaVisivel.value,
                  autofillHints: const [AutofillHints.password],
                  textInputAction: TextInputAction.done,
                  aviso: controller.capsLock.value ? 'Caps Lock está ativado' : null,
                  erro: controller.erroSenha.value,
                  onChanged: controller.aoDigitarSenha,
                  onSubmitted: (_) => controller.entrar(),
                  sufixo: _BotaoOlho(
                    visivel: controller.senhaVisivel.value,
                    onTap: controller.alternarSenhaVisivel,
                  ),
                )),
          ),
          const SizedBox(height: 12),

          // Wrap: em telas estreitas o link desce para a linha de baixo.
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 12,
            runSpacing: 10,
            children: [
              Obx(() => _CheckLembrar(
                    marcado: controller.lembrarDispositivo.value,
                    onChanged: (v) => controller.lembrarDispositivo.value = v,
                  )),
              LinkComponent(texto: 'Esqueci minha senha', onPressed: controller.abrirRecuperacao),
            ],
          ),
          const SizedBox(height: 20),

          Obx(() => BotaoComponent(
                texto: 'Entrar',
                textoCarregando: 'Entrando...',
                icone: AppIcons.logIn,
                larguraTotal: true,
                carregando: controller.carregando.value,
                onPressed: controller.entrar,
              )),
          const SizedBox(height: 20),

          const DivisorTextoComponent(texto: 'outras formas de acesso'),
          const SizedBox(height: 20),

          // Abaixo de 600px os dois botões ficam um embaixo do outro, como no protótipo.
          LayoutBuilder(builder: (context, c) {
            final certificado = BotaoComponent(
              texto: 'Certificado digital',
              icone: AppIcons.usb,
              variante: VarianteBotao.contorno,
              raio: 6,
              larguraTotal: true,
              onPressed: () => controller.entrarCom('Certificado Digital'),
            );
            final govBr = BotaoComponent(
              texto: 'gov.br',
              icone: AppIcons.landmark,
              variante: VarianteBotao.contorno,
              raio: 6,
              larguraTotal: true,
              onPressed: () => controller.entrarCom('gov.br'),
            );
            if (MediaQuery.sizeOf(context).width < AppLayout.bpPhone + 1) {
              return Column(children: [certificado, const SizedBox(height: 10), govBr]);
            }
            return Row(
              children: [
                Expanded(child: certificado),
                const SizedBox(width: 10),
                Expanded(child: govBr),
              ],
            );
          }),
          const SizedBox(height: 28),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('© 2026 Coplan Tecnologia · ', style: AppText.hint),
              LinkComponent(texto: 'Política de Privacidade', tamanho: 12, onPressed: () {}),
            ],
          ),
        ],
      ),
    );
  }
}

/// Recuperar senha no lugar do formulário. O Design System não usa janela modal.
class _RecuperarSenha extends StatelessWidget {
  const _RecuperarSenha({required this.controller});

  final LoginController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text('Recuperar senha', style: AppText.loginTitle),
        const SizedBox(height: 4),
        const Text('Enviaremos um link para o e-mail cadastrado no CPF informado.', style: AppText.subtitle),
        const SizedBox(height: 24),
        Obx(() => CampoComponent(
              rotulo: 'CPF',
              controller: controller.documentoController,
              icone: AppIcons.user,
              placeholder: '000.000.000-00',
              keyboardType: TextInputType.number,
              inputFormatters: [DocumentoInputFormatter()],
              valido: controller.documentoValido.value,
              erro: controller.erroDocumento.value,
              onChanged: controller.aoDigitarDocumento,
              onSubmitted: (_) => controller.enviarLinkRecuperacao(),
            )),
        const SizedBox(height: 20),
        Obx(() => BotaoComponent(
              texto: 'Enviar link',
              textoCarregando: 'Enviando...',
              icone: AppIcons.send,
              larguraTotal: true,
              carregando: controller.enviandoLink.value,
              onPressed: controller.enviarLinkRecuperacao,
            )),
        const SizedBox(height: 10),
        BotaoComponent(
          texto: 'Voltar para o login',
          icone: AppIcons.arrowLeft,
          variante: VarianteBotao.cinza,
          larguraTotal: true,
          onPressed: controller.fecharRecuperacao,
        ),
      ],
    );
  }
}

class _BotaoOlho extends StatelessWidget {
  const _BotaoOlho({required this.visivel, required this.onTap});

  final bool visivel;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: visivel ? 'Ocultar senha' : 'Mostrar senha',
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: onTap,
          child: SizedBox(
            width: 32,
            height: 32,
            child: Icon(visivel ? AppIcons.eyeOff : AppIcons.eye, size: 18, color: AppColors.mutedForeground),
          ),
        ),
      ),
    );
  }
}

class _CheckLembrar extends StatelessWidget {
  const _CheckLembrar({required this.marcado, required this.onChanged});

  final bool marcado;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => onChanged(!marcado),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 16,
              height: 16,
              child: Checkbox(
                value: marcado,
                onChanged: (v) => onChanged(v ?? false),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                visualDensity: VisualDensity.compact,
              ),
            ),
            const SizedBox(width: 8),
            Text('Lembrar este dispositivo', style: AppText.body.copyWith(color: AppColors.secondaryForeground)),
          ],
        ),
      ),
    );
  }
}
