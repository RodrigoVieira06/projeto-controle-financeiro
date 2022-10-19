class Profile {
  final String? email;
  final String? nome;
  final String? uid;

  Profile({
    this.email,
    this.nome,
    this.uid,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      email: json['email'],
      nome: json['nome'],
      uid: json['uid'],
    );
  }
}
