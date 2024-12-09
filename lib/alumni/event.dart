import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:skripsi/alumni/header_alumni.dart';

class Event extends StatelessWidget {
  const Event({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: HeaderAlumni(),
        body: Center(
          child: EventList(),
        ),
      ),
    );
  }
}

class eventItem {
  String deskripsi = '';
  String judul = '';
  String tanggal = '';
  String tempat = '';
}

class EventList extends StatelessWidget {
  final List<Map<String, String>> eventData = [
    {
      'title': 'Pengukuhan Pengurus Alumni PHB Periode 2019-2022',
      'description':
          'hai guys akan ada kegiatan pengukuhanwewefefsrs pengurus alumni PHB Periode 2019-2022 Lokasi : The Harber Caf.',
      'date': 'published on 1 tahun yang lalu'
    },
    {
      'title': 'Event 2 Title',
      'description':
          'hai guys akan ada kegiatan pengukuhanwewefefsrs pengurus alumni PHB Periode 2019-2022 Lokasi : The Harber Caf.',
      'date': 'published on 2 tahun yang lalu'
    },
    {
      'title': 'Event 3 Title',
      'description':
          'hai guys akan ada kegiatan pengukuhanwewefefsrs pengurus alumni PHB Periode 2019-2022 Lokasi : The Harber Caf.',
      'date': 'published on 3 tahun yang lalu'
    }
  ];
  List<eventItem> seluruhEvent = [];
  getData() async {
    await FirebaseFirestore.instance
        .collection("Admin")
        .doc("0")
        .collection("event")
        .get()
        .then(
      (value) {
        value.docs.forEach(
          (element) {
            seluruhEvent.add(eventItem());
            seluruhEvent[seluruhEvent.length - 1].deskripsi =
                element['Deskripsi'];
            seluruhEvent[seluruhEvent.length - 1].judul = element['Judul'];
            seluruhEvent[seluruhEvent.length - 1].tanggal = element['Tanggal'];
            seluruhEvent[seluruhEvent.length - 1].tempat = element['Tempat'];
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int j = 0; j < seluruhEvent.length; j += 3)
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          for (int i = j;
                              j + 3 <= seluruhEvent.length
                                  ? i < j + 3
                                  : i < seluruhEvent.length;
                              i++)
                            Container(
                              margin: EdgeInsets.all(20),
                              width: 330,
                              height: 250,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: Offset(3, 6),
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(12),
                                    color: Colors.grey[200],
                                    child: Text(
                                      seluruhEvent[i].judul,
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.all(15),
                                      color: Color.fromARGB(255, 249, 249, 255),
                                      child: SingleChildScrollView(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              seluruhEvent[i].deskripsi+'. Tempat'+seluruhEvent[i].tempat,
                                              style: TextStyle(fontSize: 14),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                 
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    color: Colors.grey[200],
                                    child: Text(
                                      seluruhEvent[i].tanggal,
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey[600]),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ],
                  )
              ],
            ),
          );
        });
  }
}
