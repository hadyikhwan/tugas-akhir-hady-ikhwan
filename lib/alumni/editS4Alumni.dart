import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:skripsi/firestore%20service/DatabaseService.dart';

class editS4Alumni extends StatelessWidget {
  const editS4Alumni({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 700,
      child: FormPage(),
    );
  }
}

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  List<TextEditingController> _skillControllers = [];
  List<TextEditingController> _percentageControllers = [];

  void clearData(){
    _skillControllers.clear();
    _percentageControllers.clear();
  }

  bool isFirst = false;

  getNothing(){}

  getDataPersonalSkill() async {
    await FirebaseFirestore.instance
        .collection("User")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("personalSkill")
        .get()
        .then(
      (value) {
        value.docs.forEach(
          (element) {
            print("object");
            _skillControllers.add(TextEditingController());
            _skillControllers[int.parse(element.id)].text =
                element["personalSkillName"].toString();
            _percentageControllers.add(TextEditingController());
            _percentageControllers[int.parse(element.id)].text =
                element["percentage"].toString();
          },
        );
      },
    );
    isFirst = true;

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: isFirst ? getNothing() : getDataPersonalSkill(),
          builder: (context, snapshot) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Profile Info',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    'With a focus on practical application and real-world relevance, these courses will equip\nyou with the competencies necessary to excel in today\'s dynamic and \ncompetitive environment.',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: Color.fromARGB(136, 70, 70, 70),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30),
                  Container(
                    width: 410,
                    height: 490,
                    padding: const EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.blue, width: 1),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.25),
                          spreadRadius: 0,
                          blurRadius: 5,
                          offset: Offset(5, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Container(
                              width: 270, // Set width manually
                              child: const Text(
                                'Your Personal Skill',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Container(
                              width: 80, // Set width manually
                              child: const Text(
                                'Percentage',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        // Expanded(
                        //   child: ListView.builder(
                        //     itemCount: _skillControllers.length,
                        //     itemBuilder: (context, index) {
                        //       return Column(
                        //         children: [
                        //           buildSkillRow(_skillControllers[index], _percentageControllers[index]),
                        //           const SizedBox(height: 10),
                        //         ],
                        //       );
                        //     },
                        //   ),
                        // ),
                        Container(
                          height: 365,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                _skillControllers.length == 0
                                    ? Text("Add Skill dulu")
                                    : Visibility(
                                        visible: false, child: Text("")),
                                for (int i = 0;
                                    i < _skillControllers.length;
                                    i++)
                                  buildSkillRow(_skillControllers[i],
                                      _percentageControllers[i])
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 170,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color.fromARGB(
                                            255, 70, 132, 0)),
                                    onPressed: () {
                                      setState(() {
                                        _skillControllers
                                            .add(TextEditingController());
                                        _percentageControllers
                                            .add(TextEditingController());
                                      });
                                    },
                                    child: Icon(
                                      Icons.add,
                                      color: Colors.white,
                                    ),
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.red),
                                    onPressed: () {
                                      setState(() {
                                        _skillControllers.removeLast();
                                        _percentageControllers.removeLast();
                                      });
                                    },
                                    child: Icon(
                                      Icons.delete,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Color.fromARGB(255, 5, 172, 249)),
                              onPressed: () async {
                                setState(() async {
                                  for (int i = 0;
                                      i < _percentageControllers.length;
                                      i++) {
                                    if (_percentageControllers[i].text == "") {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(
                                                  "isi semuanya dulu asu")));
                                      return;
                                    }
                                  }
                                  await Databaseservice(
                                          userID: FirebaseAuth
                                              .instance.currentUser!.uid)
                                      .deletePersonalSkill();
                                  for (int i = 0;
                                      i < _percentageControllers.length;
                                      i++) {
                                    await Databaseservice(
                                            userID: FirebaseAuth
                                                .instance.currentUser!.uid)
                                        .addPersonalSKill(
                                            i,
                                            _skillControllers[i].text,
                                            int.parse(_percentageControllers[i]
                                                .text));
                                  }

                                  clearData();
                                  setState(() {});

                                  isFirst = false;

                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text("Save Successfull")));
                                });
                              },
                              child: Icon(
                                Icons.save,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }

  Widget buildSkillRow(TextEditingController skillController,
      TextEditingController percentageController) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              width: 270, // Set width manually
              height: 40, // Set height manually
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Center(
                child: TextField(
                  controller: skillController,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText:
                        'Enter your personal skill, Example : public speach',
                    hintStyle:
                        TextStyle(fontStyle: FontStyle.italic, fontSize: 10),
                    contentPadding: EdgeInsets.symmetric(
                        vertical: 19), // Center text vertically
                  ),
                  style: const TextStyle(fontSize: 12),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Container(
              width: 80, // Set width manually
              height: 40, // Set height manually
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Center(
                child: TextField(
                  controller: percentageController,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: '1 - 100',
                    hintStyle: TextStyle(fontSize: 10),
                    contentPadding: EdgeInsets.symmetric(
                        vertical: 19), // Center text vertically
                  ),
                  style: const TextStyle(fontSize: 12),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 15,
        ),
      ],
    );
  }
}
