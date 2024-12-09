import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:skripsi/alumni/header_alumni.dart';

class Question {
  String? question;
  String? A, B, C, D;
}

class Kuesioner extends StatelessWidget {
  const Kuesioner({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: QuestionnairePage(),
    );
  }
}

class QuestionnairePage extends StatefulWidget {
  @override
  _QuestionnairePageState createState() => _QuestionnairePageState();
}

class _QuestionnairePageState extends State<QuestionnairePage> {
  // String uid = "o1XzMtYR1qhEDin7pxcMupjrRM43";
  String uid = FirebaseAuth.instance.currentUser!.uid;

  List<Question> _questions = [];
  List<int> _selectedAnswers = [];
  bool pertama = false;

  String dataYangAkanDiupload = "";
  Future uploadDataJawaban(List<int> x) async {
    dataYangAkanDiupload = "";
    for (int i = 0; i < x.length; i++) {
      dataYangAkanDiupload += x[i].toString() + " ";
    }

    await FirebaseFirestore.instance
        .collection("User")
        .doc(uid)
        .update({'jawabanKuesioner': dataYangAkanDiupload});
  }

  loadNothing() {}

  loadDataPertanyaan() async {
    await FirebaseFirestore.instance
        .collection("Admin")
        .doc("0")
        .collection("pertanyaan")
        .get()
        .then(
      (value) {
        value.docs.forEach(
          (element) {
            _questions.add(Question());
            _questions[_questions.length - 1].question = element["pertanyaan"];
            _questions[_questions.length - 1].A =
                element["jawabanA"].toString();
            _questions[_questions.length - 1].B =
                element["jawabanB"].toString();
            _questions[_questions.length - 1].C =
                element["jawabanC"].toString();
            _questions[_questions.length - 1].D =
                element["jawabanD"].toString();
          },
        );
      },
    );
    _selectedAnswers = List<int>.filled(_questions.length, 0);

    pertama = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeaderAlumni(),
      body: FutureBuilder(
          future: pertama ? loadNothing() : loadDataPertanyaan(),
          builder: (context, snapshot) {
            return SingleChildScrollView(
              child: Center(
                child: Container(
                    width: 550,
                    padding: EdgeInsets.all(16.0),
                    margin: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (int i = 0; i < _questions.length; i++)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _questions[i].question!,
                                  style: TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                RadioListTile(
                                  title: Text(_questions[i].A!,
                                      style: TextStyle(fontSize: 14.0)),
                                  value: 1,
                                  groupValue: _selectedAnswers[i],
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedAnswers[i] = value!;
                                      print(_selectedAnswers.toString());
                                    });
                                  },
                                ),
                                RadioListTile(
                                  title: Text(_questions[i].B!,
                                      style: TextStyle(fontSize: 14.0)),
                                  value: 2,
                                  groupValue: _selectedAnswers[i],
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedAnswers[i] = value!;
                                      print(_selectedAnswers.toString());
                                    });
                                  },
                                ),
                                RadioListTile(
                                  title: Text(_questions[i].C!,
                                      style: TextStyle(fontSize: 14.0)),
                                  value: 3,
                                  groupValue: _selectedAnswers[i],
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedAnswers[i] = value!;
                                      print(_selectedAnswers.toString());
                                    });
                                  },
                                ),
                                RadioListTile(
                                  title: Text(_questions[i].D!,
                                      style: TextStyle(fontSize: 14.0)),
                                  value: 4,
                                  groupValue: _selectedAnswers[i],
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedAnswers[i] = value!;
                                      print(_selectedAnswers.toString());
                                    });
                                  },
                                )
                              ],
                            )
                        ])),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Implementasikan logika untuk men-submit jawaban
          setState(() {
            uploadDataJawaban(_selectedAnswers);
          });
        },
        child: Icon(Icons.check),
      ),
    );
  }
}
