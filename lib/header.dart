// custom_app_bar.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:skripsi/ecek.dart';
import 'package:skripsi/edit.dart';
import 'package:skripsi/homepage.dart';
import 'package:skripsi/landingpage.dart';

import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:flutter/services.dart' show Uint8List, rootBundle;
import 'package:pdf/pdf.dart' as pw;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:skripsi/templateCV.dart';
import 'package:http/http.dart' as http;

class experienceComponents {
  String jobDescription = "";
  String linkDocument = "";
  String nameOfInstitution = "";
  String positionTitle = "";
  String year = "";
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
    final pdf = pw.Document();
    var image;

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
    }

    downloadPdfBoss() async {
      await getDataBiodata();
      // URL gambar yang ingin Anda masukkan
    final imageUrl = 'https://cdn1-production-images-kly.akamaized.net/7S1xszhXETmiMGOofkrebqoHKnE=/1200x900/smart/filters:quality(75):strip_icc():format(webp)/kly-media-production/medias/1439641/original/042027300_1482131661-reddit.jpg';

    // Download gambar dari URL
    final response = await http.get(Uri.parse(imageUrl));
    print("komtol");
      final Uint8List imageData = response.bodyBytes;
    print("komtol");

      // Convert image data to PdfImage
      final image = pw.MemoryImage(imageData);
    print("komtol");

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
                        child: pw.Image(image),
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
                ]),
          );
        },
      ));

      await Printing.sharePdf(bytes: await pdf.save(), filename: 'resume.pdf');
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
                context, MaterialPageRoute(builder: (context) => homepage()));
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
