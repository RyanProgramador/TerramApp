// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class TrOsStruct extends BaseStruct {
  TrOsStruct({
    String? osId,
    String? osIdEmp,
    String? osIdFaz,
    String? osDthrAgendamento,
    String? osDthrFinalizacao,
    String? osObservacao,
    String? osStatus,
    String? osDthrCad,
    String? osUsuCad,
    String? osDthrAlt,
    String? osUsuAlt,
  })  : _osId = osId,
        _osIdEmp = osIdEmp,
        _osIdFaz = osIdFaz,
        _osDthrAgendamento = osDthrAgendamento,
        _osDthrFinalizacao = osDthrFinalizacao,
        _osObservacao = osObservacao,
        _osStatus = osStatus,
        _osDthrCad = osDthrCad,
        _osUsuCad = osUsuCad,
        _osDthrAlt = osDthrAlt,
        _osUsuAlt = osUsuAlt;

  // "os_id" field.
  String? _osId;
  String get osId => _osId ?? '';
  set osId(String? val) => _osId = val;
  bool hasOsId() => _osId != null;

  // "os_id_emp" field.
  String? _osIdEmp;
  String get osIdEmp => _osIdEmp ?? '';
  set osIdEmp(String? val) => _osIdEmp = val;
  bool hasOsIdEmp() => _osIdEmp != null;

  // "os_id_faz" field.
  String? _osIdFaz;
  String get osIdFaz => _osIdFaz ?? '';
  set osIdFaz(String? val) => _osIdFaz = val;
  bool hasOsIdFaz() => _osIdFaz != null;

  // "os_dthr_agendamento" field.
  String? _osDthrAgendamento;
  String get osDthrAgendamento => _osDthrAgendamento ?? '';
  set osDthrAgendamento(String? val) => _osDthrAgendamento = val;
  bool hasOsDthrAgendamento() => _osDthrAgendamento != null;

  // "os_dthr_finalizacao" field.
  String? _osDthrFinalizacao;
  String get osDthrFinalizacao => _osDthrFinalizacao ?? '';
  set osDthrFinalizacao(String? val) => _osDthrFinalizacao = val;
  bool hasOsDthrFinalizacao() => _osDthrFinalizacao != null;

  // "os_observacao" field.
  String? _osObservacao;
  String get osObservacao => _osObservacao ?? '';
  set osObservacao(String? val) => _osObservacao = val;
  bool hasOsObservacao() => _osObservacao != null;

  // "os_status" field.
  String? _osStatus;
  String get osStatus => _osStatus ?? '';
  set osStatus(String? val) => _osStatus = val;
  bool hasOsStatus() => _osStatus != null;

  // "os_dthr_cad" field.
  String? _osDthrCad;
  String get osDthrCad => _osDthrCad ?? '';
  set osDthrCad(String? val) => _osDthrCad = val;
  bool hasOsDthrCad() => _osDthrCad != null;

  // "os_usu_cad" field.
  String? _osUsuCad;
  String get osUsuCad => _osUsuCad ?? '';
  set osUsuCad(String? val) => _osUsuCad = val;
  bool hasOsUsuCad() => _osUsuCad != null;

  // "os_dthr_alt" field.
  String? _osDthrAlt;
  String get osDthrAlt => _osDthrAlt ?? '';
  set osDthrAlt(String? val) => _osDthrAlt = val;
  bool hasOsDthrAlt() => _osDthrAlt != null;

  // "os_usu_alt" field.
  String? _osUsuAlt;
  String get osUsuAlt => _osUsuAlt ?? '';
  set osUsuAlt(String? val) => _osUsuAlt = val;
  bool hasOsUsuAlt() => _osUsuAlt != null;

  static TrOsStruct fromMap(Map<String, dynamic> data) => TrOsStruct(
        osId: data['os_id'] as String?,
        osIdEmp: data['os_id_emp'] as String?,
        osIdFaz: data['os_id_faz'] as String?,
        osDthrAgendamento: data['os_dthr_agendamento'] as String?,
        osDthrFinalizacao: data['os_dthr_finalizacao'] as String?,
        osObservacao: data['os_observacao'] as String?,
        osStatus: data['os_status'] as String?,
        osDthrCad: data['os_dthr_cad'] as String?,
        osUsuCad: data['os_usu_cad'] as String?,
        osDthrAlt: data['os_dthr_alt'] as String?,
        osUsuAlt: data['os_usu_alt'] as String?,
      );

  static TrOsStruct? maybeFromMap(dynamic data) =>
      data is Map ? TrOsStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'os_id': _osId,
        'os_id_emp': _osIdEmp,
        'os_id_faz': _osIdFaz,
        'os_dthr_agendamento': _osDthrAgendamento,
        'os_dthr_finalizacao': _osDthrFinalizacao,
        'os_observacao': _osObservacao,
        'os_status': _osStatus,
        'os_dthr_cad': _osDthrCad,
        'os_usu_cad': _osUsuCad,
        'os_dthr_alt': _osDthrAlt,
        'os_usu_alt': _osUsuAlt,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'os_id': serializeParam(
          _osId,
          ParamType.String,
        ),
        'os_id_emp': serializeParam(
          _osIdEmp,
          ParamType.String,
        ),
        'os_id_faz': serializeParam(
          _osIdFaz,
          ParamType.String,
        ),
        'os_dthr_agendamento': serializeParam(
          _osDthrAgendamento,
          ParamType.String,
        ),
        'os_dthr_finalizacao': serializeParam(
          _osDthrFinalizacao,
          ParamType.String,
        ),
        'os_observacao': serializeParam(
          _osObservacao,
          ParamType.String,
        ),
        'os_status': serializeParam(
          _osStatus,
          ParamType.String,
        ),
        'os_dthr_cad': serializeParam(
          _osDthrCad,
          ParamType.String,
        ),
        'os_usu_cad': serializeParam(
          _osUsuCad,
          ParamType.String,
        ),
        'os_dthr_alt': serializeParam(
          _osDthrAlt,
          ParamType.String,
        ),
        'os_usu_alt': serializeParam(
          _osUsuAlt,
          ParamType.String,
        ),
      }.withoutNulls;

  static TrOsStruct fromSerializableMap(Map<String, dynamic> data) =>
      TrOsStruct(
        osId: deserializeParam(
          data['os_id'],
          ParamType.String,
          false,
        ),
        osIdEmp: deserializeParam(
          data['os_id_emp'],
          ParamType.String,
          false,
        ),
        osIdFaz: deserializeParam(
          data['os_id_faz'],
          ParamType.String,
          false,
        ),
        osDthrAgendamento: deserializeParam(
          data['os_dthr_agendamento'],
          ParamType.String,
          false,
        ),
        osDthrFinalizacao: deserializeParam(
          data['os_dthr_finalizacao'],
          ParamType.String,
          false,
        ),
        osObservacao: deserializeParam(
          data['os_observacao'],
          ParamType.String,
          false,
        ),
        osStatus: deserializeParam(
          data['os_status'],
          ParamType.String,
          false,
        ),
        osDthrCad: deserializeParam(
          data['os_dthr_cad'],
          ParamType.String,
          false,
        ),
        osUsuCad: deserializeParam(
          data['os_usu_cad'],
          ParamType.String,
          false,
        ),
        osDthrAlt: deserializeParam(
          data['os_dthr_alt'],
          ParamType.String,
          false,
        ),
        osUsuAlt: deserializeParam(
          data['os_usu_alt'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'TrOsStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is TrOsStruct &&
        osId == other.osId &&
        osIdEmp == other.osIdEmp &&
        osIdFaz == other.osIdFaz &&
        osDthrAgendamento == other.osDthrAgendamento &&
        osDthrFinalizacao == other.osDthrFinalizacao &&
        osObservacao == other.osObservacao &&
        osStatus == other.osStatus &&
        osDthrCad == other.osDthrCad &&
        osUsuCad == other.osUsuCad &&
        osDthrAlt == other.osDthrAlt &&
        osUsuAlt == other.osUsuAlt;
  }

  @override
  int get hashCode => const ListEquality().hash([
        osId,
        osIdEmp,
        osIdFaz,
        osDthrAgendamento,
        osDthrFinalizacao,
        osObservacao,
        osStatus,
        osDthrCad,
        osUsuCad,
        osDthrAlt,
        osUsuAlt
      ]);
}

TrOsStruct createTrOsStruct({
  String? osId,
  String? osIdEmp,
  String? osIdFaz,
  String? osDthrAgendamento,
  String? osDthrFinalizacao,
  String? osObservacao,
  String? osStatus,
  String? osDthrCad,
  String? osUsuCad,
  String? osDthrAlt,
  String? osUsuAlt,
}) =>
    TrOsStruct(
      osId: osId,
      osIdEmp: osIdEmp,
      osIdFaz: osIdFaz,
      osDthrAgendamento: osDthrAgendamento,
      osDthrFinalizacao: osDthrFinalizacao,
      osObservacao: osObservacao,
      osStatus: osStatus,
      osDthrCad: osDthrCad,
      osUsuCad: osUsuCad,
      osDthrAlt: osDthrAlt,
      osUsuAlt: osUsuAlt,
    );
