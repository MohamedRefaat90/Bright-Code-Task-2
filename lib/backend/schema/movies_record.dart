import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '../../bright_code/bright_code_util.dart';

class MoviesRecord extends FirestoreRecord {
  MoviesRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "title" field.
  String? _title;
  String get title => _title ?? '';
  bool hasTitle() => _title != null;

  // "image" field.
  String? _image;
  String get image => _image ?? '';
  bool hasImage() => _image != null;

  // "discription" field.
  String? _discription;
  String get discription => _discription ?? '';
  bool hasDiscription() => _discription != null;

  // "trailerLInke" field.
  String? _trailerLInke;
  String get trailerLInke => _trailerLInke ?? '';
  bool hasTrailerLInke() => _trailerLInke != null;

  // "gener" field.
  String? _gener;
  String get gener => _gener ?? '';
  bool hasGener() => _gener != null;

  // "lenth" field.
  String? _lenth;
  String get lenth => _lenth ?? '';
  bool hasLenth() => _lenth != null;

  // "year" field.
  int? _year;
  int get year => _year ?? 0;
  bool hasYear() => _year != null;

  // "likedByUser" field.
  List<DocumentReference>? _likedByUser;
  List<DocumentReference> get likedByUser => _likedByUser ?? const [];
  bool hasLikedByUser() => _likedByUser != null;

  void _initializeFields() {
    _title = snapshotData['title'] as String?;
    _image = snapshotData['image'] as String?;
    _discription = snapshotData['discription'] as String?;
    _trailerLInke = snapshotData['trailerLInke'] as String?;
    _gener = snapshotData['gener'] as String?;
    _lenth = snapshotData['lenth'] as String?;
    _year = castToType<int>(snapshotData['year']);
    _likedByUser = getDataList(snapshotData['likedByUser']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('movies');

  static Stream<MoviesRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => MoviesRecord.fromSnapshot(s));

  static Future<MoviesRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => MoviesRecord.fromSnapshot(s));

  static MoviesRecord fromSnapshot(DocumentSnapshot snapshot) => MoviesRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static MoviesRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      MoviesRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'MoviesRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is MoviesRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createMoviesRecordData({
  String? title,
  String? image,
  String? discription,
  String? trailerLInke,
  String? gener,
  String? lenth,
  int? year,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'title': title,
      'image': image,
      'discription': discription,
      'trailerLInke': trailerLInke,
      'gener': gener,
      'lenth': lenth,
      'year': year,
    }.withoutNulls,
  );

  return firestoreData;
}

class MoviesRecordDocumentEquality implements Equality<MoviesRecord> {
  const MoviesRecordDocumentEquality();

  @override
  bool equals(MoviesRecord? e1, MoviesRecord? e2) {
    const listEquality = ListEquality();
    return e1?.title == e2?.title &&
        e1?.image == e2?.image &&
        e1?.discription == e2?.discription &&
        e1?.trailerLInke == e2?.trailerLInke &&
        e1?.gener == e2?.gener &&
        e1?.lenth == e2?.lenth &&
        e1?.year == e2?.year &&
        listEquality.equals(e1?.likedByUser, e2?.likedByUser);
  }

  @override
  int hash(MoviesRecord? e) => const ListEquality().hash([
        e?.title,
        e?.image,
        e?.discription,
        e?.trailerLInke,
        e?.gener,
        e?.lenth,
        e?.year,
        e?.likedByUser
      ]);

  @override
  bool isValidKey(Object? o) => o is MoviesRecord;
}
