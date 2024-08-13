import 'package:share_your_route_front/modules/shared/providers/api_provider.dart';

class UserData {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String bio;
  final String backgroundPhoto;
  final String profilePhoto;

  UserData({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.bio,
    required this.backgroundPhoto,
    required this.profilePhoto,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['id'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      email: json['email'] as String,
      bio: json['bio'] as String,
      backgroundPhoto: json['backgroundPhoto'] as String,
      profilePhoto: json['profilePhoto'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'bio': bio,
      'backgroundPhoto': backgroundPhoto,
      'profilePhoto': profilePhoto,
    };
  }

  static Future<UserData> getUserById(String userId) async {
    final userData = await getUserData(userId) as Map<String, dynamic>;
    return UserData.fromJson(userData);
  }
}
