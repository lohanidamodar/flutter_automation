import 'package:cloud_firestore/cloud_firestore.dart';

class Note {
  final String id;
  final String title;
  final String description;
  final DateTime createdAt;

  Note({this.id,this.title, this.description, this.createdAt});

  factory Note.fromMap(Map data) {
    return Note(
      title: data['title'],
      description: data['description'],
      createdAt: data['created_at'],
    );
  }

  factory Note.fromFirestore(DocumentSnapshot doc) {
    return Note(
      id: doc.documentID,
      title: doc.data['title'],
      description: doc.data['description'],
      createdAt: doc.data['created_at'].toDate(),
    );
  }

  Map<String,dynamic> toMap() {
    return {
      "title":title,
      "description": description,
      "created_at":createdAt,
      "id":id,
    };
  }
}