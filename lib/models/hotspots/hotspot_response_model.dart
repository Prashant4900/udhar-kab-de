import 'package:equatable/equatable.dart';

class HotspotResponseModel extends Equatable {
  const HotspotResponseModel({
    // this.permissions,
    this.hotspotName,
    this.hotspotLocation,
    this.hotspotType,
    this.userID,
    this.id,
    // this.createdAt,
    // this.updatedAt,
    // this.user,
  });

  factory HotspotResponseModel.fromMap(Map<String, dynamic> json) {
    return HotspotResponseModel(
      hotspotName: json['hotspotName'] as String?,
      hotspotLocation: json['hotspotLocation'] as String?,
      hotspotType: json['hotspotType'] as String?,
      id: json[r'$id'] as String?,

      // id: json[r'$id'] as String?,
      // createdAt: json[r'$createdAt'] as String?,
      // updatedAt: json[r'$updatedAt'] as String?,
      // permissions: List<String>.from([]),
      // user: json['users'] == null
      //     ? null
      //     : UserModel.fromMap(json['users'] as Map<String, dynamic>),
    );
  }

  final String? hotspotName;
  final String? hotspotLocation;
  final String? hotspotType;
  final String? userID;
  final String? id;
  // final String? createdAt;
  // final String? updatedAt;
  // final List<String>? permissions;
  // final UserModel? user;

  Map<String, dynamic> toMap() => {
        'hotspotName': hotspotName,
        'hotspotLocation': hotspotLocation,
        'hotspotType': hotspotType,
        'users': userID,
        r'$id': id,
        // r'$createdAt': createdAt,
        // r'$updatedAt': updatedAt,
        // r'$permissions': permissions,
      };

  @override
  List<Object?> get props {
    return [
      hotspotName,
      hotspotLocation,
      hotspotType,
      id,
      userID,
      // createdAt,
      // updatedAt,
      // permissions,
      // user,
    ];
  }

  @override
  String toString() {
    return 'HotspotModel {'
        ' hotspotName: $hotspotName,'
        ' hotspotLocation: $hotspotLocation,'
        ' hotspotType: $hotspotType,'
        ' userID: $userID,'
        ' id: $id,'
        // ' createdAt: $createdAt,'
        // ' updatedAt: $updatedAt,'
        // ' permissions: $permissions'
        ' }';
  }

  HotspotResponseModel copyWith({
    String? hotspotName,
    String? hotspotLocation,
    String? hotspotType,
    String? userID,
    String? id,
    // String? createdAt,
    // String? updatedAt,
    // List<String>? permissions,
    // UserModel? user,
  }) {
    return HotspotResponseModel(
      hotspotName: hotspotName ?? this.hotspotName,
      hotspotLocation: hotspotLocation ?? this.hotspotLocation,
      hotspotType: hotspotType ?? this.hotspotType,
      userID: userID ?? this.userID,
      id: id ?? this.id,
      // createdAt: createdAt ?? this.createdAt,
      // updatedAt: updatedAt ?? this.updatedAt,
      // permissions: permissions ?? this.permissions,
      // user: user ?? this.user,
    );
  }
}
