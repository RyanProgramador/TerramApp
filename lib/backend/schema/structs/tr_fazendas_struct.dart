// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class TrFazendasStruct extends BaseStruct {
  TrFazendasStruct({
    String? fazId,
    String? fazIdEmp,
    String? fazNome,
    String? fazLatitude,
    String? fazLongitude,
    String? fazCidade,
    String? fazEstado,
    String? fazPontoRef,
    String? fazStatus,
    String? fazDthrCad,
    String? fazUsuCad,
    String? fazDthrAlt,
    String? fazUsuAlt,
  })  : _fazId = fazId,
        _fazIdEmp = fazIdEmp,
        _fazNome = fazNome,
        _fazLatitude = fazLatitude,
        _fazLongitude = fazLongitude,
        _fazCidade = fazCidade,
        _fazEstado = fazEstado,
        _fazPontoRef = fazPontoRef,
        _fazStatus = fazStatus,
        _fazDthrCad = fazDthrCad,
        _fazUsuCad = fazUsuCad,
        _fazDthrAlt = fazDthrAlt,
        _fazUsuAlt = fazUsuAlt;

  // "faz_id" field.
  String? _fazId;
  String get fazId => _fazId ?? '';
  set fazId(String? val) => _fazId = val;
  bool hasFazId() => _fazId != null;

  // "faz_id_emp" field.
  String? _fazIdEmp;
  String get fazIdEmp => _fazIdEmp ?? '';
  set fazIdEmp(String? val) => _fazIdEmp = val;
  bool hasFazIdEmp() => _fazIdEmp != null;

  // "faz_nome" field.
  String? _fazNome;
  String get fazNome => _fazNome ?? '';
  set fazNome(String? val) => _fazNome = val;
  bool hasFazNome() => _fazNome != null;

  // "faz_latitude" field.
  String? _fazLatitude;
  String get fazLatitude => _fazLatitude ?? '';
  set fazLatitude(String? val) => _fazLatitude = val;
  bool hasFazLatitude() => _fazLatitude != null;

  // "faz_longitude" field.
  String? _fazLongitude;
  String get fazLongitude => _fazLongitude ?? '';
  set fazLongitude(String? val) => _fazLongitude = val;
  bool hasFazLongitude() => _fazLongitude != null;

  // "faz_cidade" field.
  String? _fazCidade;
  String get fazCidade => _fazCidade ?? '';
  set fazCidade(String? val) => _fazCidade = val;
  bool hasFazCidade() => _fazCidade != null;

  // "faz_estado" field.
  String? _fazEstado;
  String get fazEstado => _fazEstado ?? '';
  set fazEstado(String? val) => _fazEstado = val;
  bool hasFazEstado() => _fazEstado != null;

  // "faz_ponto_ref" field.
  String? _fazPontoRef;
  String get fazPontoRef => _fazPontoRef ?? '';
  set fazPontoRef(String? val) => _fazPontoRef = val;
  bool hasFazPontoRef() => _fazPontoRef != null;

  // "faz_status" field.
  String? _fazStatus;
  String get fazStatus => _fazStatus ?? '';
  set fazStatus(String? val) => _fazStatus = val;
  bool hasFazStatus() => _fazStatus != null;

  // "faz_dthr_cad" field.
  String? _fazDthrCad;
  String get fazDthrCad => _fazDthrCad ?? '';
  set fazDthrCad(String? val) => _fazDthrCad = val;
  bool hasFazDthrCad() => _fazDthrCad != null;

  // "faz_usu_cad" field.
  String? _fazUsuCad;
  String get fazUsuCad => _fazUsuCad ?? '';
  set fazUsuCad(String? val) => _fazUsuCad = val;
  bool hasFazUsuCad() => _fazUsuCad != null;

  // "faz_dthr_alt" field.
  String? _fazDthrAlt;
  String get fazDthrAlt => _fazDthrAlt ?? '';
  set fazDthrAlt(String? val) => _fazDthrAlt = val;
  bool hasFazDthrAlt() => _fazDthrAlt != null;

  // "faz_usu_alt" field.
  String? _fazUsuAlt;
  String get fazUsuAlt => _fazUsuAlt ?? '';
  set fazUsuAlt(String? val) => _fazUsuAlt = val;
  bool hasFazUsuAlt() => _fazUsuAlt != null;

  static TrFazendasStruct fromMap(Map<String, dynamic> data) =>
      TrFazendasStruct(
        fazId: data['faz_id'] as String?,
        fazIdEmp: data['faz_id_emp'] as String?,
        fazNome: data['faz_nome'] as String?,
        fazLatitude: data['faz_latitude'] as String?,
        fazLongitude: data['faz_longitude'] as String?,
        fazCidade: data['faz_cidade'] as String?,
        fazEstado: data['faz_estado'] as String?,
        fazPontoRef: data['faz_ponto_ref'] as String?,
        fazStatus: data['faz_status'] as String?,
        fazDthrCad: data['faz_dthr_cad'] as String?,
        fazUsuCad: data['faz_usu_cad'] as String?,
        fazDthrAlt: data['faz_dthr_alt'] as String?,
        fazUsuAlt: data['faz_usu_alt'] as String?,
      );

  static TrFazendasStruct? maybeFromMap(dynamic data) => data is Map
      ? TrFazendasStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'faz_id': _fazId,
        'faz_id_emp': _fazIdEmp,
        'faz_nome': _fazNome,
        'faz_latitude': _fazLatitude,
        'faz_longitude': _fazLongitude,
        'faz_cidade': _fazCidade,
        'faz_estado': _fazEstado,
        'faz_ponto_ref': _fazPontoRef,
        'faz_status': _fazStatus,
        'faz_dthr_cad': _fazDthrCad,
        'faz_usu_cad': _fazUsuCad,
        'faz_dthr_alt': _fazDthrAlt,
        'faz_usu_alt': _fazUsuAlt,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'faz_id': serializeParam(
          _fazId,
          ParamType.String,
        ),
        'faz_id_emp': serializeParam(
          _fazIdEmp,
          ParamType.String,
        ),
        'faz_nome': serializeParam(
          _fazNome,
          ParamType.String,
        ),
        'faz_latitude': serializeParam(
          _fazLatitude,
          ParamType.String,
        ),
        'faz_longitude': serializeParam(
          _fazLongitude,
          ParamType.String,
        ),
        'faz_cidade': serializeParam(
          _fazCidade,
          ParamType.String,
        ),
        'faz_estado': serializeParam(
          _fazEstado,
          ParamType.String,
        ),
        'faz_ponto_ref': serializeParam(
          _fazPontoRef,
          ParamType.String,
        ),
        'faz_status': serializeParam(
          _fazStatus,
          ParamType.String,
        ),
        'faz_dthr_cad': serializeParam(
          _fazDthrCad,
          ParamType.String,
        ),
        'faz_usu_cad': serializeParam(
          _fazUsuCad,
          ParamType.String,
        ),
        'faz_dthr_alt': serializeParam(
          _fazDthrAlt,
          ParamType.String,
        ),
        'faz_usu_alt': serializeParam(
          _fazUsuAlt,
          ParamType.String,
        ),
      }.withoutNulls;

  static TrFazendasStruct fromSerializableMap(Map<String, dynamic> data) =>
      TrFazendasStruct(
        fazId: deserializeParam(
          data['faz_id'],
          ParamType.String,
          false,
        ),
        fazIdEmp: deserializeParam(
          data['faz_id_emp'],
          ParamType.String,
          false,
        ),
        fazNome: deserializeParam(
          data['faz_nome'],
          ParamType.String,
          false,
        ),
        fazLatitude: deserializeParam(
          data['faz_latitude'],
          ParamType.String,
          false,
        ),
        fazLongitude: deserializeParam(
          data['faz_longitude'],
          ParamType.String,
          false,
        ),
        fazCidade: deserializeParam(
          data['faz_cidade'],
          ParamType.String,
          false,
        ),
        fazEstado: deserializeParam(
          data['faz_estado'],
          ParamType.String,
          false,
        ),
        fazPontoRef: deserializeParam(
          data['faz_ponto_ref'],
          ParamType.String,
          false,
        ),
        fazStatus: deserializeParam(
          data['faz_status'],
          ParamType.String,
          false,
        ),
        fazDthrCad: deserializeParam(
          data['faz_dthr_cad'],
          ParamType.String,
          false,
        ),
        fazUsuCad: deserializeParam(
          data['faz_usu_cad'],
          ParamType.String,
          false,
        ),
        fazDthrAlt: deserializeParam(
          data['faz_dthr_alt'],
          ParamType.String,
          false,
        ),
        fazUsuAlt: deserializeParam(
          data['faz_usu_alt'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'TrFazendasStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is TrFazendasStruct &&
        fazId == other.fazId &&
        fazIdEmp == other.fazIdEmp &&
        fazNome == other.fazNome &&
        fazLatitude == other.fazLatitude &&
        fazLongitude == other.fazLongitude &&
        fazCidade == other.fazCidade &&
        fazEstado == other.fazEstado &&
        fazPontoRef == other.fazPontoRef &&
        fazStatus == other.fazStatus &&
        fazDthrCad == other.fazDthrCad &&
        fazUsuCad == other.fazUsuCad &&
        fazDthrAlt == other.fazDthrAlt &&
        fazUsuAlt == other.fazUsuAlt;
  }

  @override
  int get hashCode => const ListEquality().hash([
        fazId,
        fazIdEmp,
        fazNome,
        fazLatitude,
        fazLongitude,
        fazCidade,
        fazEstado,
        fazPontoRef,
        fazStatus,
        fazDthrCad,
        fazUsuCad,
        fazDthrAlt,
        fazUsuAlt
      ]);
}

TrFazendasStruct createTrFazendasStruct({
  String? fazId,
  String? fazIdEmp,
  String? fazNome,
  String? fazLatitude,
  String? fazLongitude,
  String? fazCidade,
  String? fazEstado,
  String? fazPontoRef,
  String? fazStatus,
  String? fazDthrCad,
  String? fazUsuCad,
  String? fazDthrAlt,
  String? fazUsuAlt,
}) =>
    TrFazendasStruct(
      fazId: fazId,
      fazIdEmp: fazIdEmp,
      fazNome: fazNome,
      fazLatitude: fazLatitude,
      fazLongitude: fazLongitude,
      fazCidade: fazCidade,
      fazEstado: fazEstado,
      fazPontoRef: fazPontoRef,
      fazStatus: fazStatus,
      fazDthrCad: fazDthrCad,
      fazUsuCad: fazUsuCad,
      fazDthrAlt: fazDthrAlt,
      fazUsuAlt: fazUsuAlt,
    );
