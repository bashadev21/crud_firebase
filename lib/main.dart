import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyApp(),
    ));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String stdname, stdage, stddep, stdmark;
  getstdname(name) {
    this.stdname = name;
  }

  getstdage(age) {
    this.stdage = age;
  }

  getstddep(dep) {
    this.stddep = dep;
  }

  getstdmark(mark) {
    this.stdmark = mark;
  }

  createdata() {
    print('created');
    DocumentReference documentReference =
        Firestore.instance.collection('student details').document(stdname);
    Map<String, dynamic> students = {
      "studentdname": stdname,
      "studentage": stdage,
      "Department": stddep,
      "StudentMark": stdmark
    };
    documentReference.setData(students).whenComplete(() {
      print("$stdname created");
    });
  }

  readdata() {
    DocumentReference documentReference =
        Firestore.instance.collection('student details').document(stdname);
    documentReference.get().then((datasnapshot) {
      print(datasnapshot.data['studentdname']);
      print(datasnapshot.data['studentage']);
      print(datasnapshot.data['Department']);
      print(datasnapshot.data['StudentMark']);
    });
  }

  updatedata() {
    DocumentReference documentReference =
        Firestore.instance.collection('student details').document(stdname);
    Map<String, dynamic> students = {
      "studentdname": stdname,
      "studentage": stdage,
      "Department": stddep,
      "StudentMark": stdmark
    };
    documentReference.setData(students).whenComplete(() {
      print("$stdname updated");
    });
  }

  deletedata() {
    DocumentReference documentReference =
        Firestore.instance.collection('student details').document(stdname);
    documentReference.delete().whenComplete(() {
      print(('$stdname deleted'));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Curd'),
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(hintText: 'Name'),
              onChanged: (String name) {
                getstdname(name);
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(hintText: 'age'),
              onChanged: (String age) {
                getstdage(age);
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(hintText: 'dep'),
              onChanged: (String dep) {
                getstddep(dep);
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(hintText: 'mark'),
              onChanged: (String mark) {
                getstdmark(mark);
              },
            ),
          ),
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              RaisedButton(
                  child: Text('create'),
                  color: Colors.blue,
                  onPressed: () {
                    createdata();
                  }),
              RaisedButton(
                  child: Text('Read'),
                  color: Colors.green,
                  onPressed: () {
                    readdata();
                  }),
              RaisedButton(
                  child: Text('Update'),
                  color: Colors.orange,
                  onPressed: () {
                    updatedata();
                  }),
              RaisedButton(
                  child: Text('Delete'),
                  color: Colors.red,
                  onPressed: () {
                    deletedata();
                  }),
            ],
          ),
          // StreamBuilder(
          //     stream:
          //         Firestore.instance.collection("student details").snapshots(),
          //     builder: (context, snapshot) {
          //       if (snapshot.hasData) {
          //         return ListView.builder(
          //             shrinkWrap: true,
          //             itemCount: snapshot.data.documents.length,
          //             itemBuilder: (context, index) {
          //               DocumentSnapshot documentSnapshot =
          //                   snapshot.data.documents[index];
          //               return Row(
          //                 children: [
          //                   Expanded(
          //                     child: Text(documentSnapshot['studentdname']),
          //                   ),
          //                   Expanded(
          //                     child: Text(documentSnapshot['studentage']),
          //                   ),
          //                   Expanded(
          //                     child: Text(documentSnapshot['Department']),
          //                   ),
          //                   Expanded(
          //                     child: Text(documentSnapshot['StudentMark']),
          //                   ),
          //                 ],
          //               );
          //             });
          //       }
          //     })
        ],
      ),
    );
  }
}
