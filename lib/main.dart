import 'package:flutter/material.dart';
import 'package:untitled/Pages/Client.dart'; // Импортируйте Client
import 'package:untitled/Pages/ConversePage.dart';
import 'package:untitled/Pages/initialPage.dart';
import 'package:untitled/Pages/LoginPage.dart';
import 'package:untitled/Pages/user.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.deepPurple,
        scaffoldBackgroundColor: Colors.grey[200],
      ),
      home: InitialPage(), // Запускаем начальную страницу
      routes: {
        '/gadgets': (context) => LoginPage()// Добавьте маршрут для ClientsPage
      },
    );
  }
}
