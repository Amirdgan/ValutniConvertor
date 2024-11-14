import 'package:flutter/material.dart';
import 'package:untitled/Pages/CryptoPage.dart';
import 'package:untitled/Pages/user.dart';
import 'package:untitled/Pages/initialPage.dart';
import 'package:untitled/Pages/LoginPage.dart';
import 'package:untitled/Pages/ConversePage.dart';
import 'package:untitled/Pages/Client.dart';
import 'package:untitled/Pages/WorkPage.dart';

class WorkPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrangeAccent, // Цвет верхней панели
        title: Text('Профиль', style: TextStyle(color: Colors.white)), // Белый текст
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white), // Белый цвет иконки
          onPressed: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => LoginPage()));
          },
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(4.0),
          child: Container(),
        ),
      ),
      backgroundColor: Colors.grey[100], // Светло-серый фон
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Информация о работнике',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold, // Полужирный шрифт
                color: Colors.deepOrangeAccent, // Цвет заголовка
              ),
            ),
            SizedBox(height: 15),
            Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15), // Закругленные углы
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // Тень снизу
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _buildProfileItem('Имя', 'Иван Иванов'),
                  _buildProfileItem('Должность', 'Менеджер'),
                  _buildProfileItem('Телефон', '+79001234567'),
                  _buildProfileItem('Email', 'ivan.ivanov@example.com'),
                  SizedBox(height: 15),
                  _buildProfileItem('Кол-во успешных сделок', '3',
                      icon: Icons.check_circle),
                  _buildProfileItem('Сумма выручки со сделок', '4900',
                      icon: Icons.attach_money),
                ],
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepOrangeAccent,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                textStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black, // Текст внутри кнопки черного цвета
                ),
              ),
              child: Text('Редактировать профиль',style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 60,
        child: BottomAppBar(
          color: Colors.deepOrangeAccent, // Цвет нижней панели
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: Icon(Icons.inventory, color: Colors.white), // Белый цвет иконки
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ConversePage()),
                  );
                },
              ),
              IconButton(
                icon: Icon(Icons.people, color: Colors.white), // Белый цвет иконки
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CryptoPage()),
                  );
                },
              ),
              IconButton(
                icon: Icon(Icons.work, color: Colors.white), // Белый цвет иконки
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileItem(String title, String value, {IconData? icon}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: <Widget>[
          Text(
            '$title: ',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontSize: 16),
            ),
          ),
          if (icon != null) Icon(icon, color: Colors.deepOrangeAccent)
        ],
      ),
    );
  }
}
