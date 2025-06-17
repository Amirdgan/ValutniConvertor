import 'package:flutter/material.dart';
import 'package:untitled/Pages/LoginPage.dart';
import 'package:untitled/Pages/RegistrationPage.dart';

class InitialPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
      Container(
      decoration: BoxDecoration(
        color: Colors.indigo[400], // Установите один цвет
      ),
    ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 20), // Отступ сверху
                // Логотип
                Image.asset(
                  'assets/your_logo.png', // Замените на путь к вашему логотипу
                  height: 260,
                  width: 260,
                ),
                SizedBox(height: 1), // Расстояние после логотипа
                // Стильное название
                RichText(
                  text: TextSpan(
                    text: 'Curren',
                    style: TextStyle(
                      fontSize: 64,
                      fontWeight: FontWeight.bold,
                      foreground: Paint()
                        ..shader = LinearGradient(
                          colors: <Color>[
                            Colors.black87,
                            Colors.black,
                          ],
                        ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Sea',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 64,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 25), // Расстояние после названия
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => LoginPage()));
                  },
                  child: Text('Войти', style: TextStyle(fontSize: 18)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo, // Цвет кнопки
                    foregroundColor: Colors.white, // Цвет текста
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 5,
                  ),
                ),
                SizedBox(height: 15),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => RegistrationPage()));
                  },
                  child: Text('Зарегистрироваться',
                      style: TextStyle(fontSize: 20, color: Colors.white)),
                  style: TextButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15)),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ClipPath(
              clipper: WaveClipper(),
              child: Container(
                height: 200, // Высота волны
                color: Colors.blueAccent, // Белый цвет для волны
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 100);
    path.quadraticBezierTo(size.width / 4, size.height - 150, size.width / 2,
        size.height - 100);
    path.quadraticBezierTo(size.width * 3 / 4, size.height - 50, size.width,
        size.height - 100);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}