// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class TrContornoFazendaStruct extends BaseStruct {
  TrContornoFazendaStruct({
    String? contornoGrupo,
    String? markerId,
    String? oservId,
    String? latlng,
  })  : _contornoGrupo = contornoGrupo,
        _markerId = markerId,
        _oservId = oservId,
        _latlng = latlng;

  // "contorno_grupo" field.
  String? _contornoGrupo;
  String get contornoGrupo => _contornoGrupo ?? '';
  set contornoGrupo(String? val) => _contornoGrupo = val;
  bool hasContornoGrupo() => _contornoGrupo != null;

  // "marker_id" field.
  String? _markerId;
  String get markerId => _markerId ?? '';
  set markerId(String? val) => _markerId = val;
  bool hasMarkerId() => _markerId != null;

  // "oserv_id" field.
  String? _oservId;
  String get oservId => _oservId ?? '';
  set oservId(String? val) => _oservId = val;
  bool hasOservId() => _oservId != null;

  // "latlng" field.
  String? _latlng;
  String get latlng => _latlng ?? '';
  set latlng(String? val) => _latlng = val;
  bool hasLatlng() => _latlng != null;

  static TrContornoFazendaStruct fromMap(Map<String, dynamic> data) =>
      TrContornoFazendaStruct(
        contornoGrupo: data['contorno_grupo'] as String?,
        markerId: data['marker_id'] as String?,
        oservId: data['oserv_id'] as String?,
        latlng: data['latlng'] as String?,
      );

  static TrContornoFazendaStruct? maybeFromMap(dynamic data) => data is Map
      ? TrContornoFazendaStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'contorno_grupo': _contornoGrupo,
        'marker_id': _markerId,
        'oserv_id': _oservId,
        'latlng': _latlng,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'contorno_grupo': serializeParam(
          _contornoGrupo,
          ParamType.String,
        ),
        'marker_id': serializeParam(
          _markerId,
          ParamType.String,
        ),
        'oserv_id': serializeParam(
          _oservId,
          ParamType.String,
        ),
        'latlng': serializeParam(
          _latlng,
          ParamType.String,
        ),
      }.withoutNulls;

  static TrContornoFazendaStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      TrContornoFazendaStruct(
        contornoGrupo: deserializeParam(
          data['contorno_grupo'],
          ParamType.String,
          false,
        ),
        markerId: deserializeParam(
          data['marker_id'],
          ParamType.String,
          false,
        ),
        oservId: deserializeParam(
          data['oserv_id'],
          ParamType.String,
          false,
        ),
        latlng: deserializeParam(
          data['latlng'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'TrContornoFazendaStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is TrContornoFazendaStruct &&
        contornoGrupo == other.contornoGrupo &&
        markerId == other.markerId &&
        oservId == other.oservId &&
        latlng == other.latlng;
  }

  @override
  int get hashCode =>
      const ListEquality().hash([contornoGrupo, markerId, oservId, latlng]);
}

TrContornoFazendaStruct createTrContornoFazendaStruct({
  String? contornoGrupo,
  String? markerId,
  String? oservId,
  String? latlng,
}) =>
    TrContornoFazendaStruct(
      contornoGrupo: contornoGrupo,
      markerId: markerId,
      oservId: oservId,
      latlng: latlng,
    );
