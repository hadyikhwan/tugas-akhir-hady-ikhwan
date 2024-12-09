import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:skripsi/alumni/header_alumni.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:skripsi/firestore%20service/DatabaseService.dart';

class GrafikAlumni extends StatefulWidget {
  GrafikAlumni({super.key});

  @override
  State<GrafikAlumni> createState() => _GrafikAlumniState();
}

class _GrafikAlumniState extends State<GrafikAlumni> {
  int jumlahAlumni = 0;
  int jumlahPertanyaan = 0;
  int jumlahEvent = 0;
  bool isFirst = true;

  double kuliah = 0;
  double Bekerja = 0;
  double Menganggur = 0;
  double Dll = 0;

  getNothing() async {}
  getDataGrafik() async {
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
                default:
                  print("kosong");
                  break;
              }
            }
          },
        );
      },
    );
    print("$kuliah $Bekerja $Menganggur $Dll");
    isFirst = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeaderAlumni(),
      body: FutureBuilder(
        future: !isFirst ? getNothing() : getDataGrafik(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Grafik Outcome Alumni',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 4),
                          width: 190, // Sesuaikan dengan lebar teks
                          height: 5, // Ketebalan garis bawah
                          color: Colors.blue, // Warna garis bawah
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 15),
                  Center(
                    child: Container(
                      width: 520,
                      height: 400,
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Color.fromARGB(255, 255, 255, 255),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(
                                0.1), // Warna dan opasitas bayangan
                            spreadRadius: 5, // Jarak penyebaran bayangan
                            blurRadius: 10, // Jarak blur bayangan
                            offset: Offset(6, 9), // Offset bayangan (x, y)
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Container(
                            height: 320,
                            child: PieChart(
                              PieChartData(
                                sections: [
                                  kuliah != 0 ? PieChartSectionData(
                                    color: Colors.pink,
                                    value: kuliah,
                                    title: '',
                                    radius: 100,
                                    titleStyle: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ) : PieChartSectionData(),
                                  Bekerja != 0 ? PieChartSectionData(
                                    color: Colors.blue,
                                    value: Bekerja,
                                    title: '',
                                    radius: 100,
                                    titleStyle: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ) : PieChartSectionData(),
                                  Menganggur != 0 ? PieChartSectionData(
                                    color: Colors.yellow,
                                    value: Menganggur,
                                    title: '',
                                    radius: 100,
                                    titleStyle: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ) : PieChartSectionData(),
                                  Dll != 0 ? PieChartSectionData(
                                    color: Colors.purple,
                                    value: Dll,
                                    title: '',
                                    radius: 100,
                                    titleStyle: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ) : PieChartSectionData(),
                                ],
                                centerSpaceRadius: 40,
                                borderData: FlBorderData(show: false),
                                sectionsSpace: 2,
                              ),
                            ),
                          ),
                          SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              LegendItem(color: Colors.pink, text: 'Kuliah'),
                              SizedBox(width: 20),
                              LegendItem(color: Colors.blue, text: 'Bekerja'),
                              SizedBox(width: 20),
                              LegendItem(
                                  color: Colors.yellow, text: 'Menganggur'),
                              SizedBox(width: 20),
                              LegendItem(color: Colors.purple, text: 'Dll'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}

class LegendItem extends StatelessWidget {
  final Color color;
  final String text;

  LegendItem({required this.color, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 30,
          height: 24,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        SizedBox(width: 10),
        Text(
          text,
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}
