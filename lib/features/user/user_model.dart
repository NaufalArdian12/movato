class UserModel {
  final int id;
  final String name;
  final String email;
  final DateTime? emailVerifiedAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? avatarUrl;
  final String role;
  final DateTime? lastLoginAt;
  final bool isAdmin;
  final StudentProfile? studentProfile;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.emailVerifiedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.avatarUrl,
    required this.role,
    required this.lastLoginAt,
    required this.isAdmin,
    required this.studentProfile,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    DateTime? parseDate(dynamic v) {
      if (v == null) return null;
      try {
        return DateTime.parse(v.toString());
      } catch (_) {
        return null;
      }
    }

    return UserModel(
      id: (json['id'] is int) ? json['id'] : int.parse(json['id'].toString()),
      name: json['name']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      emailVerifiedAt: parseDate(json['email_verified_at']),
      createdAt: parseDate(json['created_at']) ?? DateTime.now(),
      updatedAt: parseDate(json['updated_at']) ?? DateTime.now(),
      avatarUrl: json['avatar_url'] as String?,
      role: json['role']?.toString() ?? '',
      lastLoginAt: parseDate(json['last_login_at']),
      isAdmin: json['is_admin'] == true || json['is_admin'] == 1,
      studentProfile: json['student_profile'] != null
          ? StudentProfile.fromJson(
              Map<String, dynamic>.from(json['student_profile']),
            )
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'email': email,
    'email_verified_at': emailVerifiedAt?.toIso8601String(),
    'created_at': createdAt.toIso8601String(),
    'updated_at': updatedAt.toIso8601String(),
    'avatar_url': avatarUrl,
    'role': role,
    'last_login_at': lastLoginAt?.toIso8601String(),
    'is_admin': isAdmin,
    'student_profile': studentProfile?.toJson(),
  };
}

class StudentProfile {
  final int? id;
  final int? userId;
  final int? gradeLevelId;
  final bool onboardingCompleted;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final GradeLevel? gradeLevel;

  StudentProfile({
    required this.id,
    required this.userId,
    required this.gradeLevelId,
    required this.onboardingCompleted,
    required this.createdAt,
    required this.updatedAt,
    required this.gradeLevel,
  });

  factory StudentProfile.fromJson(Map<String, dynamic> json) {
    DateTime? parseDate(dynamic v) {
      if (v == null) return null;
      try {
        return DateTime.parse(v.toString());
      } catch (_) {
        return null;
      }
    }

    int? parseInt(dynamic v) {
      if (v == null) return null;
      if (v is int) return v;
      try {
        return int.parse(v.toString());
      } catch (_) {
        return null;
      }
    }

    return StudentProfile(
      id: parseInt(json['id']),
      userId: parseInt(json['user_id']),
      gradeLevelId: parseInt(json['grade_level_id']),
      onboardingCompleted: json['onboarding_completed'] == true,
      createdAt: parseDate(json['created_at']),
      updatedAt: parseDate(json['updated_at']),
      gradeLevel: json['grade_level'] != null
          ? GradeLevel.fromJson(Map<String, dynamic>.from(json['grade_level']))
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'user_id': userId,
    'grade_level_id': gradeLevelId,
    'onboarding_completed': onboardingCompleted,
    'created_at': createdAt?.toIso8601String(),
    'updated_at': updatedAt?.toIso8601String(),
    'grade_level': gradeLevel?.toJson(),
  };
}

class GradeLevel {
  final int? id;
  final int? subjectId;
  final int? gradeNo;
  final String? name;
  final String? description;
  final int? orderIndex;
  final bool? isActive;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  GradeLevel({
    required this.id,
    required this.subjectId,
    required this.gradeNo,
    required this.name,
    required this.description,
    required this.orderIndex,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  factory GradeLevel.fromJson(Map<String, dynamic> json) {
    DateTime? parseDate(dynamic v) {
      if (v == null) return null;
      try {
        return DateTime.parse(v.toString());
      } catch (_) {
        return null;
      }
    }

    int? parseInt(dynamic v) {
      if (v == null) return null;
      if (v is int) return v;
      try {
        return int.parse(v.toString());
      } catch (_) {
        return null;
      }
    }

    return GradeLevel(
      id: parseInt(json['id']),
      subjectId: parseInt(json['subject_id']),
      gradeNo: parseInt(json['grade_no']),
      name: json['name']?.toString(),
      description: json['description']?.toString(),
      orderIndex: parseInt(json['order_index']),
      isActive: json['is_active'] == true || json['is_active'] == 1,
      createdAt: parseDate(json['created_at']),
      updatedAt: parseDate(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'subject_id': subjectId,
    'grade_no': gradeNo,
    'name': name,
    'description': description,
    'order_index': orderIndex,
    'is_active': isActive,
    'created_at': createdAt?.toIso8601String(),
    'updated_at': updatedAt?.toIso8601String(),
  };
}
