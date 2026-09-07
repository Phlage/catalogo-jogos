/// Modelo de domínio: representa um jogo na coleção pessoal.
class Game {
  final String id;
  String title;
  String platform;
  double rating; // 0.0 a 10.0
  String status; // "Quero jogar", "Jogando", "Concluído"
  String notes;

  Game({
    required this.id,
    required this.title,
    required this.platform,
    required this.rating,
    required this.status,
    this.notes = '',
  });

  Game copyWith({
    String? title,
    String? platform,
    double? rating,
    String? status,
    String? notes,
  }) {
    return Game(
      id: id,
      title: title ?? this.title,
      platform: platform ?? this.platform,
      rating: rating ?? this.rating,
      status: status ?? this.status,
      notes: notes ?? this.notes,
    );
  }
}

/// Opções fixas usadas no formulário (dropdowns), evitando strings soltas
/// espalhadas pela UI.
const List<String> kPlatforms = [
  'PC',
  'PlayStation',
  'Xbox',
  'Nintendo Switch',
  'Mobile',
];

const List<String> kStatuses = [
  'Quero jogar',
  'Jogando',
  'Concluído',
];
