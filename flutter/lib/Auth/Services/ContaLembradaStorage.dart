import 'package:shared_preferences/shared_preferences.dart';

import 'package:central_web/Auth/Models/ContaLembrada.dart';

/// Guarda a conta lembrada neste navegador (shared_preferences, que no web
/// usa o localStorage), com o prefixo "central_", como o StorageService dos
/// portais faz com "fornecedor_".
///
/// Grava SÓ nome e documento. Diferente dos portais atuais, a senha nunca é
/// guardada no navegador, nem cifrada: o atalho preenche o CPF e o usuário
/// digita a senha (ou o gerenciador de senhas do navegador preenche).
class ContaLembradaStorage {
  static const _kNome = 'central_conta_nome';
  static const _kDocumento = 'central_conta_documento';

  Future<ContaLembrada?> ler() async {
    final prefs = await SharedPreferences.getInstance();
    final nome = prefs.getString(_kNome);
    final documento = prefs.getString(_kDocumento);
    if (nome == null || documento == null || documento.isEmpty) return null;
    return ContaLembrada(nome: nome, documento: documento);
  }

  Future<void> salvar(ContaLembrada conta) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kNome, conta.nome);
    await prefs.setString(_kDocumento, conta.documento);
  }

  Future<void> limpar() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_kNome);
    await prefs.remove(_kDocumento);
  }
}
