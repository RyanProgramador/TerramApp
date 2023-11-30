// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class TrTecnicosStruct extends FFFirebaseStruct {
  TrTecnicosStruct({
    String? id,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _id = id,
        super(firestoreUtilData);

  // "id" field.
  String? _id;
  String get id => _id ?? '';
  set id(String? val) => _id = val;
  bool hasId() => _id != null;

  static TrTecnicosStruct fromMap(Map<String, dynamic> data) =>
      TrTecnicosStruct(
        id: data['id'] as String?,
      );

  static TrTecnicosStruct? maybeFromMap(dynamic data) =>
      data is Map<String, dynamic> ? TrTecnicosStruct.fromMap(data) : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'id': serializeParam(
          _id,
          ParamType.String,
        ),
      }.withoutNulls;

  static TrTecnicosStruct fromSerializableMap(Map<String, dynamic> data) =>
      TrTecnicosStruct(
        id: deserializeParam(
          data['id'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'TrTecnicosStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is TrTecnicosStruct && id == other.id;
  }

  @override
  int get hashCode => const ListEquality().hash([id]);
}

TrTecnicosStruct createTrTecnicosStruct({
  String? id,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    TrTecnicosStruct(
      id: id,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

TrTecnicosStruct? updateTrTecnicosStruct(
  TrTecnicosStruct? trTecnicos, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    trTecnicos
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addTrTecnicosStructData(
  Map<String, dynamic> firestoreData,
  TrTecnicosStruct? trTecnicos,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (trTecnicos == null) {
    return;
  }
  if (trTecnicos.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && trTecnicos.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final trTecnicosData = getTrTecnicosFirestoreData(trTecnicos, forFieldValue);
  final nestedData = trTecnicosData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = trTecnicos.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getTrTecnicosFirestoreData(
  TrTecnicosStruct? trTecnicos, [
  bool forFieldValue = false,
]) {
  if (trTecnicos == null) {
    return {};
  }
  final firestoreData = mapToFirestore(trTecnicos.toMap());

  // Add any Firestore field values
  trTecnicos.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getTrTecnicosListFirestoreData(
  List<TrTecnicosStruct>? trTecnicoss,
) =>
    trTecnicoss?.map((e) => getTrTecnicosFirestoreData(e, true)).toList() ?? [];
