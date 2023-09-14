import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String name;
  final String email;
  final String phone;
  final String? uid;
  final List videos;
  final Timestamp createdAt;

  // final bool isPaid = false;

  UserModel(
      {required this.name,
      required this.email,
      required this.phone,
      this.uid,
      required this.videos,
      required this.createdAt
      // this.isPaid,
      });

  @override
  List<Object?> get props => [name, email, phone, uid, videos, createdAt]; // isPaid

  UserModel copyWith({String? name, String? email, String? phone, String? uid, List? videos, Timestamp? createdAt}) {
    return UserModel(
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      uid: uid ?? this.uid,
      videos: videos ?? this.videos,
      createdAt: createdAt ?? this.createdAt,
      // isPaid: isPaid ?? this.isPaid,
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      uid: json['uid'],
      videos: List<String>.from(json['videos']),
      createdAt: json['createdAt'],
      // isPaid: json['isPaid'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'uid': uid,
      'videos': videos,
      'createdAt': createdAt
      // 'isPaid': isPaid,
    };
  }
}
