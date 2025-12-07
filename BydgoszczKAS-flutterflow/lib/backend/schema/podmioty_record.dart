import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class PodmiotyRecord extends FirestoreRecord {
  PodmiotyRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "Lp" field.
  int? _lp;
  int get lp => _lp ?? 0;
  bool hasLp() => _lp != null;

  // "KRS" field.
  int? _krs;
  int get krs => _krs ?? 0;
  bool hasKrs() => _krs != null;

  // "Status" field.
  String? _status;
  String get status => _status ?? '';
  bool hasStatus() => _status != null;

  // "Ostatniskan" field.
  DateTime? _ostatniskan;
  DateTime? get ostatniskan => _ostatniskan;
  bool hasOstatniskan() => _ostatniskan != null;

  // "Alerty" field.
  int? _alerty;
  int get alerty => _alerty ?? 0;
  bool hasAlerty() => _alerty != null;

  // "Nazwapodmiotu" field.
  String? _nazwapodmiotu;
  String get nazwapodmiotu => _nazwapodmiotu ?? '';
  bool hasNazwapodmiotu() => _nazwapodmiotu != null;

  // "Adres" field.
  String? _adres;
  String get adres => _adres ?? '';
  bool hasAdres() => _adres != null;

  // "ZezwolenieInternet" field.
  String? _zezwolenieInternet;
  String get zezwolenieInternet => _zezwolenieInternet ?? '';
  bool hasZezwolenieInternet() => _zezwolenieInternet != null;

  // "StronaWWW" field.
  String? _stronaWWW;
  String get stronaWWW => _stronaWWW ?? '';
  bool hasStronaWWW() => _stronaWWW != null;

  // "Zezwoleniewpunktachnaziemnych" field.
  String? _zezwoleniewpunktachnaziemnych;
  String get zezwoleniewpunktachnaziemnych =>
      _zezwoleniewpunktachnaziemnych ?? '';
  bool hasZezwoleniewpunktachnaziemnych() =>
      _zezwoleniewpunktachnaziemnych != null;

  void _initializeFields() {
    _lp = castToType<int>(snapshotData['Lp']);
    _krs = castToType<int>(snapshotData['KRS']);
    _status = snapshotData['Status'] as String?;
    _ostatniskan = snapshotData['Ostatniskan'] as DateTime?;
    _alerty = castToType<int>(snapshotData['Alerty']);
    _nazwapodmiotu = snapshotData['Nazwapodmiotu'] as String?;
    _adres = snapshotData['Adres'] as String?;
    _zezwolenieInternet = snapshotData['ZezwolenieInternet'] as String?;
    _stronaWWW = snapshotData['StronaWWW'] as String?;
    _zezwoleniewpunktachnaziemnych =
        snapshotData['Zezwoleniewpunktachnaziemnych'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('podmioty');

  static Stream<PodmiotyRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => PodmiotyRecord.fromSnapshot(s));

  static Future<PodmiotyRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => PodmiotyRecord.fromSnapshot(s));

  static PodmiotyRecord fromSnapshot(DocumentSnapshot snapshot) =>
      PodmiotyRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static PodmiotyRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      PodmiotyRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'PodmiotyRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is PodmiotyRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createPodmiotyRecordData({
  int? lp,
  int? krs,
  String? status,
  DateTime? ostatniskan,
  int? alerty,
  String? nazwapodmiotu,
  String? adres,
  String? zezwolenieInternet,
  String? stronaWWW,
  String? zezwoleniewpunktachnaziemnych,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'Lp': lp,
      'KRS': krs,
      'Status': status,
      'Ostatniskan': ostatniskan,
      'Alerty': alerty,
      'Nazwapodmiotu': nazwapodmiotu,
      'Adres': adres,
      'ZezwolenieInternet': zezwolenieInternet,
      'StronaWWW': stronaWWW,
      'Zezwoleniewpunktachnaziemnych': zezwoleniewpunktachnaziemnych,
    }.withoutNulls,
  );

  return firestoreData;
}

class PodmiotyRecordDocumentEquality implements Equality<PodmiotyRecord> {
  const PodmiotyRecordDocumentEquality();

  @override
  bool equals(PodmiotyRecord? e1, PodmiotyRecord? e2) {
    return e1?.lp == e2?.lp &&
        e1?.krs == e2?.krs &&
        e1?.status == e2?.status &&
        e1?.ostatniskan == e2?.ostatniskan &&
        e1?.alerty == e2?.alerty &&
        e1?.nazwapodmiotu == e2?.nazwapodmiotu &&
        e1?.adres == e2?.adres &&
        e1?.zezwolenieInternet == e2?.zezwolenieInternet &&
        e1?.stronaWWW == e2?.stronaWWW &&
        e1?.zezwoleniewpunktachnaziemnych == e2?.zezwoleniewpunktachnaziemnych;
  }

  @override
  int hash(PodmiotyRecord? e) => const ListEquality().hash([
        e?.lp,
        e?.krs,
        e?.status,
        e?.ostatniskan,
        e?.alerty,
        e?.nazwapodmiotu,
        e?.adres,
        e?.zezwolenieInternet,
        e?.stronaWWW,
        e?.zezwoleniewpunktachnaziemnych
      ]);

  @override
  bool isValidKey(Object? o) => o is PodmiotyRecord;
}
