// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ServicoStruct extends BaseStruct {
  ServicoStruct({
    int? idServico,
    String? nomeServico,
  })  : _idServico = idServico,
        _nomeServico = nomeServico;

  // "Id_servico" field.
  int? _idServico;
  int get idServico => _idServico ?? 0;
  set idServico(int? val) => _idServico = val;
  void incrementIdServico(int amount) => _idServico = idServico + amount;
  bool hasIdServico() => _idServico != null;

  // "nome_servico" field.
  String? _nomeServico;
  String get nomeServico => _nomeServico ?? '';
  set nomeServico(String? val) => _nomeServico = val;
  bool hasNomeServico() => _nomeServico != null;

  static ServicoStruct fromMap(Map<String, dynamic> data) => ServicoStruct(
        idServico: castToType<int>(data['Id_servico']),
        nomeServico: data['nome_servico'] as String?,
      );

  static ServicoStruct? maybeFromMap(dynamic data) =>
      data is Map ? ServicoStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'Id_servico': _idServico,
        'nome_servico': _nomeServico,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'Id_servico': serializeParam(
          _idServico,
          ParamType.int,
        ),
        'nome_servico': serializeParam(
          _nomeServico,
          ParamType.String,
        ),
      }.withoutNulls;

  static ServicoStruct fromSerializableMap(Map<String, dynamic> data) =>
      ServicoStruct(
        idServico: deserializeParam(
          data['Id_servico'],
          ParamType.int,
          false,
        ),
        nomeServico: deserializeParam(
          data['nome_servico'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'ServicoStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is ServicoStruct &&
        idServico == other.idServico &&
        nomeServico == other.nomeServico;
  }

  @override
  int get hashCode => const ListEquality().hash([idServico, nomeServico]);
}

ServicoStruct createServicoStruct({
  int? idServico,
  String? nomeServico,
}) =>
    ServicoStruct(
      idServico: idServico,
      nomeServico: nomeServico,
    );
