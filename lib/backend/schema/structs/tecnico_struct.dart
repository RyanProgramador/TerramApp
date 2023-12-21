// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class TecnicoStruct extends BaseStruct {
  TecnicoStruct({
    String? nomeTec,
    int? idTec,
  })  : _nomeTec = nomeTec,
        _idTec = idTec;

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
      data is Map ? TecnicoStruct.fromMap(data.cast<String, dynamic>()) : null;

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
}) =>
    TecnicoStruct(
      nomeTec: nomeTec,
      idTec: idTec,
    );
