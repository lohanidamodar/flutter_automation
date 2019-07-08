import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import '../model/note.dart';

class DatabaseService {
  final Firestore _db = Firestore.instance;

  Future<Note> getNote(String id) async {
    var snap = await _db.collection('notes').document(id).get();

    return Note.fromFirestore(snap);
  }

  Stream<Note> streamNote(String id) {
    return _db
        .collection('notes')
        .document(id)
        .snapshots()
        .map((snap) => Note.fromFirestore(snap));
  }

  Stream<List<Note>> streamNotes() {
    var ref = _db.collection('notes');

    return ref.snapshots().map((list) =>
        list.documents.map((doc) => Note.fromFirestore(doc)).toList());
  }

  Future<void> createNote(Note note) {
    return _db
        .collection('notes')
        .add(note.toMap());
  }

  Future<void> updateNote(Note note) {
    return _db
      .collection('notes')
      .document(note.id)
      .setData(note.toMap());
  }

  Future<void> removeNote(String id) {
    return _db
        .collection('notes')
        .document(id)
        .delete();
  }
}
