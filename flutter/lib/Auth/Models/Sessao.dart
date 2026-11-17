/// Resultado de um login bem-sucedido.
class Sessao {
  const Sessao({required this.token, required this.nomeUsuario, required this.documento});

  final String token;
  final String nomeUsuario;
  final String documento;
}
