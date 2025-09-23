class User {
  final String id;
  final String email;
  final String fullName;
  final String? profileImageUrl;
  final UserRole role;
  final DateTime createdAt;
  final DateTime? updatedAt;

  User({
    required this.id,
    required this.email,
    required this.fullName,
    this.profileImageUrl,
    required this.role,
    required this.createdAt,
    this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      fullName: json['full_name'],
      profileImageUrl: json['profile_image_url'],
      role: UserRole.values.firstWhere(
        (e) => e.toString().split('.').last == json['role'],
      ),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: json['updated_at'] != null 
          ? DateTime.parse(json['updated_at']) 
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'full_name': fullName,
      'profile_image_url': profileImageUrl,
      'role': role.toString().split('.').last,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  User copyWith({
    String? id,
    String? email,
    String? fullName,
    String? profileImageUrl,
    UserRole? role,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      fullName: fullName ?? this.fullName,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      role: role ?? this.role,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

enum UserRole {
  ngoAdministrator,
  volunteer,
  serviceSeeker,
}

extension UserRoleExtension on UserRole {
  String get displayName {
    switch (this) {
      case UserRole.ngoAdministrator:
        return 'NGO Administrator';
      case UserRole.volunteer:
        return 'Volunteer';
      case UserRole.serviceSeeker:
        return 'Service Seeker';
    }
  }
}
