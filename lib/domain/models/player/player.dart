class PlayerModel {
  final int? id;
  final String email;
  final String name;
  final String nickname;
  final String position;

  PlayerModel({
    this.id,
    required this.email,
    required this.name,
    required this.position,
    required this.nickname,
  });

  factory PlayerModel.fromJson(Map<String, dynamic> json) => PlayerModel(
        id: int.parse(json['id'] ?? '0'),
        position: json['position'],
        email: json['email'],
        name: json['name'],
        nickname: json['nickname'],
      );
}
