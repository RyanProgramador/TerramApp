// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class DeslocamentosGeoStruct extends BaseStruct {
  DeslocamentosGeoStruct({
    int? osdesId,
    String? latitude,
    String? longitude,
  })  : _osdesId = osdesId,
        _latitude = latitude,
        _longitude = longitude;

  // "osdes_id" field.
  int? _osdesId;
  int get osdesId => _osdesId ?? 0;
  set osdesId(int? val) => _osdesId = val;
  void incrementOsdesId(int amount) => _osdesId = osdesId + amount;
  bool hasOsdesId() => _osdesId != null;

  // "latitude" field.
  String? _latitude;
  String get latitude => _latitude ?? '';
  set latitude(String? val) => _latitude = val;
  bool hasLatitude() => _latitude != null;

  // "longitude" field.
  String? _longitude;
  String get longitude => _longitude ?? '';
  set longitude(String? val) => _longitude = val;
  bool hasLongitude() => _longitude != null;

  static DeslocamentosGeoStruct fromMap(Map<String, dynamic> data) =>
      DeslocamentosGeoStruct(
        osdesId: castToType<int>(data['osdes_id']),
        latitude: data['latitude'] as String?,
        longitude: data['longitude'] as String?,
      );

  static DeslocamentosGeoStruct? maybeFromMap(dynamic data) => data is Map
      ? DeslocamentosGeoStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'osdes_id': _osdesId,
        'latitude': _latitude,
        'longitude': _longitude,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'osdes_id': serializeParam(
          _osdesId,
          ParamType.int,
        ),
        'latitude': serializeParam(
          _latitude,
          ParamType.String,
        ),
        'longitude': serializeParam(
          _longitude,
          ParamType.String,
        ),
      }.withoutNulls;

  static DeslocamentosGeoStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      DeslocamentosGeoStruct(
        osdesId: deserializeParam(
          data['osdes_id'],
          ParamType.int,
          false,
        ),
        latitude: deserializeParam(
          data['latitude'],
          ParamType.String,
          false,
        ),
        longitude: deserializeParam(
          data['longitude'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'DeslocamentosGeoStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is DeslocamentosGeoStruct &&
        osdesId == other.osdesId &&
        latitude == other.latitude &&
        longitude == other.longitude;
  }

  @override
  int get hashCode => const ListEquality().hash([osdesId, latitude, longitude]);
}

DeslocamentosGeoStruct createDeslocamentosGeoStruct({
  int? osdesId,
  String? latitude,
  String? longitude,
}) =>
    DeslocamentosGeoStruct(
      osdesId: osdesId,
      latitude: latitude,
      longitude: longitude,
    );
