class Profile {
  final String? name;
  final String? gender;
  final String? birthday;
  final String? horoscope;
  final String? zodiac;
  final int? height;
  final int? weight;
  final List<String>? interests;
  final String? image;

  Profile({
    this.name,
    this.gender,
    this.birthday,
    this.horoscope,
    this.zodiac,
    this.height,
    this.weight,
    this.interests,
    this.image,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      name: json['name'],
      gender: json['gender'],
      birthday: json['birthday'],
      horoscope: json['horoscope'],
      zodiac: json['zodiac'],
      height: json['height'],
      weight: json['weight'],
      interests: List<String>.from(json['interests'] ?? []),
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'gender': gender,
      'birthday': birthday,
      'horoscope': horoscope,
      'zodiac': zodiac,
      'height': height,
      'weight': weight,
      'interests': interests,
      'image': image,
    };
  }
}