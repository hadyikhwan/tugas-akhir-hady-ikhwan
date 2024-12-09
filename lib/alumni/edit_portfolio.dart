import 'package:flutter/material.dart';
import 'package:skripsi/alumni/header_alumni.dart';
import 'editS1Alumni.dart';
import 'editS2Alumni.dart';
import 'editS3Alumni.dart';
import 'editS4Alumni.dart';
import 'editS5Alumni.dart';
import 'editS6Alumni.dart';
import 'editS7Alumni.dart';
import 'package:skripsi/mahasiswa%20aktif/header.dart';
import 'package:skripsi/footer.dart';

class editalumni extends StatelessWidget {
  const editalumni({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: EditPortfolio(),
    );
  }
}

class EditPortfolio extends StatefulWidget {
  EditPortfolio({
    Key? key,
  }) : super(key: key);

  @override
  _editPageState createState() => _editPageState();
}

class _editPageState extends State<EditPortfolio> {
  int x = 1;
  List<Widget> halamanPilihan = [
    editS1Alumni(),
    editS2Alumni(),
    editS3Alumni(),
    editS4Alumni(),
    editS5Alumni(),
    editS6Alumni(),
    editS7Alumni(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 249, 249, 255),
      appBar: HeaderAlumni(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Image.asset(
                            'assets/build.png',
                            width: 250,
                            height: 50,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'You will begin to realize why this exercise is called the Dickens Pattern with reference to the ghost showing Scrooge some different futures. You will begin to realize why this exercise is called the Dickens Pattern with reference to the ghost showing Scrooge some different futures.',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                            color: Color.fromARGB(136, 70, 70, 70),
                          ),
                          maxLines: 5,
                          overflow: TextOverflow.visible,
                        ),
                        SizedBox(height: 20),
                        ElevatedButton.icon(
                          onPressed: () {},
                          label: Text('Get Started'),
                          icon: Icon(Icons.arrow_forward_rounded),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero,
                              side: BorderSide(width: 2, color: Colors.blue),
                            ),
                            textStyle: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 550,
                    height: 550,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          "assets/posteredit.png",
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 100,
            ),
            Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                color: Color.fromARGB(255, 249, 249, 255),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          x = 1;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: x >= 1 ? Colors.blue : Colors.grey,
                            width: 3,
                          ),
                        ),
                        child: CircleAvatar(
                          radius: 16,
                          backgroundColor: x >= 1 ? Colors.blue : Colors.white,
                          child: Text(
                            '1',
                            style: TextStyle(
                              color: x >= 1 ? Colors.white : Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 30,
                      height: 3,
                      color: x >= 2 ? Colors.blue : Colors.grey,
                    ),
                    GestureDetector(
                      onTap: () {
                        x = 2;
                        setState(() {});
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: x >= 2 ? Colors.blue : Colors.grey,
                            width: 3,
                          ),
                        ),
                        child: CircleAvatar(
                          radius: 16,
                          backgroundColor: x >= 2 ? Colors.blue : Colors.white,
                          child: Text(
                            '2',
                            style: TextStyle(
                              color: x >= 2 ? Colors.white : Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 30,
                      height: 3,
                      color: x >= 3 ? Colors.blue : Colors.grey,
                    ),
                    GestureDetector(
                      onTap: () {
                        x = 3;
                        setState(() {});
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: x >= 3 ? Colors.blue : Colors.grey,
                            width: 3,
                          ),
                        ),
                        child: CircleAvatar(
                          radius: 16,
                          backgroundColor: x >= 3 ? Colors.blue : Colors.white,
                          child: Text(
                            '3',
                            style: TextStyle(
                              color: x >= 3 ? Colors.white : Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 30,
                      height: 3,
                      color: x >= 4 ? Colors.blue : Colors.grey,
                    ),
                    GestureDetector(
                      onTap: () {
                        x = 4;
                        setState(() {});
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: x >= 4 ? Colors.blue : Colors.grey,
                            width: 3,
                          ),
                        ),
                        child: CircleAvatar(
                          radius: 16,
                          backgroundColor: x >= 4 ? Colors.blue : Colors.white,
                          child: Text(
                            '4',
                            style: TextStyle(
                              color: x >= 4 ? Colors.white : Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 30,
                      height: 3,
                      color: x >= 5 ? Colors.blue : Colors.grey,
                    ),
                    GestureDetector(
                      onTap: () {
                        x = 5;
                        setState(() {});
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: x >= 5 ? Colors.blue : Colors.grey,
                            width: 3,
                          ),
                        ),
                        child: CircleAvatar(
                          radius: 16,
                          backgroundColor: x >= 5 ? Colors.blue : Colors.white,
                          child: Text(
                            '5',
                            style: TextStyle(
                              color: x >= 5 ? Colors.white : Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 30,
                      height: 3,
                      color: x >= 6 ? Colors.blue : Colors.grey,
                    ),
                    GestureDetector(
                      onTap: () {
                        x = 6;
                        setState(() {});
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: x >= 6 ? Colors.blue : Colors.grey,
                            width: 3,
                          ),
                        ),
                        child: CircleAvatar(
                          radius: 16,
                          backgroundColor: x >= 6 ? Colors.blue : Colors.white,
                          child: Text(
                            '6',
                            style: TextStyle(
                              color: x >= 6 ? Colors.white : Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 30,
                      height: 3,
                      color: x >= 7 ? Colors.blue : Colors.grey,
                    ),
                    GestureDetector(
                      onTap: () {
                        x = 7;
                        setState(() {});
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: x >= 7 ? Colors.blue : Colors.grey,
                            width: 3,
                          ),
                        ),
                        child: CircleAvatar(
                          radius: 16,
                          backgroundColor: x >= 7 ? Colors.blue : Colors.white,
                          child: Text(
                            '7',
                            style: TextStyle(
                              color: x >= 7 ? Colors.white : Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.amber,
              ),
              child: halamanPilihan[x - 1],
            ),
            SizedBox(
              height: 0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    width: 100,
                    color: Color.fromARGB(255, 249, 249, 255),
                    child: Row(
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              if (x > 1) {
                                x--;
                                setState(() {});
                              }
                            },
                            child: Text("Back")),
                      ],
                    )),
                Container(
                    width: 100,
                    color: Color.fromARGB(255, 249, 249, 255),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              if (x != 7) {
                                x++;
                                setState(() {});
                              }
                            },
                            child: Text(x != 7 ? "Next" : "Finish")),
                      ],
                    )),
              ],
            ),
            SizedBox(
              height: 25,
            ),
            footer(),
          ],
        ),
      ),
    );
  }
}
