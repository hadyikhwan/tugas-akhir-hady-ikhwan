// custom_app_bar.dart
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:skripsi/mahasiswa%20aktif/ecek.dart';
import 'package:skripsi/mahasiswa%20aktif/edit.dart';
import 'package:skripsi/mahasiswa%20aktif/homepage.dart';
import 'package:skripsi/landingpage.dart';

import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:flutter/services.dart' show Uint8List, rootBundle;
import 'package:pdf/pdf.dart' as pw;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:skripsi/registrasiTracerStudy.dart';

class experienceComponents {
  String jobDescription = "";
  String linkDocument = "";
  String nameOfInstitution = "";
  String positionTitle = "";
  String year = "";
}

class achievementComponents {
  String deskripsi = "";
  String linkDocument = "";
  String nameOfCompetition = "";
  String ranking = "";
  String year = "";
}

class experience {
  String? description;
  String? year;
  String? institution;
}

class achievement {
  String? description;
  String? year;
  String? Competition;
}

class header extends StatelessWidget implements PreferredSizeWidget {
  const header({super.key});

  @override
  Size get preferredSize => Size.fromHeight(65);

  @override
  Widget build(BuildContext context) {
    String namaUser = "";
    String urlImage = "";
    String deskripsi = "";
    String alamat = "";
    String facebook = "";
    String github = "";
    String linkedin = "";
    String twiter = "";
    String email = "";
    String whatsapp = "";
    List<experience> experienceDataUser = [];
    List<achievement> achievementDataUser = [];

    final pdf = pw.Document();
    var image;

    FilePickerResult? filePilihan;
    Reference? ref;
    UploadTask? uploadTask;
    bool EditisUpload = true;
    String? urlImageUpload;
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

    getDataBiodata() async {
      await FirebaseFirestore.instance
          .collection("User")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get()
          .then(
        (value) {
          namaUser = value['username'];
          urlImage = value['linkFotoProfile'];
          deskripsi = value['deskripsi'];
          alamat = value['alamat'];
          github = value['linkGithub'];
          twiter = value['linkTwitter'];
          facebook = value['linkFacebook'];
          linkedin = value['linkLinkedin'];
          email = value['Email'];
          whatsapp = value['noHandphone'];
        },
      );
      await FirebaseFirestore.instance
          .collection("User")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("experience")
          .get()
          .then(
        (value) {
          value.docs.forEach(
            (element) {
              experienceDataUser.add(experience());
              experienceDataUser[experienceDataUser.length - 1].year =
                  element['year'];
              experienceDataUser[experienceDataUser.length - 1].institution =
                  element['name of institution'];
              experienceDataUser[experienceDataUser.length - 1].description =
                  element['job description'];
            },
          );
        },
      );

      await FirebaseFirestore.instance
          .collection("User")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("achievement")
          .get()
          .then(
        (value) {
          value.docs.forEach(
            (element) {
              achievementDataUser.add(achievement());
              achievementDataUser[achievementDataUser.length - 1].year =
                  element['year'];
              achievementDataUser[achievementDataUser.length - 1].Competition =
                  element['name of Competition'];
              achievementDataUser[achievementDataUser.length - 1].description =
                  element['description'];
            },
          );
        },
      );
    }

    downloadPdfBoss() async {
      await getDataBiodata();
      final pdf = pw.Document();
      final image =
          (await rootBundle.load('assets/foto.jpg')).buffer.asUint8List();
      pdf.addPage(pw.Page(
        build: (context) {
          return pw.Builder(
            builder: (context) => pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Row(
                    children: [
                      pw.Container(
                        width: 80,
                        height: 80,
                        child: pw.Image(pw.MemoryImage(image)),
                      ),
                      pw.SizedBox(width: 16.0),
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text(
                            namaUser,
                            style: pw.TextStyle(
                              fontSize: 14,
                              fontWeight: pw.FontWeight.bold,
                              color: pw.PdfColors.blueGrey900,
                            ),
                          ),
                          _buildPDFRichText('Address:  ', alamat),
                          _buildPDFRichText('Phone:     ', whatsapp),
                          _buildPDFRichText('Email:       ', email),
                          _buildPDFRichText('LinkedIn:   ', linkedin),
                        ],
                      ),
                    ],
                  ),
                  pw.SizedBox(height: 15.0),
                  _pdfSectionTitle('SUMMARY'),
                  pw.Divider(thickness: 2, color: pw.PdfColors.blueGrey900),
                  _pdfSectionContent(
                    deskripsi,
                  ),
                  pw.SizedBox(height: 15.0),
                  _pdfSectionTitle('EXPERIENCE'),
                  pw.Divider(thickness: 2, color: pw.PdfColors.blueGrey900),
                  for (int i = 0;
                      experienceDataUser.length >= 4
                          ? i < 4
                          : i < experienceDataUser.length;
                      i++)
                    _pdfExperienceEntry(
                      experienceDataUser[i].institution!,
                      experienceDataUser[i].year!,
                      experienceDataUser[i].description!,
                    ),
                  pw.SizedBox(height: 15.0),
                  _pdfSectionTitle('ACHIEVEMENT'),
                  pw.Divider(thickness: 2, color: pw.PdfColors.blueGrey900),
                  for (int i = 0;
                      achievementDataUser.length >= 3
                          ? i < 3
                          : i < achievementDataUser.length;
                      i++)
                    _pdfAchievementEntry(
                      achievementDataUser[i].Competition!,
                      achievementDataUser[i].year!,
                      achievementDataUser[i].description!,
                    ),
                  pw.SizedBox(height: 20.0),
                  _pdfSectionTitle('ADDITIONAL INFORMATION'),
                  pw.Divider(thickness: 2, color: pw.PdfColors.blueGrey900),
                  _buildPDFRichTextAditional(
                    'Personal Skills: ',
                    'Public Speaking, Problem Solving, Time Management, Critical Thinking, Teamwork, Leadership',
                  ),
                  _buildPDFRichTextAditional('Software Skills: ',
                      'Photoshop, Illustrator, CorelDraw, Filmoram, Premier, Blender, After Effect, Sketch Up, Android Studio, Jupyter Notebook'),
                  _buildPDFRichTextAditional(
                    'Programming Languages: ',
                    'Dart, C++, Swift, PHP, HTML, CSS, Python, Kotlin, JavaScript, Java, Go',
                  ),
                  _buildPDFRichTextAditional(
                    'Machine Learning: ',
                    'Classification, Regression, Clustering',
                  ),
                ]),
          );
        },
      ));

      await Printing.sharePdf(bytes: await pdf.save(), filename: 'resume.pdf');
    }

    Future<bool> cekStatusTinjauanTracerStudy() async {
      bool x = false;
      await FirebaseFirestore.instance
          .collection("User")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get()
          .then((onValue) {
        x = onValue['tracerStudySedangDitinjau'];
      });
      return x;
    }

    return AppBar(
      toolbarHeight: 65,
      backgroundColor: Colors.white,
      title: Row(
        children: [
          Image.asset(
            'assets/uinar.png',
            width: 65,
            height: 65,
          ),
          Text(
            'Teknologi Informasi',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Homepage_mahasiswa()));
          },
          child: Text('Homepage', style: TextStyle(color: Colors.black)),
        ),
        TextButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => MyApp1()));
          },
          child: Text('Portofolio', style: TextStyle(color: Colors.black)),
        ),
        TextButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => edit()));
          },
          child: Text('Edit Portofolio', style: TextStyle(color: Colors.black)),
        ),
        TextButton(
          onPressed: () async {
            await downloadPdfBoss(); // Panggil fungsi downloadPDF
          },
          child: Text('Download CV', style: TextStyle(color: Colors.black)),
        ),
        TextButton(
          onPressed: () async {
            print(await cekStatusTinjauanTracerStudy());
            if (await cekStatusTinjauanTracerStudy()) {
              showDialog(context: context, builder: (builder){
                return SimpleDialog(
                  children: [
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Pengajuan Anda Sedang Ditinjau Oleh Admin Prodi", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),),
                          SizedBox(height: 25,),
                          Text("Lakukan Refresh Page Untuk Mengecek Update Status"),
                        ],
                      ),
                    )
                  ],
                );
              });
            } else {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => tracerStudy()));
            }
          },
          child: Text('Tracer Study', style: TextStyle(color: Colors.black)),
        ),
        TextButton(
          onPressed: () async {
            //logout
            try {
              await FirebaseAuth.instance.signOut();
            } on FirebaseAuthException catch (e) {
              print(e.message);
            }

            Navigator.push(context,
                MaterialPageRoute(builder: (context) => Landingpage()));
          },
          child: Text('Logout', style: TextStyle(color: Colors.black)),
        ),
      ],
    );
  }
}

Future<void> downloadPDF(BuildContext context) async {
  String namaUser = "";
  String urlImage = "";
  String deskripsi = "";
  String alamat = "";
  String facebook = "";
  String github = "";
  String linkedin = "";
  String twiter = "";
  String email = "";
  String whatsapp = "";

  await FirebaseFirestore.instance
      .collection("User")
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .get()
      .then(
    (value) {
      namaUser = value['username'];
      urlImage = value['linkFotoProfile'];
      deskripsi = value['deskripsi'];
      alamat = value['alamat'];
      github = value['linkGithub'];
      twiter = value['linkTwitter'];
      facebook = value['linkFacebook'];
      linkedin = value['linkLinkedin'];
      email = value['Email'];
      whatsapp = value['noHandphone'];
    },
  );

  final pdf = pw.Document();
  print("kontol : " + urlImage.toString());
  final image = networkImage(urlImage);
  print("kontol : " + image.toString());

  pdf.addPage(
    pw.Page(
      build: (pw.Context context) => pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Row(
            children: [
              pw.Container(
                width: 80,
                height: 80,
                // child: pw.Image(image),
              ),
              pw.SizedBox(width: 16.0),
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(
                    namaUser,
                    style: pw.TextStyle(
                      fontSize: 14,
                      fontWeight: pw.FontWeight.bold,
                      color: pw.PdfColors.blueGrey900,
                    ),
                  ),
                  _buildPDFRichText('Address:  ', alamat),
                  _buildPDFRichText('Phone:     ', whatsapp),
                  _buildPDFRichText('Email:       ', email),
                  _buildPDFRichText('LinkedIn:   ', linkedin),
                ],
              ),
            ],
          ),
          pw.SizedBox(height: 15.0),
          _pdfSectionTitle('SUMMARY'),
          pw.Divider(thickness: 2, color: pw.PdfColors.blueGrey900),
          _pdfSectionContent(
            deskripsi,
          ),
          pw.SizedBox(height: 15.0),
          _pdfSectionTitle('EXPERIENCE'),
          pw.Divider(thickness: 2, color: pw.PdfColors.blueGrey900),
          _pdfExperienceEntry(
            'Mechatronics Engineer, Borcelle Technologies',
            'Jan 2023 - Present',
            'In 2020, I participated in an internship program at XYZ Company, a leading tech firm renowned for its innovative solutions. was immersed in various projects related to software development and data.',
          ),
          _pdfExperienceEntry(
            'System Engineer, Arrowai Industries',
            'Feb 2021 - Dec 2022',
            'Designed and optimized a robotic control system, realizing a 10% performance improvement. Coordinated testing and validation, ensuring compliance with industry standards.',
          ),
          _pdfExperienceEntry(
            'Junior Project Engineer, Salford & Co Manufacturing',
            'Mar 2020 - Jan 2021',
            'Managed full lifecycle of a cutting-edge automation project, meeting all milestones. Conducted feasibility studies and risk assessments, mitigating potential project risks.',
          ),
          _pdfExperienceEntry(
            'Junior Project Engineer, Salford & Co Manufacturing',
            'Mar 2020 - Jan 2021',
            'Managed full lifecycle of a cutting-edge automation project, meeting all milestones. Conducted feasibility studies and risk assessments, mitigating potential project risks.',
          ),
          pw.SizedBox(height: 15.0),
          _pdfSectionTitle('ACHIEVEMENT'),
          pw.Divider(thickness: 2, color: pw.PdfColors.blueGrey900),
          _pdfAchievementEntry(
            'Bachelor of Mechatronics Engineering with Honours',
            'Aug 2016 - Oct 2019',
            'In 2020, I emerged as the champion of the National Debate Competition, showcasing my prowess in critical thinking and effective communication.',
          ),
          _pdfAchievementEntry(
            'Bachelor of Mechatronics Engineering with Honours',
            'Aug 2016 - Oct 2019',
            'In 2020, I emerged as the champion of the National Debate Competition, showcasing my prowess in critical thinking and effective communication.',
          ),
          _pdfAchievementEntry(
            'Bachelor of Mechatronics Engineering with Honours',
            'Aug 2016 - Oct 2019',
            'In 2020, I emerged as the champion of the National Debate Competition, showcasing my prowess in critical thinking and effective communication.',
          ),
          pw.SizedBox(height: 20.0),
          _pdfSectionTitle('ADDITIONAL INFORMATION'),
          pw.Divider(thickness: 2, color: pw.PdfColors.blueGrey900),
          _buildPDFRichTextAditional(
            'Personal Skills: ',
            'Public Speaking, Problem Solving, Time Management, Critical Thinking, Teamwork, Leadership',
          ),
          _buildPDFRichTextAditional('Software Skills: ',
              'Photoshop, Illustrator, CorelDraw, Filmoram, Premier, Blender, After Effect, Sketch Up, Android Studio, Jupyter Notebook'),
          _buildPDFRichTextAditional(
            'Programming Languages: ',
            'Dart, C++, Swift, PHP, HTML, CSS, Python, Kotlin, JavaScript, Java, Go',
          ),
          _buildPDFRichTextAditional(
            'Machine Learning: ',
            'Classification, Regression, Clustering',
          ),
        ],
      ),
    ),
  );

  await Printing.sharePdf(bytes: await pdf.save(), filename: 'resume.pdf');
}

pw.Widget _pdfSectionTitle(String title) {
  return pw.Text(
    title,
    style: pw.TextStyle(
        fontSize: 12,
        fontWeight: pw.FontWeight.bold,
        color: pw.PdfColors.blueGrey900),
  );
}

pw.Widget _pdfSectionContent(String content) {
  return pw.Text(
    content,
    style: pw.TextStyle(fontSize: 10),
  );
}

pw.Widget _pdfExperienceEntry(String title, String date, String description) {
  return pw.Padding(
    padding: const pw.EdgeInsets.symmetric(vertical: 4.0),
    child: pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Expanded(
              child: pw.Text(
                title,
                style:
                    pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold),
              ),
            ),
            pw.Text(date,
                style:
                    pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold)),
          ],
        ),
        pw.Text(description, style: pw.TextStyle(fontSize: 10)),
      ],
    ),
  );
}

pw.Widget _pdfAchievementEntry(String title, String date, String description) {
  return pw.Padding(
    padding: const pw.EdgeInsets.symmetric(vertical: 4.0),
    child: pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Expanded(
              child: pw.Text(
                title,
                style:
                    pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold),
              ),
            ),
            pw.Text(date,
                style:
                    pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold)),
          ],
        ),
        pw.Text(description, style: pw.TextStyle(fontSize: 10)),
      ],
    ),
  );
}

pw.Widget _buildPDFRichText(String title, String content) {
  return pw.RichText(
    text: pw.TextSpan(
      children: [
        pw.TextSpan(
          text: title,
          style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 11),
        ),
        pw.TextSpan(text: content, style: pw.TextStyle(fontSize: 11)),
      ],
    ),
  );
}

pw.Widget _buildPDFRichTextAditional(String title, String content) {
  return pw.RichText(
    text: pw.TextSpan(
      children: [
        pw.TextSpan(
          text: title,
          style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 11),
        ),
        pw.TextSpan(text: content, style: pw.TextStyle(fontSize: 11)),
      ],
    ),
  );
}
