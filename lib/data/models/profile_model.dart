class Profile {
  final String? email;
  final String? username;
  final String? name;
  final String? birthday;
  final String? gender;
  final String? horoscope;
  final int? height;
  final int? weight;
  final List<String>? interests;

  Profile({
    this.email,
    this.username,
    this.name,
    this.birthday,
    this.gender,
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
      gender: data['gender'],
      horoscope: data['horoscope'],
      height: data['height'],
      weight: data['weight'],
      interests: (data['interests'] as List<dynamic>?)?.map((e) => e.toString()).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'birthday': birthday,
      'horoscope': horoscope,
      'height': height,
      'weight': weight,
    };
  }
}