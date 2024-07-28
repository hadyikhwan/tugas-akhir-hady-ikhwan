import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

import 'package:skripsi/firestore%20service/DatabaseService.dart';

class editS2 extends StatelessWidget {
  const editS2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 450,
      child: FormPage(),
    );
  }
}

class FormPage extends StatefulWidget {
  const FormPage({Key? key}) : super(key: key);

  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  // final List<achievementForm> _Achievements = [];

  // @override
  // void initState() {
  //   super.initState();
  //   _addAchievement();
  // }

  // void _addAchievement() {
  //   setState(() {
  //     _Achievements.add(achievementForm(
  //       key: UniqueKey(),
  //       onDelete: _removeAchievement,
  //     ));
  //   });
  // // }

  // void _removeAchievement(Key key) {
  //   setState(() {
  //     _Achievements.removeWhere((form) => form.key == key);
  //   });
  // }

  List<TextEditingController> yearController = [];
  List<TextEditingController> nameOfCompetitionController = [];
  List<TextEditingController> rankingController = [];
  List<TextEditingController> descriptionController = [];
  bool hapusExp = false;
  bool isLoadingSave = false;

  void addRange() {
    yearController.add(TextEditingController());
    nameOfCompetitionController.add(TextEditingController());
    rankingController.add(TextEditingController());
    descriptionController.add(TextEditingController());
    urlImage.add("");
    isUploading.add(false);
  }

  void removeRange(int index) {
    yearController.removeAt(index);
    nameOfCompetitionController.removeAt(index);
    rankingController.removeAt(index);
    descriptionController.removeAt(index);

    print(yearController.length.toString());
  }

  void normalState() {
    yearController.clear();
    nameOfCompetitionController.clear();
    rankingController.clear();
    descriptionController.clear();

    year.clear();
    competition.clear();
    ranking.clear();
    description.clear();
    urlImage.clear();
  }

  //data
  List<String> year = [];
  List<String> competition = [];
  List<String> ranking = [];
  List<String> description = [];
  List<bool> isUploading = [];
  bool kontol = false;
  getDataAchievement() async {
    normalState();

    await FirebaseFirestore.instance
        .collection("User")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("achievement")
        .get()
        .then(
      (value) {
        value.docs.forEach(
          (element) {
            isUploading.add(false);
            year.add(element['year'].toString());
            competition.add(element['name of Competition'].toString());
            ranking.add(element["ranking"].toString());
            description.add(element['description'].toString());
            urlImage.add(element['linkDocument'].toString());
          },
        );
      },
    );

    print("pengambilan data berhasil dengan total data adalah : " +
        year.length.toString());

    //pembuatan data
    for (int i = 0; i < year.length; i++) {
      addRange();
    }
    //pengisian data
    for (int i = 0; i < year.length; i++) {
      yearController[i].text = year[i];
      nameOfCompetitionController[i].text = competition[i];
      rankingController[i].text = ranking[i];
      descriptionController[i].text = description[i];
    }

    kontol = true;
  }

  normal() {}

  FilePickerResult? filePilihan;
  Reference? ref;
  UploadTask? uploadTask;
  bool EditisUpload = true;
  List<String> urlImage = [];

  bool canSave = true;

  UploadGambar() async {
    //cek data lagak that
    try {
      //upload ke firebase storage
      ref = FirebaseStorage.instance
          .ref()
          .child('achievement')
          .child('/' + filePilihan!.files.first.name);

      final metadata = SettableMetadata(contentType: 'application/pdf');

      uploadTask = ref!.putData(filePilihan!.files.first.bytes!, metadata);

      await uploadTask!.whenComplete(() => null);
    } on FirebaseException catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: kontol ? normal() : getDataAchievement(),
          builder: (context, snapshot) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Achievement',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    'Throughout my educational journey, I\'ve amassed a collection of Achievements\n that signify my dedication and perseverance.',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: Color.fromARGB(136, 70, 70, 70),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Column(
                    children: [
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // ..._Achievements.map((Achievement) {
                            //   return Padding(
                            //     padding: const EdgeInsets.symmetric(horizontal: 25.0),
                            //     child: Achievement,
                            //   );
                            // }).toList(),
                            for (int i = 0; i < yearController.length; i++)
                              achievementForm(
                                isUploading: isUploading[i],
                                haveUrlImage:
                                    urlImage[i] == "null" || urlImage[i] == ""
                                        ? false
                                        : true,
                                yearController: yearController[i],
                                nameOfCompetitionController:
                                    nameOfCompetitionController[i],
                                rankingController: rankingController[i],
                                descriptionController: descriptionController[i],
                                index: i,
                                ontap: () {
                                  hapusExp = true;
                                  removeRange(i);
                                  setState(() {});
                                },
                                uploadFileOnTap: () async {
                                  FilePickerResult? x =
                                      await FilePicker.platform.pickFiles(
                                    type: FileType.custom,
                                    allowedExtensions: ['pdf'],
                                  );
                                  if (x != null) {
                                    setState(() {
                                      isUploading[i] = true;
                                      canSave = false;
                                    });
                                    filePilihan = x;
                                    //upload to database
                                    await UploadGambar();
                                    urlImage[i] = await ref!.getDownloadURL();
                                    print("url image : " + urlImage.toString());
                                    EditisUpload = true;
                                    setState(() {
                                      isUploading[i] = false;
                                      canSave = true;
                                    });
                                  }
                                },
                              ),
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  addRange();
                                });
                              }, // Call the method directly
                              child: const Text('Add +'),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          if (canSave) {
                            if (!isLoadingSave) {
                              isLoadingSave = true;
                              setState(() {});
                              setState(() async {
                                await Databaseservice(
                                        userID: FirebaseAuth
                                            .instance.currentUser!.uid)
                                    .deleteAchievement();
                                for (int i = 0;
                                    i < yearController.length;
                                    i++) {
                                  if (urlImage[i] == null) {
                                    urlImage[i] = "";
                                  }
                                  await Databaseservice(
                                          userID: FirebaseAuth
                                              .instance.currentUser!.uid)
                                      .addAchievement(
                                          yearController[i],
                                          nameOfCompetitionController[i],
                                          rankingController[i],
                                          descriptionController[i],
                                          urlImage[i]);
                                }
                                print("pembuatan data baru berhasil");
                                hapusExp = false;

                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text("Save Successfull")));

                                isLoadingSave = false;
                                kontol = false;
                                setState(() {});
                              });
                            }
                          }
                        },
                        child: Container(
                            height: 15,
                            width: 80,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.blue, width: 2),
                            ),
                            child: Center(
                                child: isLoadingSave
                                    ? CircularProgressIndicator(
                                        color: Colors.white,
                                      )
                                    : Text('Save',
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blue)))),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),
    );
  }
}

class achievementForm extends StatelessWidget {
  final TextEditingController yearController;
  final TextEditingController nameOfCompetitionController;
  final TextEditingController rankingController;
  final TextEditingController descriptionController;
  final int index;
  final VoidCallback ontap;
  final VoidCallback uploadFileOnTap;
  final bool haveUrlImage;
  final bool isUploading;

  const achievementForm(
      {super.key,
      required this.yearController,
      required this.nameOfCompetitionController,
      required this.rankingController,
      required this.descriptionController,
      required this.index,
      required this.ontap,
      required this.uploadFileOnTap,
      required this.haveUrlImage,
      required this.isUploading});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            SizedBox(
              width: 350, // Set the maximum width
              height: 330, // Set the maximum height
              child: Container(
                padding: const EdgeInsets.all(20.0),
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
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Achievement',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    TextFormField(
                      maxLines: 1,
                      controller: yearController,
                      decoration: const InputDecoration(
                        labelText: 'Year :',
                        labelStyle: TextStyle(fontSize: 12, color: Colors.blue),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue, width: 1),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue, width: 1),
                        ),
                      ),
                      style: const TextStyle(fontSize: 12),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Tahun tidak boleh kosong';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      maxLines: 1,
                      controller: nameOfCompetitionController,
                      decoration: const InputDecoration(
                        labelText: 'Name Of Competition :',
                        labelStyle: TextStyle(fontSize: 12),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue, width: 1),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue, width: 1),
                        ),
                      ),
                      style: const TextStyle(fontSize: 12),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Name Of Competition tidak boleh kosong';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      maxLines: 1,
                      controller: rankingController,
                      decoration: const InputDecoration(
                        labelText: 'rangking :',
                        labelStyle: TextStyle(fontSize: 12),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue, width: 1),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue, width: 1),
                        ),
                      ),
                      style: const TextStyle(fontSize: 12),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'rangking tidak boleh kosong';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      maxLines: 2,
                      controller: descriptionController,
                      decoration: const InputDecoration(
                        labelText: 'Description :',
                        labelStyle: TextStyle(fontSize: 12),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue, width: 1),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue, width: 1),
                        ),
                      ),
                      style: const TextStyle(fontSize: 12),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Description tidak boleh kosong';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7),
                          side: BorderSide(width: 1, color: Colors.blue),
                        ),
                        textStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      onPressed: () {
                        uploadFileOnTap();
                      },
                      // onPressed: _pickPdf,
                      child: isUploading
                          ? CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : Text(haveUrlImage ? 'Change File' : 'Upload File'),
                    ),
                    // if (_file != null)
                    //   Text(
                    //     'File selected: ${_file!.path}',
                    //     style: TextStyle(fontSize: 12),
                    //   ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 7,
              right: 7,
              child: GestureDetector(
                onTap: () {
                  ontap();
                },
                child: Container(
                  width: 25,
                  height: 25,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue,
                  ),
                  child: Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
