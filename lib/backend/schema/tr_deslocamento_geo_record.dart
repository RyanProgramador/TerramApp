import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class TrDeslocamentoGeoRecord extends FirestoreRecord {
  TrDeslocamentoGeoRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "des_latitude" field.
  String? _desLatitude;
  String get desLatitude => _desLatitude ?? '';
  bool hasDesLatitude() => _desLatitude != null;

  // "des_longitude" field.
  String? _desLongitude;
  String get desLongitude => _desLongitude ?? '';
  bool hasDesLongitude() => _desLongitude != null;

  // "osdes_id" field.
  DocumentReference? _osdesId;
  DocumentReference? get osdesId => _osdesId;
  bool hasOsdesId() => _osdesId != null;

  void _initializeFields() {
    _desLatitude = snapshotData['des_latitude'] as String?;
    _desLongitude = snapshotData['des_longitude'] as String?;
    _osdesId = snapshotData['osdes_id'] as DocumentReference?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('trDeslocamentoGeo');

  static Stream<TrDeslocamentoGeoRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => TrDeslocamentoGeoRecord.fromSnapshot(s));

  static Future<TrDeslocamentoGeoRecord> getDocumentOnce(
          DocumentReference ref) =>
      ref.get().then((s) => TrDeslocamentoGeoRecord.fromSnapshot(s));

  static TrDeslocamentoGeoRecord fromSnapshot(DocumentSnapshot snapshot) =>
      TrDeslocamentoGeoRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static TrDeslocamentoGeoRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      TrDeslocamentoGeoRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'TrDeslocamentoGeoRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is TrDeslocamentoGeoRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createTrDeslocamentoGeoRecordData({
  String? desLatitude,
  String? desLongitude,
  DocumentReference? osdesId,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'des_latitude': desLatitude,
      'des_longitude': desLongitude,
      'osdes_id': osdesId,
    }.withoutNulls,
  );

  return firestoreData;
}

class TrDeslocamentoGeoRecordDocumentEquality
    implements Equality<TrDeslocamentoGeoRecord> {
  const TrDeslocamentoGeoRecordDocumentEquality();

  @override
  bool equals(TrDeslocamentoGeoRecord? e1, TrDeslocamentoGeoRecord? e2) {
    return e1?.desLatitude == e2?.desLatitude &&
        e1?.desLongitude == e2?.desLongitude &&
        e1?.osdesId == e2?.osdesId;
  }

  @override
  int hash(TrDeslocamentoGeoRecord? e) =>
      const ListEquality().hash([e?.desLatitude, e?.desLongitude, e?.osdesId]);

  @override
  bool isValidKey(Object? o) => o is TrDeslocamentoGeoRecord;
}
