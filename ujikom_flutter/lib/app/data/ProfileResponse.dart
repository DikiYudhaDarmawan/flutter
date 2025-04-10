class ProfileResponse {
  final bool success;
  final User user;

  ProfileResponse({required this.success, required this.user});

  factory ProfileResponse.fromJson(Map<String, dynamic> json) {
    return ProfileResponse(
      success: json['success'] ?? false,
      user:
          json.containsKey('user') ? User.fromJson(json['user']) : User.empty(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'user': user.toJson(),
    };
  }
}

class User {
  final int id;
  final String name;
  final String email;
  final String? emailVerifiedAt;
  final String role;
  final int status;
  final String createdAt;
  final String updatedAt;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.emailVerifiedAt,
    required this.role,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      emailVerifiedAt: json['email_verified_at'],
      role: json['role'] ?? 'siswa',
      status: json['status'] ?? 1,
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'email_verified_at': emailVerifiedAt,
      'role': role,
      'status': status,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  // Untuk menangani data kosong
  static User empty() {
    return User(
      id: 0,
      name: "Unknown",
      email: "Unknown",
      emailVerifiedAt: null,
      role: "Unknown",
      status: 0,
      createdAt: "",
      updatedAt: "",
    );
  }
}
