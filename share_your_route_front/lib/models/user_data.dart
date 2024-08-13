class UserData {
  final String firstName;
  final String lastName;
  final String email;
  final String bio;
  final String backgroundPhoto;
  final String profilePhoto;

  UserData({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.bio,
    required this.backgroundPhoto,
    required this.profilePhoto,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      firstName: (json['firstName'] != null) ? json['firstName'] as String : '',
      lastName: (json['lastName'] != null) ? json['lastName'] as String : '',
      email: (json['email'] != null) ? json['email'] as String : '',
      bio: (json['bio'] != null) ? json['bio'] as String : '',
      backgroundPhoto: (json['backgroundPhoto'] != null) ? json['backgroundPhoto'] as String : '',
      profilePhoto: (json['profilePhoto'] != null) ? json['profilePhoto'] as String : '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'bio': bio,
      'backgroundPhoto': backgroundPhoto,
      'profilePhoto': profilePhoto,
    };
  }
}
