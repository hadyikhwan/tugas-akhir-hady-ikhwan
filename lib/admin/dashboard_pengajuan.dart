import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:skripsi/admin/dashboard_Admin.dart';
import 'package:skripsi/admin/dashboard_alumni.dart';
import 'package:skripsi/admin/dashboard_event.dart';
import 'package:skripsi/admin/dashboard_hasil.dart';
import 'package:skripsi/admin/dashboard_pengajuan.dart';
import 'package:skripsi/admin/dashboard_pertanyaan.dart';
import 'package:skripsi/admin/header_Admin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:html' as html;

import 'package:skripsi/firestore%20service/DatabaseService.dart';

class DashboardPengajuan extends StatefulWidget {
  const DashboardPengajuan({super.key});

  @override
  State<DashboardPengajuan> createState() => _DashboardPengajuanState();
}

class pengajuan {
  String id = "";
  String no = "";
  String nama = "";
  String Nim = "";
  String urlPdf = "";
}

List<pengajuan> Seluruhpengajuan = [];

getDataAlumni() async {
  Seluruhpengajuan.clear();
  await FirebaseFirestore.instance.collection("User").get().then(
    (value) {
      value.docs.forEach((element) {
        if (element['tracerStudySedangDitinjau']) {
          print("object");
          Seluruhpengajuan.add(pengajuan());
          Seluruhpengajuan[Seluruhpengajuan.length - 1].no =
              Seluruhpengajuan.length.toString();
          Seluruhpengajuan[Seluruhpengajuan.length - 1].id = element.id;
          Seluruhpengajuan[Seluruhpengajuan.length - 1].Nim = element["nim"];
          Seluruhpengajuan[Seluruhpengajuan.length - 1].nama =
              element["username"];
          Seluruhpengajuan[Seluruhpengajuan.length - 1].urlPdf =
              element["linkPengajuanTracerStudy"];
        }
      });
    },
  );
}

class _DashboardPengajuanState extends State<DashboardPengajuan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: getDataAlumni(),
          builder: (context, snapshot) {
            return Column(
              children: [
                header_admin(), // Header
                Expanded(
                  child: Row(
                    children: [
                      Container(
                        width: 180, // Lebar sidebar yang diinginkan
                        child: SideMenu(), // Memanggil SideMenu
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Pengajuan Tracer Study',
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 16),
                              Table(
                                border: TableBorder.all(color: Colors.grey),
                                columnWidths: {
                                  0: FlexColumnWidth(1),
                                  1: FlexColumnWidth(3),
                                  2: FlexColumnWidth(3),
                                  3: FlexColumnWidth(2),
                                },
                                children: [
                                  TableRow(
                                    decoration: BoxDecoration(
                                        color: Colors.deepPurpleAccent),
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text('No',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white)),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text('Nama',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white)),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text('NIM',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white)),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text('Opsi',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white)),
                                      ),
                                    ],
                                  ),
                                  for (int i = 0;
                                      i < Seluruhpengajuan.length;
                                      i++)
                                    TableRow(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(Seluruhpengajuan[i].no),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(Seluruhpengajuan[i].nama),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(Seluruhpengajuan[i].Nim),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              IconButton(
                                                icon: Icon(Icons.picture_as_pdf,
                                                    color: Colors.green),
                                                onPressed: () {
                                                  html.window.open(
                                                      Seluruhpengajuan[i]
                                                          .urlPdf,
                                                      'new tab');
                                                },
                                              ),
                                              IconButton(
                                                icon: Icon(Icons.check_box,
                                                    color: Colors.blue),
                                                onPressed: () async {
                                                  await Databaseservice(
                                                          userID: "")
                                                      .terimaPengajuan(
                                                          Seluruhpengajuan[i]
                                                              .id);
                                                  setState(() {});
                                                  print("penerimaan berhasil");
                                                },
                                              ),
                                              IconButton(
                                                icon: Icon(Icons.delete,
                                                    color: Colors.red),
                                                onPressed: () async {
                                                  await Databaseservice(
                                                          userID: "")
                                                      .tolakPengajuan(
                                                          Seluruhpengajuan[i]
                                                              .id);
                                                  setState(() {});
                                                  print("penolakan berhasil");
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }),
    );
  }
}

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.deepPurpleAccent,
      child: ListView(
        children: [
          DrawerListTile(
            title: "",
            svgSrc: "",
            press: () {},
          ),
          DrawerListTile(
            title: "Dashboard",
            svgSrc: "assets/menu_dashboard.svg",
            press: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => DashboardAdmin()));
            },
          ),
          DrawerListTile(
            title: "Alumni",
            svgSrc: "assets/menu_tran.svg",
            press: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => DashboardAlumni()));
            },
          ),
          DrawerListTile(
            title: "Pertanyaan",
            svgSrc: "assets/menu_doc.svg",
            press: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => dashboard_pertanyaan()));
            },
          ),
          DrawerListTile(
            title: "Grafik",
            svgSrc: "assets/menu_task.svg",
            press: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => DashboardHasil()));
            },
          ),
          DrawerListTile(
            title: "Event",
            svgSrc: "assets/menu_store.svg",
            press: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => dashboard_event()));
            },
          ),
          DrawerListTile(
            title: "Pengajuan",
            svgSrc: "assets/menu_notification.svg",
            press: () {},
          ),
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    // For selecting those three line once press "Command+D"
    required this.title,
    required this.svgSrc,
    required this.press,
  }) : super(key: key);

  final String title, svgSrc;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: SvgPicture.asset(
        svgSrc,
        colorFilter: ColorFilter.mode(
            Color.fromARGB(255, 255, 255, 255), BlendMode.srcIn),
        height: 16,
      ),
      title: Text(
        title,
        style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
      ),
    );
  }
}
