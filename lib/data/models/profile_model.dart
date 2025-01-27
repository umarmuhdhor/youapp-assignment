class Profile {
  final String? email;
  final String? username;
  final String? name;
  final String? birthday;
  final String? horoscope;
  final int? height;
  final int? weight;
  final List<String>? interests;

  Profile({
    this.email,
    this.username,
    this.name,
    this.birthday,
    this.horoscope,
    this.height,
    this.weight,
    this.interests,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>;
    
    return Profile(
      email: data['email'],
      username: data['username'],
      name: data['name'],
      birthday: data['birthday'],
      horoscope: data['horoscope'],
      height: data['height'],
      weight: data['weight'],
      interests: (data['interests'] as List<dynamic>?)?.map((e) => e.toString()).toList(),
    );
  }
}