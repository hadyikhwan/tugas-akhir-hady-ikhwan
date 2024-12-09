import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:skripsi/admin/header_Admin.dart';
import 'package:skripsi/mahasiswa%20aktif/editS2.dart';
import 'dart:html' as html;
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:skripsi/mahasiswa%20aktif/header.dart';
import 'package:url_launcher/url_launcher.dart';

class achievementComponents {
  String deskripsi = "";
  String linkDocument = "";
  String nameOfCompetition = "";
  String ranking = "";
  String year = "";
}

class experienceComponents {
  String jobDescription = "";
  String linkDocument = "";
  String nameOfInstitution = "";
  String positionTitle = "";
  String year = "";
}

class personalSkills {
  String name = "";
  int percentage = 0;
}

String namaUser = "";
String urlImage = "";
String deskripsi = "";
String instagram = "";
String facebook = "";
String github = "";
String linkedin = "";
String twiter = "";
String email = "";
String whatsapp = "";

List<achievementComponents> achievementComponent = [];
List<experienceComponents> experienceComponent = [];
List<personalSkills> personalSkill = [];

//skill
List<int> designVisual = [];
List<int> machineLearning = [];
List<int> programmingLanguage = [];
List<int> security = [];

//software
List<String> pathImageSoftwareDesignVisual = [];
List<String> pathImageSoftwareMachineLearning = [];
List<String> pathImageSoftwareProgramming = [];
List<String> pathImageSoftwareSecurity = [];
List<String> pathImageSoftwareVideoEditor = [];

List<int> kodePilihanDesignVisual = [];
List<int> kodePilihanMachineLearning = [];
List<int> kodePilihanProgramming = [];
List<int> kodePilihanSecurity = [];
List<int> kodePilihanVideoEditor = [];

setDataPathSoftwareDesignVisual() {
  pathImageSoftwareDesignVisual.add("assets/logo/illustrator.png");
  pathImageSoftwareDesignVisual.add("assets/logo/photoshop.png");
  pathImageSoftwareDesignVisual.add("assets/logo/coreldraw.png");
  pathImageSoftwareDesignVisual.add("assets/logo/sketch.png");
  pathImageSoftwareDesignVisual.add("assets/logo/adobeindesign.png");
  pathImageSoftwareDesignVisual.add("assets/logo/gimp.png");
  pathImageSoftwareDesignVisual.add("assets/logo/figma.png");
  pathImageSoftwareDesignVisual.add("assets/logo/affinity.png");
  pathImageSoftwareDesignVisual.add("assets/logo/sketchup.png");
  pathImageSoftwareDesignVisual.add("assets/logo/autocad.png");
  pathImageSoftwareDesignVisual.add("assets/logo/inkscape.png'");
}

setDataPathSoftwareMachineLearning() {
  pathImageSoftwareMachineLearning.add("assets/logo/tensorflow.png");
  pathImageSoftwareMachineLearning.add("assets/logo/googlecolab.png");
  pathImageSoftwareMachineLearning.add("assets/logo/knime.png");
  pathImageSoftwareMachineLearning.add("assets/logo/keras.png");
  pathImageSoftwareMachineLearning.add("assets/logo/azure.png");
  pathImageSoftwareMachineLearning.add("assets/logo/shogun.png");
  pathImageSoftwareMachineLearning.add("assets/logo/pytorch.png");
}

setDataPathSoftwareProgramming() {
  pathImageSoftwareProgramming.add("assets/logo/visualstudio.png");
  pathImageSoftwareProgramming.add("assets/logo/sublime.png");
}

setDataPathSoftwareSecurity() {
  pathImageSoftwareSecurity.add("assets/logo/wireshark.png");
}

setDataPathSoftwareVideoEditor() {
  pathImageSoftwareVideoEditor.add("assets/logo/premier.png");
  pathImageSoftwareVideoEditor.add("assets/logo/filmora.png");
  pathImageSoftwareVideoEditor.add("assets/logo/davinci.png");
}

List<String> softwareYangDikuasai = [];
pengisianDataPathImageSoftware() {
  //design visual
  for (int i = 0; i < kodePilihanDesignVisual.length; i++) {
    softwareYangDikuasai.add(pathImageSoftwareDesignVisual[i]);
  }
  //machine learning
  for (int i = 0; i < kodePilihanMachineLearning.length; i++) {
    softwareYangDikuasai.add(pathImageSoftwareMachineLearning[i]);
  }
  //programming
  for (int i = 0; i < kodePilihanProgramming.length; i++) {
    softwareYangDikuasai.add(pathImageSoftwareProgramming[i]);
  }
  //security
  for (int i = 0; i < kodePilihanSecurity.length; i++) {
    softwareYangDikuasai.add(pathImageSoftwareSecurity[i]);
  }
  //video editor
  for (int i = 0; i < kodePilihanVideoEditor.length; i++) {
    softwareYangDikuasai.add(pathImageSoftwareVideoEditor[i]);
  }
}

//nilaiMK
List<int> nilaiSems1 = [];
List<int> nilaiSems2 = [];
List<int> nilaiSems3 = [];
List<int> nilaiSems4 = [];
List<int> nilaiSems5 = [];
List<int> nilaiSems6 = [];
List<int> nilaiSems7 = [];

List<int> mkPemrogramanWebdanMobile = [];
List<int> mkKemananJaringan = [];
List<int> mkManajemenInformasi = [];

double mencariRataRataMkTiapSemester(
    int banyakData, int titikAwal, List<int> listNilai) {
  double hasilPenjumlahan = 0;

  for (int i = titikAwal; i < banyakData + titikAwal; i++) {
    hasilPenjumlahan += listNilai[i];
  }

  return hasilPenjumlahan / banyakData;
}

setMK() {
  //web dan mobile
  mkPemrogramanWebdanMobile.add(nilaiSems1[1]);

  mkPemrogramanWebdanMobile.add(nilaiSems2[0]);

  mkPemrogramanWebdanMobile.add(nilaiSems3[0]);
  mkPemrogramanWebdanMobile.add(nilaiSems3[4]);

  mkPemrogramanWebdanMobile.add(nilaiSems4[2]);
  mkPemrogramanWebdanMobile.add(nilaiSems4[3]);

  mkPemrogramanWebdanMobile.add(nilaiSems5[2]);
  mkPemrogramanWebdanMobile.add(nilaiSems5[3]);

  mkPemrogramanWebdanMobile.add(nilaiSems6[2]);
  mkPemrogramanWebdanMobile.add(nilaiSems6[7]);
  mkPemrogramanWebdanMobile.add(nilaiSems6[9]);
  mkPemrogramanWebdanMobile.add(nilaiSems6[10]);

  mkPemrogramanWebdanMobile.add(nilaiSems7[0]);
  mkPemrogramanWebdanMobile.add(nilaiSems7[3]);
  mkPemrogramanWebdanMobile.add(nilaiSems7[8]);

  //kemanan jaringan
  mkKemananJaringan.add(nilaiSems1[1]);
  mkKemananJaringan.add(nilaiSems1[0]);

  mkKemananJaringan.add(nilaiSems2[1]);
  mkKemananJaringan.add(nilaiSems2[2]);

  mkKemananJaringan.add(nilaiSems3[1]);
  mkKemananJaringan.add(nilaiSems3[3]);

  mkKemananJaringan.add(nilaiSems4[0]);

  mkKemananJaringan.add(nilaiSems5[1]);

  mkKemananJaringan.add(nilaiSems6[1]);
  mkKemananJaringan.add(nilaiSems6[3]);
  mkKemananJaringan.add(nilaiSems6[6]);
  mkKemananJaringan.add(nilaiSems6[11]);

  mkKemananJaringan.add(nilaiSems7[6]);
  mkKemananJaringan.add(nilaiSems7[7]);
  mkKemananJaringan.add(nilaiSems7[9]);

  //manajemen informasi
  mkManajemenInformasi.add(nilaiSems1[1]);

  mkManajemenInformasi.add(nilaiSems2[3]);

  mkManajemenInformasi.add(nilaiSems3[2]);

  mkManajemenInformasi.add(nilaiSems4[1]);

  mkManajemenInformasi.add(nilaiSems5[0]);

  mkManajemenInformasi.add(nilaiSems6[1]);
  mkManajemenInformasi.add(nilaiSems6[4]);
  mkManajemenInformasi.add(nilaiSems6[5]);
  mkManajemenInformasi.add(nilaiSems6[8]);

  mkManajemenInformasi.add(nilaiSems7[1]);
  mkManajemenInformasi.add(nilaiSems7[2]);
  mkManajemenInformasi.add(nilaiSems7[4]);
  mkManajemenInformasi.add(nilaiSems7[5]);
}

//end of variable
deleteData() {
  mkPemrogramanWebdanMobile.clear();
  mkKemananJaringan.clear();
  mkManajemenInformasi.clear();

  nilaiSems1.clear();
  nilaiSems2.clear();
  nilaiSems3.clear();
  nilaiSems4.clear();
  nilaiSems5.clear();
  nilaiSems6.clear();
  nilaiSems7.clear();

  namaUser = "";
  urlImage = "";
  deskripsi = "";

  achievementComponent.clear();
  experienceComponent.clear();
  personalSkill.clear();

  skillDesignVisual.clear();
  skillMachineLearning.clear();
  skillProgrammingLanguage.clear();
  skillSecurity.clear();

  designVisual.clear();
  machineLearning.clear();
  programmingLanguage.clear();
  security.clear();

  softwareYangDikuasai.clear();

  pathImageSoftwareDesignVisual.clear();
  pathImageSoftwareMachineLearning.clear();
  pathImageSoftwareProgramming.clear();
  pathImageSoftwareSecurity.clear();
  pathImageSoftwareVideoEditor.clear();
  kodePilihanDesignVisual.clear();
  kodePilihanMachineLearning.clear();
  kodePilihanProgramming.clear();
  kodePilihanSecurity.clear();
  kodePilihanVideoEditor.clear();
}

class designVisualData {
  bool uiuxDesign = false;
  bool mockupDesign = false;
  bool designGraphic = false;
  bool logoDesign = false;
  bool gameDesign = false;
  bool industrialDesign = false;
  bool creativeDesign = false;
}

List<String> skillDesignVisual = [];
List<String> skillMachineLearning = [];
List<String> skillProgrammingLanguage = [];
List<String> skillSecurity = [];

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
        skillSecurity.add("Java Script");
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

class MyAppadmin extends StatelessWidget {
  final String id;
  const MyAppadmin({super.key, required this.id});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: portfolioPage(
        id: id,
      ),
    );
  }
}

class portfolioPage extends StatefulWidget {
  final String id;
  portfolioPage({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  _portfolioPageState createState() => _portfolioPageState();
}

class _portfolioPageState extends State<portfolioPage> {
  void _onIconPressed(String url) {
    html.window.open(url, 'new tab');
  }

  @override
  Widget build(BuildContext context) {
    getDataUser() async {
      deleteData();

      //software
      setDataPathSoftwareDesignVisual();
      setDataPathSoftwareMachineLearning();
      setDataPathSoftwareProgramming();
      setDataPathSoftwareSecurity();
      setDataPathSoftwareVideoEditor();

      await FirebaseFirestore.instance
          .collection("User")
          .doc(widget.id)
          .get()
          .then(
        (value) {
          namaUser = value['username'];
          urlImage = value['linkFotoProfile'];
          deskripsi = value['deskripsi'];
          instagram = value['linkInstagram'];
          github = value['linkGithub'];
          twiter = value['linkTwitter'];
          facebook = value['linkFacebook'];
          linkedin = value['linkLinkedin'];
          email = value['Email'];
          whatsapp = value['noHandphone'];
        },
      );
      //achievement
      await FirebaseFirestore.instance
          .collection("User")
          .doc(widget.id)
          .collection("achievement")
          .get()
          .then(
        (value) {
          value.docs.forEach((element) {
            achievementComponent.add(achievementComponents());
            achievementComponent[achievementComponent.length - 1].deskripsi =
                element['description'];
            achievementComponent[achievementComponent.length - 1].linkDocument =
                element['linkDocument'];
            achievementComponent[achievementComponent.length - 1]
                .nameOfCompetition = element['name of Competition'];
            achievementComponent[achievementComponent.length - 1].ranking =
                element['ranking'];
            achievementComponent[achievementComponent.length - 1].year =
                element['year'];
          });
        },
      );

      //experience
      await FirebaseFirestore.instance
          .collection("User")
          .doc(widget.id)
          .collection("experience")
          .get()
          .then(
        (value) {
          value.docs.forEach((element) {
            experienceComponent.add(experienceComponents());
            experienceComponent[experienceComponent.length - 1].jobDescription =
                element['job description'];
            experienceComponent[experienceComponent.length - 1].linkDocument =
                element['linkDocument'];
            experienceComponent[experienceComponent.length - 1]
                .nameOfInstitution = element['name of institution'];
            experienceComponent[experienceComponent.length - 1].positionTitle =
                element['position_title'];
            experienceComponent[experienceComponent.length - 1].year =
                element['year'];
          });
        },
      );

      //personal Skill
      await FirebaseFirestore.instance
          .collection("User")
          .doc(widget.id)
          .collection("personalSkill")
          .get()
          .then(
        (value) {
          value.docs.forEach((element) {
            personalSkill.add(personalSkills());
            personalSkill[personalSkill.length - 1].name =
                element['personalSkillName'].toString();
            personalSkill[personalSkill.length - 1].percentage =
                element['percentage'];
          });
        },
      );

      //skill
      await FirebaseFirestore.instance
          .collection("User")
          .doc(widget.id)
          .collection("Skill")
          .get()
          .then(
        (value) {
          value.docs.forEach((element) {
            switch (element.id) {
              case "Design Visual":
                for (int i = 0;
                    i < element["Skill yang dikuasai"].length;
                    i++) {
                  designVisual.add(element["Skill yang dikuasai"][i]);
                }
                break;
              case "Machine Learning":
                for (int i = 0;
                    i < element["Skill yang dikuasai"].length;
                    i++) {
                  machineLearning.add(element["Skill yang dikuasai"][i]);
                }
                break;
              case "Proramming Language":
                for (int i = 0;
                    i < element["Skill yang dikuasai"].length;
                    i++) {
                  programmingLanguage.add(element["Skill yang dikuasai"][i]);
                }
                break;
              case "Security":
                for (int i = 0;
                    i < element["Skill yang dikuasai"].length;
                    i++) {
                  security.add(element["Skill yang dikuasai"][i]);
                }
                break;
            }
          });
        },
      );

      //software
      await FirebaseFirestore.instance
          .collection("User")
          .doc(widget.id)
          .collection("software")
          .get()
          .then(
        (value) {
          value.docs.forEach((element) {
            switch (element.id) {
              case "designVisual":
                for (int i = 0;
                    i < element["aplikasi yang dikuasai"].length;
                    i++) {
                  kodePilihanDesignVisual
                      .add(element["aplikasi yang dikuasai"][i]);
                }
                break;
              case "machineLearning":
                for (int i = 0;
                    i < element["aplikasi yang dikuasai"].length;
                    i++) {
                  kodePilihanMachineLearning
                      .add(element["aplikasi yang dikuasai"][i]);
                }
                break;
              case "programming":
                for (int i = 0;
                    i < element["aplikasi yang dikuasai"].length;
                    i++) {
                  kodePilihanProgramming
                      .add(element["aplikasi yang dikuasai"][i]);
                }
                break;
              case "security":
                for (int i = 0;
                    i < element["aplikasi yang dikuasai"].length;
                    i++) {
                  kodePilihanSecurity.add(element["aplikasi yang dikuasai"][i]);
                }
                break;
              case "videoEditor":
                for (int i = 0;
                    i < element["aplikasi yang dikuasai"].length;
                    i++) {
                  kodePilihanVideoEditor
                      .add(element["aplikasi yang dikuasai"][i]);
                }
                break;
            }
          });
        },
      );

      //nilaiMK
      await FirebaseFirestore.instance
          .collection("User")
          .doc(widget.id)
          .collection("nilaiMK")
          .get()
          .then(
        (value) {
          value.docs.forEach((element) {
            print("laskjdflasejflaskjdfe");
            switch (element.id) {
              case "semester1":
                nilaiSems1.add(int.parse(element['Matematika Dasar']));
                nilaiSems1
                    .add(int.parse(element['Pengantar Teknologi Informasi']));
                break;
              case "semester2":
                nilaiSems2.add(int.parse(element['Algoritma dan Pemrograman']));
                nilaiSems2.add(int.parse(element['Logika Informatika'])); //k
                nilaiSems2
                    .add(int.parse(element['Pengantar Jaringan Komputer'])); //k
                nilaiSems2
                    .add(int.parse(element['Sistem Manajemen Basis Data'])); //i
                break;
              case "semester3":
                nilaiSems3
                    .add(int.parse(element['Interaksi Manusia dan Komputer']));
                nilaiSems3
                    .add(int.parse(element['Jaringan Komputer Lanjut'])); //k
                nilaiSems3.add(int.parse(element['Manajemen Informasi'])); //i
                nilaiSems3.add(int.parse(element['Matematika Distrik'])); //k
                nilaiSems3.add(int.parse(element['Struktu Data']));
                break;
              case "semester4":
                nilaiSems4.add(int.parse(element['Keamanan Jaringan'])); //k
                nilaiSems4.add(int.parse(element['Kecerdasan Bisnis'])); //i
                nilaiSems4
                    .add(int.parse(element['Pemograman Berorientasi Object']));
                nilaiSems4
                    .add(int.parse(element['Perancangan User Experience']));
                break;
              case "semester5":
                nilaiSems5.add(int.parse(element['Big Data'])); //i
                nilaiSems5
                    .add(int.parse(element['Keamanan Data dan Informasi'])); //k
                nilaiSems5.add(int.parse(
                    element['Konsep Pengembangan Aplikasi Web dan Mobile']));
                nilaiSems5.add(int.parse(element['Pemograman Web']));
                break;
              case "semester6":
                nilaiSems6.add(int.parse(element['Audit IT Security'])); //k
                nilaiSems6.add(int.parse(element['Data Mining'])); //i
                nilaiSems6.add(int.parse(element['E-Learning'])); // mobile 2
                nilaiSems6.add(int.parse(element['Internet Of Thinks'])); //k
                nilaiSems6.add(int.parse(element['Kecerdasan Buatan'])); //i
                nilaiSems6.add(int.parse(element['Komputasi Cloud'])); //i
                nilaiSems6.add(int.parse(element['Kriptografi'])); //k
                nilaiSems6
                    .add(int.parse(element['Pemograman Mobile'])); //mobile 7
                nilaiSems6
                    .add(int.parse(element['Sistem Informasi Geografis'])); //i
                nilaiSems6.add(int.parse(
                    element['Sistem Operasi Berbasis Mobile'])); //mobile 9

                nilaiSems6.add(
                    int.parse(element['Sistem Web dan Mobile'])); // mobile 10

                nilaiSems6.add(int.parse(element['Teknologi Manuskrip'])); //k
                break;
              case "semester7":
                nilaiSems7.add(int.parse(element['Bisnis Digital'])); // m 0
                nilaiSems7
                    .add(int.parse(element['ERP Software dan Manajemen'])); //i
                nilaiSems7
                    .add(int.parse(element['Jaringan Syaraf Tiruan'])); //i
                nilaiSems7.add(int.parse(element['Konten Digital'])); // m 3
                nilaiSems7.add(int.parse(element['Machine Learning'])); //i
                nilaiSems7
                    .add(int.parse(element['Pemrosesan Bahasa Alami'])); //i
                nilaiSems7.add(int.parse(
                    element['Sistem Forensik, Investigasi dan Respon'])); //k
                nilaiSems7
                    .add(int.parse(element['Software Aplikasi Cluster'])); //k
                nilaiSems7.add(int.parse(element['Software Sosial'])); // m 8
                nilaiSems7.add(int.parse(element['Teknologi Blockchain'])); //k
                break;
            }
          });
        },
      );

      setMK();

      pengisianDataPathImageSoftware();

      convertingSkillSecurity(security);
      convertingSkillDesignVisual(designVisual);
      convertingSkillMachineLearning(machineLearning);
      convertingSkillProgrammingLanguage(programmingLanguage);
    }

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 249, 249, 255),
      appBar: header_admin(),
      body: FutureBuilder(
          future: getDataUser(),
          builder: (context, snapshot) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 50),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'THIS IS ME',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                namaUser,
                                style: TextStyle(
                                  fontSize: 60,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                deskripsi,
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
                              Row(
                                children: [
                                  ElevatedButton(
                                    onPressed: () {},
                                    child: Text('DISCOVER NOW'),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.blue,
                                      foregroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.zero,
                                      ),
                                      textStyle: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 20),
                                  ElevatedButton.icon(
                                    onPressed: () {
                                      //   Navigator.push(context, MaterialPageRoute(builder: (context) => kartu()));
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return SimpleDialog(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    CircleAvatar(
                                                      radius: 40,
                                                      backgroundImage:
                                                          NetworkImage(
                                                              urlImage),
                                                    ),
                                                    SizedBox(height: 10),
                                                    Text(
                                                      namaUser,
                                                      style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    Text(
                                                      'Web Developer',
                                                      style: TextStyle(
                                                        color: Colors.blue,
                                                      ),
                                                    ),
                                                    SizedBox(height: 5),
                                                    Container(
                                                      width: 300,
                                                      child: Text(
                                                        deskripsi,
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(height: 20),
                                                    GestureDetector(
                                                      onTap: () =>
                                                          _onIconPressed(email),
                                                      child: Container(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical: 8,
                                                                horizontal: 16),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.blue,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                        ),
                                                        child: Text(
                                                          email,
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(height: 20),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        IconButton(
                                                          icon: FaIcon(
                                                              FontAwesomeIcons
                                                                  .whatsapp),
                                                          onPressed: () =>
                                                              _onIconPressed(
                                                                  "https://wa.me/" +
                                                                      whatsapp),
                                                        ),
                                                        IconButton(
                                                          icon: FaIcon(
                                                              FontAwesomeIcons
                                                                  .twitter),
                                                          onPressed: () =>
                                                              _onIconPressed(
                                                                  "https://x.com/" +
                                                                      twiter),
                                                        ),
                                                        IconButton(
                                                          icon: FaIcon(
                                                              FontAwesomeIcons
                                                                  .squareInstagram),
                                                          onPressed: () =>
                                                              _onIconPressed(
                                                                  "https://www.instagram.com/" +
                                                                      instagram),
                                                        ),
                                                        IconButton(
                                                          icon: FaIcon(
                                                              FontAwesomeIcons
                                                                  .facebook),
                                                          onPressed: () =>
                                                              _onIconPressed(
                                                                  "https://www.facebook.com/" +
                                                                      facebook),
                                                        ),
                                                        IconButton(
                                                          icon: FaIcon(
                                                              FontAwesomeIcons
                                                                  .linkedin),
                                                          onPressed: () =>
                                                              _onIconPressed(
                                                                  "https://id.linkedin.com/in/" +
                                                                      linkedin),
                                                        ),
                                                        IconButton(
                                                          icon: FaIcon(
                                                              FontAwesomeIcons
                                                                  .github),
                                                          onPressed: () =>
                                                              _onIconPressed(
                                                                  "https://github.com/" +
                                                                      github),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    icon: Icon(Icons.send),
                                    label: Text('Hire Me'),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      foregroundColor: Colors.blue,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.zero,
                                        side: BorderSide(
                                            width: 2, color: Colors.blue),
                                      ),
                                      textStyle: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                            width: 20), // Jarak antara dua bagian dalam Row
                        Container(
                          width: 400,
                          height: 440,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(urlImage),
                                fit:
                                    BoxFit.cover), // Warna latar belakang kotak
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(
                                    0.25), // Warna dan opasitas bayangan
                                spreadRadius: 0, // Jarak penyebaran bayangan
                                blurRadius: 10, // Jarak blur bayangan
                                offset:
                                    Offset(15, 15), // Offset bayangan (x, y)
                              ),
                            ],
                            border: Border.all(
                              color: Colors.blue, // Warna border
                              width: 25, // Ketebalan border
                            ),
                          ),
                          child: Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(urlImage.toString()),
                                    fit: BoxFit.cover)),
                          ),
                        ),
                        SizedBox(
                          width: 25,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 80),

                  // ACHIEVEMENT
                  Center(
                    child: Text(
                      'Achievement',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  Center(
                    child: Text(
                      'Throughout my educational journey, I\'ve amassed a collection of achievements\n that signify my dedication and perseverance.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: Color.fromARGB(136, 70, 70, 70),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  for (int i = 0; i < achievementComponent.length; i = i + 3)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for (int j = i;
                            i + 3 <= achievementComponent.length
                                ? j < i + 3
                                : j < achievementComponent.length;
                            j++)
                          AchievementCard(
                              year: achievementComponent[j].year,
                              title: achievementComponent[j].nameOfCompetition,
                              icon: AssetImage("assets/piala.png"),
                              description: achievementComponent[j].deskripsi,
                              buttonText: "Download",
                              urlFile: achievementComponent[j].linkDocument),
                      ],
                    ),

                  SizedBox(height: 100),

                  // EXPERIENCE
                  Center(
                    child: Text(
                      'Experience',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      'My experience includes years of working in various industries, allowing  me to\n develop diverse skills and perspectives.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: Color.fromARGB(136, 70, 70, 70),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  for (int i = 0; i < experienceComponent.length; i = i + 3)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for (int j = i;
                            i + 3 <= experienceComponent.length
                                ? j < i + 3
                                : j < experienceComponent.length;
                            j++)
                          AchievementCard(
                              year: experienceComponent[j].year,
                              title: experienceComponent[j].nameOfInstitution,
                              icon: AssetImage("assets/experience.png"),
                              description:
                                  experienceComponent[j].jobDescription,
                              buttonText: "Download",
                              urlFile: experienceComponent[j].linkDocument),
                      ],
                    ),

                  SizedBox(
                    height: 100,
                  ),

                  // END EXPERIENCE

                  // PERSONAL SKILL

                  Center(
                    child: Text(
                      'Personal Skill',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      'Here are my personal skills that I have developed throughout my life journey. \n I possess strong communication skills, both verbal and written, enabling me to \ninteract with diverse individuals and convey ideas clearly and effectively',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: Color.fromARGB(136, 70, 70, 70),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  for (int i = 0; i < personalSkill.length; i = i + 5)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for (int j = i;
                            i + 5 <= personalSkill.length
                                ? j < i + 5
                                : j < personalSkill.length;
                            j++)
                          personalSkillTampilan(
                              name: personalSkill[j].name,
                              percentage: personalSkill[j].percentage)
                      ],
                    ),

                  SizedBox(
                    height: 100,
                  ),
                  // END CHARTS

                  // SOFT SKILL

                  Center(
                    child: Text(
                      'Soft Skills',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      'Here are my soft skills that I have honed over time. I possess strong interpersonal\n skills, allowing me to build and maintain positive relationships with others.\n These soft skills collectively contribute to my effectiveness in various professional\n and personal endeavors.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: Color.fromARGB(136, 70, 70, 70),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),

                  //Design Grafis
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Column(
                      children: [
                        Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    '1. Design Grafis',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue),
                                  ),
                                ),
                              ],
                            ),
                            skillDesignVisual.length != 0
                                ? Column(
                                    children: [
                                      for (int i = 0;
                                          i < skillDesignVisual.length;
                                          i = i + 6)
                                        Row(
                                          children: [
                                            for (int j = i;
                                                i + 6 <=
                                                        skillDesignVisual.length
                                                    ? j < i + 6
                                                    : j <
                                                        skillDesignVisual
                                                            .length;
                                                j++)
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 10, right: 20),
                                                child: Container(
                                                  width: 150,
                                                  height: 40,
                                                  decoration: BoxDecoration(
                                                    color: Color.fromARGB(
                                                        255, 249, 249, 255),
                                                    border: Border.all(
                                                      color: Colors
                                                          .blue, // Ubah warna border di sini
                                                      width:
                                                          2, // Ubah ketebalan border di sini
                                                    ),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      skillDesignVisual[j],
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.blue,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                          ],
                                        ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                    ],
                                  )
                                : Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 24.0),
                                    child: Row(
                                      children: [
                                        Container(
                                          child: Text(
                                            "-",
                                            style: TextStyle(
                                                color: Colors.blue,
                                                fontSize: 30),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                            SizedBox(
                              height: 25,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Column(
                      children: [
                        Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    '2. Programming Language',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue),
                                  ),
                                ),
                              ],
                            ),
                            skillProgrammingLanguage.length != 0
                                ? Column(
                                    children: [
                                      for (int i = 0;
                                          i < skillProgrammingLanguage.length;
                                          i = i + 6)
                                        Row(
                                          children: [
                                            for (int j = i;
                                                i + 6 <=
                                                        skillProgrammingLanguage
                                                            .length
                                                    ? j < i + 6
                                                    : j <
                                                        skillProgrammingLanguage
                                                            .length;
                                                j++)
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 10, right: 20),
                                                child: Container(
                                                  width: 150,
                                                  height: 40,
                                                  decoration: BoxDecoration(
                                                    color: Color.fromARGB(
                                                        255, 249, 249, 255),
                                                    border: Border.all(
                                                      color: Colors
                                                          .blue, // Ubah warna border di sini
                                                      width:
                                                          2, // Ubah ketebalan border di sini
                                                    ),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      skillProgrammingLanguage[
                                                          j],
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.blue,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                          ],
                                        ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                    ],
                                  )
                                : Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 24.0),
                                    child: Row(
                                      children: [
                                        Container(
                                          child: Text(
                                            "-",
                                            style: TextStyle(
                                                color: Colors.blue,
                                                fontSize: 30),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                            SizedBox(
                              height: 25,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Column(
                      children: [
                        Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    '3. Machine Learning',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue),
                                  ),
                                ),
                              ],
                            ),
                            skillMachineLearning.length != 0
                                ? Column(
                                    children: [
                                      for (int i = 0;
                                          i < skillMachineLearning.length;
                                          i = i + 6)
                                        Row(
                                          children: [
                                            for (int j = i;
                                                i + 6 <=
                                                        skillMachineLearning
                                                            .length
                                                    ? j < i + 6
                                                    : j <
                                                        skillMachineLearning
                                                            .length;
                                                j++)
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 10, right: 20),
                                                child: Container(
                                                  width: 150,
                                                  height: 40,
                                                  decoration: BoxDecoration(
                                                    color: Color.fromARGB(
                                                        255, 249, 249, 255),
                                                    border: Border.all(
                                                      color: Colors
                                                          .blue, // Ubah warna border di sini
                                                      width:
                                                          2, // Ubah ketebalan border di sini
                                                    ),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      skillMachineLearning[j],
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.blue,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                          ],
                                        ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                    ],
                                  )
                                : Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 24.0),
                                    child: Row(
                                      children: [
                                        Container(
                                          child: Text(
                                            "-",
                                            style: TextStyle(
                                                color: Colors.blue,
                                                fontSize: 30),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                            SizedBox(
                              height: 25,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Column(
                      children: [
                        Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    '4. Security',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue),
                                  ),
                                ),
                              ],
                            ),
                            skillSecurity.length != 0
                                ? Column(
                                    children: [
                                      for (int i = 0;
                                          i < skillSecurity.length;
                                          i = i + 6)
                                        Row(
                                          children: [
                                            for (int j = i;
                                                i + 6 <= skillSecurity.length
                                                    ? j < i + 6
                                                    : j < skillSecurity.length;
                                                j++)
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 10, right: 20),
                                                child: Container(
                                                  width: 150,
                                                  height: 40,
                                                  decoration: BoxDecoration(
                                                    color: Color.fromARGB(
                                                        255, 249, 249, 255),
                                                    border: Border.all(
                                                      color: Colors
                                                          .blue, // Ubah warna border di sini
                                                      width:
                                                          2, // Ubah ketebalan border di sini
                                                    ),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      skillSecurity[j],
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.blue,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                          ],
                                        ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                    ],
                                  )
                                : Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 24.0),
                                    child: Row(
                                      children: [
                                        Container(
                                          child: Text(
                                            "-",
                                            style: TextStyle(
                                                color: Colors.blue,
                                                fontSize: 30),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                            SizedBox(
                              height: 25,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  SizedBox(
                    height: 100,
                  ),

                  // END SOFT SKILL

                  // SOFTWARE

                  Center(
                    child: Text(
                      'Software',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      'Here are my software skills that I have acquired and mastered over time. I am proficient in using \n a variety of programming languages such as Python, Java, and JavaScript, allowing me to\n develop robust and scalable software solutions.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: Color.fromARGB(136, 70, 70, 70),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),

                  //row 1
                  for (int i = 0; i < softwareYangDikuasai.length; i = i + 6)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for (int j = i;
                            i + 6 <= softwareYangDikuasai.length
                                ? j < i + 6
                                : j < softwareYangDikuasai.length;
                            j++)
                          Row(
                            mainAxisAlignment: MainAxisAlignment
                                .center, // Posisikan semua item di tengah baris
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(35),
                                child: Expanded(
                                  child: Column(
                                    children: [
                                      Container(
                                        width: 100, // Ukuran lingkaran
                                        height: 100,
                                        decoration: BoxDecoration(
                                          shape: BoxShape
                                              .circle, // Mengatur bentuk menjadi lingkaran
                                          border: Border.all(
                                            color: Colors.blue, // Warna border
                                            width: 5, // Ketebalan border
                                          ),
                                        ),
                                        child: Center(
                                          child: Image.asset(
                                            softwareYangDikuasai[
                                                j], // Path gambar Anda
                                            width:
                                                60, // Ukuran gambar di dalam lingkaran
                                            height: 60,
                                            fit: BoxFit
                                                .cover, // Atur bagaimana gambar diatur dalam lingkaran
                                            color: Colors
                                                .blue, // Warna overlay gambar (optional)
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),

                  SizedBox(
                    height: 100,
                  ),

                  //END SOFTWARE

                  // STATISTIC
                  Center(
                    child: Text(
                      'Statistic',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      'Here is my academic transcript, showcasing my academic achievements throughout my\n educational journey. It provides a comprehensive overview of my grades, courses taken,\n and any honors or awards received during my academic pursuits.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: Color.fromARGB(136, 70, 70, 70),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),

                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Center(
                      child: Stack(
                        children: <Widget>[
                          Container(
                            width: 750, // Lebar kotak latar belakang
                            height: 450, // Tinggi kotak latar belakang
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0),
                              border:
                                  Border.all(color: Colors.black, width: 1.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),

                            child: Align(
                              alignment: Alignment.center,
                              child: SizedBox(
                                width: 700, // Lebar grafik
                                height: 350, // Tinggi grafik
                                child: BarChart(),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 20.0,
                            left: 20.0,
                            child: Text(
                              'Bidang Peminatan Statistic',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 100),

                  // END Statistic

                  //FOOTER

                  Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.5,
                      decoration: BoxDecoration(
                        color: Colors.blue, // Warna latar belakang kotak
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'SUPSKILL FOR A BETTER FUTURE',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Prodi Teknologi Informasi',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Jln. Syeikh Abdul Rauf Kopelma Darussalam\n Banda Aceh, 23111 INDONESIA',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () {
                              // Aksi ketika tombol ditekan
                            },
                            child: Text('Contact Us'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Colors.white, // Warna latar belakang tombol
                              foregroundColor: Colors.blue, // Warna teks tombol
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    20), // Sudut lengkung tombol
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Text(
                            '© 2024 Prodi Teknologi Informasi',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 20),
                          Center(
                            child: Container(
                              height: 1, // Tinggi garis horizontal (1 pixel)
                              width: MediaQuery.of(context).size.width * 0.4,
                              color: Colors.white, // Warna garis horizontal
                            ),
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment
                                .center, // Posisikan semua item di tengah baris
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Expanded(
                                  child: Column(
                                    children: [
                                      Container(
                                        width: 34, // Ukuran lingkaran
                                        height: 34,
                                        decoration: BoxDecoration(
                                          shape: BoxShape
                                              .circle, // Mengatur bentuk menjadi lingkaran
                                          border: Border.all(
                                            color: Colors.white, // Warna border
                                            width: 1, // Ketebalan border
                                          ),
                                        ),
                                        child: Center(
                                          child: Image.asset(
                                            'assets/linkedin.png',
                                            width: 20,
                                            height: 20,
                                            fit: BoxFit.cover,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Expanded(
                                  child: Column(
                                    children: [
                                      Container(
                                        width: 34, // Ukuran lingkaran
                                        height: 34,
                                        decoration: BoxDecoration(
                                          shape: BoxShape
                                              .circle, // Mengatur bentuk menjadi lingkaran
                                          border: Border.all(
                                            color: Colors.white, // Warna border
                                            width: 1, // Ketebalan border
                                          ),
                                        ),
                                        child: Center(
                                          child: Image.asset(
                                            'assets/facebook.png',
                                            width: 20,
                                            height: 20,
                                            fit: BoxFit.cover,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Expanded(
                                  child: Column(
                                    children: [
                                      Container(
                                        width: 34, // Ukuran lingkaran
                                        height: 34,
                                        decoration: BoxDecoration(
                                          shape: BoxShape
                                              .circle, // Mengatur bentuk menjadi lingkaran
                                          border: Border.all(
                                            color: Colors.white, // Warna border
                                            width: 1, // Ketebalan border
                                          ),
                                        ),
                                        child: Center(
                                          child: Image.asset(
                                            'assets/instagram.png',
                                            width: 20,
                                            height: 20,
                                            fit: BoxFit.cover,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Expanded(
                                  child: Column(
                                    children: [
                                      Container(
                                        width: 34, // Ukuran lingkaran
                                        height: 34,
                                        decoration: BoxDecoration(
                                          shape: BoxShape
                                              .circle, // Mengatur bentuk menjadi lingkaran
                                          border: Border.all(
                                            color: Colors.white, // Warna border
                                            width: 1, // Ketebalan border
                                          ),
                                        ),
                                        child: Center(
                                          child: Image.asset(
                                            'assets/youtube.png',
                                            width: 20,
                                            height: 20,
                                            fit: BoxFit.cover,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Expanded(
                                  child: Column(
                                    children: [
                                      Container(
                                        width: 34, // Ukuran lingkaran
                                        height: 34,
                                        decoration: BoxDecoration(
                                          shape: BoxShape
                                              .circle, // Mengatur bentuk menjadi lingkaran
                                          border: Border.all(
                                            color: Colors.white, // Warna border
                                            width: 1, // Ketebalan border
                                          ),
                                        ),
                                        child: Center(
                                          child: Image.asset(
                                            'assets/website.png',
                                            width: 20,
                                            height: 20,
                                            fit: BoxFit.cover,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}

// STATISTIC

class BarChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Data generation
    final pemrogramanWebdanMobileData = [
      OrdinalSales(
          'Semester 1',
          mencariRataRataMkTiapSemester(1, 0, mkPemrogramanWebdanMobile)
              .toInt()),
      OrdinalSales(
          'Semester 2',
          mencariRataRataMkTiapSemester(1, 1, mkPemrogramanWebdanMobile)
              .toInt()),
      OrdinalSales(
          'Semester 3',
          mencariRataRataMkTiapSemester(2, 2, mkPemrogramanWebdanMobile)
              .toInt()),
      OrdinalSales(
          'Semester 4',
          mencariRataRataMkTiapSemester(2, 4, mkPemrogramanWebdanMobile)
              .toInt()),
      OrdinalSales(
          'Semester 5',
          mencariRataRataMkTiapSemester(2, 6, mkPemrogramanWebdanMobile)
              .toInt()),
      OrdinalSales(
          'Semester 6',
          mencariRataRataMkTiapSemester(4, 8, mkPemrogramanWebdanMobile)
              .toInt()),
      OrdinalSales(
          'Semester 7',
          mencariRataRataMkTiapSemester(3, 12, mkPemrogramanWebdanMobile)
              .toInt()),
    ];

    final keamananJaringanData = [
      OrdinalSales('Semester 1',
          mencariRataRataMkTiapSemester(2, 0, mkKemananJaringan).toInt()),
      OrdinalSales('Semester 2',
          mencariRataRataMkTiapSemester(2, 2, mkKemananJaringan).toInt()),
      OrdinalSales('Semester 3',
          mencariRataRataMkTiapSemester(2, 4, mkKemananJaringan).toInt()),
      OrdinalSales('Semester 4',
          mencariRataRataMkTiapSemester(1, 6, mkKemananJaringan).toInt()),
      OrdinalSales('Semester 5',
          mencariRataRataMkTiapSemester(1, 7, mkKemananJaringan).toInt()),
      OrdinalSales('Semester 6',
          mencariRataRataMkTiapSemester(4, 8, mkKemananJaringan).toInt()),
      OrdinalSales('Semester 7',
          mencariRataRataMkTiapSemester(3, 12, mkKemananJaringan).toInt()),
    ];

    final manajemenInformasiData = [
      OrdinalSales('Semester 1',
          mencariRataRataMkTiapSemester(1, 0, mkManajemenInformasi).toInt()),
      OrdinalSales('Semester 2',
          mencariRataRataMkTiapSemester(1, 1, mkManajemenInformasi).toInt()),
      OrdinalSales('Semester 3',
          mencariRataRataMkTiapSemester(1, 2, mkManajemenInformasi).toInt()),
      OrdinalSales('Semester 4',
          mencariRataRataMkTiapSemester(1, 3, mkManajemenInformasi).toInt()),
      OrdinalSales('Semester 5',
          mencariRataRataMkTiapSemester(1, 4, mkManajemenInformasi).toInt()),
      OrdinalSales('Semester 6',
          mencariRataRataMkTiapSemester(4, 5, mkManajemenInformasi).toInt()),
      OrdinalSales('Semester 7',
          mencariRataRataMkTiapSemester(4, 9, mkManajemenInformasi).toInt()),
    ];

    // Series creation
    List<charts.Series<OrdinalSales, String>> seriesList = [
      charts.Series<OrdinalSales, String>(
        id: 'Pemrograman Web & Mobile',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (OrdinalSales sales, _) => sales.semester,
        measureFn: (OrdinalSales sales, _) => sales.value,
        data: pemrogramanWebdanMobileData,
      ),
      charts.Series<OrdinalSales, String>(
        id: 'Keamanan Jaringan',
        colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
        domainFn: (OrdinalSales sales, _) => sales.semester,
        measureFn: (OrdinalSales sales, _) => sales.value,
        data: keamananJaringanData,
      ),
      charts.Series<OrdinalSales, String>(
        id: 'Manajemen Informasi',
        colorFn: (_, __) => charts.MaterialPalette.yellow.shadeDefault,
        domainFn: (OrdinalSales sales, _) => sales.semester,
        measureFn: (OrdinalSales sales, _) => sales.value,
        data: manajemenInformasiData,
      ),
    ];

    // Chart creation
    return charts.BarChart(
      seriesList,
      animate: true,
      barGroupingType: charts.BarGroupingType.grouped,
      defaultRenderer: charts.BarRendererConfig<String>(
        maxBarWidthPx: 20,
        barGroupInnerPaddingPx: 5,
      ),
      behaviors: [
        charts.SeriesLegend(
          position: charts.BehaviorPosition.bottom,
          outsideJustification: charts.OutsideJustification.middleDrawArea,
          cellPadding: EdgeInsets.only(right: 23, left: 23, top: 23),
          entryTextStyle: charts.TextStyleSpec(
            color: charts.MaterialPalette.black,
            fontSize: 14,
          ),
        ),
      ],
      domainAxis: charts.OrdinalAxisSpec(
        renderSpec: charts.SmallTickRendererSpec(
          labelStyle: charts.TextStyleSpec(
            fontSize: 12,
            color: charts.MaterialPalette.black,
          ),
        ),
      ),
      primaryMeasureAxis: charts.NumericAxisSpec(
        renderSpec: charts.GridlineRendererSpec(
          labelStyle: charts.TextStyleSpec(
            fontSize: 12,
            color: charts.MaterialPalette.black,
          ),
        ),
        tickProviderSpec: charts.StaticNumericTickProviderSpec(
          // Menyediakan tick pada nilai 10, 20, 30, dst.
          <charts.TickSpec<num>>[
            charts.TickSpec<num>(0),
            charts.TickSpec<num>(10),
            charts.TickSpec<num>(20),
            charts.TickSpec<num>(30),
            charts.TickSpec<num>(40),
            charts.TickSpec<num>(50),
            charts.TickSpec<num>(60),
            charts.TickSpec<num>(70),
            charts.TickSpec<num>(80),
            charts.TickSpec<num>(90),
            charts.TickSpec<num>(100),
          ],
        ),
      ),
    );
  }
}

class OrdinalSales {
  final String semester;
  final int value;

  OrdinalSales(this.semester, this.value);
}

// CARD ACHIEVEMENT
tampilkanListAchievement(List<achievementComponents> list) {}

class AchievementCard extends StatelessWidget {
  final String title;
  final ImageProvider icon;
  final String description;
  final String buttonText;
  final String urlFile;
  final String year;

  AchievementCard({
    required this.title,
    required this.icon,
    required this.description,
    required this.buttonText,
    required this.urlFile,
    required this.year,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
      child: Container(
        height: 270,
        width: 350,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color:
                  Colors.black.withOpacity(0.10), // Warna dan opasitas bayangan
              spreadRadius: 0, // Jarak penyebaran bayangan
              blurRadius: 4, // Jarak blur bayangan
              offset: Offset(4, 4), // Offset bayangan (x, y)
            ),
          ],
        ),
        child: Card(
          elevation: 0.0,
          color: Color.fromARGB(255, 255, 255, 255),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image(
                  image: icon,
                  width: 50,
                  height: 50,
                  color: const Color.fromARGB(255, 0, 0, 0),
                ),
                SizedBox(height: 16),
                Container(
                  height: 50,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Container(
                  height: 50,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Text(
                          "In " + year + ", " + description,
                          style: TextStyle(
                            fontSize: 12,
                            color: Color.fromARGB(136, 70, 70, 70),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 16),
                urlFile != ""
                    ? ElevatedButton(
                        onPressed: () {
                          html.window.open(urlFile, 'new tab');
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 1.0, vertical: 1.0),
                          child: Text(buttonText),
                        ),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: Size(95, 35),
                          backgroundColor: Color.fromARGB(255, 248, 248, 248),
                          foregroundColor: const Color.fromARGB(255, 0, 0, 0),
                          iconColor: const Color.fromARGB(255, 0, 0, 0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          side: BorderSide(
                              width: 2,
                              color: const Color.fromARGB(255, 0, 0, 0)),
                          textStyle: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      )
                    : Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 2),
                          child: Text("Download"),
                        ),
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class personalSkillTampilan extends StatelessWidget {
  final String name;
  final int percentage;
  const personalSkillTampilan(
      {super.key, required this.name, required this.percentage});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Column(
        children: [
          Container(
            height: 150,
            width: 150,
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                shape: BoxShape.circle, color: Colors.grey.shade200),
            child: SfRadialGauge(
              axes: [
                RadialAxis(
                  pointers: [
                    RangePointer(
                      value: percentage.toDouble(),
                      width: 20,
                      cornerStyle: CornerStyle.bothCurve,
                      gradient: const SweepGradient(colors: [
                        Colors.blue,
                        Color.fromARGB(255, 46, 183, 247),
                      ], stops: [
                        0.1,
                        0.75
                      ]),
                    )
                  ],
                  axisLineStyle:
                      AxisLineStyle(thickness: 20, color: Colors.grey.shade300),
                  startAngle: 5,
                  endAngle: 4,
                  showLabels: false,
                  showTicks: false,
                  annotations: [
                    GaugeAnnotation(
                      widget: Text(
                        percentage.toString() + '%',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: Colors.blue,
                        ),
                      ),
                      angle: 270,
                      positionFactor: 0.1,
                    )
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            height: 3,
          ),
          Container(
            width: 150,
            height: 100,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Center(
                    child: Text(
                      name,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
