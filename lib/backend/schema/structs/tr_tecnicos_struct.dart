// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class TrTecnicosStruct extends BaseStruct {
  TrTecnicosStruct({
    String? id,
  }) : _id = id;

  // "id" field.
  String? _id;
  String get id => _id ?? '';
  set id(String? val) => _id = val;
  bool hasId() => _id != null;

  static TrTecnicosStruct fromMap(Map<String, dynamic> data) =>
      TrTecnicosStruct(
        id: data['id'] as String?,
      );

  static TrTecnicosStruct? maybeFromMap(dynamic data) => data is Map
      ? TrTecnicosStruct.fromMap(data.cast<String, dynamic>())
      : null;

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
}) =>
    TrTecnicosStruct(
      id: id,
    );
