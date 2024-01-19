import 'package:equatable/equatable.dart';

class HotspotRequestModel extends Equatable {
  const HotspotRequestModel({
    this.hotspotName,
    this.hotspotLocation,
    this.hotspotType,
    this.userID,
    this.id,
  });

  factory HotspotRequestModel.fromMap(Map<String, dynamic> json) {
    return HotspotRequestModel(
      hotspotName: json['hotspotName'] as String?,
      hotspotLocation: json['hotspotLocation'] as String?,
      hotspotType: json['hotspotType'] as String?,
    );
  }

  final String? hotspotName;
  final String? hotspotLocation;
  final String? hotspotType;
  final String? userID;
  final String? id;

  Map<String, dynamic> toMap() => {
        'hotspotName': hotspotName,
        'hotspotLocation': hotspotLocation,
        'hotspotType': hotspotType,
        'users': userID,
      };

  @override
  List<Object?> get props {
    return [
      hotspotName,
      hotspotLocation,
      hotspotType,
      userID,
      id,
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
        ' }';
  }

  HotspotRequestModel copyWith({
    String? hotspotName,
    String? hotspotLocation,
    String? hotspotType,
    String? userID,
    String? id,
  }) {
    return HotspotRequestModel(
      hotspotName: hotspotName ?? this.hotspotName,
      hotspotLocation: hotspotLocation ?? this.hotspotLocation,
      hotspotType: hotspotType ?? this.hotspotType,
      userID: userID ?? this.userID,
      id: id ?? this.id,
    );
  }
}
