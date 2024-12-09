// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unnecessary_new

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:skripsi/firestore%20service/DatabaseService.dart';
import 'package:skripsi/mahasiswa%20aktif/ecek.dart';
import 'package:skripsi/mahasiswa%20aktif/homepage.dart';
import 'package:skripsi/loginpage.dart';

class tracerStudy extends StatefulWidget {
  const tracerStudy({super.key});

  @override
  State<tracerStudy> createState() => _tracerStudyState();
}



class _tracerStudyState extends State<tracerStudy> {
  FilePickerResult? filePilihan;
  Reference? ref;
  UploadTask? uploadTask;
  bool EditisUpload = true;
  String? urlImage;

  bool loading = false;

  UploadGambar() async {
    try {
      //upload ke firebase storage
      ref = FirebaseStorage.instance
          .ref()
          .child('pengajuanTracerStudy')
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
      body: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Upload Foto SKL/Ijazah"),
                  SizedBox(
                    height: 25,
                  ),
                  GestureDetector(
                    onTap: () async {
                      FilePickerResult? x = await FilePicker.platform.pickFiles(
                          type: FileType.custom, allowedExtensions: ['pdf']);
                      if (x != null) {
                        setState(() {
                          loading = true;
                        });
                        filePilihan = x;
                        //upload to database
                        await UploadGambar();
                        urlImage = await ref!.getDownloadURL() as String?;
                        await Databaseservice(userID: FirebaseAuth.instance.currentUser!.uid).pengajuanTracerStudyUpload(urlImage!);
                        await Databaseservice(userID: FirebaseAuth.instance.currentUser!.uid).meninjauTracerStudy();
                        setState(() {
                          loading = false;
                        });
                        Navigator.pop(context);
                      }
                    },
                    child: Container(
                        width: 200,
                        height: 25,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.blue, width: 2),
                            color: const Color.fromARGB(255, 240, 240, 240)),
                        child: Center(
                            child: Text(
                                urlImage == null || urlImage == ""
                                    ? 'Upload file'
                                    : 'Update file',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue)))),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                        width: 150,
                        height: 25,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: Color.fromARGB(255, 255, 30, 30),
                                width: 2),
                            color: const Color.fromARGB(255, 240, 240, 240)),
                        child: Center(
                            child: Text("kembali",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 255, 30, 30))))),
                  ),
                ],
              ),
            ),
          ),
          Visibility(
            visible: loading,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colors.black26,
              child: Center(
                  child: Column(
                children: [
                  SizedBox(height: 50,),
                  Text("Mohon Tunggu, Sedang Upload ni", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                  SizedBox(
                    height: 15,
                  ),
                  CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ],
              )),
            ),
          ),
        ],
      ),
    );
  }
}
