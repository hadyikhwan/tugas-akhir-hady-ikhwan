import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:skripsi/admin/dashboard_Admin.dart';
import 'package:skripsi/admin/dashboard_alumni.dart';
import 'package:skripsi/admin/dashboard_event.dart';
import 'package:skripsi/admin/dashboard_pengajuan.dart';
import 'package:skripsi/admin/dashboard_pertanyaan.dart';
import 'package:skripsi/admin/header_Admin.dart';
import 'package:fl_chart/fl_chart.dart';

class DashboardHasil extends StatefulWidget {
  const DashboardHasil({super.key});

  @override
  State<DashboardHasil> createState() => _DashboardhasilState();
}

class pertanyaan {
  String question = "";
  String jawabanA = "";
  String jawabanB = "";
  String jawabanC = "";
  String jawabanD = "";
  int doc = 0;
}

class hasilJawabanUser {
  double a = 0;
  double b = 0;
  double c = 0;
  double d = 0;
}

class _DashboardhasilState extends State<DashboardHasil> {
  List<pertanyaan> seluruhPertanyaan = [];
  List<String> jawabanUser = [];
  List<hasilJawabanUser> _hasilJawabanUser = [];

  susunData() {
    for (int i = 0; i < seluruhPertanyaan.length - 1; i++) {
      pertanyaan temp;
      for (int j = 0; j < seluruhPertanyaan.length - i - 1; j++) {
        if (seluruhPertanyaan[j].doc > seluruhPertanyaan[j + 1].doc) {
          temp = seluruhPertanyaan[j];
          seluruhPertanyaan[j] = seluruhPertanyaan[j + 1];
          seluruhPertanyaan[j + 1] = temp;
        }
      }
    }
  }

  membuatTemplateJawaban() {
    for (int i = 0; i < seluruhPertanyaan.length; i++) {
      _hasilJawabanUser.add(hasilJawabanUser());
    }
  }

  terjemahkanJawabanUser() {
    _hasilJawabanUser.clear();
    membuatTemplateJawaban();
    int x = 0;

    for (int i = 0; i < jawabanUser.length; i++) {
      x = 0;
      for (int j = 0; j < jawabanUser[i].length; j += 2) {
        switch (jawabanUser[i][j]) {
          case '1':
            _hasilJawabanUser[x].a += 1;
            break;
          case '2':
            _hasilJawabanUser[x].b += 1;
            break;
          case '3':
            _hasilJawabanUser[x].c += 1;
            break;
          case '4':
            _hasilJawabanUser[x].d += 1;
            break;
        }

        
        x++;
      }
    }
    
  }

  getData() async {
    seluruhPertanyaan.clear();
    //ambil data pertanyaan
    await FirebaseFirestore.instance
        .collection("Admin")
        .doc("0")
        .collection("pertanyaan")
        .get()
        .then(
      (value) {
        value.docs.forEach(
          (element) {
            seluruhPertanyaan.add(pertanyaan());
            seluruhPertanyaan[seluruhPertanyaan.length - 1].question =
                element["pertanyaan"];
            seluruhPertanyaan[seluruhPertanyaan.length - 1].jawabanA =
                element["jawabanA"];
            seluruhPertanyaan[seluruhPertanyaan.length - 1].jawabanB =
                element["jawabanB"];
            seluruhPertanyaan[seluruhPertanyaan.length - 1].jawabanC =
                element["jawabanC"];
            seluruhPertanyaan[seluruhPertanyaan.length - 1].jawabanD =
                element["jawabanD"];
            seluruhPertanyaan[seluruhPertanyaan.length - 1].doc =
                int.parse(element.id);
          },
        );
      },
    );
    susunData();

    //ambil data seluruh jawaban user
    await FirebaseFirestore.instance.collection("User").get().then(
      (value) {
        value.docs.forEach(
          (element) {
            if (element['Alumni']) {
              jawabanUser.add(element["jawabanKuesioner"]);
            }
          },
        );
      },
    );
    terjemahkanJawabanUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: getData(),
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
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Grafik Hasil Kuesioner',
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 16),
                                for (int i = 0;
                                    i < seluruhPertanyaan.length;
                                    i += 2)
                                  Padding(
                                    padding: const EdgeInsets.all(25.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        for (int j = i;
                                            i + 2 <= seluruhPertanyaan.length
                                                ? j < i + 2
                                                : j < i + 1;
                                            j++)
                                          Container(
                                            width: 480,
                                            height: 240,
                                            child: Expanded(
                                              child: buildQuestionContainer(
                                                seluruhPertanyaan[j].question,
                                                {
                                                  'A. ${seluruhPertanyaan[j].jawabanA}':
                                                      _hasilJawabanUser[j].a,
                                                  'B. ${seluruhPertanyaan[j].jawabanB}':
                                                      _hasilJawabanUser[j].b,
                                                  'C. ${seluruhPertanyaan[j].jawabanC}':
                                                      _hasilJawabanUser[j].c,
                                                  'D. ${seluruhPertanyaan[j].jawabanD}':
                                                      _hasilJawabanUser[j].d
                                                },
                                                [
                                                  Colors.red,
                                                  Colors.blue,
                                                  Colors.green,
                                                  Colors.yellow
                                                ],
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
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
          }),
    );
  }

  Widget buildQuestionContainer(
      String question, Map<String, double> answers, List<Color> colors) {
    return Container(
      width: 500,
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 239, 239, 239),
              borderRadius: BorderRadius.circular(15),
            ),
            width: 230,
            height: 240,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Pertanyaan: $question',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    ...answers.keys.map((answer) => Text(
                          answer,
                          style: TextStyle(fontSize: 16),
                        )),
                  ],
                ),
              ),
            ),
          ),
          Container(
            width: 200,
            height: 200,
            child: PieChart(
              PieChartData(
                sections: answers.entries.map((entry) {
                  int index = answers.keys.toList().indexOf(entry.key);
                  return PieChartSectionData(
                    color: colors[index],
                    value: entry.value,
                    title: entry.key.split('. ')[0],
                    radius: 100,
                    titleStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  );
                }).toList(),
              ),
            ),
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
