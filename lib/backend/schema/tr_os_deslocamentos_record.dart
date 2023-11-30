import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class TrOsDeslocamentosRecord extends FirestoreRecord {
  TrOsDeslocamentosRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "osdes_id" field.
  String? _osdesId;
  String get osdesId => _osdesId ?? '';
  bool hasOsdesId() => _osdesId != null;

  // "osdes_id_oserv" field.
  String? _osdesIdOserv;
  String get osdesIdOserv => _osdesIdOserv ?? '';
  bool hasOsdesIdOserv() => _osdesIdOserv != null;

  // "osdes_id_tec" field.
  String? _osdesIdTec;
  String get osdesIdTec => _osdesIdTec ?? '';
  bool hasOsdesIdTec() => _osdesIdTec != null;

  // "osdes_latitude_final" field.
  String? _osdesLatitudeFinal;
  String get osdesLatitudeFinal => _osdesLatitudeFinal ?? '';
  bool hasOsdesLatitudeFinal() => _osdesLatitudeFinal != null;

  // "osdes_latitude_inicial" field.
  String? _osdesLatitudeInicial;
  String get osdesLatitudeInicial => _osdesLatitudeInicial ?? '';
  bool hasOsdesLatitudeInicial() => _osdesLatitudeInicial != null;

  // "osdes_longitude_inicial" field.
  String? _osdesLongitudeInicial;
  String get osdesLongitudeInicial => _osdesLongitudeInicial ?? '';
  bool hasOsdesLongitudeInicial() => _osdesLongitudeInicial != null;

  // "osdes_longitude_final" field.
  String? _osdesLongitudeFinal;
  String get osdesLongitudeFinal => _osdesLongitudeFinal ?? '';
  bool hasOsdesLongitudeFinal() => _osdesLongitudeFinal != null;

  // "osdes_status" field.
  String? _osdesStatus;
  String get osdesStatus => _osdesStatus ?? '';
  bool hasOsdesStatus() => _osdesStatus != null;

  // "osdes_dthr_inicio" field.
  String? _osdesDthrInicio;
  String get osdesDthrInicio => _osdesDthrInicio ?? '';
  bool hasOsdesDthrInicio() => _osdesDthrInicio != null;

  // "osdes_dthr_fim" field.
  String? _osdesDthrFim;
  String get osdesDthrFim => _osdesDthrFim ?? '';
  bool hasOsdesDthrFim() => _osdesDthrFim != null;

  void _initializeFields() {
    _osdesId = snapshotData['osdes_id'] as String?;
    _osdesIdOserv = snapshotData['osdes_id_oserv'] as String?;
    _osdesIdTec = snapshotData['osdes_id_tec'] as String?;
    _osdesLatitudeFinal = snapshotData['osdes_latitude_final'] as String?;
    _osdesLatitudeInicial = snapshotData['osdes_latitude_inicial'] as String?;
    _osdesLongitudeInicial = snapshotData['osdes_longitude_inicial'] as String?;
    _osdesLongitudeFinal = snapshotData['osdes_longitude_final'] as String?;
    _osdesStatus = snapshotData['osdes_status'] as String?;
    _osdesDthrInicio = snapshotData['osdes_dthr_inicio'] as String?;
    _osdesDthrFim = snapshotData['osdes_dthr_fim'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('trOsDeslocamentos');

  static Stream<TrOsDeslocamentosRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => TrOsDeslocamentosRecord.fromSnapshot(s));

  static Future<TrOsDeslocamentosRecord> getDocumentOnce(
          DocumentReference ref) =>
      ref.get().then((s) => TrOsDeslocamentosRecord.fromSnapshot(s));

  static TrOsDeslocamentosRecord fromSnapshot(DocumentSnapshot snapshot) =>
      TrOsDeslocamentosRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static TrOsDeslocamentosRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      TrOsDeslocamentosRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'TrOsDeslocamentosRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is TrOsDeslocamentosRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createTrOsDeslocamentosRecordData({
  String? osdesId,
  String? osdesIdOserv,
  String? osdesIdTec,
  String? osdesLatitudeFinal,
  String? osdesLatitudeInicial,
  String? osdesLongitudeInicial,
  String? osdesLongitudeFinal,
  String? osdesStatus,
  String? osdesDthrInicio,
  String? osdesDthrFim,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'osdes_id': osdesId,
      'osdes_id_oserv': osdesIdOserv,
      'osdes_id_tec': osdesIdTec,
      'osdes_latitude_final': osdesLatitudeFinal,
      'osdes_latitude_inicial': osdesLatitudeInicial,
      'osdes_longitude_inicial': osdesLongitudeInicial,
      'osdes_longitude_final': osdesLongitudeFinal,
      'osdes_status': osdesStatus,
      'osdes_dthr_inicio': osdesDthrInicio,
      'osdes_dthr_fim': osdesDthrFim,
    }.withoutNulls,
  );

  return firestoreData;
}

class TrOsDeslocamentosRecordDocumentEquality
    implements Equality<TrOsDeslocamentosRecord> {
  const TrOsDeslocamentosRecordDocumentEquality();

  @override
  bool equals(TrOsDeslocamentosRecord? e1, TrOsDeslocamentosRecord? e2) {
    return e1?.osdesId == e2?.osdesId &&
        e1?.osdesIdOserv == e2?.osdesIdOserv &&
        e1?.osdesIdTec == e2?.osdesIdTec &&
        e1?.osdesLatitudeFinal == e2?.osdesLatitudeFinal &&
        e1?.osdesLatitudeInicial == e2?.osdesLatitudeInicial &&
        e1?.osdesLongitudeInicial == e2?.osdesLongitudeInicial &&
        e1?.osdesLongitudeFinal == e2?.osdesLongitudeFinal &&
        e1?.osdesStatus == e2?.osdesStatus &&
        e1?.osdesDthrInicio == e2?.osdesDthrInicio &&
        e1?.osdesDthrFim == e2?.osdesDthrFim;
  }

  @override
  int hash(TrOsDeslocamentosRecord? e) => const ListEquality().hash([
        e?.osdesId,
        e?.osdesIdOserv,
        e?.osdesIdTec,
        e?.osdesLatitudeFinal,
        e?.osdesLatitudeInicial,
        e?.osdesLongitudeInicial,
        e?.osdesLongitudeFinal,
        e?.osdesStatus,
        e?.osdesDthrInicio,
        e?.osdesDthrFim
      ]);

  @override
  bool isValidKey(Object? o) => o is TrOsDeslocamentosRecord;
}
