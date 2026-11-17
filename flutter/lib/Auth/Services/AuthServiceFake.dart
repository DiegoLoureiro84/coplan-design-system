import 'package:central_web/Auth/Models/Municipio.dart';
import 'package:central_web/Auth/Models/Sessao.dart';
import 'package:central_web/Auth/Services/AuthService.dart';

/// Implementação de exemplo, com o mesmo comportamento do protótipo:
/// qualquer CPF/CNPJ válido com senha de 4 ou mais caracteres entra.
/// Remover quando a API real existir.
class AuthServiceFake implements AuthService {
  int _tentativas = 5;

  @override
  Future<List<Municipio>> listarMunicipios() async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    return const [
      Municipio(id: 'sinop', nome: 'Prefeitura de Sinop', nomeCurto: 'Sinop'),
      Municipio(id: 'cuiaba', nome: 'Prefeitura de Cuiabá', nomeCurto: 'Cuiabá'),
      Municipio(id: 'diamantino', nome: 'Prefeitura de Diamantino', nomeCurto: 'Diamantino'),
    ];
  }

  @override
  Future<Sessao> entrar({required String municipioId, required String documento, required String senha}) async {
    await Future<void>.delayed(const Duration(milliseconds: 700));
    if (senha.length < 4) {
      _tentativas--;
      throw FalhaLogin('Senha incorreta.', tentativasRestantes: _tentativas);
    }
    _tentativas = 5;
    return Sessao(token: 'token-de-exemplo', nomeUsuario: 'Diego Loureiro', documento: documento);
  }

  @override
  Future<void> enviarLinkRecuperacao({required String municipioId, required String documento}) async {
    await Future<void>.delayed(const Duration(milliseconds: 500));
  }
}
