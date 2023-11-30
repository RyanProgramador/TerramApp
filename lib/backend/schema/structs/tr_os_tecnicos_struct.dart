// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class TrOsTecnicosStruct extends FFFirebaseStruct {
  TrOsTecnicosStruct({
    String? ostecId,
    String? ostecIdServ,
    String? ostecIdTec,
    String? ostecDthrCad,
    String? ostecUsuCad,
    String? ostecDthrAlt,
    String? ostecUsuAlt,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _ostecId = ostecId,
        _ostecIdServ = ostecIdServ,
        _ostecIdTec = ostecIdTec,
        _ostecDthrCad = ostecDthrCad,
        _ostecUsuCad = ostecUsuCad,
        _ostecDthrAlt = ostecDthrAlt,
        _ostecUsuAlt = ostecUsuAlt,
        super(firestoreUtilData);

  // "ostec_id" field.
  String? _ostecId;
  String get ostecId => _ostecId ?? '';
  set ostecId(String? val) => _ostecId = val;
  bool hasOstecId() => _ostecId != null;

  // "ostec_id_serv" field.
  String? _ostecIdServ;
  String get ostecIdServ => _ostecIdServ ?? '';
  set ostecIdServ(String? val) => _ostecIdServ = val;
  bool hasOstecIdServ() => _ostecIdServ != null;

  // "ostec_id_tec" field.
  String? _ostecIdTec;
  String get ostecIdTec => _ostecIdTec ?? '';
  set ostecIdTec(String? val) => _ostecIdTec = val;
  bool hasOstecIdTec() => _ostecIdTec != null;

  // "ostec_dthr_cad" field.
  String? _ostecDthrCad;
  String get ostecDthrCad => _ostecDthrCad ?? '';
  set ostecDthrCad(String? val) => _ostecDthrCad = val;
  bool hasOstecDthrCad() => _ostecDthrCad != null;

  // "ostec_usu_cad" field.
  String? _ostecUsuCad;
  String get ostecUsuCad => _ostecUsuCad ?? '';
  set ostecUsuCad(String? val) => _ostecUsuCad = val;
  bool hasOstecUsuCad() => _ostecUsuCad != null;

  // "ostec_dthr_alt" field.
  String? _ostecDthrAlt;
  String get ostecDthrAlt => _ostecDthrAlt ?? '';
  set ostecDthrAlt(String? val) => _ostecDthrAlt = val;
  bool hasOstecDthrAlt() => _ostecDthrAlt != null;

  // "ostec_usu_alt" field.
  String? _ostecUsuAlt;
  String get ostecUsuAlt => _ostecUsuAlt ?? '';
  set ostecUsuAlt(String? val) => _ostecUsuAlt = val;
  bool hasOstecUsuAlt() => _ostecUsuAlt != null;

  static TrOsTecnicosStruct fromMap(Map<String, dynamic> data) =>
      TrOsTecnicosStruct(
        ostecId: data['ostec_id'] as String?,
        ostecIdServ: data['ostec_id_serv'] as String?,
        ostecIdTec: data['ostec_id_tec'] as String?,
        ostecDthrCad: data['ostec_dthr_cad'] as String?,
        ostecUsuCad: data['ostec_usu_cad'] as String?,
        ostecDthrAlt: data['ostec_dthr_alt'] as String?,
        ostecUsuAlt: data['ostec_usu_alt'] as String?,
      );

  static TrOsTecnicosStruct? maybeFromMap(dynamic data) =>
      data is Map<String, dynamic> ? TrOsTecnicosStruct.fromMap(data) : null;

  Map<String, dynamic> toMap() => {
        'ostec_id': _ostecId,
        'ostec_id_serv': _ostecIdServ,
        'ostec_id_tec': _ostecIdTec,
        'ostec_dthr_cad': _ostecDthrCad,
        'ostec_usu_cad': _ostecUsuCad,
        'ostec_dthr_alt': _ostecDthrAlt,
        'ostec_usu_alt': _ostecUsuAlt,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'ostec_id': serializeParam(
          _ostecId,
          ParamType.String,
        ),
        'ostec_id_serv': serializeParam(
          _ostecIdServ,
          ParamType.String,
        ),
        'ostec_id_tec': serializeParam(
          _ostecIdTec,
          ParamType.String,
        ),
        'ostec_dthr_cad': serializeParam(
          _ostecDthrCad,
          ParamType.String,
        ),
        'ostec_usu_cad': serializeParam(
          _ostecUsuCad,
          ParamType.String,
        ),
        'ostec_dthr_alt': serializeParam(
          _ostecDthrAlt,
          ParamType.String,
        ),
        'ostec_usu_alt': serializeParam(
          _ostecUsuAlt,
          ParamType.String,
        ),
      }.withoutNulls;

  static TrOsTecnicosStruct fromSerializableMap(Map<String, dynamic> data) =>
      TrOsTecnicosStruct(
        ostecId: deserializeParam(
          data['ostec_id'],
          ParamType.String,
          false,
        ),
        ostecIdServ: deserializeParam(
          data['ostec_id_serv'],
          ParamType.String,
          false,
        ),
        ostecIdTec: deserializeParam(
          data['ostec_id_tec'],
          ParamType.String,
          false,
        ),
        ostecDthrCad: deserializeParam(
          data['ostec_dthr_cad'],
          ParamType.String,
          false,
        ),
        ostecUsuCad: deserializeParam(
          data['ostec_usu_cad'],
          ParamType.String,
          false,
        ),
        ostecDthrAlt: deserializeParam(
          data['ostec_dthr_alt'],
          ParamType.String,
          false,
        ),
        ostecUsuAlt: deserializeParam(
          data['ostec_usu_alt'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'TrOsTecnicosStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is TrOsTecnicosStruct &&
        ostecId == other.ostecId &&
        ostecIdServ == other.ostecIdServ &&
        ostecIdTec == other.ostecIdTec &&
        ostecDthrCad == other.ostecDthrCad &&
        ostecUsuCad == other.ostecUsuCad &&
        ostecDthrAlt == other.ostecDthrAlt &&
        ostecUsuAlt == other.ostecUsuAlt;
  }

  @override
  int get hashCode => const ListEquality().hash([
        ostecId,
        ostecIdServ,
        ostecIdTec,
        ostecDthrCad,
        ostecUsuCad,
        ostecDthrAlt,
        ostecUsuAlt
      ]);
}

TrOsTecnicosStruct createTrOsTecnicosStruct({
  String? ostecId,
  String? ostecIdServ,
  String? ostecIdTec,
  String? ostecDthrCad,
  String? ostecUsuCad,
  String? ostecDthrAlt,
  String? ostecUsuAlt,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    TrOsTecnicosStruct(
      ostecId: ostecId,
      ostecIdServ: ostecIdServ,
      ostecIdTec: ostecIdTec,
      ostecDthrCad: ostecDthrCad,
      ostecUsuCad: ostecUsuCad,
      ostecDthrAlt: ostecDthrAlt,
      ostecUsuAlt: ostecUsuAlt,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

TrOsTecnicosStruct? updateTrOsTecnicosStruct(
  TrOsTecnicosStruct? trOsTecnicos, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    trOsTecnicos
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addTrOsTecnicosStructData(
  Map<String, dynamic> firestoreData,
  TrOsTecnicosStruct? trOsTecnicos,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (trOsTecnicos == null) {
    return;
  }
  if (trOsTecnicos.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && trOsTecnicos.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final trOsTecnicosData =
      getTrOsTecnicosFirestoreData(trOsTecnicos, forFieldValue);
  final nestedData =
      trOsTecnicosData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = trOsTecnicos.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getTrOsTecnicosFirestoreData(
  TrOsTecnicosStruct? trOsTecnicos, [
  bool forFieldValue = false,
]) {
  if (trOsTecnicos == null) {
    return {};
  }
  final firestoreData = mapToFirestore(trOsTecnicos.toMap());

  // Add any Firestore field values
  trOsTecnicos.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getTrOsTecnicosListFirestoreData(
  List<TrOsTecnicosStruct>? trOsTecnicoss,
) =>
    trOsTecnicoss?.map((e) => getTrOsTecnicosFirestoreData(e, true)).toList() ??
    [];
