import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:mobile/models/hotspot_model.dart';

class UserModel extends Equatable {
  const UserModel({
    this.hotspot,
    this.permissions,
    this.name,
    this.phone,
    this.createAt,
    this.updateAt,
    this.emailVerification,
    this.phoneVerification,
    this.status,
    this.registrationDate,
    this.accessedAt,
    this.email,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.databaseId,
    this.collectionId,
  });

  factory UserModel.fromJson(String str) => UserModel.fromMap(
        json.decode(str) as Map<String, dynamic>,
      );

  factory UserModel.fromMap(Map<String, dynamic> json) => UserModel(
        name: json['name'] as String?,
        phone: json['phone'] as String?,
        createAt: json['createAt'] as String?,
        updateAt: json['updateAt'] as String?,
        emailVerification: json['emailVerification'] as bool?,
        phoneVerification: json['phoneVerification'] as bool?,
        status: json['status'] as bool?,
        registrationDate: json['registrationDate'] as String?,
        accessedAt: json['accessedAt'] as String?,
        email: json['email'] as String?,
        id: json[r'$id'] as String?,
        createdAt: json[r'$createdAt'] as String?,
        updatedAt: json[r'$updatedAt'] as String?,
        hotspot: (json['hotspot'] as List<dynamic>?)
                ?.map(
                  (item) => HotspotModel.fromMap(item as Map<String, dynamic>),
                )
                .toList() ??
            [],
        // permissions: List<String>.from(json['\$permissions'] ?? []),
        databaseId: json[r'$databaseId'] as String?,
        collectionId: json[r'$collectionId'] as String?,
      );
  final String? name;
  final String? phone;
  final String? createAt;
  final String? updateAt;
  final bool? emailVerification;
  final bool? phoneVerification;
  final bool? status;
  final String? registrationDate;
  final String? accessedAt;
  final String? email;
  final String? id;
  final String? createdAt;
  final String? updatedAt;
  final List<HotspotModel>? hotspot;
  final List<String>? permissions;
  final String? databaseId;
  final String? collectionId;

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        'name': name,
        'phone': phone,
        'createAt': createAt,
        'updateAt': updateAt,
        'emailVerification': emailVerification,
        'phoneVerification': phoneVerification,
        'status': status,
        'registrationDate': registrationDate,
        'accessedAt': accessedAt,
        'email': email,
        r'$id': id,
        r'$createdAt': createdAt,
        r'$updatedAt': updatedAt,
        'hotspot': hotspot!.map((e) => e.toMap()).toList(),
        r'$permissions': permissions,
        r'$databaseId': databaseId,
        r'$collectionId': collectionId,
      };

  UserModel copyWith({
    String? name,
    String? phone,
    String? createAt,
    String? updateAt,
    bool? emailVerification,
    bool? phoneVerification,
    bool? status,
    String? registrationDate,
    String? accessedAt,
    String? email,
    String? id,
    String? createdAt,
    String? updatedAt,
    List<HotspotModel>? hotspot,
    List<String>? permissions,
    String? databaseId,
    String? collectionId,
  }) {
    return UserModel(
      name: name ?? this.name,
      phone: phone ?? this.phone,
      createAt: createAt ?? this.createAt,
      updateAt: updateAt ?? this.updateAt,
      emailVerification: emailVerification ?? this.emailVerification,
      phoneVerification: phoneVerification ?? this.phoneVerification,
      status: status ?? this.status,
      registrationDate: registrationDate ?? this.registrationDate,
      accessedAt: accessedAt ?? this.accessedAt,
      email: email ?? this.email,
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      hotspot: hotspot ?? this.hotspot,
      permissions: permissions ?? this.permissions,
      databaseId: databaseId ?? this.databaseId,
      collectionId: collectionId ?? this.collectionId,
    );
  }

  @override
  List<Object?> get props {
    return [
      name,
      phone,
      createAt,
      updateAt,
      emailVerification,
      phoneVerification,
      status,
      registrationDate,
      accessedAt,
      email,
      id,
      createdAt,
      updatedAt,
      hotspot,
      permissions,
      databaseId,
      collectionId,
    ];
  }

  @override
  String toString() {
    return 'UserModel {'
        ' name: $name,'
        ' phone: $phone,'
        ' createAt: $createAt,'
        ' updateAt: $updateAt,'
        ' emailVerification: $emailVerification,'
        ' phoneVerification: $phoneVerification,'
        ' status: $status,'
        ' registrationDate: $registrationDate,'
        ' accessedAt: $accessedAt,'
        ' email: $email,'
        ' id: $id,'
        ' createdAt: $createdAt,'
        ' updatedAt: $updatedAt,'
        ' hotspot: $hotspot,'
        ' permissions: $permissions,'
        ' databaseId: $databaseId,'
        ' collectionId: $collectionId'
        ' }';
  }
}
