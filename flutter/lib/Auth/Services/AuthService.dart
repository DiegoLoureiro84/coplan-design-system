import 'package:central_web/Auth/Models/Municipio.dart';
import 'package:central_web/Auth/Models/Sessao.dart';

/// Contrato de autenticação do Central.
///
/// A tela depende só desta interface. O backend implementa a versão real
/// (ex.: AuthServiceApi usando o BaseService e os endpoints Ws_ do padrão
/// Coplan) e troca no LoginBinding, sem mexer em controller nem página.
abstract class AuthService {
  Future<List<Municipio>> listarMunicipios();

  /// Lança [FalhaLogin] quando o CPF/CNPJ ou a senha não conferem.
  Future<Sessao> entrar({required String municipioId, required String documento, required String senha});

  Future<void> enviarLinkRecuperacao({required String municipioId, required String documento});
}

class FalhaLogin implements Exception {
  const FalhaLogin(this.mensagem, {this.tentativasRestantes});

  final String mensagem;
  final int? tentativasRestantes;
}
