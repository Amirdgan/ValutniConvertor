import 'package:flutter/material.dart';
import 'package:untitled/Pages/Client.dart';
import 'package:untitled/Pages/ConversePage.dart';
import 'package:untitled/Pages/CryptoPage.dart';
import 'package:untitled/Pages/InitialPage.dart';
import 'package:untitled/Pages/LoginPage.dart';
import 'package:untitled/Pages/WorkPage.dart';
import 'package:untitled/Pages/FauoritePage.dart';
import 'package:untitled/Pages/user.dart';

class ConversePage extends StatefulWidget {
  // Remove the user parameter
  const ConversePage({Key? key}) : super(key: key);

  @override
  _ConversePageState createState() => _ConversePageState();
}

class _ConversePageState extends State<ConversePage> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  String _fromCurrency = 'USD';
  String _toCurrency = 'EUR';
  double _convertedAmount = 0;

  // Курсы валют (замените на реальные данные)
  final Map<String, Map<String, double>> _exchangeRates = {
    'USD': {
      'EUR': 0.9,
      'RUB': 75,
      'GBP': 0.8,
    },
    'EUR': {
      'USD': 1.1,
      'RUB': 83,
      'GBP': 0.9,
    },
    'RUB': {
      'USD': 0.013,
      'EUR': 0.012,
      'GBP': 0.011,
    },
    'GBP': {
      'USD': 1.25,
      'EUR': 1.12,
      'RUB': 91,
    },
  };

  void _convertCurrency() {
    if (_formKey.currentState!.validate()) {
      final amount = double.parse(_amountController.text);

      // Получаем курс из _exchangeRates
      final rate = _exchangeRates[_fromCurrency]![_toCurrency]!;

      _convertedAmount = amount * rate;
      setState(() {});
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent, // Темно-фиолетовый цвет
        title: Text(
          'Конвертер',
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
              // Выбор валют
              SizedBox(height: 16.0),
              Row(
                children: [
                  Expanded(
                    child: DropdownButton<String>(
                      value: _fromCurrency,
                      hint: Text('Из валюты'),
                      isExpanded: true, // Занимает всю ширину
                      items: <String>['USD', 'EUR', 'RUB', 'GBP']
                          .map((String value) => DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      ))
                          .toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _fromCurrency = newValue!;
                        });
                      },
                    ),
                  ),
                  SizedBox(width: 16.0),
                  Expanded(
                    child: DropdownButton<String>(
                      value: _toCurrency,
                      hint: Text('В валюту'),
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
                onPressed: _convertCurrency,
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.white), // Цвет кнопки
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                  ),
                  textStyle: MaterialStateProperty.all<TextStyle>(
                    TextStyle(
                      color: Colors.white, // Цвет текста на кнопке
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                child: Text('Конвертировать'), // Текст на кнопке
              ),
              // Результат конвертации
              SizedBox(height: 32.0),
              Text(
                'Результат: $_convertedAmount $_toCurrency',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple, // Цвет результата
                ),
              ),
              // Кнопка "Сохранить конвертацию"
              SizedBox(height: 32.0),
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
                  // Здесь можно добавить функционал для "Инвентаризация"
                  print('Инвентаризация'); // Замените на необходимый код
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

