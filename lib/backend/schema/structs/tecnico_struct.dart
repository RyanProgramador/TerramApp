// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class TecnicoStruct extends FFFirebaseStruct {
  TecnicoStruct({
    String? nomeTec,
    int? idTec,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _nomeTec = nomeTec,
        _idTec = idTec,
        super(firestoreUtilData);

  // "Nome_tec" field.
  String? _nomeTec;
  String get nomeTec => _nomeTec ?? '';
  set nomeTec(String? val) => _nomeTec = val;
  bool hasNomeTec() => _nomeTec != null;

  // "Id_tec" field.
  int? _idTec;
  int get idTec => _idTec ?? 0;
  set idTec(int? val) => _idTec = val;
  void incrementIdTec(int amount) => _idTec = idTec + amount;
  bool hasIdTec() => _idTec != null;

  static TecnicoStruct fromMap(Map<String, dynamic> data) => TecnicoStruct(
        nomeTec: data['Nome_tec'] as String?,
        idTec: castToType<int>(data['Id_tec']),
      );

  static TecnicoStruct? maybeFromMap(dynamic data) =>
      data is Map<String, dynamic> ? TecnicoStruct.fromMap(data) : null;

  Map<String, dynamic> toMap() => {
        'Nome_tec': _nomeTec,
        'Id_tec': _idTec,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'Nome_tec': serializeParam(
          _nomeTec,
          ParamType.String,
        ),
        'Id_tec': serializeParam(
          _idTec,
          ParamType.int,
        ),
      }.withoutNulls;

  static TecnicoStruct fromSerializableMap(Map<String, dynamic> data) =>
      TecnicoStruct(
        nomeTec: deserializeParam(
          data['Nome_tec'],
          ParamType.String,
          false,
        ),
        idTec: deserializeParam(
          data['Id_tec'],
          ParamType.int,
          false,
        ),
      );

  @override
  String toString() => 'TecnicoStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is TecnicoStruct &&
        nomeTec == other.nomeTec &&
        idTec == other.idTec;
  }

  @override
  int get hashCode => const ListEquality().hash([nomeTec, idTec]);
}

TecnicoStruct createTecnicoStruct({
  String? nomeTec,
  int? idTec,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    TecnicoStruct(
      nomeTec: nomeTec,
      idTec: idTec,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

TecnicoStruct? updateTecnicoStruct(
  TecnicoStruct? tecnico, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    tecnico
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addTecnicoStructData(
  Map<String, dynamic> firestoreData,
  TecnicoStruct? tecnico,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (tecnico == null) {
    return;
  }
  if (tecnico.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && tecnico.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final tecnicoData = getTecnicoFirestoreData(tecnico, forFieldValue);
  final nestedData = tecnicoData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = tecnico.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getTecnicoFirestoreData(
  TecnicoStruct? tecnico, [
  bool forFieldValue = false,
]) {
  if (tecnico == null) {
    return {};
  }
  final firestoreData = mapToFirestore(tecnico.toMap());

  // Add any Firestore field values
  tecnico.firestoreUtilData.fieldValues.forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getTecnicoListFirestoreData(
  List<TecnicoStruct>? tecnicos,
) =>
    tecnicos?.map((e) => getTecnicoFirestoreData(e, true)).toList() ?? [];
