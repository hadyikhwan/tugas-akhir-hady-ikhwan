import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Databaseservice {
  final String? userID;
  Databaseservice({this.userID});

  Future addNamaUser(String namaUser) async {
    //biodata
    await FirebaseFirestore.instance.collection("User").doc(userID).set({
      "username": namaUser,
      "alamat": "",
      "noHandphone": "",
      "Email": "",
      "linkInstagram": "",
      "linkTwitter": "",
      "linkFacebook": "",
      "linkLinkedin": "",
      "linkGithub": "",
      "deskripsi": "",
      "linkFotoProfile" : "",
    });

    //skill
    await FirebaseFirestore.instance
        .collection("User")
        .doc(userID)
        .collection("Skill")
        .doc("Proramming Language")
        .set({"Skill yang dikuasai": []});
    await FirebaseFirestore.instance
        .collection("User")
        .doc(userID)
        .collection("Skill")
        .doc("Machine Learning")
        .set({"Skill yang dikuasai": []});
    await FirebaseFirestore.instance
        .collection("User")
        .doc(userID)
        .collection("Skill")
        .doc("Security")
        .set({"Skill yang dikuasai": []});
    await FirebaseFirestore.instance
        .collection("User")
        .doc(userID)
        .collection("Skill")
        .doc("Design Visual")
        .set({"Skill yang dikuasai": []});

    //software
    await FirebaseFirestore.instance
        .collection("User")
        .doc(userID)
        .collection("software")
        .doc("designVisual")
        .set({"aplikasi yang dikuasai": []});
    await FirebaseFirestore.instance
        .collection("User")
        .doc(userID)
        .collection("software")
        .doc("videoEditor")
        .set({"aplikasi yang dikuasai": []});
    await FirebaseFirestore.instance
        .collection("User")
        .doc(userID)
        .collection("software")
        .doc("machineLearning")
        .set({"aplikasi yang dikuasai": []});
    await FirebaseFirestore.instance
        .collection("User")
        .doc(userID)
        .collection("software")
        .doc("programming")
        .set({"aplikasi yang dikuasai": []});
    await FirebaseFirestore.instance
        .collection("User")
        .doc(userID)
        .collection("software")
        .doc("security")
        .set({"aplikasi yang dikuasai": []});

    //nilai
    await FirebaseFirestore.instance
        .collection("User")
        .doc(userID)
        .collection("nilaiMK")
        .doc("semester1")
        .set({"Pengantar Teknologi Informasi": "0", "Matematika Dasar": "0",});

    await FirebaseFirestore.instance
        .collection("User")
        .doc(userID)
        .collection("nilaiMK")
        .doc("semester2")
        .set({"Algoritma dan Pemrograman": "0", "Logika Informatika": "0",
        "Pengantar Jaringan Komputer": "0", "Sistem Manajemen Basis Data": "0"}); 

    await FirebaseFirestore.instance
        .collection("User")
        .doc(userID)
        .collection("nilaiMK")
        .doc("semester3")
        .set({"Struktu Data": "0", "Matematika Distrik": "0",
        "Jaringan Komputer Lanjut": "0", "Manajemen Informasi": "0", 
        "Interaksi Manusia dan Komputer": "0"});

    await FirebaseFirestore.instance
        .collection("User")
        .doc(userID)
        .collection("nilaiMK")
        .doc("semester4")
        .set({"Kecerdasan Bisnis": "0", "Pemograman Berorientasi Object": "0",
        "Keamanan Jaringan": "0", "Perancangan User Experience": "0"});

    await FirebaseFirestore.instance
        .collection("User")
        .doc(userID)
        .collection("nilaiMK")
        .doc("semester5")
        .set({"Big Data": "0", "Keamanan Data dan Informasi": "0",
        "Pemograman Web": "0", "Konsep Pengembangan Aplikasi Web dan Mobile": "0"});

    await FirebaseFirestore.instance
        .collection("User")
        .doc(userID)
        .collection("nilaiMK")
        .doc("semester6")
        .set({"Kriptografi": "0", "Sistem Web dan Mobile": "0",
        "Teknologi Manuskrip": "0", "Internet Of Thinks": "0",
        "Audit IT Security": "0", "Komputasi Cloud": "0",
        "Sistem Informasi Geografis": "0", "Kecerdasan Buatan": "0",
        "Data Mining": "0","Pemograman Mobile": "0",
        "Sistem Operasi Berbasis Mobile": "0","E-Learning": "0"});

    await FirebaseFirestore.instance
        .collection("User")
        .doc(userID)
        .collection("nilaiMK")
        .doc("semester7")
        .set({"Sistem Forensik, Investigasi dan Respon": "0", "Teknologi Blockchain": "0",
        "Software Aplikasi Cluster": "0", "Machine Learning": "0",
        "ERP Software dan Manajemen": "0", "Jaringan Syaraf Tiruan": "0",
        "Pemrosesan Bahasa Alami": "0", "Konten Digital": "0",
        "Software Sosial": "0", "Bisnis Digital": "0",});
  }

  Future addTest(String namaUser) async {
    return await FirebaseFirestore.instance
        .collection("User")
        .doc(userID)
        .update({
      "kontol": namaUser,
    });
  }

  Future getDataUsername() async {
    String username = "";
    await FirebaseFirestore.instance.collection("User").doc(userID).get().then(
      (value) {
        username = value["username"];
      },
    );

    return username;
  }

  Future deleteAllSkill() async {
    await FirebaseFirestore.instance
        .collection("User")
        .doc(userID)
        .collection("Skill")
        .doc("Proramming Language")
        .delete();
    await FirebaseFirestore.instance
        .collection("User")
        .doc(userID)
        .collection("Skill")
        .doc("Machine Learning")
        .delete();
    await FirebaseFirestore.instance
        .collection("User")
        .doc(userID)
        .collection("Skill")
        .doc("Security")
        .delete();
    await FirebaseFirestore.instance
        .collection("User")
        .doc(userID)
        .collection("Skill")
        .doc("Design Visual")
        .delete();
  }

  Future deleteAllSoftware() async {
    await FirebaseFirestore.instance
        .collection("User")
        .doc(userID)
        .collection("software")
        .doc("designVisual")
        .delete();
    await FirebaseFirestore.instance
        .collection("User")
        .doc(userID)
        .collection("software")
        .doc("videoEditor")
        .delete();
    await FirebaseFirestore.instance
        .collection("User")
        .doc(userID)
        .collection("software")
        .doc("machineLearning")
        .delete();
    await FirebaseFirestore.instance
        .collection("User")
        .doc(userID)
        .collection("software")
        .doc("programming")
        .delete();
    await FirebaseFirestore.instance
        .collection("User")
        .doc(userID)
        .collection("software")
        .doc("security")
        .delete();
  }

  Future addSoftware(
      List kodeDV, List kodeVE, List kodeML, List kodeP, List kodeS) async {
    await FirebaseFirestore.instance
        .collection("User")
        .doc(userID)
        .collection("software")
        .doc("designVisual")
        .set({"aplikasi yang dikuasai": kodeDV});
    await FirebaseFirestore.instance
        .collection("User")
        .doc(userID)
        .collection("software")
        .doc("videoEditor")
        .set({"aplikasi yang dikuasai": kodeVE});
    await FirebaseFirestore.instance
        .collection("User")
        .doc(userID)
        .collection("software")
        .doc("machineLearning")
        .set({"aplikasi yang dikuasai": kodeML});
    await FirebaseFirestore.instance
        .collection("User")
        .doc(userID)
        .collection("software")
        .doc("programming")
        .set({"aplikasi yang dikuasai": kodeP});
    return await FirebaseFirestore.instance
        .collection("User")
        .doc(userID)
        .collection("software")
        .doc("security")
        .set({"aplikasi yang dikuasai": kodeS});
  }

  Future addSkill(List kodeDV, List kodePL, List kodeML, List kodeS) async {
    await FirebaseFirestore.instance
        .collection("User")
        .doc(userID)
        .collection("Skill")
        .doc("Proramming Language")
        .set({"Skill yang dikuasai": kodePL});
    await FirebaseFirestore.instance
        .collection("User")
        .doc(userID)
        .collection("Skill")
        .doc("Machine Learning")
        .set({"Skill yang dikuasai": kodeML});
    await FirebaseFirestore.instance
        .collection("User")
        .doc(userID)
        .collection("Skill")
        .doc("Security")
        .set({"Skill yang dikuasai": kodeS});
    return await FirebaseFirestore.instance
        .collection("User")
        .doc(userID)
        .collection("Skill")
        .doc("Design Visual")
        .set({"Skill yang dikuasai": kodeDV});
  }

  Future addBiodataUser(
      String namaUserBaru,
      String alamat,
      String noHP,
      String Email,
      String ig,
      String X,
      String Fb,
      String linkedIn,
      String github,
      String deskripsi,
      String urlImage) async {
    return await FirebaseFirestore.instance
        .collection("User")
        .doc(userID)
        .update({
      "username": namaUserBaru,
      "alamat": alamat,
      "noHandphone": noHP,
      "Email": Email,
      "linkInstagram": ig,
      "linkTwitter": X,
      "linkFacebook": Fb,
      "linkLinkedin": linkedIn,
      "linkGithub": github,
      "deskripsi": deskripsi,
      "linkFotoProfile" : urlImage,
    });
  }

  Future deleteExperience() async {
    await FirebaseFirestore.instance
        .collection("User")
        .doc(userID)
        .collection("experience")
        .get()
        .then(
      (value) {
        value.docs.forEach(
          (element) async {
            await FirebaseFirestore.instance
                .collection("User")
                .doc(userID)
                .collection("experience")
                .doc(element.id)
                .delete();
          },
        );
      },
    );
  }

  Future addExperience(
      TextEditingController year,
      TextEditingController nameOfInstitution,
      TextEditingController positionOrTitle,
      TextEditingController jobDescription, String urlImage) async {
    int idDoc = 0;
    //menghitung total id
    await FirebaseFirestore.instance
        .collection("User")
        .doc(userID)
        .collection("experience")
        .get()
        .then(
      (value) {
        value.docs.forEach(
          (element) {
            // if (int.parse(element.id.toString()) >= idDoc){
            //   idDoc = int.parse(element.id.toString()) + 1;
            // }
            idDoc += 1;
          },
        );
      },
    );

    await FirebaseFirestore.instance
        .collection("User")
        .doc(userID)
        .collection("experience")
        .doc(idDoc.toString())
        .set({
      "id": idDoc,
      "year": year.text,
      "name of institution": nameOfInstitution.text,
      "position_title": positionOrTitle.text,
      "job description": jobDescription.text,
      "linkDocument" : urlImage,
    });
  }

  Future deleteAchievement() async {
    await FirebaseFirestore.instance
        .collection("User")
        .doc(userID)
        .collection("achievement")
        .get()
        .then(
      (value) {
        value.docs.forEach(
          (element) async {
            await FirebaseFirestore.instance
                .collection("User")
                .doc(userID)
                .collection("achievement")
                .doc(element.id)
                .delete();
          },
        );
      },
    );
  }

  Future addAchievement(
      TextEditingController year,
      TextEditingController nameOfCompetition,
      TextEditingController ranking,
      TextEditingController Description, String urlImage) async {
    int idDoc = 0;
    //menghitung total id
    await FirebaseFirestore.instance
        .collection("User")
        .doc(userID)
        .collection("achievement")
        .get()
        .then(
      (value) {
        value.docs.forEach(
          (element) {
            // if (int.parse(element.id.toString()) >= idDoc){
            //   idDoc = int.parse(element.id.toString()) + 1;
            // }
            idDoc += 1;
          },
        );
      },
    );

    await FirebaseFirestore.instance
        .collection("User")
        .doc(userID)
        .collection("achievement")
        .doc(idDoc.toString())
        .set({
      "id": idDoc,
      "year": year.text,
      "name of Competition": nameOfCompetition.text,
      "ranking": ranking.text,
      "description": Description.text,
      "linkDocument" : urlImage,
    });
  }

  Future addPersonalSKill(
      int index, String namaPersonalSkill, int percentagePersonalSkill) async {
    await FirebaseFirestore.instance
        .collection("User")
        .doc(userID)
        .collection("personalSkill")
        .doc(index.toString())
        .set({
      "id": index,
      "personalSkillName": namaPersonalSkill,
      "percentage": percentagePersonalSkill,
    });
  }

  Future deletePersonalSkill() async {
    await FirebaseFirestore.instance
        .collection("User")
        .doc(userID)
        .collection("personalSkill")
        .get()
        .then(
      (value) {
        value.docs.forEach(
          (element) async {
            await FirebaseFirestore.instance
                .collection("User")
                .doc(userID)
                .collection("personalSkill")
                .doc(element.id)
                .delete();
          },
        );
      },
    );
  }

  Future hapusNilaiMk() async {
    await FirebaseFirestore.instance
        .collection("User")
        .doc(userID)
        .collection("nilaiMK")
        .doc("semester1")
        .delete();
    await FirebaseFirestore.instance
        .collection("User")
        .doc(userID)
        .collection("nilaiMK")
        .doc("semester2")
        .delete();
    await FirebaseFirestore.instance
        .collection("User")
        .doc(userID)
        .collection("nilaiMK")
        .doc("semester3")
        .delete();
    await FirebaseFirestore.instance
        .collection("User")
        .doc(userID)
        .collection("nilaiMK")
        .doc("semester4")
        .delete();
    await FirebaseFirestore.instance
        .collection("User")
        .doc(userID)
        .collection("nilaiMK")
        .doc("semester5")
        .delete();
    await FirebaseFirestore.instance
        .collection("User")
        .doc(userID)
        .collection("nilaiMK")
        .doc("semester6")
        .delete();
    await FirebaseFirestore.instance
        .collection("User")
        .doc(userID)
        .collection("nilaiMK")
        .doc("semester7")
        .delete();
  }

  Future addNilaiMk(
      List<TextEditingController> sems1,
      List<TextEditingController> sems2,
      List<TextEditingController> sems3,
      List<TextEditingController> sems4,
      List<TextEditingController> sems5,
      List<TextEditingController> sems6,
      List<TextEditingController> sems7) async {
    await FirebaseFirestore.instance
        .collection("User")
        .doc(userID)
        .collection("nilaiMK")
        .doc("semester1")
        .set({"Pengantar Teknologi Informasi": sems1[0].text, "Matematika Dasar": sems1[1].text,});

    await FirebaseFirestore.instance
        .collection("User")
        .doc(userID)
        .collection("nilaiMK")
        .doc("semester2")
        .set({"Algoritma dan Pemrograman": sems2[0].text, "Logika Informatika": sems2[1].text,
        "Pengantar Jaringan Komputer": sems2[2].text, "Sistem Manajemen Basis Data": sems2[3].text}); 

    await FirebaseFirestore.instance
        .collection("User")
        .doc(userID)
        .collection("nilaiMK")
        .doc("semester3")
        .set({"Struktu Data": sems3[0].text, "Matematika Distrik": sems3[1].text,
        "Jaringan Komputer Lanjut": sems3[2].text, "Manajemen Informasi": sems3[3].text, 
        "Interaksi Manusia dan Komputer": sems3[4].text});

    await FirebaseFirestore.instance
        .collection("User")
        .doc(userID)
        .collection("nilaiMK")
        .doc("semester4")
        .set({"Kecerdasan Bisnis": sems4[0].text, "Pemograman Berorientasi Object": sems4[1].text,
        "Keamanan Jaringan": sems4[2].text, "Perancangan User Experience": sems4[3].text});

    await FirebaseFirestore.instance
        .collection("User")
        .doc(userID)
        .collection("nilaiMK")
        .doc("semester5")
        .set({"Big Data": sems5[0].text, "Keamanan Data dan Informasi": sems5[1].text,
        "Pemograman Web": sems5[2].text, "Konsep Pengembangan Aplikasi Web dan Mobile": sems5[3].text});

    await FirebaseFirestore.instance
        .collection("User")
        .doc(userID)
        .collection("nilaiMK")
        .doc("semester6")
        .set({"Kriptografi": sems6[0].text, "Sistem Web dan Mobile": sems6[1].text,
        "Teknologi Manuskrip": sems6[2].text, "Internet Of Thinks": sems6[3].text,
        "Audit IT Security": sems6[4].text, "Komputasi Cloud": sems6[5].text,
        "Sistem Informasi Geografis": sems6[6].text, "Kecerdasan Buatan": sems6[7].text,
        "Data Mining": sems6[8].text,"Pemograman Mobile": sems6[9].text,
        "Sistem Operasi Berbasis Mobile": sems6[10].text,"E-Learning": sems6[11].text});

    await FirebaseFirestore.instance
        .collection("User")
        .doc(userID)
        .collection("nilaiMK")
        .doc("semester7")
        .set({"Sistem Forensik, Investigasi dan Respon": sems7[0].text, "Teknologi Blockchain": sems7[1].text,
        "Software Aplikasi Cluster": sems7[2].text, "Machine Learning": sems7[3].text,
        "ERP Software dan Manajemen": sems7[4].text, "Jaringan Syaraf Tiruan": sems7[5].text,
        "Pemrosesan Bahasa Alami": sems7[6].text, "Konten Digital": sems7[7].text,
        "Software Sosial": sems7[8].text, "Bisnis Digital": sems7[9].text,});
  }
}
