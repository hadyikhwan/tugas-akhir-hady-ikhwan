import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

import 'package:skripsi/firestore%20service/DatabaseService.dart';

class editS3Alumni extends StatelessWidget {
  const editS3Alumni({Key? key}) : super(key: key);

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
  // final List<ExperienceForm> _experiences = [];

  // @override
  // void initState() {
  //   super.initState();
  //   _addExperience();
  // }

  // void _addExperience() {
  //   setState(() {
  //     _experiences.add(ExperienceForm(
  //       key: UniqueKey(),
  //       onDelete: _removeExperience,
  //     ));
  //   });
  // // }

  // void _removeExperience(Key key) {
  //   setState(() {
  //     _experiences.removeWhere((form) => form.key == key);
  //   });
  // }

  List<TextEditingController> yearController = [];
  List<TextEditingController> nameOfInstitutionController = [];
  List<TextEditingController> positionTitleController = [];
  List<TextEditingController> descriptionController = [];
  bool hapusExp = false;
  bool isLoadingSave = false;
  
  void addRange() {
    yearController.add(TextEditingController());
    nameOfInstitutionController.add(TextEditingController());
    positionTitleController.add(TextEditingController());
    descriptionController.add(TextEditingController());
     urlImage.add("");
    isUploading.add(false);
  }

  void removeRange(int index) {
    yearController.removeAt(index);
    nameOfInstitutionController.removeAt(index);
    positionTitleController.removeAt(index);
    descriptionController.removeAt(index);

    print(yearController.length.toString());
  }

  void normalState() {
    yearController.clear();
    nameOfInstitutionController.clear();
    positionTitleController.clear();
    descriptionController.clear();

    year.clear();
    institution.clear();
    position.clear();
    description.clear();
    urlImage.clear();
  }

  //data
  List<String> year = [];
  List<String> institution = [];
  List<String> position = [];
  List<String> description = [];
  List<bool> isUploading = [];
  bool kontol = false;
  getDataExperience() async {
    normalState();
    await FirebaseFirestore.instance
        .collection("User")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("experience")
        .get()
        .then(
      (value) {
        value.docs.forEach(
          (element) {
            year.add(element['year'].toString());
            institution.add(element['name of institution'].toString());
            position.add(element["position_title"].toString());
            description.add(element['job description'].toString());
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
      nameOfInstitutionController[i].text = institution[i];
      positionTitleController[i].text = position[i];
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
          .child('experience')
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
          future: kontol ? normal() : getDataExperience(),
          builder: (context, snapshot) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Experience',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    'Throughout my educational journey, I\'ve amassed a collection of Experiences\n that signify my dedication and perseverance.',
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
                            // ..._experiences.map((experience) {
                            //   return Padding(
                            //     padding: const EdgeInsets.symmetric(horizontal: 25.0),
                            //     child: experience,
                            //   );
                            // }).toList(),
                            for (int i = 0; i < yearController.length; i++)
                              experienceForm(
                                isUploading: isUploading[i],
                                haveUrlImage:
                                    urlImage[i] == "null" || urlImage[i] == ""
                                        ? false
                                        : true,
                                yearController: yearController[i],
                                nameOfInstitutionController:
                                    nameOfInstitutionController[i],
                                positionTitleController:
                                    positionTitleController[i],
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
                                  .deleteExperience();
                              print(
                                  "penghapusan data berhasil, dengan year controller : " +
                                      yearController.length.toString());

                              for (int i = 0;
                                  i < yearController.length;
                                  i++) {
                                    if (urlImage[i] == null) {
                                    urlImage[i] = "";
                                  }
                                await Databaseservice(
                                        userID: FirebaseAuth
                                            .instance.currentUser!.uid)
                                    .addExperience(
                                        yearController[i],
                                        nameOfInstitutionController[i],
                                        positionTitleController[i],
                                        descriptionController[i],
                                        urlImage[i]);
                              }
                              print("pembuatan data baru berhasil");
                              hapusExp = false;

                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("Save Successfull")));

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

class experienceForm extends StatelessWidget {
  final TextEditingController yearController;
  final TextEditingController nameOfInstitutionController;
  final TextEditingController positionTitleController;
  final TextEditingController descriptionController;
  final int index;
  final VoidCallback ontap;
  final VoidCallback uploadFileOnTap;
  final bool haveUrlImage;
  final bool isUploading;

  const experienceForm(
      {super.key,
      required this.yearController,
      required this.nameOfInstitutionController,
      required this.positionTitleController,
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
                      'Experience',
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
                      controller: nameOfInstitutionController,
                      decoration: const InputDecoration(
                        labelText: 'Name Of Institution :',
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
                          return 'Name Of Institution tidak boleh kosong';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      maxLines: 1,
                      controller: positionTitleController,
                      decoration: const InputDecoration(
                        labelText: 'Potition/Title :',
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
                          return 'Potition/Title tidak boleh kosong';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      maxLines: 2,
                      controller: descriptionController,
                      decoration: const InputDecoration(
                        labelText: 'Job Description :',
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
                          return 'Job Description tidak boleh kosong';
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

