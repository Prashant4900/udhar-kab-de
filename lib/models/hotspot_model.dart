import 'dart:convert';

class HotspotModel {
  HotspotModel({
    this.id,
    this.collectionId,
    this.databaseId,
    this.createdAt,
    this.updatedAt,
    this.data,
  });

  factory HotspotModel.fromRawJson(String str) =>
      HotspotModel.fromJson(json.decode(str) as Map<String, dynamic>);

  factory HotspotModel.fromJson(Map<String, dynamic> json) => HotspotModel(
        id: json['\u0024id'] as String?,
        collectionId: json['\u0024collectionId'] as String?,
        databaseId: json['\u0024databaseId'] as String?,
        createdAt: json['\u0024createdAt'] as String?,
        updatedAt: json['\u0024updatedAt'] as String?,
        data: json['data'] == null
            ? null
            : Data.fromJson(json['data'] as Map<String, dynamic>),
      );
  final String? id;
  final String? collectionId;
  final String? databaseId;
  final String? createdAt;
  final String? updatedAt;

  final Data? data;

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        '\u0024id': id,
        '\u0024collectionId': collectionId,
        '\u0024databaseId': databaseId,
        '\u0024createdAt': createdAt,
        '\u0024updatedAt': updatedAt,
        'data': data?.toJson(),
      };
}

class Data {
  Data({
    this.hostpotName,
    this.hotspotLocation,
    this.hotspotType,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.databaseId,
    this.collectionId,
  });

  factory Data.fromRawJson(String str) =>
      Data.fromJson(json.decode(str) as Map<String, dynamic>);

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        hostpotName: json['hostpotName'] as String?,
        hotspotLocation: json['hotspotLocation'] as String?,
        hotspotType: json['hotspotType'] as String?,
        id: json['\u0024id'] as String?,
        createdAt: json['\u0024createdAt'] as String?,
        updatedAt: json['\u0024updatedAt'] as String?,
        databaseId: json['\u0024databaseId'] as String?,
        collectionId: json['\u0024collectionId'] as String?,
      );
  final String? hostpotName;
  final String? hotspotLocation;
  final String? hotspotType;
  final String? id;
  final String? createdAt;
  final String? updatedAt;
  final String? databaseId;
  final String? collectionId;

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        'hostpotName': hostpotName,
        'hotspotLocation': hotspotLocation,
        'hotspotType': hotspotType,
        '\u0024id': id,
        '\u0024createdAt': createdAt,
        '\u0024updatedAt': updatedAt,
        '\u0024databaseId': databaseId,
        '\u0024collectionId': collectionId,
      };
}
