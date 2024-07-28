import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart' as pw;

class contoh extends StatelessWidget {
  const contoh({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Homepage'),
        actions: [
          TextButton(
            onPressed: () {},
            child: Text('Homepage', style: TextStyle(color: Colors.black)),
          ),
          TextButton(
            onPressed: () {},
            child: Text('Portofolio', style: TextStyle(color: Colors.black)),
          ),
          TextButton(
            onPressed: () {},
            child: Text('Edit portofolio', style: TextStyle(color: Colors.black)),
          ),
          TextButton(
            onPressed: () {
              _downloadPDF(context);
            },
            child: Text('Download CV', style: TextStyle(color: Colors.black)),
          ),
        ],
      ),
      body: Center(
        child: Text('Welcome to the Homepage!'),
      ),
    );
  }

  void _downloadPDF(BuildContext context) async {
    final pdf = pw.Document();

    final image =
        (await rootBundle.load('assets/foto.jpg')).buffer.asUint8List();

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
                  child: pw.Image(pw.MemoryImage(image)),
                ),
                pw.SizedBox(width: 16.0),
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      'MUHAMMAD ABILI',
                      style: pw.TextStyle(
                        fontSize: 14,
                        fontWeight: pw.FontWeight.bold,
                        color: pw.PdfColor.fromInt(0xFF263238), // BlueGrey900
                      ),
                    ),
                    _buildPDFRichText('Address: ', '103 Anywhere St., Any City'),
                    _buildPDFRichText('Phone: ', '103-456-7890'),
                    _buildPDFRichText('Email: ', 'hello@reallygreatsite.com'),
                    _buildPDFRichText('Website: ', 'www.reallygreatsite.com'),
                  ],
                ),
              ],
            ),
            pw.SizedBox(height: 15.0),
            _pdfSectionTitle('SUMMARY'),
            pw.Divider(thickness: 2, color: pw.PdfColor.fromInt(0xFF263238)), // BlueGrey900
            _pdfSectionContent(
              'Results-oriented Mechanical and Mechatronics Engineer seeking a challenging position to apply expertise in designing and implementing innovative solutions for complex engineering challenges. Proven track record of success in project management, problem-solving, and cross-functional collaboration. Adept at utilizing cutting-edge technologies to optimize processes and enhance overall efficiency.',
            ),
            pw.SizedBox(height: 15.0),
            _pdfSectionTitle('EXPERIENCE'),
            pw.Divider(thickness: 2, color: pw.PdfColor.fromInt(0xFF263238)), // BlueGrey900
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
            pw.SizedBox(height: 15.0),
            _pdfSectionTitle('ACHIEVEMENT'),
            pw.Divider(thickness: 2, color: pw.PdfColor.fromInt(0xFF263238)), // BlueGrey900
            _pdfAchievementEntry(
              'Bachelor of Mechatronics Engineering with Honours',
              'Aug 2016 - Oct 2019',
              'In 2020, I emerged as the champion of the National Debate Competition, showcasing my prowess in critical thinking and effective communication.',
            ),
            pw.SizedBox(height: 15.0),
            _pdfSectionTitle('ADDITIONAL INFORMATION'),
            pw.Divider(thickness: 2, color: pw.PdfColor.fromInt(0xFF263238)), // BlueGrey900
            _pdfSectionContent(
              '• Personal Skills: Public Speaking, Problem Solving, Time Management, Critical Thinking, Teamwork, Leadership\n• Software Skills: Photoshop, Illustrator, CorelDraw, Filmoram, Premier, Blender, After Effect, Sketch Up, Android Studio, Jupyter Notebook\n• Programming Language: Dart, C++, Swift, PHP, HTML, CSS, Python, Kotlin, JavaScript, Java, GO.\n• Machine Learning: Classification, Regression, Clustering',
            ),
          ],
        ),
      ),
    );

    final output = await getExternalStorageDirectory();
    final file = File("${output!.path}/resume.pdf");
    await file.writeAsBytes(await pdf.save());
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('PDF Downloaded')),
    );
  }

  pw.Widget _buildPDFRichText(String title, String content) {
    return pw.RichText(
      text: pw.TextSpan(
        children: [
          pw.TextSpan(
            text: title,
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
          ),
          pw.TextSpan(text: content),
        ],
      ),
    );
  }

  pw.Widget _pdfSectionTitle(String title) {
    return pw.Text(
      title,
      style: pw.TextStyle(
        fontSize: 14,
        fontWeight: pw.FontWeight.bold,
        color: pw.PdfColor.fromInt(0xFF263238), // BlueGrey900
      ),
    );
  }

  pw.Widget _pdfSectionContent(String content) {
    return pw.Text(
      content,
      style: pw.TextStyle(fontSize: 12),
    );
  }

  pw.Widget _pdfExperienceEntry(String title, String date, String description) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 8.0),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Expanded(
                child: pw.Text(
                  title,
                  style: pw.TextStyle(
                    fontSize: 12,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
              pw.Text(
                date,
                style: pw.TextStyle(
                  fontSize: 12,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ],
          ),
          pw.Text(description, style: pw.TextStyle(fontSize: 12)),
        ],
      ),
    );
  }

  pw.Widget _pdfAchievementEntry(String title, String date, String description) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 8.0),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Expanded(
                child: pw.Text(
                  title,
                  style: pw.TextStyle(
                    fontSize: 12,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
              pw.Text(
                date,
                style: pw.TextStyle(
                  fontSize: 12,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ],
          ),
          pw.Text(description, style: pw.TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
  
  Future<Directory?> getExternalStorageDirectory() async {
    return await getApplicationDocumentsDirectory();
  }
}

