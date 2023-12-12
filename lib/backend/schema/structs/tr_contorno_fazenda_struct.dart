// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class TrContornoFazendaStruct extends BaseStruct {
  TrContornoFazendaStruct({
    List<LatLng>? latlng,
  }) : _latlng = latlng;

  // "latlng" field.
  List<LatLng>? _latlng;
  List<LatLng> get latlng => _latlng ?? const [];
  set latlng(List<LatLng>? val) => _latlng = val;
  void updateLatlng(Function(List<LatLng>) updateFn) =>
      updateFn(_latlng ??= []);
  bool hasLatlng() => _latlng != null;

  static TrContornoFazendaStruct fromMap(Map<String, dynamic> data) =>
      TrContornoFazendaStruct(
        latlng: getDataList(data['latlng']),
      );

  static TrContornoFazendaStruct? maybeFromMap(dynamic data) =>
      data is Map<String, dynamic>
          ? TrContornoFazendaStruct.fromMap(data)
          : null;

  Map<String, dynamic> toMap() => {
        'latlng': _latlng,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'latlng': serializeParam(
          _latlng,
          ParamType.LatLng,
          true,
        ),
      }.withoutNulls;

  static TrContornoFazendaStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      TrContornoFazendaStruct(
        latlng: deserializeParam<LatLng>(
          data['latlng'],
          ParamType.LatLng,
          true,
        ),
      );

  @override
  String toString() => 'TrContornoFazendaStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is TrContornoFazendaStruct &&
        listEquality.equals(latlng, other.latlng);
  }

  @override
  int get hashCode => const ListEquality().hash([latlng]);
}

TrContornoFazendaStruct createTrContornoFazendaStruct() =>
    TrContornoFazendaStruct();
