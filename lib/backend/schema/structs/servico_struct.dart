// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ServicoStruct extends FFFirebaseStruct {
  ServicoStruct({
    int? idServico,
    String? nomeServico,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _idServico = idServico,
        _nomeServico = nomeServico,
        super(firestoreUtilData);

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
      data is Map<String, dynamic> ? ServicoStruct.fromMap(data) : null;

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
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    ServicoStruct(
      idServico: idServico,
      nomeServico: nomeServico,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

ServicoStruct? updateServicoStruct(
  ServicoStruct? servico, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    servico
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addServicoStructData(
  Map<String, dynamic> firestoreData,
  ServicoStruct? servico,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (servico == null) {
    return;
  }
  if (servico.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && servico.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final servicoData = getServicoFirestoreData(servico, forFieldValue);
  final nestedData = servicoData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = servico.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getServicoFirestoreData(
  ServicoStruct? servico, [
  bool forFieldValue = false,
]) {
  if (servico == null) {
    return {};
  }
  final firestoreData = mapToFirestore(servico.toMap());

  // Add any Firestore field values
  servico.firestoreUtilData.fieldValues.forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getServicoListFirestoreData(
  List<ServicoStruct>? servicos,
) =>
    servicos?.map((e) => getServicoFirestoreData(e, true)).toList() ?? [];
