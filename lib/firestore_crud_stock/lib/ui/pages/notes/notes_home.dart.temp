import 'add_note.dart';
import 'view_note.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../res/db_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../model/note.dart';

class NotesHomePage extends StatelessWidget {
  final auth = FirebaseAuth.instance;
  final db = DatabaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notes"),
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
              StreamProvider<List<Note>>.value(
                value: db.streamNotes(),
                child: NotesList(),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(
            builder: (_) => AddNotePage()
          ));
        },
      ),
    );
  }
}

class NotesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var notes = Provider.of<List<Note>>(context);
    if(notes == null || notes.length < 1) {
      return Container(child: Text("No notes found"),);
    }
    return Expanded(
      child: ListView(
        padding: const EdgeInsets.all(16.0),
        children: notes.map((note) {
          return Dismissible(
            direction: DismissDirection.endToStart,
            key: Key(note.id),
            background: Container(
              alignment: Alignment.centerRight,
              color: Colors.red,
              padding: const EdgeInsets.all(16.0),
              child: Icon(Icons.delete, color: Colors.white,),
            ),
            onDismissed: (direction) {
              DatabaseService().removeNote(note.id);
            },
            confirmDismiss: (direction) {
              return showDialog<bool>(
                context: context,
                builder: (_)=>AlertDialog(
                  title: Text("Are you sure you want to delete note?"),
                  actions: <Widget>[
                    FlatButton(
                      child: Text("Yes"),
                      onPressed: () => Navigator.pop(context,true),
                    ),
                    FlatButton(
                      child: Text("No"),
                      onPressed: () => Navigator.pop(context,false),
                    ),
                  ],
                )
              );
            },
            child: Card(
              child: ListTile(
                title: Text(note.title),
                subtitle: Text(note.description.substring(0,note.description.length < 20 ? note.description.length : 20) + (note.description.length < 20 ? "" : "...")),
                trailing: IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(
                      builder: (_) => AddNotePage(note: note)
                    ));
                  },
                  color: Colors.blue,
                ),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(
                    builder: (_) => NoteDetailsPage(note: note)
                  ));
                },
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
