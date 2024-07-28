import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:skripsi/firestore%20service/DatabaseService.dart';

class editS5 extends StatelessWidget {
  const editS5({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1000,
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
  List<int> skill_DesignVisual = [];
  List<int> skill_ProgrammingLanguage = [];
  List<int> skill_MachineLearning = [];
  List<int> skill_Security = [];
  final Map<String, bool> _selectedSkills = {};

  void cekDesignVisual(int i) {
    switch (i) {
      case 0:
        _selectedSkills['UI/UX Design'] = true;
        break;
      case 1:
        _selectedSkills['Mockup Design'] = true;
        break;
      case 2:
        _selectedSkills['Design Graphic'] = true;
        break;
      case 3:
        _selectedSkills['Logo Design'] = true;
        break;
      case 4:
        _selectedSkills['Game Design'] = true;
        break;
      case 5:
        _selectedSkills['Industrial Design'] = true;
        break;
      case 6:
        _selectedSkills['Creative Design'] = true;
        break;
    }
  }

  void cekProgrammingLanguage(int i) {
    switch (i) {
      case 0:
        _selectedSkills['Java'] = true;
        break;
      case 1:
        _selectedSkills['Flutter'] = true;
        break;
      case 2:
        _selectedSkills['Python'] = true;
        break;
      case 3:
        _selectedSkills['Java Script'] = true;
        break;
      case 4:
        _selectedSkills['PHP'] = true;
        break;
      case 5:
        _selectedSkills['Kotlin'] = true;
        break;
      case 6:
        _selectedSkills['Dart'] = true;
        break;
      case 7:
        _selectedSkills['Golang'] = true;
        break;
      case 8:
        _selectedSkills['Swift'] = true;
        break;
      case 9:
        _selectedSkills['C++'] = true;
        break;
    }
  }

  void cekMachineLearning(int i) {
    switch (i) {
      case 0:
        _selectedSkills['Clasification'] = true;
        break;
      case 1:
        _selectedSkills['Regression'] = true;
        break;
      case 2:
        _selectedSkills['Clustering'] = true;
        break;
      case 3:
        _selectedSkills['Association'] = true;
        break;
      case 4:
        _selectedSkills['Deep Learning'] = true;
        break;
      case 5:
        _selectedSkills['Image Processing'] = true;
        break;
      case 6:
        _selectedSkills['Big Data'] = true;
        break;
      case 7:
        _selectedSkills['Image Clasification'] = true;
        break;
    }
  }

  void cekSecurity(int i) {
    switch (i) {
      case 0:
        _selectedSkills['IOT'] = true;
        break;
      case 1:
        _selectedSkills['Kriptografi'] = true;
        break;
      case 2:
        _selectedSkills['Firewall'] = true;
        break;
      case 3:
        _selectedSkills['Java Script'] = true;
        break;
      case 4:
        _selectedSkills['Cloud'] = true;
        break;
      case 5:
        _selectedSkills['Endpoint'] = true;
        break;
    }
  }

  void mengecekDataYangSudahDiload() {
    //design visual
    for (int i = 0; i < skill_DesignVisual.length; i++) {
      cekDesignVisual(skill_DesignVisual[i]);
    }
    //programming language
    for (int i = 0; i < skill_ProgrammingLanguage.length; i++) {
      cekProgrammingLanguage(skill_ProgrammingLanguage[i]);
    }
    //machine learning
    for (int i = 0; i < skill_MachineLearning.length; i++) {
      cekMachineLearning(skill_MachineLearning[i]);
    }
    //security
    for (int i = 0; i < skill_Security.length; i++) {
      cekSecurity(skill_Security[i]);
    }
  }

  void clearData() {
    skill_DesignVisual.clear();
    skill_ProgrammingLanguage.clear();
    skill_MachineLearning.clear();
    skill_Security.clear();
  }

  bool isFirst = false;

  getNothing() {}

  getDataSkill() async {
    await FirebaseFirestore.instance
        .collection("User")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("Skill")
        .get()
        .then(
      (value) {
        value.docs.forEach((element) {
          int x = 0;
          x = element["Skill yang dikuasai"].length;
          switch (element.id.toString()) {
            case "Design Visual":
              for (int i = 0; i < x; i++) {
                skill_DesignVisual.add(element["Skill yang dikuasai"][i]);
              }
              break;
            case "Proramming Language":
              for (int i = 0; i < x; i++) {
                skill_ProgrammingLanguage
                    .add(element["Skill yang dikuasai"][i]);
              }
              break;
            case "Machine Learning":
              for (int i = 0; i < x; i++) {
                skill_MachineLearning.add(element["Skill yang dikuasai"][i]);
              }
              break;
            case "Security":
              for (int i = 0; i < x; i++) {
                skill_Security.add(element["Skill yang dikuasai"][i]);
              }
              break;
          }
        });
      },
    );

    //
    mengecekDataYangSudahDiload();

    isFirst = true;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: isFirst ? getNothing() : getDataSkill(),
        builder: (context, snapshot) {
          return Scaffold(
            body: SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Soft Skills',
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Here are my soft skills that I have honed over time. I possess strong interpersonal\n skills, allowing me to build and maintain positive relationships with others.\n These soft skills collectively contribute to my effectiveness in various professional\n and personal endeavors.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Color.fromARGB(136, 70, 70, 70),
                        ),
                      ),
                      SizedBox(height: 50),
                      Container(
                        width: 800,
                        height: 1000,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.25),
                              spreadRadius: 0,
                              blurRadius: 5,
                              offset: Offset(5, 5),
                            ),
                          ],
                          border: Border.all(color: Colors.blue, width: 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Design Visual
                            Text(
                              '1. Design Visual',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue),
                            ),
                            SizedBox(height: 10),
                            Wrap(
                              spacing: 14,
                              runSpacing: 10,
                              children: [
                                SkillContainer(
                                  text: 'UI/UX Design',
                                  isSelected:
                                      _selectedSkills['UI/UX Design'] ?? false,
                                  onTap: () {
                                    setState(() {
                                      _selectedSkills['UI/UX Design'] =
                                          !(_selectedSkills['UI/UX Design'] ??
                                              false);
                                      if (_selectedSkills['UI/UX Design']!) {
                                        skill_DesignVisual.add(0);
                                      } else {
                                        skill_DesignVisual.remove(0);
                                      }
                                    });
                                  },
                                ),
                                SkillContainer(
                                  text: 'Mockup Design',
                                  isSelected:
                                      _selectedSkills['Mockup Design'] ?? false,
                                  onTap: () {
                                    setState(() {
                                      _selectedSkills['Mockup Design'] =
                                          !(_selectedSkills['Mockup Design'] ??
                                              false);
                                      if (_selectedSkills['Mockup Design']!) {
                                        skill_DesignVisual.add(1);
                                      } else {
                                        skill_DesignVisual.remove(1);
                                      }
                                    });
                                  },
                                ),
                                SkillContainer(
                                  text: 'Design Graphic',
                                  isSelected:
                                      _selectedSkills['Design Graphic'] ??
                                          false,
                                  onTap: () {
                                    setState(() {
                                      _selectedSkills['Design Graphic'] =
                                          !(_selectedSkills['Design Graphic'] ??
                                              false);
                                      if (_selectedSkills['Design Graphic']!) {
                                        skill_DesignVisual.add(2);
                                      } else {
                                        skill_DesignVisual.remove(2);
                                      }
                                    });
                                  },
                                ),
                                SkillContainer(
                                  text: 'Logo Design',
                                  isSelected:
                                      _selectedSkills['Logo Design'] ?? false,
                                  onTap: () {
                                    setState(() {
                                      _selectedSkills['Logo Design'] =
                                          !(_selectedSkills['Logo Design'] ??
                                              false);
                                      if (_selectedSkills['Logo Design']!) {
                                        skill_DesignVisual.add(3);
                                      } else {
                                        skill_DesignVisual.remove(3);
                                      }
                                    });
                                  },
                                ),
                                SkillContainer(
                                  text: 'Game Design',
                                  isSelected:
                                      _selectedSkills['Game Design'] ?? false,
                                  onTap: () {
                                    setState(() {
                                      _selectedSkills['Game Design'] =
                                          !(_selectedSkills['Game Design'] ??
                                              false);
                                      if (_selectedSkills['Game Design']!) {
                                        skill_DesignVisual.add(4);
                                      } else {
                                        skill_DesignVisual.remove(4);
                                      }
                                    });
                                  },
                                ),
                                SkillContainer(
                                  text: 'Industrial Design',
                                  isSelected:
                                      _selectedSkills['Industrial Design'] ??
                                          false,
                                  onTap: () {
                                    setState(() {
                                      _selectedSkills['Industrial Design'] =
                                          !(_selectedSkills[
                                                  'Industrial Design'] ??
                                              false);
                                      if (_selectedSkills[
                                          'Industrial Design']!) {
                                        skill_DesignVisual.add(5);
                                      } else {
                                        skill_DesignVisual.remove(5);
                                      }
                                    });
                                  },
                                ),
                                SkillContainer(
                                  text: 'Creative Design',
                                  isSelected:
                                      _selectedSkills['Creative Design'] ??
                                          false,
                                  onTap: () {
                                    setState(() {
                                      _selectedSkills['Creative Design'] =
                                          !(_selectedSkills[
                                                  'Creative Design'] ??
                                              false);
                                      if (_selectedSkills['Creative Design']!) {
                                        skill_DesignVisual.add(6);
                                      } else {
                                        skill_DesignVisual.remove(6);
                                      }
                                    });
                                  },
                                ),
                              ],
                            ),
                            SizedBox(height: 20),

                            // Development
                            Text(
                              '2. Programming Language',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue),
                            ),
                            SizedBox(height: 10),
                            Wrap(
                              spacing: 14,
                              runSpacing: 10,
                              children: [
                                SkillContainer(
                                  text: 'Java',
                                  isSelected: _selectedSkills['Java'] ?? false,
                                  onTap: () {
                                    setState(() {
                                      _selectedSkills['Java'] =
                                          !(_selectedSkills['Java'] ?? false);
                                      if (_selectedSkills['Java']!) {
                                        skill_ProgrammingLanguage.add(0);
                                      } else {
                                        skill_ProgrammingLanguage.remove(0);
                                      }
                                    });
                                  },
                                ),
                                SkillContainer(
                                  text: 'Flutter',
                                  isSelected:
                                      _selectedSkills['Flutter'] ?? false,
                                  onTap: () {
                                    setState(() {
                                      _selectedSkills['Flutter'] =
                                          !(_selectedSkills['Flutter'] ??
                                              false);
                                      if (_selectedSkills['Flutter']!) {
                                        skill_ProgrammingLanguage.add(1);
                                      } else {
                                        skill_ProgrammingLanguage.remove(1);
                                      }
                                    });
                                  },
                                ),
                                SkillContainer(
                                  text: 'Python',
                                  isSelected:
                                      _selectedSkills['Python'] ?? false,
                                  onTap: () {
                                    setState(() {
                                      _selectedSkills['Python'] =
                                          !(_selectedSkills['Python'] ?? false);
                                      if (_selectedSkills['Python']!) {
                                        skill_ProgrammingLanguage.add(2);
                                      } else {
                                        skill_ProgrammingLanguage.remove(2);
                                      }
                                    });
                                  },
                                ),
                                SkillContainer(
                                  text: 'Java Script',
                                  isSelected:
                                      _selectedSkills['Java Script'] ?? false,
                                  onTap: () {
                                    setState(() {
                                      _selectedSkills['Java Script'] =
                                          !(_selectedSkills['Java Script'] ??
                                              false);
                                      if (_selectedSkills['Java Script']!) {
                                        skill_ProgrammingLanguage.add(3);
                                      } else {
                                        skill_ProgrammingLanguage.remove(3);
                                      }
                                    });
                                  },
                                ),
                                SkillContainer(
                                  text: 'PHP',
                                  isSelected: _selectedSkills['PHP'] ?? false,
                                  onTap: () {
                                    setState(() {
                                      _selectedSkills['PHP'] =
                                          !(_selectedSkills['PHP'] ?? false);
                                      if (_selectedSkills['PHP']!) {
                                        skill_ProgrammingLanguage.add(4);
                                      } else {
                                        skill_ProgrammingLanguage.remove(4);
                                      }
                                    });
                                  },
                                ),
                                SkillContainer(
                                  text: 'Kotlin',
                                  isSelected:
                                      _selectedSkills['Kotlin'] ?? false,
                                  onTap: () {
                                    setState(() {
                                      _selectedSkills['Kotlin'] =
                                          !(_selectedSkills['Kotlin'] ?? false);
                                      if (_selectedSkills['Kotlin']!) {
                                        skill_ProgrammingLanguage.add(5);
                                      } else {
                                        skill_ProgrammingLanguage.remove(5);
                                      }
                                    });
                                  },
                                ),
                                SkillContainer(
                                  text: 'Dart',
                                  isSelected: _selectedSkills['Dart'] ?? false,
                                  onTap: () {
                                    setState(() {
                                      _selectedSkills['Dart'] =
                                          !(_selectedSkills['Dart'] ?? false);
                                      if (_selectedSkills['Dart']!) {
                                        skill_ProgrammingLanguage.add(6);
                                      } else {
                                        skill_ProgrammingLanguage.remove(6);
                                      }
                                    });
                                  },
                                ),
                                SkillContainer(
                                  text: 'Golang',
                                  isSelected:
                                      _selectedSkills['Golang'] ?? false,
                                  onTap: () {
                                    setState(() {
                                      _selectedSkills['Golang'] =
                                          !(_selectedSkills['Golang'] ?? false);
                                      if (_selectedSkills['Golang']!) {
                                        skill_ProgrammingLanguage.add(7);
                                      } else {
                                        skill_ProgrammingLanguage.remove(7);
                                      }
                                    });
                                  },
                                ),
                                SkillContainer(
                                  text: 'Swift',
                                  isSelected: _selectedSkills['Swift'] ?? false,
                                  onTap: () {
                                    setState(() {
                                      _selectedSkills['Swift'] =
                                          !(_selectedSkills['Swift'] ?? false);
                                      if (_selectedSkills['Swift']!) {
                                        skill_ProgrammingLanguage.add(8);
                                      } else {
                                        skill_ProgrammingLanguage.remove(8);
                                      }
                                    });
                                  },
                                ),
                                SkillContainer(
                                  text: 'C++',
                                  isSelected: _selectedSkills['C++'] ?? false,
                                  onTap: () {
                                    setState(() {
                                      _selectedSkills['C++'] =
                                          !(_selectedSkills['C++'] ?? false);
                                      if (_selectedSkills['C++']!) {
                                        skill_ProgrammingLanguage.add(9);
                                      } else {
                                        skill_ProgrammingLanguage.remove(9);
                                      }
                                    });
                                  },
                                ),
                              ],
                            ),
                            SizedBox(height: 20),

                            // Machine Learning
                            Text(
                              '3. Machine Learning',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue),
                            ),
                            SizedBox(height: 10),
                            Wrap(
                              spacing: 14,
                              runSpacing: 10,
                              children: [
                                SkillContainer(
                                  text: 'Clasification',
                                  isSelected:
                                      _selectedSkills['Clasification'] ?? false,
                                  onTap: () {
                                    setState(() {
                                      _selectedSkills['Clasification'] =
                                          !(_selectedSkills['Clasification'] ??
                                              false);
                                      if (_selectedSkills['Clasification']!) {
                                        skill_MachineLearning.add(0);
                                      } else {
                                        skill_MachineLearning.remove(0);
                                      }
                                    });
                                  },
                                ),
                                SkillContainer(
                                  text: 'Regression',
                                  isSelected:
                                      _selectedSkills['Regression'] ?? false,
                                  onTap: () {
                                    setState(() {
                                      _selectedSkills['Regression'] =
                                          !(_selectedSkills['Regression'] ??
                                              false);
                                      if (_selectedSkills['Regression']!) {
                                        skill_MachineLearning.add(1);
                                      } else {
                                        skill_MachineLearning.remove(1);
                                      }
                                    });
                                  },
                                ),
                                SkillContainer(
                                  text: 'Clustering',
                                  isSelected:
                                      _selectedSkills['Clustering'] ?? false,
                                  onTap: () {
                                    setState(() {
                                      _selectedSkills['Clustering'] =
                                          !(_selectedSkills['Clustering'] ??
                                              false);
                                      if (_selectedSkills['Clustering']!) {
                                        skill_MachineLearning.add(2);
                                      } else {
                                        skill_MachineLearning.remove(2);
                                      }
                                    });
                                  },
                                ),
                                SkillContainer(
                                  text: 'Association',
                                  isSelected:
                                      _selectedSkills['Association'] ?? false,
                                  onTap: () {
                                    setState(() {
                                      _selectedSkills['Association'] =
                                          !(_selectedSkills['Association'] ??
                                              false);
                                      if (_selectedSkills['Association']!) {
                                        skill_MachineLearning.add(3);
                                      } else {
                                        skill_MachineLearning.remove(3);
                                      }
                                    });
                                  },
                                ),
                                SkillContainer(
                                  text: 'Deep Learning',
                                  isSelected:
                                      _selectedSkills['Deep Learning'] ?? false,
                                  onTap: () {
                                    setState(() {
                                      _selectedSkills['Deep Learning'] =
                                          !(_selectedSkills['Deep Learning'] ??
                                              false);
                                      if (_selectedSkills['Deep Learning']!) {
                                        skill_MachineLearning.add(4);
                                      } else {
                                        skill_MachineLearning.remove(4);
                                      }
                                    });
                                  },
                                ),
                                SkillContainer(
                                  text: 'Image Processing',
                                  isSelected:
                                      _selectedSkills['Image Processing'] ??
                                          false,
                                  onTap: () {
                                    setState(() {
                                      _selectedSkills['Image Processing'] =
                                          !(_selectedSkills[
                                                  'Image Processing'] ??
                                              false);
                                      if (_selectedSkills[
                                          'Image Processing']!) {
                                        skill_MachineLearning.add(5);
                                      } else {
                                        skill_MachineLearning.remove(5);
                                      }
                                    });
                                  },
                                ),
                                SkillContainer(
                                  text: 'Big Data',
                                  isSelected:
                                      _selectedSkills['Big Data'] ?? false,
                                  onTap: () {
                                    setState(() {
                                      _selectedSkills['Big Data'] =
                                          !(_selectedSkills['Big Data'] ??
                                              false);
                                      if (_selectedSkills['Big Data']!) {
                                        skill_MachineLearning.add(6);
                                      } else {
                                        skill_MachineLearning.remove(6);
                                      }
                                    });
                                  },
                                ),
                                SkillContainer(
                                  text: 'Image Clasification',
                                  isSelected:
                                      _selectedSkills['Image Clasification'] ??
                                          false,
                                  onTap: () {
                                    setState(() {
                                      _selectedSkills['Image Clasification'] =
                                          !(_selectedSkills[
                                                  'Image Clasification'] ??
                                              false);
                                      if (_selectedSkills[
                                          'Image Clasification']!) {
                                        skill_MachineLearning.add(7);
                                      } else {
                                        skill_MachineLearning.remove(7);
                                      }
                                    });
                                  },
                                ),
                              ],
                            ),
                            SizedBox(height: 20),

                            // Security
                            Text(
                              '4. Security',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue),
                            ),
                            SizedBox(height: 10),
                            Wrap(
                              spacing: 14,
                              runSpacing: 10,
                              children: [
                                SkillContainer(
                                  text: 'IOT',
                                  isSelected: _selectedSkills['IOT'] ?? false,
                                  onTap: () {
                                    setState(() {
                                      _selectedSkills['IOT'] =
                                          !(_selectedSkills['IOT'] ?? false);
                                      if (_selectedSkills['IOT']!) {
                                        skill_Security.add(0);
                                      } else {
                                        skill_Security.remove(0);
                                      }
                                    });
                                  },
                                ),
                                SkillContainer(
                                  text: 'Kriptografi',
                                  isSelected:
                                      _selectedSkills['Kriptografi'] ?? false,
                                  onTap: () {
                                    setState(() {
                                      _selectedSkills['Kriptografi'] =
                                          !(_selectedSkills['Kriptografi'] ??
                                              false);
                                      if (_selectedSkills['Kriptografi']!) {
                                        skill_Security.add(1);
                                      } else {
                                        skill_Security.remove(1);
                                      }
                                    });
                                  },
                                ),
                                SkillContainer(
                                  text: 'Firewall',
                                  isSelected:
                                      _selectedSkills['Firewall'] ?? false,
                                  onTap: () {
                                    setState(() {
                                      _selectedSkills['Firewall'] =
                                          !(_selectedSkills['Firewall'] ??
                                              false);
                                      if (_selectedSkills['Firewall']!) {
                                        skill_Security.add(2);
                                      } else {
                                        skill_Security.remove(2);
                                      }
                                    });
                                  },
                                ),
                                SkillContainer(
                                  text: 'Java Script',
                                  isSelected:
                                      _selectedSkills['Java Script'] ?? false,
                                  onTap: () {
                                    setState(() {
                                      _selectedSkills['Java Script'] =
                                          !(_selectedSkills['Java Script'] ??
                                              false);
                                      if (_selectedSkills['Clasification']!) {
                                        skill_Security.add(3);
                                      } else {
                                        skill_Security.remove(3);
                                      }
                                    });
                                  },
                                ),
                                SkillContainer(
                                  text: 'Cloud',
                                  isSelected: _selectedSkills['Cloud'] ?? false,
                                  onTap: () {
                                    setState(() {
                                      _selectedSkills['Cloud'] =
                                          !(_selectedSkills['Cloud'] ?? false);
                                      if (_selectedSkills['Cloud']!) {
                                        skill_Security.add(4);
                                      } else {
                                        skill_Security.remove(4);
                                      }
                                    });
                                  },
                                ),
                                SkillContainer(
                                  text: 'Endpoint',
                                  isSelected:
                                      _selectedSkills['Endpoint'] ?? false,
                                  onTap: () {
                                    setState(() {
                                      _selectedSkills['Endpoint'] =
                                          !(_selectedSkills['Endpoint'] ??
                                              false);
                                      if (_selectedSkills['Endpoint']!) {
                                        skill_Security.add(5);
                                      } else {
                                        skill_Security.remove(5);
                                      }
                                    });
                                  },
                                ),
                              ],
                            ),
                            GestureDetector(
                              onTap: () async {
                                await Databaseservice(
                                        userID: FirebaseAuth
                                            .instance.currentUser!.uid)
                                    .deleteAllSkill();
                                await Databaseservice(
                                        userID: FirebaseAuth
                                            .instance.currentUser!.uid)
                                    .addSkill(
                                        skill_DesignVisual,
                                        skill_ProgrammingLanguage,
                                        skill_MachineLearning,
                                        skill_Security);

                                clearData();
                                setState(() {
                                  isFirst = false;
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text('Save data Successful')));
                              },
                              child: Container(
                                  height: 30,
                                  width: 80,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.blue, width: 2),
                                  ),
                                  child: const Center(
                                      child: Text('Save',
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.blue)))),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}

class SkillContainer extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const SkillContainer({
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 140, // Adjust the width as needed
        height: 40,
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue : Colors.white,
          border: Border.all(
            color: Colors.blue,
            width: 1,
          ),
        ),
        alignment: Alignment.center, // Align text to the center
        child: Text(
          text,
          style: TextStyle(
            fontSize: 14,
            color: isSelected ? Colors.white : Colors.blue,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
