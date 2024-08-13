import 'package:share_your_route_front/modules/shared/providers/api_provider.dart';

class UserData {
  final String id;
  final String bio;
  final String backgroundPhoto;
  final String profilePhoto;

  UserData({
    required this.id,
    required this.bio,
    required this.backgroundPhoto,
    required this.profilePhoto,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
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

  static Future<UserData> getUserById(String userId) async {
    final userData = await getUserData(userId) as Map<String, dynamic>;
    return UserData.fromJson(userData);
  }
}
