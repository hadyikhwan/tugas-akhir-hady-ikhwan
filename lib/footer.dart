import 'package:flutter/material.dart';
import 'package:skripsi/footer.dart';
import 'package:skripsi/homepage.dart';

class footer extends StatelessWidget {
  const footer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
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
                backgroundColor: Colors.white, // Warna latar belakang tombol
                foregroundColor: Colors.blue, // Warna teks tombol
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20), // Sudut lengkung tombol
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
              mainAxisAlignment: MainAxisAlignment.center, // Posisikan semua item di tengah baris
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      Container(
                        width: 34, // Ukuran lingkaran
                        height: 34,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle, // Mengatur bentuk menjadi lingkaran
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      Container(
                        width: 34, // Ukuran lingkaran
                        height: 34,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle, // Mengatur bentuk menjadi lingkaran
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      Container(
                        width: 34, // Ukuran lingkaran
                        height: 34,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle, // Mengatur bentuk menjadi lingkaran
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      Container(
                        width: 34, // Ukuran lingkaran
                        height: 34,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle, // Mengatur bentuk menjadi lingkaran
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      Container(
                        width: 34, // Ukuran lingkaran
                        height: 34,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle, // Mengatur bentuk menjadi lingkaran
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}
