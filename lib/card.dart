import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:html' as html;

void main() {
  runApp(kartu());
}

class kartu extends StatelessWidget {
  const kartu({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey[200],
        body: Center(
          child: ProfileCard(),
        ),
      ),
    );
  }
}

class ProfileCard extends StatelessWidget {
  void _onIconPressed(String url) {
    
    html.window.open(url, 'new tab');
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 4,
      child: Container(
        width: 300, 
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 40,
              backgroundImage: AssetImage('assets/foto.jpg'), // Replace with your image asset
            ),
            SizedBox(height: 10),
            Text(
              'Yanto Harahap',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Web Developer',
              style: TextStyle(
                color: Colors.blue,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'A kiddo who uses Bootstrap and Laravel in web development. '
              'Currently playing around with design via Figma.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
              ),
            ),
            SizedBox(height: 10),
            GestureDetector(
              onTap: () => _onIconPressed('mailto:harahapyanto@gmail.com'),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'harahapyanto@gmail.com',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: FaIcon(FontAwesomeIcons.twitter),
                  onPressed: () => _onIconPressed('https://twitter.com'),
                ),
                IconButton(
                  icon: FaIcon(FontAwesomeIcons.instagram),
                  onPressed: () => html.window.open("https://www.instagram.com/hady_1007", 'new tab'),
                ),
                IconButton(
                  icon: FaIcon(FontAwesomeIcons.dribbble),
                  onPressed: () => _onIconPressed('https://dribbble.com'),
                ),
                IconButton(
                  icon: FaIcon(FontAwesomeIcons.linkedin),
                  onPressed: () => _onIconPressed('https://linkedin.com'),
                ),
                IconButton(
                  icon: FaIcon(FontAwesomeIcons.github),
                  onPressed: () => _onIconPressed('https://github.com'),
                ),
                IconButton(
                  icon: FaIcon(FontAwesomeIcons.dev),
                  onPressed: () => _onIconPressed('https://dev.to'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}