import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:untitled/Pages/LoginPage.dart';
import 'package:flutter/material.dart';
import 'package:untitled/Pages/Client.dart';
import 'package:untitled/Pages/ConversePage.dart';
import 'package:untitled/Pages/CryptoPage.dart';
import 'package:untitled/Pages/InitialPage.dart';
import 'package:untitled/Pages/LoginPage.dart';
import 'package:untitled/Pages/WorkPage.dart';
import 'package:untitled/Pages/user.dart';
import 'package:untitled/Pages/FauoritePage.dart';

class CryptoPage extends StatefulWidget {
  @override
  _CryptoPageState createState() => _CryptoPageState();
}

class _CryptoPageState extends State<CryptoPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _amountController = TextEditingController();
  String _fromCrypto = 'BTC';
  String _toCurrency = 'USD';
  String _convertedAmount = '';

  Future<void> _convertCrypto() async {
    final String from = _fromCrypto;
    final String to = _toCurrency;
    final double amount = double.tryParse(_amountController.text) ?? 0;

    try {
      final response = await http.get(Uri.parse(
          'https://api.coingecko.com/api/v3/simple/price?ids=$from&vs_currencies=$to'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final rate = data[from][to];
        final converted = amount * rate;
        setState(() {
          _convertedAmount = converted.toStringAsFixed(2);
        });
      } else {
        setState(() {
          _convertedAmount = 'Ошибка';
        });
      }
    } catch (e) {
      setState(() {
        _convertedAmount = 'Ошибка';
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent, // Темно-фиолетовый цвет
        title: Text(
          'Конвертер Криптовалют',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()),
            );
          },
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(4.0),
          child: Container(),
        ),
      ),
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Заголовок
              Text(
                'Конвертация',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple, // Цвет заголовка
                ),
              ),
              SizedBox(height: 16.0),

              // Ввод суммы
              Form(
                key: _formKey,
                child: TextFormField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Введите сумму',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: Icon(Icons.attach_money),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Введите сумму';
                    }
                    return null;
                  },
                ),
              ),

              // Выбор Криптовалюты
              SizedBox(height: 16.0),
              Row(
                children: [
                  Expanded(
                    child: DropdownButton<String>(
                      value: _fromCrypto,
                      hint: Text('Из Криптовалюты'),
                      isExpanded: true, // Занимает всю ширину
                      items: <String>['BTC', 'ETH', 'USDT', 'BNB', 'ADA', 'DOGE']
                          .map((String value) => DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      ))
                          .toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _fromCrypto = newValue!;
                        });
                      },
                    ),
                  ),
                  SizedBox(width: 16.0),
                  Expanded(
                    child: DropdownButton<String>(
                      value: _toCurrency,
                      hint: Text('В Валюту'),
                      isExpanded: true,
                      items: <String>['USD', 'EUR', 'RUB', 'GBP']
                          .map((String value) => DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      ))
                          .toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _toCurrency = newValue!;
                        });
                      },
                    ),
                  ),
                ],
              ),

              // Кнопка конвертации
              SizedBox(height: 32.0),
              ElevatedButton(
                onPressed: _convertCrypto,
                style: ButtonStyle(
                  backgroundColor:
                  MaterialStateProperty.all<Color>(Colors.white), // Цвет кнопки
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                  ),
                  textStyle: MaterialStateProperty.all<TextStyle>(
                    TextStyle(
                      color: Colors.deepPurple, // Цвет текста на кнопке
                      fontSize: 18,
                    ),
                  ),
                ),
                child: Text('Конвертировать'),
              ),

              // Результат конвертации
              SizedBox(height: 32.0),
              Text(
                'Результат: $_convertedAmount $_toCurrency',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 60,
        child: BottomAppBar(
          color: Colors.deepPurpleAccent, // Темно-фиолетовый
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: Icon(Icons.comment_bank, color: Colors.white),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ConversePage(), // Remove the user: user argument
                    ),
                  );
                },
              ),
              IconButton(
                icon: Icon(Icons.currency_bitcoin, color: Colors.white),
                onPressed: () {
                  // Переход на CryptoPage без использования user
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CryptoPage(), // Remove the user: user argument
                    ),
                  );
                },
              ),
              IconButton(
                icon: Icon(Icons.star, color: Colors.white),
                onPressed: () {
                  // Переход на CryptoPage без использования user
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FauoritsPage(), // Remove the user: user argument
                    ),
                  );
                },
              ),
              IconButton(
                icon: Icon(Icons.work, color: Colors.white),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => WorkPage()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Модель для представления конвертации
class Conversion {
  final double amount;
  final String fromCurrency;
  final double convertedAmount;
  final String toCurrency;

  Conversion({
    required this.amount,
    required this.fromCurrency,
    required this.convertedAmount,
    required this.toCurrency,
  });
}

