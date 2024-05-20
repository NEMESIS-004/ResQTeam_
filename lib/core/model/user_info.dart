// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cloud_firestore/cloud_firestore.dart';

class UserInfo {
  final String id;
  final String name;
  final String email;
  final int buildNumber;

  UserInfo({
    required this.id,
    required this.name,
    required this.email,
    required this.buildNumber,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'buildNumber': buildNumber,
    };
  }

  factory UserInfo.fromFireStore(DocumentSnapshot doc) {
    final map = doc.data() as Map<String, dynamic>;
    return UserInfo(
      id: doc.id,
      name: map['name'] as String,
      email: map['email'] as String,
      buildNumber: map['buildNumber'] as int,
    );
  }

  UserInfo copyWith({
    String? id,
    String? name,
    String? email,
    int? buildNumber,
    DateTime? createdAt,
  }) {
    return UserInfo(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      buildNumber: buildNumber ?? this.buildNumber,
    );
  }
}
