/// Conta salva neste navegador quando o usuário marca "Lembrar este dispositivo".
/// Guardar só o necessário para exibir o atalho: nunca a senha.
class ContaLembrada {
  const ContaLembrada({required this.nome, required this.documento});

  final String nome;

  /// CPF ou CNPJ só com dígitos.
  final String documento;

  /// "DL" para "Diego Loureiro".
  String get iniciais {
    final partes = nome.trim().split(RegExp(r'\s+'));
    if (partes.isEmpty || partes.first.isEmpty) return '';
    final primeira = partes.first[0];
    final ultima = partes.length > 1 ? partes.last[0] : '';
    return (primeira + ultima).toUpperCase();
  }
}
