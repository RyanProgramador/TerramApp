// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class TrOsTecnicosStruct extends BaseStruct {
  TrOsTecnicosStruct({
    String? ostecId,
    String? ostecIdServ,
    String? ostecIdTec,
    String? ostecDthrCad,
    String? ostecUsuCad,
    String? ostecDthrAlt,
    String? ostecUsuAlt,
  })  : _ostecId = ostecId,
        _ostecIdServ = ostecIdServ,
        _ostecIdTec = ostecIdTec,
        _ostecDthrCad = ostecDthrCad,
        _ostecUsuCad = ostecUsuCad,
        _ostecDthrAlt = ostecDthrAlt,
        _ostecUsuAlt = ostecUsuAlt;

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

  static TrOsTecnicosStruct? maybeFromMap(dynamic data) => data is Map
      ? TrOsTecnicosStruct.fromMap(data.cast<String, dynamic>())
      : null;

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
}) =>
    TrOsTecnicosStruct(
      ostecId: ostecId,
      ostecIdServ: ostecIdServ,
      ostecIdTec: ostecIdTec,
      ostecDthrCad: ostecDthrCad,
      ostecUsuCad: ostecUsuCad,
      ostecDthrAlt: ostecDthrAlt,
      ostecUsuAlt: ostecUsuAlt,
    );
