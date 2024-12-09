import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:skripsi/admin/dashboard_alumni.dart';
import 'package:skripsi/admin/dashboard_event.dart';
import 'package:skripsi/admin/dashboard_hasil.dart';
import 'package:skripsi/admin/dashboard_pengajuan.dart';
import 'package:skripsi/admin/dashboard_pertanyaan.dart';
import 'package:skripsi/admin/header_Admin.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:skripsi/alumni/event.dart';
import 'package:skripsi/firestore%20service/DatabaseService.dart';

double kuliah = 0;
double Bekerja = 0;
double Menganggur = 0;
double Dll = 0;

class DashboardAdmin extends StatefulWidget {
  const DashboardAdmin({super.key});

  @override
  State<DashboardAdmin> createState() => _DashboardAdminState();
}

class _DashboardAdminState extends State<DashboardAdmin> {
  int jumlahAlumni = 0;
  int jumlahPertanyaan = 0;
  int jumlahEvent = 0;

  getDataGrafik() async {
    kuliah = 0;
    Bekerja = 0;
    Menganggur = 0;
    Dll = 0;
    await FirebaseFirestore.instance.collection("User").get().then(
      (value) {
        value.docs.forEach(
          (element) {
            if (element['Alumni']) {
              switch (element["statusPekerjaan"].toString()) {
                case "lanjut kuliah":
                  kuliah++;
                  break;
                case "bekerja":
                  Bekerja++;
                  break;
                case "tidak bekerja":
                  Menganggur++;
                  break;
                case "dll":
                  Dll++;
                  break;
              }
            }
          },
        );
      },
    );
    print("berhasil : $Dll");
  }

  bool pertama = false;

  getnothing() async {
    await Databaseservice(userID: "qK9Ni5kE45dMnbCGRW2gPtIky4w2")
        .getTotalAlumni();
  }

  getData() async {
    jumlahAlumni = await Databaseservice(userID: "qK9Ni5kE45dMnbCGRW2gPtIky4w2")
        .getTotalAlumni();
    jumlahPertanyaan =
        await Databaseservice(userID: "qK9Ni5kE45dMnbCGRW2gPtIky4w2")
            .getTotalPertanyaan();
    jumlahEvent = await Databaseservice(userID: "qK9Ni5kE45dMnbCGRW2gPtIky4w2")
        .getTotalEvent();
    getDataGrafik();
    setState(() {});
    pertama = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: !pertama ? getData() : getnothing(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
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
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Dashboard',
                                    style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 16),
                                  Row(
                                    children: [
                                      StatisticCard(
                                        title: 'Jumlah Alumni',
                                        count: jumlahAlumni,
                                        color: Colors.blue.shade900,
                                      ),
                                      SizedBox(width: 16),
                                      StatisticCard(
                                        title: 'Jumlah Pertanyaan',
                                        count: jumlahPertanyaan,
                                        color: Colors.lightBlueAccent,
                                      ),
                                      SizedBox(width: 16),
                                      StatisticCard(
                                        title: 'Jumlah Event',
                                        count: jumlahEvent,
                                        color: Colors.green,
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 32),
                                  Text(
                                    'Status Alumni',
                                    style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 16),
                                  SizedBox(
                                    height: 300,
                                    child: BarChartSample(),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            } else {
              return Column(
                children: [
                  header_admin(),
                  CircularProgressIndicator(),
                ],
              );
            }
          }),
    );
  }
}

class StatisticCard extends StatelessWidget {
  final String title;
  final int count;
  final Color color;

  const StatisticCard({
    required this.title,
    required this.count,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              count.toString(),
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

class BarChartSample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: 10,
        barTouchData: BarTouchData(enabled: false),
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (double value, TitleMeta meta) {
                final titles = ['Kuliah', 'Bekerja', 'Menanggur', 'Dll'];
                return SideTitleWidget(
                  axisSide: meta.axisSide,
                  space: 8.0,
                  child: Text(
                    titles[value.toInt()],
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                );
              },
              reservedSize: 30,
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                return Text(
                  value.toInt().toString(),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                );
              },
              reservedSize: 28,
            ),
          ),
        ),
        borderData: FlBorderData(show: false),
        barGroups: [
          BarChartGroupData(
            x: 0,
            barRods: [
              BarChartRodData(toY: kuliah, color: Colors.blue, width: 20),
            ],
          ),
          BarChartGroupData(
            x: 1,
            barRods: [
              BarChartRodData(toY: Bekerja, color: Colors.blue, width: 20),
            ],
          ),
          BarChartGroupData(
            x: 2,
            barRods: [
              BarChartRodData(toY: Menganggur, color: Colors.blue, width: 20),
            ],
          ),
          BarChartGroupData(
            x: 3,
            barRods: [
              BarChartRodData(toY: Dll, color: Colors.blue, width: 20),
            ],
          ),
        ],
      ),
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
            press: () {},
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
