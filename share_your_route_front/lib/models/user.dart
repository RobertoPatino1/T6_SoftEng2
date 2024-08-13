class User {
  final String id;
  final String bio;
  final String backgroundPhoto;
  final String profilePhoto;

  User({
    required this.id,
    required this.bio,
    required this.backgroundPhoto,
    required this.profilePhoto,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      bio: json['bio'] as String,
      backgroundPhoto: json['backgroundPhoto'] as String,
      profilePhoto: json['profilePhoto'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'bio': bio,
      'backgroundPhoto': backgroundPhoto,
      'profilePhoto': profilePhoto,
    };
  }
}
