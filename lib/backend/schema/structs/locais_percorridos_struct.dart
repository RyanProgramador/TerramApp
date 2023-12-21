// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class LocaisPercorridosStruct extends BaseStruct {
  LocaisPercorridosStruct({
    List<LatLng>? locaisPercorridos,
    List<int>? idTec,
    List<int>? idServic,
    List<LatLng>? localFinal,
    List<LatLng>? localInicio,
  })  : _locaisPercorridos = locaisPercorridos,
        _idTec = idTec,
        _idServic = idServic,
        _localFinal = localFinal,
        _localInicio = localInicio;

  // "LocaisPercorridos" field.
  List<LatLng>? _locaisPercorridos;
  List<LatLng> get locaisPercorridos => _locaisPercorridos ?? const [];
  set locaisPercorridos(List<LatLng>? val) => _locaisPercorridos = val;
  void updateLocaisPercorridos(Function(List<LatLng>) updateFn) =>
      updateFn(_locaisPercorridos ??= []);
  bool hasLocaisPercorridos() => _locaisPercorridos != null;

  // "id_tec" field.
  List<int>? _idTec;
  List<int> get idTec => _idTec ?? const [];
  set idTec(List<int>? val) => _idTec = val;
  void updateIdTec(Function(List<int>) updateFn) => updateFn(_idTec ??= []);
  bool hasIdTec() => _idTec != null;

  // "id_servic" field.
  List<int>? _idServic;
  List<int> get idServic => _idServic ?? const [];
  set idServic(List<int>? val) => _idServic = val;
  void updateIdServic(Function(List<int>) updateFn) =>
      updateFn(_idServic ??= []);
  bool hasIdServic() => _idServic != null;

  // "localFinal" field.
  List<LatLng>? _localFinal;
  List<LatLng> get localFinal => _localFinal ?? const [];
  set localFinal(List<LatLng>? val) => _localFinal = val;
  void updateLocalFinal(Function(List<LatLng>) updateFn) =>
      updateFn(_localFinal ??= []);
  bool hasLocalFinal() => _localFinal != null;

  // "localInicio" field.
  List<LatLng>? _localInicio;
  List<LatLng> get localInicio => _localInicio ?? const [];
  set localInicio(List<LatLng>? val) => _localInicio = val;
  void updateLocalInicio(Function(List<LatLng>) updateFn) =>
      updateFn(_localInicio ??= []);
  bool hasLocalInicio() => _localInicio != null;

  static LocaisPercorridosStruct fromMap(Map<String, dynamic> data) =>
      LocaisPercorridosStruct(
        locaisPercorridos: getDataList(data['LocaisPercorridos']),
        idTec: getDataList(data['id_tec']),
        idServic: getDataList(data['id_servic']),
        localFinal: getDataList(data['localFinal']),
        localInicio: getDataList(data['localInicio']),
      );

  static LocaisPercorridosStruct? maybeFromMap(dynamic data) => data is Map
      ? LocaisPercorridosStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'LocaisPercorridos': _locaisPercorridos,
        'id_tec': _idTec,
        'id_servic': _idServic,
        'localFinal': _localFinal,
        'localInicio': _localInicio,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'LocaisPercorridos': serializeParam(
          _locaisPercorridos,
          ParamType.LatLng,
          true,
        ),
        'id_tec': serializeParam(
          _idTec,
          ParamType.int,
          true,
        ),
        'id_servic': serializeParam(
          _idServic,
          ParamType.int,
          true,
        ),
        'localFinal': serializeParam(
          _localFinal,
          ParamType.LatLng,
          true,
        ),
        'localInicio': serializeParam(
          _localInicio,
          ParamType.LatLng,
          true,
        ),
      }.withoutNulls;

  static LocaisPercorridosStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      LocaisPercorridosStruct(
        locaisPercorridos: deserializeParam<LatLng>(
          data['LocaisPercorridos'],
          ParamType.LatLng,
          true,
        ),
        idTec: deserializeParam<int>(
          data['id_tec'],
          ParamType.int,
          true,
        ),
        idServic: deserializeParam<int>(
          data['id_servic'],
          ParamType.int,
          true,
        ),
        localFinal: deserializeParam<LatLng>(
          data['localFinal'],
          ParamType.LatLng,
          true,
        ),
        localInicio: deserializeParam<LatLng>(
          data['localInicio'],
          ParamType.LatLng,
          true,
        ),
      );

  @override
  String toString() => 'LocaisPercorridosStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is LocaisPercorridosStruct &&
        listEquality.equals(locaisPercorridos, other.locaisPercorridos) &&
        listEquality.equals(idTec, other.idTec) &&
        listEquality.equals(idServic, other.idServic) &&
        listEquality.equals(localFinal, other.localFinal) &&
        listEquality.equals(localInicio, other.localInicio);
  }

  @override
  int get hashCode => const ListEquality()
      .hash([locaisPercorridos, idTec, idServic, localFinal, localInicio]);
}

LocaisPercorridosStruct createLocaisPercorridosStruct() =>
    LocaisPercorridosStruct();
