import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:skripsi/admin/dashboard_Admin.dart';
import 'package:skripsi/admin/dashboard_event.dart';
import 'package:skripsi/admin/dashboard_hasil.dart';
import 'package:skripsi/admin/dashboard_pengajuan.dart';
import 'package:skripsi/admin/dashboard_pertanyaan.dart';
import 'package:skripsi/admin/ecek_admin.dart';
import 'package:skripsi/admin/header_Admin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DashboardAlumni extends StatefulWidget {
  const DashboardAlumni({super.key});

  @override
  State<DashboardAlumni> createState() => _DashboardAlumniState();
}

class alumni {
  String id = "";
  String no = "";
  String nama = "";
  String Nim = "";
  String Amalat = "";
  String jenisKelamin = "";
  String telepon = "";
}

List<alumni> SeluruhAlumni = [];
getDataAlumni() async {
  SeluruhAlumni.clear();
  await FirebaseFirestore.instance.collection("User").get().then(
    (value) {
      value.docs.forEach((element) {
        if (element['Alumni']) {
          SeluruhAlumni.add(alumni());
          SeluruhAlumni[SeluruhAlumni.length - 1].no =
              SeluruhAlumni.length.toString();
          SeluruhAlumni[SeluruhAlumni.length - 1].Nim = element["nim"];
          SeluruhAlumni[SeluruhAlumni.length - 1].nama = element["username"];
          SeluruhAlumni[SeluruhAlumni.length - 1].Amalat = element["alamat"];
          SeluruhAlumni[SeluruhAlumni.length - 1].jenisKelamin =
              element["jenisKelamin"];
          SeluruhAlumni[SeluruhAlumni.length - 1].telepon =
              element["noHandphone"];
          SeluruhAlumni[SeluruhAlumni.length - 1].id = element.id;
        }
      });
    },
  );
}

class _DashboardAlumniState extends State<DashboardAlumni> {
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
                                'Data Alumni',
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 16),
                              Table(
                                border: TableBorder.all(color: Colors.grey),
                                columnWidths: {
                                  0: FlexColumnWidth(0.8),
                                  1: FlexColumnWidth(3),
                                  2: FlexColumnWidth(3),
                                  3: FlexColumnWidth(3),
                                  4: FlexColumnWidth(2),
                                  5: FlexColumnWidth(3),
                                  6: FlexColumnWidth(2),
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
                                        child: Text('Alamat',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white)),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text('Jenis Kelamin',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white)),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text('No Telpon',
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
                                  for (int i = 0; i < SeluruhAlumni.length; i++)
                                    TableRow(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(SeluruhAlumni[i].no),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(SeluruhAlumni[i].nama),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(SeluruhAlumni[i].Nim),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(SeluruhAlumni[i].Amalat),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                              SeluruhAlumni[i].jenisKelamin),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(SeluruhAlumni[i].telepon),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              IconButton(
                                                icon: Icon(Icons.search,
                                                    color: Colors.blue),
                                                onPressed: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            MyAppadmin(
                                                                id: SeluruhAlumni[
                                                                        i]
                                                                    .id),
                                                      ));
                                                },
                                              ),
                                              IconButton(
                                                icon: Icon(Icons.delete,
                                                    color: Colors.red),
                                                onPressed: () {},
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
            press: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DashboardPengajuan()));
            },
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
