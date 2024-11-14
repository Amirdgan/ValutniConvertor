import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/Pages/ConversePage.dart';
import 'package:untitled/Pages/InitialPage.dart';
import 'package:untitled/main.dart';
import 'package:untitled/Pages/user.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late String _username;
  late String _password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  User? _currentUser; // Объявите _currentUser здесь

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text('Вход', style: TextStyle(color: Colors.white)),
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => InitialPage()),
          );
        },
      ),
      backgroundColor: Color(0xFF2E5DAB),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(4.0),
        child: Container(),
      ),
    ),
    backgroundColor: Color(0xFF2E5DAB),
    body: Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[


              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Имя пользователя',
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  hintText: 'Введите имя пользователя',
                  hintStyle: TextStyle(color: Colors.grey),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Пожалуйста, введите имя пользователя';
                  }
                  return null;
                },
                onSaved: (value) {
                  _username = value!;
                },
                style: TextStyle(color: Colors.white), // White text for input
              ),
              SizedBox(height: 20),

              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Пароль',
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  hintText: 'Введите пароль',
                  hintStyle: TextStyle(color: Colors.grey),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Пожалуйста, введите пароль';
                  }
                  return null;
                },
                onSaved: (value) {
                  _password = value!;
                },
                obscureText: true,
                style: TextStyle(color: Colors.white), // White text for input
              ),

              SizedBox(height: 30),

              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    final user = User(username: _username, password: _password);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ConversePage(),
                      ),
                    );
                  }
                },
                child: Text('Войти', style: TextStyle(color: Colors.black)), // Black text on button
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Color(0xFFF59E0B)), // Orange color for button
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      EdgeInsets.symmetric(horizontal: 50, vertical: 15)),
                  textStyle: MaterialStateProperty.all<TextStyle>(
                    TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),

        ),
      ),
    ),

  );
}
