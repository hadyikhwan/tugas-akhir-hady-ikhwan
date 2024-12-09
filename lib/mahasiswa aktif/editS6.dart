import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:skripsi/firestore%20service/DatabaseService.dart';

class editS6 extends StatelessWidget {
  const editS6({super.key});

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
  List<int> DesignVisual = [];
  List<int> VideoEditor = [];
  List<int> MachineLearning = [];
  List<int> Programming = [];
  List<int> Security = [];
  final Map<String, bool> _selectedSkills = {};

  void clearData() {
    DesignVisual.clear();
    VideoEditor.clear();
    MachineLearning.clear();
    Programming.clear();
    Security.clear();
  }

  void cekDesignVisual(int i) {
    switch (i) {
      case 0:
        _selectedSkills['illustrator'] = true;
        break;
      case 1:
        _selectedSkills['photoshop'] = true;
        break;
      case 2:
        _selectedSkills['coreldraw'] = true;
        break;
      case 3:
        _selectedSkills['sketch'] = true;
        break;
      case 4:
        _selectedSkills['adobeindesign'] = true;
        break;
      case 5:
        _selectedSkills['gimp'] = true;
        break;
      case 6:
        _selectedSkills['figma'] = true;
        break;
      case 7:
        _selectedSkills['affinity'] = true;
        break;
      case 8:
        _selectedSkills['sketchup'] = true;
        break;
      case 9:
        _selectedSkills['autocad'] = true;
        break;
      case 10:
        _selectedSkills['inkscape'] = true;
        break;
    }
  }

  void cekVideoEditing(int i) {
    switch (i) {
      case 0:
        _selectedSkills['premier'] = true;
        break;
      case 1:
        _selectedSkills['filmora'] = true;
        break;
      case 2:
        _selectedSkills['davinci'] = true;
        break;
    }
  }

  void cekMachineLearning(int i) {
    switch (i) {
      case 0:
        _selectedSkills['tensorflow'] = true;
        break;
      case 1:
        _selectedSkills['googlecolab'] = true;
        break;
      case 2:
        _selectedSkills['knime'] = true;
        break;
      case 3:
        _selectedSkills['keras'] = true;
        break;
      case 4:
        _selectedSkills['azure'] = true;
        break;
      case 5:
        _selectedSkills['shogun'] = true;
        break;
      case 6:
        _selectedSkills['pytorch'] = true;
        break;
    }
  }

  void cekProgramming(int i) {
    switch (i) {
      case 0:
        _selectedSkills['visualstudio'] = true;
        break;
      case 1:
        _selectedSkills['sublime'] = true;
    }
  }

  void cekSecurity(int i) {
    switch (i) {
      case 0:
        _selectedSkills['wireshark'] = true;
        break;
    }
  }

  void mengecekDataYangSudahDiload() {
    //design visual
    for (int i = 0; i < DesignVisual.length; i++) {
      cekDesignVisual(DesignVisual[i]);
    }
    //video editing
    for (int i = 0; i < VideoEditor.length; i++) {
      cekVideoEditing(VideoEditor[i]);
    }
    //machine learning
    for (int i = 0; i < MachineLearning.length; i++) {
      cekMachineLearning(MachineLearning[i]);
    }
    //programming
    for (int i = 0; i < Programming.length; i++) {
      cekProgramming(Programming[i]);
    }
    //security
    for (int i = 0; i < Security.length; i++) {
      cekSecurity(Security[i]);
    }
  }

bool isFirst = false;

  getNothing(){

  }
  getDataSkill() async {
    await FirebaseFirestore.instance
        .collection("User")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("software")
        .get()
        .then(
      (value) {
        value.docs.forEach((element) {
          int x = 0;
          x = element["aplikasi yang dikuasai"].length;
          switch (element.id.toString()) {
            case "designVisual":
              for (int i = 0; i < x; i++) {
                DesignVisual.add(element["aplikasi yang dikuasai"][i]);
              }
              break;
            case "videoEditor":
              for (int i = 0; i < x; i++) {
                VideoEditor.add(element["aplikasi yang dikuasai"][i]);
              }
              break;
            case "machineLearning":
              for (int i = 0; i < x; i++) {
                MachineLearning.add(element["aplikasi yang dikuasai"][i]);
              }
              break;
            case "programming":
              for (int i = 0; i < x; i++) {
                Programming.add(element["aplikasi yang dikuasai"][i]);
              }
              break;
            case "security":
              for (int i = 0; i < x; i++) {
                Security.add(element["aplikasi yang dikuasai"][i]);
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
          print("hasil pengambilan data : ");
          for (int i = 0; i < DesignVisual.length; i++) {
            print(DesignVisual[i]);
          }
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
                                  assetPath: 'assets/logo/illustrator.png',
                                  isSelected:
                                      _selectedSkills['illustrator'] ?? false,
                                  onTap: () {
                                    setState(() {
                                      _selectedSkills['illustrator'] =
                                          !(_selectedSkills['illustrator'] ??
                                              false);
                                      if (_selectedSkills['illustrator']!) {
                                        DesignVisual.add(0);
                                      } else {
                                        DesignVisual.remove(0);
                                      }
                                    });
                                  },
                                ),
                                SkillContainer(
                                  assetPath: 'assets/logo/photoshop.png',
                                  isSelected:
                                      _selectedSkills['photoshop'] ?? false,
                                  onTap: () {
                                    setState(() {
                                      _selectedSkills['photoshop'] =
                                          !(_selectedSkills['photoshop'] ??
                                              false);
                                      if (_selectedSkills['photoshop']!) {
                                        DesignVisual.add(1);
                                      } else {
                                        DesignVisual.remove(1);
                                      }
                                    });
                                  },
                                ),
                                SkillContainer(
                                  assetPath: 'assets/logo/coreldraw.png',
                                  isSelected:
                                      _selectedSkills['coreldraw'] ?? false,
                                  onTap: () {
                                    setState(() {
                                      _selectedSkills['coreldraw'] =
                                          !(_selectedSkills['coreldraw'] ??
                                              false);
                                      if (_selectedSkills['coreldraw']!) {
                                        DesignVisual.add(2);
                                      } else {
                                        DesignVisual.remove(2);
                                      }
                                    });
                                  },
                                ),
                                SkillContainer(
                                  assetPath: 'assets/logo/sketch.png',
                                  isSelected:
                                      _selectedSkills['sketch'] ?? false,
                                  onTap: () {
                                    setState(() {
                                      _selectedSkills['sketch'] =
                                          !(_selectedSkills['sketch'] ?? false);
                                      if (_selectedSkills['sketch']!) {
                                        DesignVisual.add(3);
                                      } else {
                                        DesignVisual.remove(3);
                                      }
                                    });
                                  },
                                ),
                                SkillContainer(
                                  assetPath: 'assets/logo/adobeindesign.png',
                                  isSelected:
                                      _selectedSkills['adobeindesign'] ?? false,
                                  onTap: () {
                                    setState(() {
                                      _selectedSkills['adobeindesign'] =
                                          !(_selectedSkills['adobeindesign'] ??
                                              false);
                                      if (_selectedSkills['adobeindesign']!) {
                                        DesignVisual.add(4);
                                      } else {
                                        DesignVisual.remove(4);
                                      }
                                    });
                                  },
                                ),
                                SkillContainer(
                                  assetPath: 'assets/logo/gimp.png',
                                  isSelected: _selectedSkills['gimp'] ?? false,
                                  onTap: () {
                                    setState(() {
                                      _selectedSkills['gimp'] =
                                          !(_selectedSkills['gimp'] ?? false);
                                      if (_selectedSkills['gimp']!) {
                                        DesignVisual.add(5);
                                      } else {
                                        DesignVisual.remove(5);
                                      }
                                    });
                                  },
                                ),
                                SkillContainer(
                                  assetPath: 'assets/logo/figma.png',
                                  isSelected: _selectedSkills['figma'] ?? false,
                                  onTap: () {
                                    setState(() {
                                      _selectedSkills['figma'] =
                                          !(_selectedSkills['figma'] ?? false);
                                      if (_selectedSkills['figma']!) {
                                        DesignVisual.add(6);
                                      } else {
                                        DesignVisual.remove(6);
                                      }
                                    });
                                  },
                                ),
                                SkillContainer(
                                  assetPath: 'assets/logo/affinity.png',
                                  isSelected:
                                      _selectedSkills['affinity'] ?? false,
                                  onTap: () {
                                    setState(() {
                                      _selectedSkills['affinity'] =
                                          !(_selectedSkills['affinity'] ??
                                              false);
                                      if (_selectedSkills['affinity']!) {
                                        DesignVisual.add(7);
                                      } else {
                                        DesignVisual.remove(7);
                                      }
                                    });
                                  },
                                ),
                                SkillContainer(
                                  assetPath: 'assets/logo/sketchup.png',
                                  isSelected:
                                      _selectedSkills['sketchup'] ?? false,
                                  onTap: () {
                                    setState(() {
                                      _selectedSkills['sketchup'] =
                                          !(_selectedSkills['sketchup'] ??
                                              false);
                                      if (_selectedSkills['sketchup']!) {
                                        DesignVisual.add(8);
                                      } else {
                                        DesignVisual.remove(8);
                                      }
                                    });
                                  },
                                ),
                                SkillContainer(
                                  assetPath: 'assets/logo/autocad.png',
                                  isSelected:
                                      _selectedSkills['autocad'] ?? false,
                                  onTap: () {
                                    setState(() {
                                      _selectedSkills['autocad'] =
                                          !(_selectedSkills['autocad'] ??
                                              false);
                                      if (_selectedSkills['autocad']!) {
                                        DesignVisual.add(9);
                                      } else {
                                        DesignVisual.remove(9);
                                      }
                                    });
                                  },
                                ),
                                SkillContainer(
                                  assetPath: 'assets/logo/inkscape.png',
                                  isSelected:
                                      _selectedSkills['inkscape'] ?? false,
                                  onTap: () {
                                    setState(() {
                                      _selectedSkills['inkscape'] =
                                          !(_selectedSkills['inkscape'] ??
                                              false);
                                      if (_selectedSkills['inkscape']!) {
                                        DesignVisual.add(10);
                                      } else {
                                        DesignVisual.remove(10);
                                      }
                                    });
                                  },
                                ),
                              ],
                            ),
                            SizedBox(height: 20),

                            // Development
                            Text(
                              '2. Vidio Editor',
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
                                  assetPath: 'assets/logo/premier.png',
                                  isSelected:
                                      _selectedSkills['premier'] ?? false,
                                  onTap: () {
                                    setState(() {
                                      _selectedSkills['premier'] =
                                          !(_selectedSkills['premier'] ??
                                              false);
                                      if (_selectedSkills['premier']!) {
                                        VideoEditor.add(0);
                                      } else {
                                        VideoEditor.remove(0);
                                      }
                                    });
                                  },
                                ),
                                SkillContainer(
                                  assetPath: 'assets/logo/filmora.png',
                                  isSelected:
                                      _selectedSkills['filmora'] ?? false,
                                  onTap: () {
                                    setState(() {
                                      _selectedSkills['filmora'] =
                                          !(_selectedSkills['filmora'] ??
                                              false);
                                      if (_selectedSkills['filmora']!) {
                                        VideoEditor.add(1);
                                      } else {
                                        VideoEditor.remove(1);
                                      }
                                    });
                                  },
                                ),
                                SkillContainer(
                                  assetPath: 'assets/logo/davinci.png',
                                  isSelected:
                                      _selectedSkills['davinci'] ?? false,
                                  onTap: () {
                                    setState(() {
                                      _selectedSkills['davinci'] =
                                          !(_selectedSkills['davinci'] ??
                                              false);
                                      if (_selectedSkills['davinci']!) {
                                        VideoEditor.add(2);
                                      } else {
                                        VideoEditor.remove(2);
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
                                  assetPath: 'assets/logo/tensorflow.png',
                                  isSelected:
                                      _selectedSkills['tensorflow'] ?? false,
                                  onTap: () {
                                    setState(() {
                                      _selectedSkills['tensorflow'] =
                                          !(_selectedSkills['tensorflow'] ??
                                              false);
                                      if (_selectedSkills['tensorflow']!) {
                                        MachineLearning.add(0);
                                      } else {
                                        MachineLearning.remove(0);
                                      }
                                    });
                                  },
                                ),
                                SkillContainer(
                                  assetPath: 'assets/logo/googlecolab.png',
                                  isSelected:
                                      _selectedSkills['googlecolab'] ?? false,
                                  onTap: () {
                                    setState(() {
                                      _selectedSkills['googlecolab'] =
                                          !(_selectedSkills['googlecolab'] ??
                                              false);
                                      if (_selectedSkills['googlecolab']!) {
                                        MachineLearning.add(1);
                                      } else {
                                        MachineLearning.remove(1);
                                      }
                                    });
                                  },
                                ),
                                SkillContainer(
                                  assetPath: 'assets/logo/knime.png',
                                  isSelected: _selectedSkills['knime'] ?? false,
                                  onTap: () {
                                    setState(() {
                                      _selectedSkills['knime'] =
                                          !(_selectedSkills['knime'] ?? false);
                                      if (_selectedSkills['knime']!) {
                                        MachineLearning.add(2);
                                      } else {
                                        MachineLearning.remove(2);
                                      }
                                    });
                                  },
                                ),
                                SkillContainer(
                                  assetPath: 'assets/logo/keras.png',
                                  isSelected: _selectedSkills['keras'] ?? false,
                                  onTap: () {
                                    setState(() {
                                      _selectedSkills['keras'] =
                                          !(_selectedSkills['keras'] ?? false);
                                      if (_selectedSkills['keras']!) {
                                        MachineLearning.add(3);
                                      } else {
                                        MachineLearning.remove(3);
                                      }
                                    });
                                  },
                                ),
                                SkillContainer(
                                  assetPath: 'assets/logo/azure.png',
                                  isSelected: _selectedSkills['azure'] ?? false,
                                  onTap: () {
                                    setState(() {
                                      _selectedSkills['azure'] =
                                          !(_selectedSkills['azure'] ?? false);
                                      if (_selectedSkills['azure']!) {
                                        MachineLearning.add(4);
                                      } else {
                                        MachineLearning.remove(4);
                                      }
                                    });
                                  },
                                ),
                                SkillContainer(
                                  assetPath: 'assets/logo/shogun.png',
                                  isSelected:
                                      _selectedSkills['shogun'] ?? false,
                                  onTap: () {
                                    setState(() {
                                      _selectedSkills['shogun'] =
                                          !(_selectedSkills['shogun'] ?? false);
                                      if (_selectedSkills['shogun']!) {
                                        MachineLearning.add(5);
                                      } else {
                                        MachineLearning.remove(5);
                                      }
                                    });
                                  },
                                ),
                                SkillContainer(
                                  assetPath: 'assets/logo/pytorch.png',
                                  isSelected:
                                      _selectedSkills['pytorch'] ?? false,
                                  onTap: () {
                                    setState(() {
                                      _selectedSkills['pytorch'] =
                                          !(_selectedSkills['pytorch'] ??
                                              false);
                                      if (_selectedSkills['pytorch']!) {
                                        MachineLearning.add(6);
                                      } else {
                                        MachineLearning.remove(6);
                                      }
                                    });
                                  },
                                ),
                              ],
                            ),
                            SizedBox(height: 20),

                            // Security
                            Text(
                              '4. Programming',
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
                                  assetPath: 'assets/logo/visualstudio.png',
                                  isSelected:
                                      _selectedSkills['visualstudio'] ?? false,
                                  onTap: () {
                                    setState(() {
                                      _selectedSkills['visualstudio'] =
                                          !(_selectedSkills['visualstudio'] ??
                                              false);
                                      if (_selectedSkills['visualstudio']!) {
                                        Programming.add(0);
                                      } else {
                                        Programming.remove(0);
                                      }
                                    });
                                  },
                                ),
                                SkillContainer(
                                  assetPath: 'assets/logo/sublime.png',
                                  isSelected:
                                      _selectedSkills['sublime'] ?? false,
                                  onTap: () {
                                    setState(() {
                                      _selectedSkills['sublime'] =
                                          !(_selectedSkills['sublime'] ??
                                              false);
                                      if (_selectedSkills['sublime']!) {
                                        Programming.add(1);
                                      } else {
                                        Programming.remove(1);
                                      }
                                    });
                                  },
                                ),
                              ],
                            ),

                            Text(
                              '5. Security',
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
                                  assetPath: 'assets/logo/wireshark.png',
                                  isSelected:
                                      _selectedSkills['wireshark'] ?? false,
                                  onTap: () {
                                    setState(() {
                                      _selectedSkills['wireshark'] =
                                          !(_selectedSkills['wireshark'] ??
                                              false);
                                      if (_selectedSkills['wireshark']!) {
                                        Security.add(0);
                                      } else {
                                        Security.remove(0);
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
                                    .deleteAllSoftware();
                                await Databaseservice(
                                        userID: FirebaseAuth
                                            .instance.currentUser!.uid)
                                    .addSoftware(DesignVisual, VideoEditor,
                                        MachineLearning, Programming, Security);

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
  final String assetPath;
  final bool isSelected;
  final VoidCallback onTap;

  const SkillContainer({
    required this.assetPath,
    required this.isSelected,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.blue, width: 2),
            ),
            child: CircleAvatar(
              radius: 30,
              backgroundColor: isSelected ? Colors.blue : Colors.white,
              child: Image.asset(
                assetPath,
                width: 30,
                height: 30,
                color: isSelected ? Colors.white : Colors.blue,
              ),
            ),
          ),
          // Remove the text under the icon
          // Text(
          //   skillName,
          //   style: TextStyle(
          //     fontSize: 12,
          //     fontWeight: FontWeight.bold,
          //   ),
          // ),
        ],
      ),
    );
  }
}
