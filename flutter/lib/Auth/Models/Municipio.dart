/// Município atendido. No Central real vem da lista de clientes.
class Municipio {
  const Municipio({required this.id, required this.nome, required this.nomeCurto, this.brasaoUrl});

  final String id;

  /// Ex.: "Prefeitura de Sinop", usado no painel de marca.
  final String nome;

  /// Ex.: "Sinop", usado no seletor.
  final String nomeCurto;

  /// URL do brasão. Vazio usa o brasão de exemplo dos assets.
  final String? brasaoUrl;

  factory Municipio.fromJson(Map<String, dynamic> json) => Municipio(
        id: '${json['id']}',
        nome: json['nome'] ?? '',
        nomeCurto: json['nomeCurto'] ?? json['nome'] ?? '',
        brasaoUrl: json['brasaoUrl'],
      );
}
