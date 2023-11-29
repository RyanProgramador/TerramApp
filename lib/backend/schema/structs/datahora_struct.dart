// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class DatahoraStruct extends BaseStruct {
  DatahoraStruct({
    DateTime? teste,
  }) : _teste = teste;

  // "teste" field.
  DateTime? _teste;
  DateTime? get teste => _teste;
  set teste(DateTime? val) => _teste = val;
  bool hasTeste() => _teste != null;

  static DatahoraStruct fromMap(Map<String, dynamic> data) => DatahoraStruct(
        teste: data['teste'] as DateTime?,
      );

  static DatahoraStruct? maybeFromMap(dynamic data) =>
      data is Map<String, dynamic> ? DatahoraStruct.fromMap(data) : null;

  Map<String, dynamic> toMap() => {
        'teste': _teste,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'teste': serializeParam(
          _teste,
          ParamType.DateTime,
        ),
      }.withoutNulls;

  static DatahoraStruct fromSerializableMap(Map<String, dynamic> data) =>
      DatahoraStruct(
        teste: deserializeParam(
          data['teste'],
          ParamType.DateTime,
          false,
        ),
      );

  @override
  String toString() => 'DatahoraStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is DatahoraStruct && teste == other.teste;
  }

  @override
  int get hashCode => const ListEquality().hash([teste]);
}

DatahoraStruct createDatahoraStruct({
  DateTime? teste,
}) =>
    DatahoraStruct(
      teste: teste,
    );
