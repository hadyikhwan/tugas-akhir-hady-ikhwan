import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:skripsi/firestore%20service/DatabaseService.dart';

class EditS1 extends StatelessWidget {
  const EditS1({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 800,
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
  FilePickerResult? filePilihan;
  Reference? ref;
  UploadTask? uploadTask;
  bool EditisUpload = true;
  String? urlImage;

  bool canSave = true;

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();
  final _instagramController = TextEditingController();
  final _emailController = TextEditingController();
  final _linkedinController = TextEditingController();
  final _githubController = TextEditingController();
  final _facebookController = TextEditingController();
  final _twiterController = TextEditingController();
  final _descriptionController = TextEditingController();

  UploadGambar() async {
    //cek data lagak that
    try {
      //upload ke firebase storage
      ref = FirebaseStorage.instance
          .ref()
          .child('gambar')
          .child('/' + filePilihan!.files.first.name);

      final metadata = SettableMetadata(contentType: 'image/jpeg');

      uploadTask = ref!.putData(filePilihan!.files.first.bytes!, metadata);

      await uploadTask!.whenComplete(() => null);
    } on FirebaseException catch (e) {
      print(e);
    }
  }

  getUsername() async {
    _nameController.text =
        await Databaseservice(userID: FirebaseAuth.instance.currentUser!.uid)
            .getDataUsername();
  }

  bool isfirst = false;

  getNothing() {
    print("loot kosong");
  }

  Future getBiodataUser() async {
    isfirst = true;

    String dataCek;
    return await FirebaseFirestore.instance
        .collection("User")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then(
      (value) {
        dataCek = value["alamat"];
        if (dataCek.isNotEmpty) {
          _addressController.text = value["alamat"];
          _phoneController.text = value["noHandphone"];
          _emailController.text = value["Email"];
          _instagramController.text = value["linkInstagram"];
          _twiterController.text = value["linkTwitter"];
          _facebookController.text = value["linkFacebook"];
          _linkedinController.text = value["linkLinkedin"];
          _githubController.text = value["linkGithub"];
          _descriptionController.text = value["deskripsi"];
          urlImage = value["linkFotoProfile"];
        }
      },
    );
  }

  saveData() async {
    await Databaseservice(userID: FirebaseAuth.instance.currentUser!.uid)
        .addBiodataUser(
            _nameController.text,
            _addressController.text,
            _phoneController.text,
            _emailController.text,
            _instagramController.text,
            _twiterController.text,
            _facebookController.text,
            _linkedinController.text,
            _githubController.text,
            _descriptionController.text,
            urlImage!);
  }

  @override
  Widget build(BuildContext context) {
    getUsername();

    return FutureBuilder(
        future: isfirst ? getNothing() : getBiodataUser(),
        builder: (context, snapshot) {
          return Scaffold(
            body: Center(
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
                    width: 500,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextFormField(
                            controller: _nameController,
                            decoration: const InputDecoration(
                              labelText: 'Nama',
                              labelStyle:
                                  TextStyle(fontSize: 12, color: Colors.blue),
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.blue, width: 1.0),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.blue, width: 1.0),
                              ),
                            ),
                            style: const TextStyle(fontSize: 12),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Nama tidak boleh kosong';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            controller: _addressController,
                            decoration: const InputDecoration(
                              labelText: 'Alamat',
                              labelStyle: TextStyle(fontSize: 12),
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.blue, width: 1),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.blue, width: 1),
                              ),
                            ),
                            style: const TextStyle(fontSize: 12),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Alamat tidak boleh kosong';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            controller: _phoneController,
                            decoration: const InputDecoration(
                              labelText: 'Nomor HP',
                              labelStyle: TextStyle(fontSize: 12),
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.blue, width: 1),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.blue, width: 1),
                              ),
                            ),
                            style: const TextStyle(fontSize: 12),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Nomor HP tidak boleh kosong';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            controller: _emailController,
                            decoration: const InputDecoration(
                              labelText: 'Email',
                              labelStyle: TextStyle(fontSize: 12),
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.blue, width: 1),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.blue, width: 1),
                              ),
                            ),
                            style: const TextStyle(fontSize: 12),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Email tidak boleh kosong';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            controller: _instagramController,
                            decoration: const InputDecoration(
                              labelText: 'Link Instagram',
                              labelStyle: TextStyle(fontSize: 12),
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.blue, width: 1),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.blue, width: 1),
                              ),
                            ),
                            style: const TextStyle(fontSize: 12),
                          ),
                          TextFormField(
                            controller: _twiterController,
                            decoration: const InputDecoration(
                              labelText: 'Link Twiter',
                              labelStyle: TextStyle(fontSize: 12),
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.blue, width: 1),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.blue, width: 1),
                              ),
                            ),
                            style: const TextStyle(fontSize: 12),
                          ),
                          TextFormField(
                            controller: _facebookController,
                            decoration: const InputDecoration(
                              labelText: 'Link Facebook',
                              labelStyle: TextStyle(fontSize: 12),
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.blue, width: 1),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.blue, width: 1),
                              ),
                            ),
                            style: const TextStyle(fontSize: 12),
                          ),
                          TextFormField(
                            controller: _linkedinController,
                            decoration: const InputDecoration(
                              labelText: 'Link LinkedIn',
                              labelStyle: TextStyle(fontSize: 12),
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.blue, width: 1),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.blue, width: 1),
                              ),
                            ),
                            style: const TextStyle(fontSize: 12),
                          ),
                          TextFormField(
                            controller: _githubController,
                            decoration: const InputDecoration(
                              labelText: 'Link GitHub',
                              labelStyle: TextStyle(fontSize: 12),
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.blue, width: 1),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.blue, width: 1),
                              ),
                            ),
                            style: const TextStyle(fontSize: 12),
                          ),
                          TextFormField(
                            controller: _descriptionController,
                            maxLines: null,
                            decoration: const InputDecoration(
                              labelText: 'Deskripsi',
                              labelStyle: TextStyle(fontSize: 12),
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.blue, width: 1),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.blue, width: 1),
                              ),
                            ),
                            style: const TextStyle(fontSize: 12),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Deskripsi tidak boleh kosong';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 30.0),
                          GestureDetector(
                            onTap: () async {
                              FilePickerResult? x =
                                  await FilePicker.platform.pickFiles();
                              if (x != null) {
                                setState(() {
                                canSave = false;
                                });
                                filePilihan = x;
                                //upload to database
                                await UploadGambar();
                                urlImage =
                                    await ref!.getDownloadURL() as String?;
                                print("url image : " + urlImage.toString());
                                EditisUpload = true;
                                setState(() {
                                  canSave = true;
                                });
                              }
                            },
                            child: Container(
                                height: 30,
                                width: 80,
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.blue, width: 2),
                                ),
                                child: Center(
                                    child: Text(
                                        urlImage == null || urlImage == ""
                                            ? 'Upload Foto'
                                            : 'Update Foto',
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blue)))),
                          ),
                          const SizedBox(height: 10.0),
                          ElevatedButton(
                            onPressed: () async {
                              if (canSave) {
                                if (urlImage == null) {
                                  urlImage = "";
                                }
                                isfirst = false;
                                print(urlImage);
                                setState(() {});
                                await saveData();
                                setState(() {});
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text('Save data Successful')));
                              }
                              
                            },
                            style: ElevatedButton.styleFrom(),
                            child: Container(
                                height: 30,
                                width: 80,
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.blue, width: 2),
                                ),
                                child: Center(
                                    child: Text('Save',
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: canSave
                                                ? Colors.blue
                                                : Colors.grey)))),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
