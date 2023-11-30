// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class DeslocamentosGeoStruct extends FFFirebaseStruct {
  DeslocamentosGeoStruct({
    int? osdesId,
    String? latitude,
    String? longitude,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _osdesId = osdesId,
        _latitude = latitude,
        _longitude = longitude,
        super(firestoreUtilData);

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

  static DeslocamentosGeoStruct? maybeFromMap(dynamic data) =>
      data is Map<String, dynamic>
          ? DeslocamentosGeoStruct.fromMap(data)
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
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    DeslocamentosGeoStruct(
      osdesId: osdesId,
      latitude: latitude,
      longitude: longitude,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

DeslocamentosGeoStruct? updateDeslocamentosGeoStruct(
  DeslocamentosGeoStruct? deslocamentosGeo, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    deslocamentosGeo
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addDeslocamentosGeoStructData(
  Map<String, dynamic> firestoreData,
  DeslocamentosGeoStruct? deslocamentosGeo,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (deslocamentosGeo == null) {
    return;
  }
  if (deslocamentosGeo.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && deslocamentosGeo.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final deslocamentosGeoData =
      getDeslocamentosGeoFirestoreData(deslocamentosGeo, forFieldValue);
  final nestedData =
      deslocamentosGeoData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = deslocamentosGeo.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getDeslocamentosGeoFirestoreData(
  DeslocamentosGeoStruct? deslocamentosGeo, [
  bool forFieldValue = false,
]) {
  if (deslocamentosGeo == null) {
    return {};
  }
  final firestoreData = mapToFirestore(deslocamentosGeo.toMap());

  // Add any Firestore field values
  deslocamentosGeo.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getDeslocamentosGeoListFirestoreData(
  List<DeslocamentosGeoStruct>? deslocamentosGeos,
) =>
    deslocamentosGeos
        ?.map((e) => getDeslocamentosGeoFirestoreData(e, true))
        .toList() ??
    [];
