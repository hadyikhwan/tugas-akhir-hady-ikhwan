import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'package:skripsi/mahasiswa%20aktif/ecek.dart';
import 'package:skripsi/admin/ecek_admin.dart';
import 'package:skripsi/mahasiswa%20aktif/editS2.dart';
import 'package:skripsi/mahasiswa%20aktif/editS1.dart';
import 'package:skripsi/mahasiswa%20aktif/editS3.dart';
import 'package:skripsi/mahasiswa%20aktif/editS4.dart';
import 'package:skripsi/mahasiswa%20aktif/editS5.dart';
import 'package:skripsi/mahasiswa%20aktif/editS6.dart';
import 'package:skripsi/firestore%20service/DatabaseService.dart';
import 'package:skripsi/admin/header_Admin.dart';
import 'package:skripsi/mahasiswa%20aktif/header.dart';
import 'package:skripsi/footer.dart';

class homepageadmin extends StatelessWidget {
  const homepageadmin({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Philip Gilbert Portfolio',
      home: MyHomePage(title: 'Teknologi Informasi'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class dataUser {
  String? id;
  String? nama;
  String? deskripsi;
  String pemrogramanSkill = "";
  String designVisualSkill = "";
  String machineLearningSkill = "";
  String keamananSkill = "";
}

class _MyHomePageState extends State<MyHomePage> {
  String namaYangDiSearch = "";

  List<dataUser> hasilSearch = [];

  List<dataUser> seluruhDataPengguna = [];
  List<int> noPemrograman = [];
  List<int> noDesignVisual = [];
  List<int> noKemanan = [];
  List<int> noMachineLearning = [];

  //bantuan
  List<String> skillProgrammingLanguage = [];
  List<String> skillDesignVisual = [];
  List<String> skillSecurity = [];
  List<String> skillMachineLearning = [];

  List<int> DesignVisual = [];
  List<int> VideoEditor = [];
  List<int> MachineLearning = [];
  List<int> Programming = [];
  List<int> Security = [];

  List<int> skill_DesignVisual = [];
  List<int> skill_ProgrammingLanguage = [];
  List<int> skill_MachineLearning = [];
  List<int> skill_Security = [];

  printList(List x) {
    for (int i = 0; i < x.length; i++) {
      print(x[i]);
    }
  }

  searchNamaUser() {
    hasilSearch.clear();

    //filter nama
    for (int i = 0; i < seluruhDataPengguna.length; i++) {
      bool aman = false;
      for (int j = 0; j < namaYangDiSearch.length; j++) {
        if (namaYangDiSearch[j].toLowerCase() ==
            seluruhDataPengguna[i].nama.toString()[j].toLowerCase()) {
          aman = true;
        } else {
          aman = false;
          break;
        }
      }
      if (aman == true) {
        hasilSearch.add(seluruhDataPengguna[i]);
      }
    }

    for (int i = 0; i < hasilSearch.length - 1; i++) {
      dataUser temp = new dataUser();
      if (hitungTotalSkill(hasilSearch, i) <
          hitungTotalSkill(hasilSearch, i + 1)) {
        temp = hasilSearch[i];
        hasilSearch[i] = hasilSearch[i + 1];
        hasilSearch[i + 1] = temp;
      }
    }
  }

  int hitungTotalSkill(List<dataUser> dataUser, int index) {
    int hasil = hitungKoma(dataUser[index].keamananSkill) +
        hitungKoma(dataUser[index].designVisualSkill) +
        hitungKoma(dataUser[index].machineLearningSkill) +
        hitungKoma(dataUser[index].pemrogramanSkill);
    return hasil;
  }

  int hitungKoma(String x) {
    bool pertama = false;
    int hasil = 0;
    for (int i = 0; i < x.length; i++) {
      if (!pertama) {
        if (x[i] != '') {
          hasil++;
        }
        pertama = true;
      } else {
        if (x[i] == ',') {
          hasil++;
        }
      }
    }
    return hasil;
  }

  List<String> pembacaSkillPemain(String x) {
    bool pertama = false;
    bool spasiPertama = false;
    String kata = "";
    List<String> hasil = [];
    if (x.length != 0) {
      for (int i = 0; i < x.length; i++) {
        if (!pertama) {
          if (x[i] == ",") {
            hasil.add(kata);
            kata = "";
            pertama = true;
          } else {
            kata += x[i];
          }
        } else {
          if (x[i] == ",") {
            hasil.add(kata);
            kata = "";
            spasiPertama = false;
          } else {
            if (spasiPertama) {
              kata += x[i];
            } else {
              spasiPertama = true;
            }
          }
        }
      }
      hasil.add(kata);
    }

    return hasil;
  }

  List<dataUser> hasilFilter = [];
  filterSkill() {
    hasilFilter.clear();

    //data skill user
    List programmingSementaraUser = [];
    List machineLearningSementaraUser = [];
    List securitySementaraUser = [];
    List designVisualSementaraUser = [];
    convertingSkillDesignVisual(skill_DesignVisual);
    convertingSkillMachineLearning(skill_MachineLearning);
    convertingSkillProgrammingLanguage(skill_ProgrammingLanguage);
    convertingSkillSecurity(skill_Security);

    //data software user
    List programmingSoftwareSementaraUser = [];
    List machineLearningSoftwareSementaraUser = [];
    List securitySoftwareSementaraUser = [];
    List designVisualSoftwareSementaraUser = [];
    List videoEditorSoftwareSementaraUser = [];

    //perulangan untuk setiap user
    for (int i = 0; i < seluruhDataPengguna.length; i++) {
      designVisualSementaraUser =
          pembacaSkillPemain(seluruhDataPengguna[i].designVisualSkill);
      machineLearningSementaraUser =
          pembacaSkillPemain(seluruhDataPengguna[i].machineLearningSkill);
      securitySementaraUser =
          pembacaSkillPemain(seluruhDataPengguna[i].keamananSkill);
      programmingSementaraUser =
          pembacaSkillPemain(seluruhDataPengguna[i].pemrogramanSkill);

      //pengecekan di design visual
      bool ketemu = false;
      List<int> patokan = [];
      if (!ketemu) {
        for (int j = 0; j < designVisualSementaraUser.length; j++) {
          for (int k = 0; k < skillDesignVisual.length; k++) {
            if (skillDesignVisual[k] == designVisualSementaraUser[j]) {
              patokan.add(0);
              ketemu = true;
              break;
            }
          }
        }
        for (int j = 0; j < machineLearningSementaraUser.length; j++) {
          for (int k = 0; k < skillMachineLearning.length; k++) {
            if (skillMachineLearning[k] == machineLearningSementaraUser[j]) {
              patokan.add(0);
              ketemu = true;
              break;
            }
          }
        }
        for (int j = 0; j < programmingSementaraUser.length; j++) {
          for (int k = 0; k < skillProgrammingLanguage.length; k++) {
            if (skillProgrammingLanguage[k] == programmingSementaraUser[j]) {
              patokan.add(0);
              ketemu = true;
              break;
            }
          }
        }
        for (int j = 0; j < securitySementaraUser.length; j++) {
          for (int k = 0; k < skillSecurity.length; k++) {
            if (skillSecurity[k] == securitySementaraUser[j]) {
              patokan.add(0);
              ketemu = true;
              break;
            }
          }
        }

        //proses pemasukan data
        if (patokan.length ==
            skillSecurity.length +
                skillDesignVisual.length +
                skillMachineLearning.length +
                skillProgrammingLanguage.length) {
          hasilFilter.add(seluruhDataPengguna[i]);
        }
      }
      ketemu = false;
    }
  }

  clearData() {
    noPemrograman.clear();
    noKemanan.clear();
    noDesignVisual.clear();
    noMachineLearning.clear();

    skillProgrammingLanguage.clear();
    skillSecurity.clear();
    skillDesignVisual.clear();
    skillMachineLearning.clear();
  }

  void convertingSkillSecurity(List<int> x) {
    for (int i = 0; i < x.length; i++) {
      switch (x[i]) {
        case 0:
          skillSecurity.add("IOT");
          break;
        case 1:
          skillSecurity.add("Kriptografi");
          break;
        case 2:
          skillSecurity.add("Firewall");
          break;
        case 3:
          skillSecurity.add("Kali");
          break;
        case 4:
          skillSecurity.add("Cloud");
          break;
        case 5:
          skillSecurity.add("Endpoint");
          break;
      }
    }
  }

  void convertingSkillDesignVisual(List<int> x) {
    for (int i = 0; i < x.length; i++) {
      switch (x[i]) {
        case 0:
          skillDesignVisual.add("UI/UX Design");
          break;
        case 1:
          skillDesignVisual.add("Mockup Design");
          break;
        case 2:
          skillDesignVisual.add("Design Graphic");
          break;
        case 3:
          skillDesignVisual.add("Logo Design");
          break;
        case 4:
          skillDesignVisual.add("Game Design");
          break;
        case 5:
          skillDesignVisual.add("Indutrial Design");
          break;
        case 6:
          skillDesignVisual.add("Creative Design");
          break;
      }
    }
  }

  void convertingSkillMachineLearning(List<int> x) {
    for (int i = 0; i < x.length; i++) {
      switch (x[i]) {
        case 0:
          skillMachineLearning.add("Classification");
          break;
        case 1:
          skillMachineLearning.add("Regressioni");
          break;
        case 2:
          skillMachineLearning.add("Clustering");
          break;
        case 3:
          skillMachineLearning.add("Association");
          break;
        case 4:
          skillMachineLearning.add("Deep Learning");
          break;
        case 5:
          skillMachineLearning.add("Image Processing");
          break;
        case 6:
          skillMachineLearning.add("Big Data");
          break;
        case 7:
          skillMachineLearning.add("Image Classification");
          break;
      }
    }
  }

  void convertingSkillProgrammingLanguage(List<int> x) {
    for (int i = 0; i < x.length; i++) {
      switch (x[i]) {
        case 0:
          skillProgrammingLanguage.add("Java");
          break;
        case 1:
          skillProgrammingLanguage.add("Flutter");
          break;
        case 2:
          skillProgrammingLanguage.add("Python");
          break;
        case 3:
          skillProgrammingLanguage.add("Java Script");
          break;
        case 4:
          skillProgrammingLanguage.add("PHP");
          break;
        case 5:
          skillProgrammingLanguage.add("Kotlin");
          break;
        case 6:
          skillProgrammingLanguage.add("Dart");
          break;
        case 7:
          skillProgrammingLanguage.add("Golang");
          break;
        case 8:
          skillProgrammingLanguage.add("Swift");
          break;
        case 9:
          skillProgrammingLanguage.add("C++");
          break;
      }
    }
  }

  addDataSkill() async {
    for (int j = 0; j < seluruhDataPengguna.length; j++) {
      await FirebaseFirestore.instance
          .collection("User")
          .doc(seluruhDataPengguna[j].id)
          .collection("Skill")
          .get()
          .then(
        (x) {
          x.docs.forEach(
            (y) {
              switch (y.id) {
                case "Design Visual":
                  for (int i = 0; i < y["Skill yang dikuasai"].length; i++) {
                    noDesignVisual.add(y["Skill yang dikuasai"][i]);
                  }

                  break;
                case "Machine Learning":
                  for (int i = 0; i < y["Skill yang dikuasai"].length; i++) {
                    noMachineLearning.add(y["Skill yang dikuasai"][i]);
                  }

                  break;
                case "Proramming Language":
                  for (int i = 0; i < y["Skill yang dikuasai"].length; i++) {
                    noPemrograman.add(y["Skill yang dikuasai"][i]);
                  }

                  break;
                case "Security":
                  for (int i = 0; i < y["Skill yang dikuasai"].length; i++) {
                    noKemanan.add(y["Skill yang dikuasai"][i]);
                  }

                  break;
              }
            },
          );
        },
      );
      convertingSkillProgrammingLanguage(noPemrograman);
      convertingSkillMachineLearning(noMachineLearning);
      convertingSkillDesignVisual(noDesignVisual);
      convertingSkillSecurity(noKemanan);
      for (int i = 0; i < skillMachineLearning.length; i++) {
        if (i != skillMachineLearning.length - 1) {
          seluruhDataPengguna[j].machineLearningSkill +=
              skillMachineLearning[i] + ", ";
        } else {
          seluruhDataPengguna[j].machineLearningSkill +=
              skillMachineLearning[i];
        }
      }

      for (int i = 0; i < skillDesignVisual.length; i++) {
        if (i != skillDesignVisual.length - 1) {
          seluruhDataPengguna[j].designVisualSkill +=
              skillDesignVisual[i] + ", ";
        } else {
          seluruhDataPengguna[j].designVisualSkill += skillDesignVisual[i];
        }
      }
      for (int i = 0; i < skillProgrammingLanguage.length; i++) {
        if (i != skillProgrammingLanguage.length - 1) {
          seluruhDataPengguna[j].pemrogramanSkill +=
              skillProgrammingLanguage[i] + ", ";
        } else {
          seluruhDataPengguna[j].pemrogramanSkill +=
              skillProgrammingLanguage[i];
        }
      }

      for (int i = 0; i < skillSecurity.length; i++) {
        if (i != skillSecurity.length - 1) {
          seluruhDataPengguna[j].keamananSkill += skillSecurity[i] + ", ";
        } else {
          seluruhDataPengguna[j].keamananSkill += skillSecurity[i];
        }
      }

      clearData();
    }
  }

  //ADMIN
  int totalUser = 0;
  int totalMahasiswaAktif = 0;

  setDataAdmin() async {
    // await Databaseservice(userID: "")
    //     .setDatabaseAdmin();

    await Databaseservice(userID: "qK9Ni5kE45dMnbCGRW2gPtIky4w2")
        .hitungTotalUser();
    await Databaseservice(userID: "qK9Ni5kE45dMnbCGRW2gPtIky4w2")
        .hitungTotalAlumni();
    await Databaseservice(userID: "qK9Ni5kE45dMnbCGRW2gPtIky4w2")
        .hitungTotalPertanyaan();
    await Databaseservice(userID: "qK9Ni5kE45dMnbCGRW2gPtIky4w2")
        .hitungTotalEvent();

    totalUser = await Databaseservice(userID: "qK9Ni5kE45dMnbCGRW2gPtIky4w2")
        .GetTotalUser();
    totalMahasiswaAktif =
        await Databaseservice(userID: "qK9Ni5kE45dMnbCGRW2gPtIky4w2")
            .GetTotalMahasiswa();

    setState(() {});
  }

  updateTotalMahasiwa(int inputanData) async {
    await Databaseservice(userID: "qK9Ni5kE45dMnbCGRW2gPtIky4w2")
        .updateTotalMahasiswa(inputanData);
  }

  bool isFirst = false;
  getNothing() {}
  getData() async {
    seluruhDataPengguna.clear();
    await FirebaseFirestore.instance.collection("User").get().then(
      (value) {
        value.docs.forEach(
          (element) async {
            if (element['username'].toString() != "Admin") {
              seluruhDataPengguna.add(dataUser());
              seluruhDataPengguna[seluruhDataPengguna.length - 1].id =
                  element.id;
              seluruhDataPengguna[seluruhDataPengguna.length - 1].nama =
                  (element['username'].toString());
              seluruhDataPengguna[seluruhDataPengguna.length - 1].deskripsi =
                  (element['deskripsi'].toString());
            }
          },
        );
      },
    );
    print(seluruhDataPengguna.length);
    await setDataAdmin();
    await addDataSkill();

    for (int i = 0; i < seluruhDataPengguna.length - 1; i++) {
      dataUser temp = new dataUser();
      if (hitungTotalSkill(seluruhDataPengguna, i) <
          hitungTotalSkill(seluruhDataPengguna, i + 1)) {
        temp = seluruhDataPengguna[i];
        seluruhDataPengguna[i] = seluruhDataPengguna[i + 1];
        seluruhDataPengguna[i + 1] = temp;
      }
    }

    for (int i = 0;
        seluruhDataPengguna.length >= 5
            ? i < 5
            : i < seluruhDataPengguna.length;
        i++) {
      hasilSearch.add(seluruhDataPengguna[i]);
    }
    setState(() {
      isFirst = true;
    });
  }

  int x = 1;
  List<Widget> halamanPilihan = [
    EditS1(),
    editS2(),
    editS3(),
    editS4(),
    editS5(),
    editS6(),
    editS2(),
  ];

  bool showFilter = false; // State untuk mengelola visibilitas filter
  final Map<String, bool> _selectedSoftware = {};
  final Map<String, bool> _selectedSkills = {};

  resetSelectedFilter() {
    _selectedSkills['sublime'] = false;
    _selectedSkills['illustrator'] = false;
    _selectedSkills['photoshop'] = false;
    _selectedSkills['coreldraw'] = false;
    _selectedSkills['sketch'] = false;
    _selectedSkills['adobeindesign'] = false;
    _selectedSkills['gimp'] = false;
    _selectedSkills['figma'] = false;
    _selectedSkills['affinity'] = false;
    _selectedSkills['sketchup'] = false;
    _selectedSkills['autocad'] = false;
    _selectedSkills['inkscape'] = false;
    _selectedSkills['premier'] = false;
    _selectedSkills['filmora'] = false;
    _selectedSkills['davinci'] = false;
    _selectedSkills['tensorflow'] = false;
    _selectedSkills['googlecolab'] = false;
    _selectedSkills['knime'] = false;
    _selectedSkills['keras'] = false;
    _selectedSkills['azure'] = false;
    _selectedSkills['shogun'] = false;
    _selectedSkills['wireshark'] = false;
    _selectedSkills['visualstudio'] = false;
    _selectedSkills['pytorch'] = false;
    _selectedSkills['UI/UX Design'] = false;
    _selectedSkills['Mockup Design'] = false;
    _selectedSkills['Design Graphic'] = false;
    _selectedSkills['Logo Design'] = false;
    _selectedSkills['Game Design'] = false;
    _selectedSkills['Industrial Design'] = false;
    _selectedSkills['Creative Design'] = false;
    _selectedSkills['Java'] = false;
    _selectedSkills['Flutter'] = false;
    _selectedSkills['Python'] = false;
    _selectedSkills['Java Script'] = false;
    _selectedSkills['PHP'] = false;
    _selectedSkills['Kotlin'] = false;
    _selectedSkills['Dart'] = false;
    _selectedSkills['Golang'] = false;
    _selectedSkills['Swift'] = false;
    _selectedSkills['C++'] = false;
    _selectedSkills['Clasification'] = false;
    _selectedSkills['Regression'] = false;
    _selectedSkills['Clustering'] = false;
    _selectedSkills['Association'] = false;
    _selectedSkills['Deep Learning'] = false;
    _selectedSkills['Image Processing'] = false;
    _selectedSkills['Big Data'] = false;
    _selectedSkills['Image Clasification'] = false;
    _selectedSkills['IOT'] = false;
    _selectedSkills['Kriptografi'] = false;
    _selectedSkills['Firewall'] = false;
    _selectedSkills['Kali'] = false;
    _selectedSkills['Cloud'] = false;
    _selectedSkills['Endpoint'] = false;

    skill_DesignVisual.clear();
    skill_MachineLearning.clear();
    skill_ProgrammingLanguage.clear();
    skill_Security.clear();
    clearData();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    List<DashboardItem> items = [
      DashboardItem(
        berbutton: true,
        icon: Icon(
          Icons.edit,
          color: const Color.fromARGB(255, 255, 147, 139),
        ),
        imagePath: 'assets/student active.png',
        title: 'Active Students',
        count: totalMahasiswaAktif.toString(),
        color: const Color.fromARGB(255, 249, 229, 234),
      ),
      DashboardItem(
        berbutton: false,
        icon: null,
        imagePath: 'assets/STUDent.png',
        title: 'Total User',
        count: totalUser.toString(),
        color: const Color.fromARGB(255, 237, 223, 247),
      ),
      DashboardItem(
        berbutton: false,
        icon: null,
        imagePath: 'assets/software.png',
        title: 'Software Skill',
        count: '25',
        color: const Color.fromARGB(255, 251, 237, 217),
      ),
      DashboardItem(
        berbutton: false,
        icon: null,
        imagePath: 'assets/softskil.png',
        title: 'Softskill',
        count: '32',
        color: Color.fromARGB(255, 223, 237, 247),
      ),
    ];
    TextEditingController editJumlahMahasiswa = new TextEditingController();
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 249, 249, 255),
      appBar: header_admin(),
      body: FutureBuilder(
          future: isFirst ? getNothing() : getData(),
          builder: (context, snapshot) {
            print(isFirst);

            if (isFirst) {
              return SingleChildScrollView(
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
                                RichText(
                                    text: TextSpan(
                                  text:
                                      'Digital Portfolio Website for Information Technology Department Students',
                                  style: TextStyle(
                                    fontSize: 55,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    height:
                                        1.2, // Mengatur jarak antar baris (1.5 kali tinggi font)
                                  ),
                                )),
                                SizedBox(
                                  height: 15,
                                ),
                                RichText(
                                  text: TextSpan(
                                    text:
                                        'This platform is designed to make it easy for students to digitize and showcase their portfolios. Here, students can effortlessly compile and present their best work, making it accessible to peers, faculty, and potential employers.',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.normal,
                                      color: Color.fromARGB(136, 70, 70, 70),
                                      height:
                                          1.5, // Mengatur jarak antar baris (1.5 kali tinggi font)
                                    ),
                                    children: <TextSpan>[],
                                  ),
                                  textAlign: TextAlign.left,
                                  maxLines: 5,
                                  overflow: TextOverflow.visible,
                                ),
                                SizedBox(height: 20),
                                ElevatedButton.icon(
                                  onPressed: () {
                                    Databaseservice(
                                            userID: FirebaseAuth
                                                .instance.currentUser!.uid)
                                        .addTest("kontol");
                                  },
                                  label: Text('Get Started'),
                                  icon: Icon(Icons.arrow_forward_rounded),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue,
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.zero,
                                      side: BorderSide(
                                          width: 2, color: Colors.blue),
                                    ),
                                    textStyle: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    minimumSize: Size(150, 50),
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
                                  "assets/posterhomepage1.png",
                                ),
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        items.length,
                        (index) => Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: Expanded(
                            child: Container(
                              height: 200,
                              width: 180,
                              decoration: BoxDecoration(
                                color: items[index].color,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Stack(
                                children: [
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: GestureDetector(
                                        onTap: () {
                                          if (items[index].berbutton) {
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return SimpleDialog(
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 25.0,
                                                          vertical: 5),
                                                      child: Container(
                                                        child: Column(
                                                          children: [
                                                            Text(
                                                                "Ganti Jumlah Mahasiswa Aktif Saat Ini"),
                                                            SizedBox(
                                                              height: 25,
                                                            ),
                                                            TextField(
                                                              controller:
                                                                  editJumlahMahasiswa,
                                                              keyboardType:
                                                                  TextInputType
                                                                      .number,
                                                              decoration:
                                                                  InputDecoration(
                                                                hintText:
                                                                    "Masukkan Jumlah Mahasiswa",
                                                              ),
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                            ),
                                                            SizedBox(
                                                              height: 25,
                                                            ),
                                                            GestureDetector(
                                                              onTap: () async {
                                                                await updateTotalMahasiwa(
                                                                    int.parse(
                                                                        editJumlahMahasiswa
                                                                            .text));
                                                                totalMahasiswaAktif =
                                                                    int.parse(
                                                                        editJumlahMahasiswa
                                                                            .text);
                                                                setState(() {});

                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: Container(
                                                                width: 100,
                                                                height: 35,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                  color: Colors
                                                                      .green,
                                                                ),
                                                                child: Center(
                                                                    child: Text(
                                                                  "Ubah",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500),
                                                                )),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                );
                                              },
                                            );
                                          }
                                        },
                                        child: Container(
                                          width: 25,
                                          height: 25,
                                          child: items[index].icon,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.center,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          items[index].imagePath,
                                          width: 60,
                                          height: 60,
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          items[index].title,
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 8),
                                        Text(
                                          items[index].count,
                                          style: TextStyle(
                                            fontSize: 26,
                                            fontWeight: FontWeight.bold,
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
                      ),
                    ),
                    SizedBox(height: 100),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 20.0),
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      width: MediaQuery.of(context).size.width *
                          0.6, // Sesuaikan lebar konten utama
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                showFilter = !showFilter;

                                resetSelectedFilter();
                                // Toggle visibilitas filter
                              });
                            },
                            child: Text(
                              'Filter',
                              style: TextStyle(fontSize: 18.0),
                            ),
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.blue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 20.0),
                            ),
                          ),
                          SizedBox(width: 20.0),
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Search...',
                                border: InputBorder.none,
                              ),
                              onChanged: (value) {
                                namaYangDiSearch = value;
                                print("data yang tersimpan : " +
                                    namaYangDiSearch);
                              },
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                for (int i = 0;
                                    i < seluruhDataPengguna.length;
                                    i++) {
                                  print("nama pengguna no " +
                                      i.toString() +
                                      " " +
                                      seluruhDataPengguna[i].nama.toString());
                                }
                                searchNamaUser();
                                showFilter = false;
                                resetSelectedFilter();
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.search,
                                color: Colors.blue,
                                size: 30.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      visible:
                          showFilter, // Tampilkan hanya jika showFilter false
                      child: Container(
                        width: 760,
                        height: 1000,
                        padding: EdgeInsets.all(25.0),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 255, 255, 255),
                          borderRadius: BorderRadius.circular(10.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Design Visual
                            Text(
                              '1. Skill',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue),
                            ),
                            SizedBox(height: 10),
                            Wrap(
                              spacing: 14,
                              runSpacing: 10,
                              children: [
                                SkillContainer(
                                  text: 'UI/UX Design',
                                  isSelected:
                                      _selectedSkills['UI/UX Design'] ?? false,
                                  onTap: () {
                                    setState(() {
                                      _selectedSkills['UI/UX Design'] =
                                          !(_selectedSkills['UI/UX Design'] ??
                                              false);
                                      if (_selectedSkills['UI/UX Design']!) {
                                        skill_DesignVisual.add(0);
                                      } else {
                                        skill_DesignVisual.remove(0);
                                      }
                                    });
                                  },
                                ),
                                SkillContainer(
                                  text: 'Mockup Design',
                                  isSelected:
                                      _selectedSkills['Mockup Design'] ?? false,
                                  onTap: () {
                                    setState(() {
                                      _selectedSkills['Mockup Design'] =
                                          !(_selectedSkills['Mockup Design'] ??
                                              false);
                                      if (_selectedSkills['Mockup Design']!) {
                                        skill_DesignVisual.add(1);
                                      } else {
                                        skill_DesignVisual.remove(1);
                                      }
                                    });
                                  },
                                ),
                                SkillContainer(
                                  text: 'Design Graphic',
                                  isSelected:
                                      _selectedSkills['Design Graphic'] ??
                                          false,
                                  onTap: () {
                                    setState(() {
                                      _selectedSkills['Design Graphic'] =
                                          !(_selectedSkills['Design Graphic'] ??
                                              false);
                                      if (_selectedSkills['Design Graphic']!) {
                                        skill_DesignVisual.add(2);
                                      } else {
                                        skill_DesignVisual.remove(2);
                                      }
                                    });
                                  },
                                ),
                                SkillContainer(
                                  text: 'Logo Design',
                                  isSelected:
                                      _selectedSkills['Logo Design'] ?? false,
                                  onTap: () {
                                    setState(() {
                                      _selectedSkills['Logo Design'] =
                                          !(_selectedSkills['Logo Design'] ??
                                              false);
                                      if (_selectedSkills['Logo Design']!) {
                                        skill_DesignVisual.add(3);
                                      } else {
                                        skill_DesignVisual.remove(3);
                                      }
                                    });
                                  },
                                ),
                                SkillContainer(
                                  text: 'Game Design',
                                  isSelected:
                                      _selectedSkills['Game Design'] ?? false,
                                  onTap: () {
                                    setState(() {
                                      _selectedSkills['Game Design'] =
                                          !(_selectedSkills['Game Design'] ??
                                              false);
                                      if (_selectedSkills['Game Design']!) {
                                        skill_DesignVisual.add(4);
                                      } else {
                                        skill_DesignVisual.remove(4);
                                      }
                                    });
                                  },
                                ),
                                SkillContainer(
                                  text: 'Industrial Design',
                                  isSelected:
                                      _selectedSkills['Industrial Design'] ??
                                          false,
                                  onTap: () {
                                    setState(() {
                                      _selectedSkills['Industrial Design'] =
                                          !(_selectedSkills[
                                                  'Industrial Design'] ??
                                              false);
                                      if (_selectedSkills[
                                          'Industrial Design']!) {
                                        skill_DesignVisual.add(5);
                                      } else {
                                        skill_DesignVisual.remove(5);
                                      }
                                    });
                                  },
                                ),
                                SkillContainer(
                                  text: 'Creative Design',
                                  isSelected:
                                      _selectedSkills['Creative Design'] ??
                                          false,
                                  onTap: () {
                                    setState(() {
                                      _selectedSkills['Creative Design'] =
                                          !(_selectedSkills[
                                                  'Creative Design'] ??
                                              false);
                                      if (_selectedSkills['Creative Design']!) {
                                        skill_DesignVisual.add(6);
                                      } else {
                                        skill_DesignVisual.remove(6);
                                      }
                                    });
                                  },
                                ),
                              ],
                            ),
                            SizedBox(height: 20),

                            // Development

                            Wrap(
                              spacing: 14,
                              runSpacing: 10,
                              children: [
                                SkillContainer(
                                  text: 'Java',
                                  isSelected: _selectedSkills['Java'] ?? false,
                                  onTap: () {
                                    setState(() {
                                      _selectedSkills['Java'] =
                                          !(_selectedSkills['Java'] ?? false);
                                      if (_selectedSkills['Java']!) {
                                        skill_ProgrammingLanguage.add(0);
                                      } else {
                                        skill_ProgrammingLanguage.remove(0);
                                      }
                                    });
                                  },
                                ),
                                SkillContainer(
                                  text: 'Flutter',
                                  isSelected:
                                      _selectedSkills['Flutter'] ?? false,
                                  onTap: () {
                                    setState(() {
                                      _selectedSkills['Flutter'] =
                                          !(_selectedSkills['Flutter'] ??
                                              false);
                                      if (_selectedSkills['Flutter']!) {
                                        skill_ProgrammingLanguage.add(1);
                                      } else {
                                        skill_ProgrammingLanguage.remove(1);
                                      }
                                    });
                                  },
                                ),
                                SkillContainer(
                                  text: 'Python',
                                  isSelected:
                                      _selectedSkills['Python'] ?? false,
                                  onTap: () {
                                    setState(() {
                                      _selectedSkills['Python'] =
                                          !(_selectedSkills['Python'] ?? false);
                                      if (_selectedSkills['Python']!) {
                                        skill_ProgrammingLanguage.add(2);
                                      } else {
                                        skill_ProgrammingLanguage.remove(2);
                                      }
                                    });
                                  },
                                ),
                                SkillContainer(
                                  text: 'Java Script',
                                  isSelected:
                                      _selectedSkills['Java Script'] ?? false,
                                  onTap: () {
                                    setState(() {
                                      _selectedSkills['Java Script'] =
                                          !(_selectedSkills['Java Script'] ??
                                              false);
                                      if (_selectedSkills['Java Script']!) {
                                        skill_ProgrammingLanguage.add(3);
                                      } else {
                                        skill_ProgrammingLanguage.remove(3);
                                      }
                                    });
                                  },
                                ),
                                SkillContainer(
                                  text: 'PHP',
                                  isSelected: _selectedSkills['PHP'] ?? false,
                                  onTap: () {
                                    setState(() {
                                      _selectedSkills['PHP'] =
                                          !(_selectedSkills['PHP'] ?? false);
                                      if (_selectedSkills['PHP']!) {
                                        skill_ProgrammingLanguage.add(4);
                                      } else {
                                        skill_ProgrammingLanguage.remove(4);
                                      }
                                    });
                                  },
                                ),
                                SkillContainer(
                                  text: 'Kotlin',
                                  isSelected:
                                      _selectedSkills['Kotlin'] ?? false,
                                  onTap: () {
                                    setState(() {
                                      _selectedSkills['Kotlin'] =
                                          !(_selectedSkills['Kotlin'] ?? false);
                                      if (_selectedSkills['Kotlin']!) {
                                        skill_ProgrammingLanguage.add(5);
                                      } else {
                                        skill_ProgrammingLanguage.remove(5);
                                      }
                                    });
                                  },
                                ),
                                SkillContainer(
                                  text: 'Dart',
                                  isSelected: _selectedSkills['Dart'] ?? false,
                                  onTap: () {
                                    setState(() {
                                      _selectedSkills['Dart'] =
                                          !(_selectedSkills['Dart'] ?? false);
                                      if (_selectedSkills['Dart']!) {
                                        skill_ProgrammingLanguage.add(6);
                                      } else {
                                        skill_ProgrammingLanguage.remove(6);
                                      }
                                    });
                                  },
                                ),
                                SkillContainer(
                                  text: 'Golang',
                                  isSelected:
                                      _selectedSkills['Golang'] ?? false,
                                  onTap: () {
                                    setState(() {
                                      _selectedSkills['Golang'] =
                                          !(_selectedSkills['Golang'] ?? false);
                                      if (_selectedSkills['Golang']!) {
                                        skill_ProgrammingLanguage.add(7);
                                      } else {
                                        skill_ProgrammingLanguage.remove(7);
                                      }
                                    });
                                  },
                                ),
                                SkillContainer(
                                  text: 'Swift',
                                  isSelected: _selectedSkills['Swift'] ?? false,
                                  onTap: () {
                                    setState(() {
                                      _selectedSkills['Swift'] =
                                          !(_selectedSkills['Swift'] ?? false);
                                      if (_selectedSkills['Swift']!) {
                                        skill_ProgrammingLanguage.add(8);
                                      } else {
                                        skill_ProgrammingLanguage.remove(8);
                                      }
                                    });
                                  },
                                ),
                                SkillContainer(
                                  text: 'C++',
                                  isSelected: _selectedSkills['C++'] ?? false,
                                  onTap: () {
                                    setState(() {
                                      _selectedSkills['C++'] =
                                          !(_selectedSkills['C++'] ?? false);
                                      if (_selectedSkills['C++']!) {
                                        skill_ProgrammingLanguage.add(9);
                                      } else {
                                        skill_ProgrammingLanguage.remove(9);
                                      }
                                    });
                                  },
                                ),
                              ],
                            ),
                            SizedBox(height: 20),

                            // Machine Learning

                            Wrap(
                              spacing: 14,
                              runSpacing: 10,
                              children: [
                                SkillContainer(
                                  text: 'Clasification',
                                  isSelected:
                                      _selectedSkills['Clasification'] ?? false,
                                  onTap: () {
                                    setState(() {
                                      _selectedSkills['Clasification'] =
                                          !(_selectedSkills['Clasification'] ??
                                              false);
                                      if (_selectedSkills['Clasification']!) {
                                        skill_MachineLearning.add(0);
                                      } else {
                                        skill_MachineLearning.remove(0);
                                      }
                                    });
                                  },
                                ),
                                SkillContainer(
                                  text: 'Regression',
                                  isSelected:
                                      _selectedSkills['Regression'] ?? false,
                                  onTap: () {
                                    setState(() {
                                      _selectedSkills['Regression'] =
                                          !(_selectedSkills['Regression'] ??
                                              false);
                                      if (_selectedSkills['Regression']!) {
                                        skill_MachineLearning.add(1);
                                      } else {
                                        skill_MachineLearning.remove(1);
                                      }
                                    });
                                  },
                                ),
                                SkillContainer(
                                  text: 'Clustering',
                                  isSelected:
                                      _selectedSkills['Clustering'] ?? false,
                                  onTap: () {
                                    setState(() {
                                      _selectedSkills['Clustering'] =
                                          !(_selectedSkills['Clustering'] ??
                                              false);
                                      if (_selectedSkills['Clustering']!) {
                                        skill_MachineLearning.add(2);
                                      } else {
                                        skill_MachineLearning.remove(2);
                                      }
                                    });
                                  },
                                ),
                                SkillContainer(
                                  text: 'Association',
                                  isSelected:
                                      _selectedSkills['Association'] ?? false,
                                  onTap: () {
                                    setState(() {
                                      _selectedSkills['Association'] =
                                          !(_selectedSkills['Association'] ??
                                              false);
                                      if (_selectedSkills['Association']!) {
                                        skill_MachineLearning.add(3);
                                      } else {
                                        skill_MachineLearning.remove(3);
                                      }
                                    });
                                  },
                                ),
                                SkillContainer(
                                  text: 'Deep Learning',
                                  isSelected:
                                      _selectedSkills['Deep Learning'] ?? false,
                                  onTap: () {
                                    setState(() {
                                      _selectedSkills['Deep Learning'] =
                                          !(_selectedSkills['Deep Learning'] ??
                                              false);
                                      if (_selectedSkills['Deep Learning']!) {
                                        skill_MachineLearning.add(4);
                                      } else {
                                        skill_MachineLearning.remove(4);
                                      }
                                    });
                                  },
                                ),
                                SkillContainer(
                                  text: 'Image Processing',
                                  isSelected:
                                      _selectedSkills['Image Processing'] ??
                                          false,
                                  onTap: () {
                                    setState(() {
                                      _selectedSkills['Image Processing'] =
                                          !(_selectedSkills[
                                                  'Image Processing'] ??
                                              false);
                                      if (_selectedSkills[
                                          'Image Processing']!) {
                                        skill_MachineLearning.add(5);
                                      } else {
                                        skill_MachineLearning.remove(5);
                                      }
                                    });
                                  },
                                ),
                                SkillContainer(
                                  text: 'Big Data',
                                  isSelected:
                                      _selectedSkills['Big Data'] ?? false,
                                  onTap: () {
                                    setState(() {
                                      _selectedSkills['Big Data'] =
                                          !(_selectedSkills['Big Data'] ??
                                              false);
                                      if (_selectedSkills['Big Data']!) {
                                        skill_MachineLearning.add(6);
                                      } else {
                                        skill_MachineLearning.remove(6);
                                      }
                                    });
                                  },
                                ),
                                SkillContainer(
                                  text: 'Image Clasification',
                                  isSelected:
                                      _selectedSkills['Image Clasification'] ??
                                          false,
                                  onTap: () {
                                    setState(() {
                                      _selectedSkills['Image Clasification'] =
                                          !(_selectedSkills[
                                                  'Image Clasification'] ??
                                              false);
                                      if (_selectedSkills[
                                          'Image Clasification']!) {
                                        skill_MachineLearning.add(7);
                                      } else {
                                        skill_MachineLearning.remove(7);
                                      }
                                    });
                                  },
                                ),
                              ],
                            ),
                            SizedBox(height: 20),

                            // Security

                            Wrap(
                              spacing: 14,
                              runSpacing: 10,
                              children: [
                                SkillContainer(
                                  text: 'IOT',
                                  isSelected: _selectedSkills['IOT'] ?? false,
                                  onTap: () {
                                    setState(() {
                                      _selectedSkills['IOT'] =
                                          !(_selectedSkills['IOT'] ?? false);
                                      if (_selectedSkills['IOT']!) {
                                        skill_Security.add(0);
                                      } else {
                                        skill_Security.remove(0);
                                      }
                                    });
                                  },
                                ),
                                SkillContainer(
                                  text: 'Kriptografi',
                                  isSelected:
                                      _selectedSkills['Kriptografi'] ?? false,
                                  onTap: () {
                                    setState(() {
                                      _selectedSkills['Kriptografi'] =
                                          !(_selectedSkills['Kriptografi'] ??
                                              false);
                                      if (_selectedSkills['Kriptografi']!) {
                                        skill_Security.add(1);
                                      } else {
                                        skill_Security.remove(1);
                                      }
                                    });
                                  },
                                ),
                                SkillContainer(
                                  text: 'Firewall',
                                  isSelected:
                                      _selectedSkills['Firewall'] ?? false,
                                  onTap: () {
                                    setState(() {
                                      _selectedSkills['Firewall'] =
                                          !(_selectedSkills['Firewall'] ??
                                              false);
                                      if (_selectedSkills['Firewall']!) {
                                        skill_Security.add(2);
                                      } else {
                                        skill_Security.remove(2);
                                      }
                                    });
                                  },
                                ),
                                SkillContainer(
                                  text: 'Kali',
                                  isSelected: _selectedSkills['Kali'] ?? false,
                                  onTap: () {
                                    setState(() {
                                      _selectedSkills['Kali'] =
                                          !(_selectedSkills['Kali'] ?? false);
                                      if (_selectedSkills['Kali']!) {
                                        skill_Security.add(3);
                                      } else {
                                        skill_Security.remove(3);
                                      }
                                    });
                                  },
                                ),
                                SkillContainer(
                                  text: 'Cloud',
                                  isSelected: _selectedSkills['Cloud'] ?? false,
                                  onTap: () {
                                    setState(() {
                                      _selectedSkills['Cloud'] =
                                          !(_selectedSkills['Cloud'] ?? false);
                                      if (_selectedSkills['Cloud']!) {
                                        skill_Security.add(4);
                                      } else {
                                        skill_Security.remove(4);
                                      }
                                    });
                                  },
                                ),
                                SkillContainer(
                                  text: 'Endpoint',
                                  isSelected:
                                      _selectedSkills['Endpoint'] ?? false,
                                  onTap: () {
                                    setState(() {
                                      _selectedSkills['Endpoint'] =
                                          !(_selectedSkills['Endpoint'] ??
                                              false);
                                      if (_selectedSkills['Endpoint']!) {
                                        skill_Security.add(5);
                                      } else {
                                        skill_Security.remove(5);
                                      }
                                    });
                                  },
                                ),
                              ],
                            ),

                            SizedBox(height: 40),
                            Text(
                              '2. Software Skill',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue),
                            ),
                            SizedBox(height: 10),
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Design Visual
                                  Text(
                                    'Design Visual',
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue),
                                  ),
                                  SizedBox(height: 10),
                                  Wrap(
                                    spacing: 14,
                                    runSpacing: 10,
                                    children: [
                                      SoftwareContainer(
                                        assetPath:
                                            'assets/logo/illustrator.png',
                                        isSelected:
                                            _selectedSkills['illustrator'] ??
                                                false,
                                        onTap: () {
                                          setState(() {
                                            _selectedSkills['illustrator'] =
                                                !(_selectedSkills[
                                                        'illustrator'] ??
                                                    false);
                                            if (_selectedSkills[
                                                'illustrator']!) {
                                              DesignVisual.add(0);
                                            } else {
                                              DesignVisual.remove(0);
                                            }
                                          });
                                        },
                                      ),
                                      SoftwareContainer(
                                        assetPath: 'assets/logo/photoshop.png',
                                        isSelected:
                                            _selectedSkills['photoshop'] ??
                                                false,
                                        onTap: () {
                                          setState(() {
                                            _selectedSkills['photoshop'] =
                                                !(_selectedSkills[
                                                        'photoshop'] ??
                                                    false);
                                            if (_selectedSkills['photoshop']!) {
                                              DesignVisual.add(1);
                                            } else {
                                              DesignVisual.remove(1);
                                            }
                                          });
                                        },
                                      ),
                                      SoftwareContainer(
                                        assetPath: 'assets/logo/coreldraw.png',
                                        isSelected:
                                            _selectedSkills['coreldraw'] ??
                                                false,
                                        onTap: () {
                                          setState(() {
                                            _selectedSkills['coreldraw'] =
                                                !(_selectedSkills[
                                                        'coreldraw'] ??
                                                    false);
                                            if (_selectedSkills['coreldraw']!) {
                                              DesignVisual.add(2);
                                            } else {
                                              DesignVisual.remove(2);
                                            }
                                          });
                                        },
                                      ),
                                      SoftwareContainer(
                                        assetPath: 'assets/logo/sketch.png',
                                        isSelected:
                                            _selectedSkills['sketch'] ?? false,
                                        onTap: () {
                                          setState(() {
                                            _selectedSkills['sketch'] =
                                                !(_selectedSkills['sketch'] ??
                                                    false);
                                            if (_selectedSkills['sketch']!) {
                                              DesignVisual.add(3);
                                            } else {
                                              DesignVisual.remove(3);
                                            }
                                          });
                                        },
                                      ),
                                      SoftwareContainer(
                                        assetPath:
                                            'assets/logo/adobeindesign.png',
                                        isSelected:
                                            _selectedSkills['adobeindesign'] ??
                                                false,
                                        onTap: () {
                                          setState(() {
                                            _selectedSkills['adobeindesign'] =
                                                !(_selectedSkills[
                                                        'adobeindesign'] ??
                                                    false);
                                            if (_selectedSkills[
                                                'adobeindesign']!) {
                                              DesignVisual.add(4);
                                            } else {
                                              DesignVisual.remove(4);
                                            }
                                          });
                                        },
                                      ),
                                      SoftwareContainer(
                                        assetPath: 'assets/logo/gimp.png',
                                        isSelected:
                                            _selectedSkills['gimp'] ?? false,
                                        onTap: () {
                                          setState(() {
                                            _selectedSkills['gimp'] =
                                                !(_selectedSkills['gimp'] ??
                                                    false);
                                            if (_selectedSkills['gimp']!) {
                                              DesignVisual.add(5);
                                            } else {
                                              DesignVisual.remove(5);
                                            }
                                          });
                                        },
                                      ),
                                      SoftwareContainer(
                                        assetPath: 'assets/logo/figma.png',
                                        isSelected:
                                            _selectedSkills['figma'] ?? false,
                                        onTap: () {
                                          setState(() {
                                            _selectedSkills['figma'] =
                                                !(_selectedSkills['figma'] ??
                                                    false);
                                            if (_selectedSkills['figma']!) {
                                              DesignVisual.add(6);
                                            } else {
                                              DesignVisual.remove(6);
                                            }
                                          });
                                        },
                                      ),
                                      SoftwareContainer(
                                        assetPath: 'assets/logo/affinity.png',
                                        isSelected:
                                            _selectedSkills['affinity'] ??
                                                false,
                                        onTap: () {
                                          setState(() {
                                            _selectedSkills['affinity'] =
                                                !(_selectedSkills['affinity'] ??
                                                    false);
                                            if (_selectedSkills['affinity']!) {
                                              DesignVisual.add(7);
                                            } else {
                                              DesignVisual.remove(7);
                                            }
                                          });
                                        },
                                      ),
                                      SoftwareContainer(
                                        assetPath: 'assets/logo/sketchup.png',
                                        isSelected:
                                            _selectedSkills['sketchup'] ??
                                                false,
                                        onTap: () {
                                          setState(() {
                                            _selectedSkills['sketchup'] =
                                                !(_selectedSkills['sketchup'] ??
                                                    false);
                                            if (_selectedSkills['sketchup']!) {
                                              DesignVisual.add(8);
                                            } else {
                                              DesignVisual.remove(8);
                                            }
                                          });
                                        },
                                      ),
                                      SoftwareContainer(
                                        assetPath: 'assets/logo/autocad.png',
                                        isSelected:
                                            _selectedSkills['autocad'] ?? false,
                                        onTap: () {
                                          setState(() {
                                            _selectedSkills['autocad'] =
                                                !(_selectedSkills['autocad'] ??
                                                    false);
                                            if (_selectedSkills['autocad']!) {
                                              DesignVisual.add(9);
                                            } else {
                                              DesignVisual.remove(9);
                                            }
                                          });
                                        },
                                      ),
                                      SoftwareContainer(
                                        assetPath: 'assets/logo/inkscape.png',
                                        isSelected:
                                            _selectedSkills['inkscape'] ??
                                                false,
                                        onTap: () {
                                          setState(() {
                                            _selectedSkills['inkscape'] =
                                                !(_selectedSkills['inkscape'] ??
                                                    false);
                                            if (_selectedSkills['inkscape']!) {
                                              DesignVisual.add(10);
                                            } else {
                                              DesignVisual.remove(10);
                                            }
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 20),

                                  // Development
                                  Text(
                                    'Vidio Editor',
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue),
                                  ),
                                  SizedBox(height: 10),
                                  Wrap(
                                    spacing: 14,
                                    runSpacing: 10,
                                    children: [
                                      SoftwareContainer(
                                        assetPath: 'assets/logo/premier.png',
                                        isSelected:
                                            _selectedSkills['premier'] ?? false,
                                        onTap: () {
                                          setState(() {
                                            _selectedSkills['premier'] =
                                                !(_selectedSkills['premier'] ??
                                                    false);
                                            if (_selectedSkills['premier']!) {
                                              VideoEditor.add(0);
                                            } else {
                                              VideoEditor.remove(0);
                                            }
                                          });
                                        },
                                      ),
                                      SoftwareContainer(
                                        assetPath: 'assets/logo/filmora.png',
                                        isSelected:
                                            _selectedSkills['filmora'] ?? false,
                                        onTap: () {
                                          setState(() {
                                            _selectedSkills['filmora'] =
                                                !(_selectedSkills['filmora'] ??
                                                    false);
                                            if (_selectedSkills['filmora']!) {
                                              VideoEditor.add(1);
                                            } else {
                                              VideoEditor.remove(1);
                                            }
                                          });
                                        },
                                      ),
                                      SoftwareContainer(
                                        assetPath: 'assets/logo/davinci.png',
                                        isSelected:
                                            _selectedSkills['davinci'] ?? false,
                                        onTap: () {
                                          setState(() {
                                            _selectedSkills['davinci'] =
                                                !(_selectedSkills['davinci'] ??
                                                    false);
                                            if (_selectedSkills['davinci']!) {
                                              VideoEditor.add(2);
                                            } else {
                                              VideoEditor.remove(2);
                                            }
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 20),

                                  // Machine Learning
                                  Text(
                                    'Machine Learning',
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue),
                                  ),
                                  SizedBox(height: 10),
                                  Wrap(
                                    spacing: 14,
                                    runSpacing: 10,
                                    children: [
                                      SoftwareContainer(
                                        assetPath: 'assets/logo/tensorflow.png',
                                        isSelected:
                                            _selectedSkills['tensorflow'] ??
                                                false,
                                        onTap: () {
                                          setState(() {
                                            _selectedSkills['tensorflow'] =
                                                !(_selectedSkills[
                                                        'tensorflow'] ??
                                                    false);
                                            if (_selectedSkills[
                                                'tensorflow']!) {
                                              MachineLearning.add(0);
                                            } else {
                                              MachineLearning.remove(0);
                                            }
                                          });
                                        },
                                      ),
                                      SoftwareContainer(
                                        assetPath:
                                            'assets/logo/googlecolab.png',
                                        isSelected:
                                            _selectedSkills['googlecolab'] ??
                                                false,
                                        onTap: () {
                                          setState(() {
                                            _selectedSkills['googlecolab'] =
                                                !(_selectedSkills[
                                                        'googlecolab'] ??
                                                    false);
                                            if (_selectedSkills[
                                                'googlecolab']!) {
                                              MachineLearning.add(1);
                                            } else {
                                              MachineLearning.remove(1);
                                            }
                                          });
                                        },
                                      ),
                                      SoftwareContainer(
                                        assetPath: 'assets/logo/knime.png',
                                        isSelected:
                                            _selectedSkills['knime'] ?? false,
                                        onTap: () {
                                          setState(() {
                                            _selectedSkills['knime'] =
                                                !(_selectedSkills['knime'] ??
                                                    false);
                                            if (_selectedSkills['knime']!) {
                                              MachineLearning.add(2);
                                            } else {
                                              MachineLearning.remove(2);
                                            }
                                          });
                                        },
                                      ),
                                      SoftwareContainer(
                                        assetPath: 'assets/logo/keras.png',
                                        isSelected:
                                            _selectedSkills['keras'] ?? false,
                                        onTap: () {
                                          setState(() {
                                            _selectedSkills['keras'] =
                                                !(_selectedSkills['keras'] ??
                                                    false);
                                            if (_selectedSkills['keras']!) {
                                              MachineLearning.add(3);
                                            } else {
                                              MachineLearning.remove(3);
                                            }
                                          });
                                        },
                                      ),
                                      SoftwareContainer(
                                        assetPath: 'assets/logo/azure.png',
                                        isSelected:
                                            _selectedSkills['azure'] ?? false,
                                        onTap: () {
                                          setState(() {
                                            _selectedSkills['azure'] =
                                                !(_selectedSkills['azure'] ??
                                                    false);
                                            if (_selectedSkills['azure']!) {
                                              MachineLearning.add(4);
                                            } else {
                                              MachineLearning.remove(4);
                                            }
                                          });
                                        },
                                      ),
                                      SoftwareContainer(
                                        assetPath: 'assets/logo/shogun.png',
                                        isSelected:
                                            _selectedSkills['shogun'] ?? false,
                                        onTap: () {
                                          setState(() {
                                            _selectedSkills['shogun'] =
                                                !(_selectedSkills['shogun'] ??
                                                    false);
                                            if (_selectedSkills['shogun']!) {
                                              MachineLearning.add(5);
                                            } else {
                                              MachineLearning.remove(5);
                                            }
                                          });
                                        },
                                      ),
                                      SoftwareContainer(
                                        assetPath: 'assets/logo/pytorch.png',
                                        isSelected:
                                            _selectedSkills['pytorch'] ?? false,
                                        onTap: () {
                                          setState(() {
                                            _selectedSkills['pytorch'] =
                                                !(_selectedSkills['pytorch'] ??
                                                    false);
                                            if (_selectedSkills['pytorch']!) {
                                              MachineLearning.add(6);
                                            } else {
                                              MachineLearning.remove(6);
                                            }
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 20),

                                  // Security
                                  Text(
                                    'Programming',
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue),
                                  ),
                                  SizedBox(height: 10),
                                  Wrap(
                                    spacing: 14,
                                    runSpacing: 10,
                                    children: [
                                      SoftwareContainer(
                                        assetPath:
                                            'assets/logo/visualstudio.png',
                                        isSelected:
                                            _selectedSkills['visualstudio'] ??
                                                false,
                                        onTap: () {
                                          setState(() {
                                            _selectedSkills['visualstudio'] =
                                                !(_selectedSkills[
                                                        'visualstudio'] ??
                                                    false);
                                            if (_selectedSkills[
                                                'visualstudio']!) {
                                              Programming.add(0);
                                            } else {
                                              Programming.remove(0);
                                            }
                                          });
                                        },
                                      ),
                                      SoftwareContainer(
                                        assetPath: 'assets/logo/sublime.png',
                                        isSelected:
                                            _selectedSkills['sublime'] ?? false,
                                        onTap: () {
                                          setState(() {
                                            _selectedSkills['sublime'] =
                                                !(_selectedSkills['sublime'] ??
                                                    false);
                                            if (_selectedSkills['sublime']!) {
                                              Programming.add(1);
                                            } else {
                                              Programming.remove(1);
                                            }
                                          });
                                        },
                                      ),
                                    ],
                                  ),

                                  Text(
                                    'Security',
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue),
                                  ),
                                  SizedBox(height: 10),
                                  Wrap(
                                    spacing: 14,
                                    runSpacing: 10,
                                    children: [
                                      SoftwareContainer(
                                        assetPath: 'assets/logo/wireshark.png',
                                        isSelected:
                                            _selectedSkills['wireshark'] ??
                                                false,
                                        onTap: () {
                                          setState(() {
                                            _selectedSkills['wireshark'] =
                                                !(_selectedSkills[
                                                        'wireshark'] ??
                                                    false);
                                            if (_selectedSkills['wireshark']!) {
                                              Security.add(0);
                                            } else {
                                              Security.remove(0);
                                            }
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      height: 400,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            for (int i = 0; i < hasilSearch.length; i++)
                              Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => MyAppadmin(
                                                id: hasilSearch[i].id!),
                                          ));
                                    },
                                    child: Container(
                                      width: 650,
                                      height: 130,
                                      padding: EdgeInsets.all(16.0),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                        border: Border.all(
                                            color: Colors.blue, width: 1),
                                      ),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  hasilSearch[i].nama!,
                                                  style: TextStyle(
                                                    color: Color(0xFF6372F5),
                                                    fontSize: 16.0,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                SizedBox(height: 8.0),
                                                Container(
                                                  height: 50,
                                                  child: SingleChildScrollView(
                                                    child: Text(
                                                      hasilSearch[i].deskripsi!,
                                                      style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 12.0,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),

                                          VerticalDivider(
                                            color: Color(0xFF6372F5),
                                            thickness: 4.0,
                                          ),
                                          SizedBox(
                                              width:
                                                  10.0), // Space to the right of the divider

                                          Expanded(
                                            child: Container(
                                              height: 120,
                                              child: SingleChildScrollView(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    RichText(
                                                      text: TextSpan(
                                                        children: [
                                                          TextSpan(
                                                            text:
                                                                'Pemograman web & mobile: ',
                                                            style: TextStyle(
                                                              color: Color(
                                                                  0xFF6372F5),
                                                              fontSize: 12.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                          TextSpan(
                                                            text: hasilSearch[i]
                                                                .pemrogramanSkill,
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.grey,
                                                              fontSize: 12.0,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(height: 4.0),
                                                    RichText(
                                                      text: TextSpan(
                                                        children: [
                                                          TextSpan(
                                                            text:
                                                                'Design Visual: ',
                                                            style: TextStyle(
                                                              color: Color(
                                                                  0xFF6372F5),
                                                              fontSize: 12.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                          TextSpan(
                                                            text: hasilSearch[i]
                                                                .designVisualSkill,
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.grey,
                                                              fontSize: 12.0,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(height: 4.0),
                                                    RichText(
                                                      text: TextSpan(
                                                        children: [
                                                          TextSpan(
                                                            text:
                                                                'Keamanan Jaringan: ',
                                                            style: TextStyle(
                                                              color: Color(
                                                                  0xFF6372F5),
                                                              fontSize: 12.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                          TextSpan(
                                                            text: hasilSearch[i]
                                                                .keamananSkill,
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.grey,
                                                              fontSize: 12.0,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(height: 4.0),
                                                    RichText(
                                                      text: TextSpan(
                                                        children: [
                                                          TextSpan(
                                                            text:
                                                                'Machine Learning: ',
                                                            style: TextStyle(
                                                              color: Color(
                                                                  0xFF6372F5),
                                                              fontSize: 12.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                          TextSpan(
                                                            text: hasilSearch[i]
                                                                .machineLearningSkill,
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.grey,
                                                              fontSize: 12.0,
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
                                  ),
                                  SizedBox(
                                    height: 15,
                                  )
                                ],
                              ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 100,
                    ),
                    footer(),
                  ],
                ),
              );
            } else {
              if (snapshot.connectionState == ConnectionState.done) {
                return SingleChildScrollView(
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
                                  RichText(
                                      text: TextSpan(
                                    text:
                                        'Digital Portfolio Website for Information Technology Department Students',
                                    style: TextStyle(
                                      fontSize: 55,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      height:
                                          1.2, // Mengatur jarak antar baris (1.5 kali tinggi font)
                                    ),
                                  )),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      text:
                                          'This platform is designed to make it easy for students to digitize and showcase their portfolios. Here, students can effortlessly compile and present their best work, making it accessible to peers, faculty, and potential employers.',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.normal,
                                        color: Color.fromARGB(136, 70, 70, 70),
                                        height:
                                            1.5, // Mengatur jarak antar baris (1.5 kali tinggi font)
                                      ),
                                      children: <TextSpan>[],
                                    ),
                                    textAlign: TextAlign.left,
                                    maxLines: 5,
                                    overflow: TextOverflow.visible,
                                  ),
                                  SizedBox(height: 20),
                                  ElevatedButton.icon(
                                    onPressed: () {},
                                    label: Text('Get Started'),
                                    icon: Icon(Icons.arrow_forward_rounded),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.blue,
                                      foregroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.zero,
                                        side: BorderSide(
                                            width: 2, color: Colors.blue),
                                      ),
                                      textStyle: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      minimumSize: Size(150, 50),
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
                                    "assets/posterhomepage1.png",
                                  ),
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 100,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 20.0),
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        width: MediaQuery.of(context).size.width *
                            0.6, // Sesuaikan lebar konten utama
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  showFilter = !showFilter;

                                  resetSelectedFilter();
                                  // Toggle visibilitas filter
                                });
                              },
                              child: Text(
                                'Filter',
                                style: TextStyle(fontSize: 18.0),
                              ),
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.blue,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 20.0),
                              ),
                            ),
                            SizedBox(width: 20.0),
                            Expanded(
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: 'Search...',
                                  border: InputBorder.none,
                                ),
                                onChanged: (value) {
                                  namaYangDiSearch = value;
                                  print("data yang tersimpan : " +
                                      namaYangDiSearch);
                                },
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  for (int i = 0;
                                      i < seluruhDataPengguna.length;
                                      i++) {
                                    print("nama pengguna no " +
                                        i.toString() +
                                        " " +
                                        seluruhDataPengguna[i].nama.toString());
                                  }
                                  searchNamaUser();
                                  showFilter = false;
                                  resetSelectedFilter();
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.search,
                                  color: Colors.blue,
                                  size: 30.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Visibility(
                        visible:
                            showFilter, // Tampilkan hanya jika showFilter true
                        child: Container(
                          width: 760,
                          height: 1000,
                          padding: EdgeInsets.all(25.0),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 255, 255, 255),
                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Design Visual

                              Text(
                                '1. Soft Skill',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue),
                              ),
                              SizedBox(height: 10),
                              Wrap(
                                spacing: 14,
                                runSpacing: 10,
                                children: [
                                  SkillContainer(
                                    text: 'UI/UX Design',
                                    isSelected:
                                        _selectedSkills['UI/UX Design'] ??
                                            false,
                                    onTap: () {
                                      setState(() {
                                        _selectedSkills['UI/UX Design'] =
                                            !(_selectedSkills['UI/UX Design'] ??
                                                false);
                                      });
                                    },
                                  ),
                                  SkillContainer(
                                    text: 'Mockup Design',
                                    isSelected:
                                        _selectedSkills['Mockup Design'] ??
                                            false,
                                    onTap: () {
                                      setState(() {
                                        _selectedSkills['Mockup Design'] =
                                            !(_selectedSkills[
                                                    'Mockup Design'] ??
                                                false);
                                      });
                                    },
                                  ),
                                  SkillContainer(
                                    text: 'Design Graphic',
                                    isSelected:
                                        _selectedSkills['Design Graphic'] ??
                                            false,
                                    onTap: () {
                                      setState(() {
                                        _selectedSkills['Design Graphic'] =
                                            !(_selectedSkills[
                                                    'Design Graphic'] ??
                                                false);
                                      });
                                    },
                                  ),
                                  SkillContainer(
                                    text: 'Logo Design',
                                    isSelected:
                                        _selectedSkills['Logo Design'] ?? false,
                                    onTap: () {
                                      setState(() {
                                        _selectedSkills['Logo Design'] =
                                            !(_selectedSkills['Logo Design'] ??
                                                false);
                                      });
                                    },
                                  ),
                                  SkillContainer(
                                    text: 'Game Design',
                                    isSelected:
                                        _selectedSkills['Game Design'] ?? false,
                                    onTap: () {
                                      setState(() {
                                        _selectedSkills['Game Design'] =
                                            !(_selectedSkills['Game Design'] ??
                                                false);
                                      });
                                    },
                                  ),
                                  SkillContainer(
                                    text: 'Industrial Design',
                                    isSelected:
                                        _selectedSkills['Industrial Design'] ??
                                            false,
                                    onTap: () {
                                      setState(() {
                                        _selectedSkills['Industrial Design'] =
                                            !(_selectedSkills[
                                                    'Industrial Design'] ??
                                                false);
                                      });
                                    },
                                  ),
                                  SkillContainer(
                                    text: 'Creative Design',
                                    isSelected:
                                        _selectedSkills['Creative Design'] ??
                                            false,
                                    onTap: () {
                                      setState(() {
                                        _selectedSkills['Creative Design'] =
                                            !(_selectedSkills[
                                                    'Creative Design'] ??
                                                false);
                                      });
                                    },
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),

                              // Development
                              // Text(
                              //   '2. Programming Language',
                              //   style: TextStyle(
                              //       fontSize: 12,
                              //       fontWeight: FontWeight.bold,
                              //       color: Colors.blue),
                              // ),
                              SizedBox(height: 10),
                              Wrap(
                                spacing: 14,
                                runSpacing: 10,
                                children: [
                                  SkillContainer(
                                    text: 'Java',
                                    isSelected:
                                        _selectedSkills['Java'] ?? false,
                                    onTap: () {
                                      setState(() {
                                        _selectedSkills['Java'] =
                                            !(_selectedSkills['Java'] ?? false);
                                      });
                                    },
                                  ),
                                  SkillContainer(
                                    text: 'Flutter',
                                    isSelected:
                                        _selectedSkills['Flutter'] ?? false,
                                    onTap: () {
                                      setState(() {
                                        _selectedSkills['Flutter'] =
                                            !(_selectedSkills['Flutter'] ??
                                                false);
                                      });
                                    },
                                  ),
                                  SkillContainer(
                                    text: 'Python',
                                    isSelected:
                                        _selectedSkills['Python'] ?? false,
                                    onTap: () {
                                      setState(() {
                                        _selectedSkills['Python'] =
                                            !(_selectedSkills['Python'] ??
                                                false);
                                      });
                                    },
                                  ),
                                  SkillContainer(
                                    text: 'Java Script',
                                    isSelected:
                                        _selectedSkills['Java Script'] ?? false,
                                    onTap: () {
                                      setState(() {
                                        _selectedSkills['Java Script'] =
                                            !(_selectedSkills['Java Script'] ??
                                                false);
                                      });
                                    },
                                  ),
                                  SkillContainer(
                                    text: 'PHP',
                                    isSelected: _selectedSkills['PHP'] ?? false,
                                    onTap: () {
                                      setState(() {
                                        _selectedSkills['PHP'] =
                                            !(_selectedSkills['PHP'] ?? false);
                                      });
                                    },
                                  ),
                                  SkillContainer(
                                    text: 'Kotlin',
                                    isSelected:
                                        _selectedSkills['Kotlin'] ?? false,
                                    onTap: () {
                                      setState(() {
                                        _selectedSkills['Kotlin'] =
                                            !(_selectedSkills['Kotlin'] ??
                                                false);
                                      });
                                    },
                                  ),
                                  SkillContainer(
                                    text: 'Dart',
                                    isSelected:
                                        _selectedSkills['Dart'] ?? false,
                                    onTap: () {
                                      setState(() {
                                        _selectedSkills['Dart'] =
                                            !(_selectedSkills['Dart'] ?? false);
                                      });
                                    },
                                  ),
                                  SkillContainer(
                                    text: 'Golang',
                                    isSelected:
                                        _selectedSkills['Golang'] ?? false,
                                    onTap: () {
                                      setState(() {
                                        _selectedSkills['Golang'] =
                                            !(_selectedSkills['Golang'] ??
                                                false);
                                      });
                                    },
                                  ),
                                  SkillContainer(
                                    text: 'Swift',
                                    isSelected:
                                        _selectedSkills['Swift'] ?? false,
                                    onTap: () {
                                      setState(() {
                                        _selectedSkills['Swift'] =
                                            !(_selectedSkills['Swift'] ??
                                                false);
                                      });
                                    },
                                  ),
                                  SkillContainer(
                                    text: 'C++',
                                    isSelected: _selectedSkills['C++'] ?? false,
                                    onTap: () {
                                      setState(() {
                                        _selectedSkills['C++'] =
                                            !(_selectedSkills['C++'] ?? false);
                                      });
                                    },
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),

                              // Machine Learning
                              // Text(
                              //   '3. Machine Learning',
                              //   style: TextStyle(
                              //       fontSize: 12,
                              //       fontWeight: FontWeight.bold,
                              //       color: Colors.blue),
                              // ),
                              SizedBox(height: 10),
                              Wrap(
                                spacing: 14,
                                runSpacing: 10,
                                children: [
                                  SkillContainer(
                                    text: 'Clasification',
                                    isSelected:
                                        _selectedSkills['Clasification'] ??
                                            false,
                                    onTap: () {
                                      setState(() {
                                        _selectedSkills['Clasification'] =
                                            !(_selectedSkills[
                                                    'Clasification'] ??
                                                false);
                                      });
                                    },
                                  ),
                                  SkillContainer(
                                    text: 'Regression',
                                    isSelected:
                                        _selectedSkills['Regression'] ?? false,
                                    onTap: () {
                                      setState(() {
                                        _selectedSkills['Regression'] =
                                            !(_selectedSkills['Regression'] ??
                                                false);
                                      });
                                    },
                                  ),
                                  SkillContainer(
                                    text: 'Clustering',
                                    isSelected:
                                        _selectedSkills['Clustering'] ?? false,
                                    onTap: () {
                                      setState(() {
                                        _selectedSkills['Clustering'] =
                                            !(_selectedSkills['Clustering'] ??
                                                false);
                                      });
                                    },
                                  ),
                                  SkillContainer(
                                    text: 'Association',
                                    isSelected:
                                        _selectedSkills['Association'] ?? false,
                                    onTap: () {
                                      setState(() {
                                        _selectedSkills['Association'] =
                                            !(_selectedSkills['Association'] ??
                                                false);
                                      });
                                    },
                                  ),
                                  SkillContainer(
                                    text: 'Deep Learning',
                                    isSelected:
                                        _selectedSkills['Deep Learning'] ??
                                            false,
                                    onTap: () {
                                      setState(() {
                                        _selectedSkills['Deep Learning'] =
                                            !(_selectedSkills[
                                                    'Deep Learning'] ??
                                                false);
                                      });
                                    },
                                  ),
                                  SkillContainer(
                                    text: 'jancok',
                                    isSelected:
                                        _selectedSkills['jancok'] ?? false,
                                    onTap: () {
                                      setState(() {
                                        _selectedSkills['jancok'] =
                                            !(_selectedSkills['jancok'] ??
                                                false);
                                      });
                                    },
                                  ),
                                  SkillContainer(
                                    text: 'Dart',
                                    isSelected:
                                        _selectedSkills['Dart'] ?? false,
                                    onTap: () {
                                      setState(() {
                                        _selectedSkills['Dart'] =
                                            !(_selectedSkills['Dart'] ?? false);
                                      });
                                    },
                                  ),
                                  SkillContainer(
                                    text: 'Golang',
                                    isSelected:
                                        _selectedSkills['Golang'] ?? false,
                                    onTap: () {
                                      setState(() {
                                        _selectedSkills['Golang'] =
                                            !(_selectedSkills['Golang'] ??
                                                false);
                                      });
                                    },
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),

                              // Security
                              // Text(
                              //   '4. Security',
                              //   style: TextStyle(
                              //       fontSize: 12,
                              //       fontWeight: FontWeight.bold,
                              //       color: Colors.blue),
                              // ),
                              SizedBox(height: 10),
                              Wrap(
                                spacing: 14,
                                runSpacing: 10,
                                children: [
                                  SkillContainer(
                                    text: 'Java',
                                    isSelected:
                                        _selectedSkills['Java'] ?? false,
                                    onTap: () {
                                      setState(() {
                                        _selectedSkills['Java'] =
                                            !(_selectedSkills['Java'] ?? false);
                                      });
                                    },
                                  ),
                                  SkillContainer(
                                    text: 'Flutter',
                                    isSelected:
                                        _selectedSkills['Flutter'] ?? false,
                                    onTap: () {
                                      setState(() {
                                        _selectedSkills['Flutter'] =
                                            !(_selectedSkills['Flutter'] ??
                                                false);
                                      });
                                    },
                                  ),
                                  SkillContainer(
                                    text: 'Python',
                                    isSelected:
                                        _selectedSkills['Python'] ?? false,
                                    onTap: () {
                                      setState(() {
                                        _selectedSkills['Python'] =
                                            !(_selectedSkills['Python'] ??
                                                false);
                                      });
                                    },
                                  ),
                                  SkillContainer(
                                    text: 'Java Script',
                                    isSelected:
                                        _selectedSkills['Java Script'] ?? false,
                                    onTap: () {
                                      setState(() {
                                        _selectedSkills['Java Script'] =
                                            !(_selectedSkills['Java Script'] ??
                                                false);
                                      });
                                    },
                                  ),
                                  SkillContainer(
                                    text: 'PHP',
                                    isSelected: _selectedSkills['PHP'] ?? false,
                                    onTap: () {
                                      setState(() {
                                        _selectedSkills['PHP'] =
                                            !(_selectedSkills['PHP'] ?? false);
                                      });
                                    },
                                  ),
                                  SkillContainer(
                                    text: 'Kotlin',
                                    isSelected:
                                        _selectedSkills['Kotlin'] ?? false,
                                    onTap: () {
                                      setState(() {
                                        _selectedSkills['Kotlin'] =
                                            !(_selectedSkills['Kotlin'] ??
                                                false);
                                      });
                                    },
                                  ),
                                  SkillContainer(
                                    text: 'Dart',
                                    isSelected:
                                        _selectedSkills['Dart'] ?? false,
                                    onTap: () {
                                      setState(() {
                                        _selectedSkills['Dart'] =
                                            !(_selectedSkills['Dart'] ?? false);
                                      });
                                    },
                                  ),
                                  SkillContainer(
                                    text: 'Golang',
                                    isSelected:
                                        _selectedSkills['Golang'] ?? false,
                                    onTap: () {
                                      setState(() {
                                        _selectedSkills['Golang'] =
                                            !(_selectedSkills['Golang'] ??
                                                false);
                                      });
                                    },
                                  ),
                                ],
                              ),

                              SizedBox(height: 40),
                              Text(
                                '2. Software Skill',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue),
                              ),
                              SizedBox(height: 10),
                              Wrap(
                                spacing: 20,
                                runSpacing: 10,
                                children: [
                                  SoftwareContainer(
                                    assetPath: 'assets/logo/illustrator.png',
                                    isSelected: _selectedSoftware[''] ?? false,
                                    onTap: () {
                                      setState(() {
                                        _selectedSoftware[''] =
                                            !(_selectedSoftware[''] ?? false);
                                      });
                                    },
                                  ),
                                  SoftwareContainer(
                                    assetPath: 'assets/logo/photoshop.png',
                                    isSelected:
                                        _selectedSoftware['photoshop'] ?? false,
                                    onTap: () {
                                      setState(() {
                                        _selectedSoftware['photoshop'] =
                                            !(_selectedSoftware['photoshop'] ??
                                                false);
                                      });
                                    },
                                  ),
                                  SoftwareContainer(
                                    assetPath: 'assets/logo/coreldraw.png',
                                    isSelected:
                                        _selectedSoftware['coreldraw'] ?? false,
                                    onTap: () {
                                      setState(() {
                                        _selectedSoftware['coreldraw'] =
                                            !(_selectedSoftware['coreldraw'] ??
                                                false);
                                      });
                                    },
                                  ),
                                  SoftwareContainer(
                                    assetPath: 'assets/logo/sketch.png',
                                    isSelected:
                                        _selectedSoftware['sketch'] ?? false,
                                    onTap: () {
                                      setState(() {
                                        _selectedSoftware['sketch'] =
                                            !(_selectedSoftware['sketch'] ??
                                                false);
                                      });
                                    },
                                  ),
                                  SoftwareContainer(
                                    assetPath: 'assets/logo/adobeindesign.png',
                                    isSelected:
                                        _selectedSoftware['adobeindesign'] ??
                                            false,
                                    onTap: () {
                                      setState(() {
                                        _selectedSoftware['adobeindesign'] =
                                            !(_selectedSoftware[
                                                    'adobeindesign'] ??
                                                false);
                                      });
                                    },
                                  ),
                                  SoftwareContainer(
                                    assetPath: 'assets/logo/gimp.png',
                                    isSelected:
                                        _selectedSoftware['gimp'] ?? false,
                                    onTap: () {
                                      setState(() {
                                        _selectedSoftware['gimp'] =
                                            !(_selectedSoftware['gimp'] ??
                                                false);
                                      });
                                    },
                                  ),
                                  SoftwareContainer(
                                    assetPath: 'assets/logo/figma.png',
                                    isSelected:
                                        _selectedSoftware['figma'] ?? false,
                                    onTap: () {
                                      setState(() {
                                        _selectedSoftware['figma'] =
                                            !(_selectedSoftware['figma'] ??
                                                false);
                                      });
                                    },
                                  ),
                                  SoftwareContainer(
                                    assetPath: 'assets/logo/affinity.png',
                                    isSelected:
                                        _selectedSoftware['affinity'] ?? false,
                                    onTap: () {
                                      setState(() {
                                        _selectedSoftware['affinity'] =
                                            !(_selectedSoftware['affinity'] ??
                                                false);
                                      });
                                    },
                                  ),
                                  SoftwareContainer(
                                    assetPath: 'assets/logo/sketchup.png',
                                    isSelected:
                                        _selectedSoftware['sketchup'] ?? false,
                                    onTap: () {
                                      setState(() {
                                        _selectedSoftware['sketchup'] =
                                            !(_selectedSoftware['sketchup'] ??
                                                false);
                                      });
                                    },
                                  ),
                                  SoftwareContainer(
                                    assetPath: 'assets/logo/autocad.png',
                                    isSelected:
                                        _selectedSoftware['autocad'] ?? false,
                                    onTap: () {
                                      setState(() {
                                        _selectedSoftware['autocad'] =
                                            !(_selectedSoftware['autocad'] ??
                                                false);
                                      });
                                    },
                                  ),
                                  SoftwareContainer(
                                    assetPath: 'assets/logo/inkscape.png',
                                    isSelected:
                                        _selectedSoftware['inkscape'] ?? false,
                                    onTap: () {
                                      setState(() {
                                        _selectedSoftware['inkscape'] =
                                            !(_selectedSoftware['inkscape'] ??
                                                false);
                                      });
                                    },
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),

                              // Development
                              Text(
                                '2. Vidio Editor',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue),
                              ),
                              SizedBox(height: 10),
                              Wrap(
                                spacing: 20,
                                runSpacing: 10,
                                children: [
                                  SoftwareContainer(
                                    assetPath: 'assets/icons/icon.png',
                                    isSelected:
                                        _selectedSoftware['Java'] ?? false,
                                    onTap: () {
                                      setState(() {
                                        _selectedSoftware['Java'] =
                                            !(_selectedSoftware['Java'] ??
                                                false);
                                      });
                                    },
                                  ),
                                  SoftwareContainer(
                                    assetPath: 'assets/icons/icon.png',
                                    isSelected:
                                        _selectedSoftware['Flutter'] ?? false,
                                    onTap: () {
                                      setState(() {
                                        _selectedSoftware['Flutter'] =
                                            !(_selectedSoftware['Flutter'] ??
                                                false);
                                      });
                                    },
                                  ),
                                  SoftwareContainer(
                                    assetPath: 'assets/icons/icon.png',
                                    isSelected:
                                        _selectedSoftware['Python'] ?? false,
                                    onTap: () {
                                      setState(() {
                                        _selectedSoftware['Python'] =
                                            !(_selectedSoftware['Python'] ??
                                                false);
                                      });
                                    },
                                  ),
                                  SoftwareContainer(
                                    assetPath: 'assets/icons/icon.png',
                                    isSelected:
                                        _selectedSoftware['Java Script'] ??
                                            false,
                                    onTap: () {
                                      setState(() {
                                        _selectedSoftware['Java Script'] =
                                            !(_selectedSoftware[
                                                    'Java Script'] ??
                                                false);
                                      });
                                    },
                                  ),
                                  SoftwareContainer(
                                    assetPath: 'assets/icons/icon.png',
                                    isSelected:
                                        _selectedSoftware['PHP'] ?? false,
                                    onTap: () {
                                      setState(() {
                                        _selectedSoftware['PHP'] =
                                            !(_selectedSoftware['PHP'] ??
                                                false);
                                      });
                                    },
                                  ),
                                  SoftwareContainer(
                                    assetPath: 'assets/icons/icon.png',
                                    isSelected:
                                        _selectedSoftware['Kotlin'] ?? false,
                                    onTap: () {
                                      setState(() {
                                        _selectedSoftware['Kotlin'] =
                                            !(_selectedSoftware['Kotlin'] ??
                                                false);
                                      });
                                    },
                                  ),
                                  SoftwareContainer(
                                    assetPath: 'assets/icons/icon.png',
                                    isSelected:
                                        _selectedSoftware['Dart'] ?? false,
                                    onTap: () {
                                      setState(() {
                                        _selectedSoftware['Dart'] =
                                            !(_selectedSoftware['Dart'] ??
                                                false);
                                      });
                                    },
                                  ),
                                  SoftwareContainer(
                                    assetPath: 'assets/icons/icon.png',
                                    isSelected:
                                        _selectedSoftware['Golang'] ?? false,
                                    onTap: () {
                                      setState(() {
                                        _selectedSoftware['Golang'] =
                                            !(_selectedSoftware['Golang'] ??
                                                false);
                                      });
                                    },
                                  ),
                                  SoftwareContainer(
                                    assetPath: 'assets/icons/icon.png',
                                    isSelected:
                                        _selectedSoftware['Swift'] ?? false,
                                    onTap: () {
                                      setState(() {
                                        _selectedSoftware['Swift'] =
                                            !(_selectedSoftware['Swift'] ??
                                                false);
                                      });
                                    },
                                  ),
                                  SoftwareContainer(
                                    assetPath: 'assets/icons/icon.png',
                                    isSelected:
                                        _selectedSoftware['C++'] ?? false,
                                    onTap: () {
                                      setState(() {
                                        _selectedSoftware['C++'] =
                                            !(_selectedSoftware['C++'] ??
                                                false);
                                      });
                                    },
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),

                              // Machine Learning
                              Text(
                                '3. Machine Learning',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue),
                              ),
                              SizedBox(height: 10),
                              Wrap(
                                spacing: 20,
                                runSpacing: 10,
                                children: [
                                  SoftwareContainer(
                                    assetPath: 'assets/icons/icon.png',
                                    isSelected:
                                        _selectedSoftware['Data Analysis'] ??
                                            false,
                                    onTap: () {
                                      setState(() {
                                        _selectedSoftware['Data Analysis'] =
                                            !(_selectedSoftware[
                                                    'Data Analysis'] ??
                                                false);
                                      });
                                    },
                                  ),
                                  SoftwareContainer(
                                    assetPath: 'assets/icons/icon.png',
                                    isSelected:
                                        _selectedSoftware['Computer Vision'] ??
                                            false,
                                    onTap: () {
                                      setState(() {
                                        _selectedSoftware['Computer Vision'] =
                                            !(_selectedSoftware[
                                                    'Computer Vision'] ??
                                                false);
                                      });
                                    },
                                  ),
                                  SoftwareContainer(
                                    assetPath: 'assets/icons/icon.png',
                                    isSelected: _selectedSoftware[
                                            'Natural Language Processing'] ??
                                        false,
                                    onTap: () {
                                      setState(() {
                                        _selectedSoftware[
                                                'Natural Language Processing'] =
                                            !(_selectedSoftware[
                                                    'Natural Language Processing'] ??
                                                false);
                                      });
                                    },
                                  ),
                                  SoftwareContainer(
                                    assetPath: 'assets/icons/icon.png',
                                    isSelected:
                                        _selectedSoftware['Deep Learning'] ??
                                            false,
                                    onTap: () {
                                      setState(() {
                                        _selectedSoftware['Deep Learning'] =
                                            !(_selectedSoftware[
                                                    'Deep Learning'] ??
                                                false);
                                      });
                                    },
                                  ),
                                  SoftwareContainer(
                                    assetPath: 'assets/icons/icon.png',
                                    isSelected:
                                        _selectedSoftware['Neural Networks'] ??
                                            false,
                                    onTap: () {
                                      setState(() {
                                        _selectedSoftware['Neural Networks'] =
                                            !(_selectedSoftware[
                                                    'Neural Networks'] ??
                                                false);
                                      });
                                    },
                                  ),
                                  SoftwareContainer(
                                    assetPath: 'assets/icons/icon.png',
                                    isSelected: _selectedSoftware[
                                            'Reinforcement Learning'] ??
                                        false,
                                    onTap: () {
                                      setState(() {
                                        _selectedSoftware[
                                                'Reinforcement Learning'] =
                                            !(_selectedSoftware[
                                                    'Reinforcement Learning'] ??
                                                false);
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        height: 400,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              for (int i = 0; i < hasilSearch.length; i++)
                                Column(
                                  children: [
                                    Container(
                                      width: 650,
                                      height: 130,
                                      padding: EdgeInsets.all(16.0),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                        border: Border.all(
                                            color: Colors.blue, width: 1),
                                      ),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  hasilSearch[i].nama!,
                                                  style: TextStyle(
                                                    color: Color(0xFF6372F5),
                                                    fontSize: 16.0,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                SizedBox(height: 8.0),
                                                Container(
                                                  height: 50,
                                                  child: SingleChildScrollView(
                                                    child: Text(
                                                      hasilSearch[i].deskripsi!,
                                                      style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 12.0,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),

                                          VerticalDivider(
                                            color: Color(0xFF6372F5),
                                            thickness: 4.0,
                                          ),
                                          SizedBox(
                                              width:
                                                  10.0), // Space to the right of the divider

                                          Expanded(
                                            child: Container(
                                              height: 120,
                                              child: SingleChildScrollView(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    RichText(
                                                      text: TextSpan(
                                                        children: [
                                                          TextSpan(
                                                            text:
                                                                'Pemograman web & mobile: ',
                                                            style: TextStyle(
                                                              color: Color(
                                                                  0xFF6372F5),
                                                              fontSize: 12.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                          TextSpan(
                                                            text: hasilSearch[i]
                                                                .pemrogramanSkill,
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.grey,
                                                              fontSize: 12.0,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(height: 4.0),
                                                    RichText(
                                                      text: TextSpan(
                                                        children: [
                                                          TextSpan(
                                                            text:
                                                                'Design Visual: ',
                                                            style: TextStyle(
                                                              color: Color(
                                                                  0xFF6372F5),
                                                              fontSize: 12.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                          TextSpan(
                                                            text: hasilSearch[i]
                                                                .designVisualSkill,
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.grey,
                                                              fontSize: 12.0,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(height: 4.0),
                                                    RichText(
                                                      text: TextSpan(
                                                        children: [
                                                          TextSpan(
                                                            text:
                                                                'Keamanan Jaringan: ',
                                                            style: TextStyle(
                                                              color: Color(
                                                                  0xFF6372F5),
                                                              fontSize: 12.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                          TextSpan(
                                                            text: hasilSearch[i]
                                                                .keamananSkill,
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.grey,
                                                              fontSize: 12.0,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(height: 4.0),
                                                    RichText(
                                                      text: TextSpan(
                                                        children: [
                                                          TextSpan(
                                                            text:
                                                                'Machine Learning: ',
                                                            style: TextStyle(
                                                              color: Color(
                                                                  0xFF6372F5),
                                                              fontSize: 12.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                          TextSpan(
                                                            text: hasilSearch[i]
                                                                .machineLearningSkill,
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.grey,
                                                              fontSize: 12.0,
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
                                    SizedBox(
                                      height: 15,
                                    )
                                  ],
                                ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 100,
                      ),
                      footer(),
                    ],
                  ),
                );
              } else {
                return CircularProgressIndicator();
              }
            }
          }),
    );
  }
}

class SoftwareContainer extends StatelessWidget {
  final String assetPath;
  final bool isSelected;
  final VoidCallback onTap;

  const SoftwareContainer({
    required this.assetPath,
    required this.isSelected,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.blue, width: 1),
            ),
            child: CircleAvatar(
              radius: 25,
              backgroundColor: isSelected ? Colors.blue : Colors.white,
              child: Image.asset(
                assetPath,
                width: 25,
                height: 25,
                color: isSelected ? Colors.white : Colors.blue,
              ),
            ),
          ),
          // Remove the text under the icon
          // Text(
          //   skillName,
          //   style: TextStyle(
          //     fontSize: 12,
          //     fontWeight: FontWeight.bold,
          //   ),
          // ),
        ],
      ),
    );
  }
}

class SkillContainer extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const SkillContainer({
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 106, // Adjust the width as needed
        height: 25,
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue : Colors.white,
          border: Border.all(
            color: Colors.blue,
            width: 1,
          ),
        ),
        alignment: Alignment.center, // Align text to the center
        child: Text(
          text,
          style: TextStyle(
            fontSize: 12,
            color: isSelected ? Colors.white : Colors.blue,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class DashboardItem {
  final bool berbutton;
  final String imagePath;
  final String title;
  final String count;
  final Color color;
  final Icon? icon;

  DashboardItem({
    required this.berbutton,
    required this.imagePath,
    required this.icon,
    required this.title,
    required this.count,
    required this.color,
  });
}
