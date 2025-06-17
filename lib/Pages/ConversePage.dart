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
      'RUB': 82,
      'GBP': 0.8,
      'JPU': 0.8,
    },
    'EUR': {
      'USD': 1.1,
      'RUB': 93,
      'GBP': 0.9,
      'JPU': 0.8,
    },
    'RUB': {
      'USD': 0.013,
      'EUR': 0.012,
      'GBP': 0.011,
      'JPU': 0.8,
    },
    'GBP': {
      'USD': 1.25,
      'EUR': 1.12,
      'RUB': 91,
      'JPU': 0.8,
    },
  };
  void _convertCurrency() {
    if (_formKey.currentState!.validate()) {
      final amount = double.parse(_amountController.text);

      // Получаем курс из _exchangeRates
      final rate = _exchangeRates[_fromCurrency]![_toCurrency]!;

      _convertedAmount = amount * rate;
      setState(() {});

      // Показываем результат в SnackBar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Результат: $_convertedAmount $_toCurrency',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          duration: Duration(seconds: 3),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.indigo[400],
        ),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo[400],
        title: Text('Конвертация валют',
          style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold,),),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);},),),
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[Text('Конвертация',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.indigo[400],),),
              SizedBox(height: 16.0),
              Card(elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),),
                child: Padding(
                  padding: const
                  EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: SizedBox(
                      width: 350,
                    child: TextFormField(controller: _amountController, keyboardType: TextInputType.number,
                      decoration: InputDecoration(hintText: 'Введите сумму',
                        border: InputBorder.none, prefixIcon: Icon(Icons.attach_money),),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Введите сумму';}return null;},),),),),),
              SizedBox(height: 16.0),
              Row(children: [Expanded(child: Card(elevation: 4, shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: DropdownButtonFormField<String>(
                        value: _fromCurrency,
                        decoration: InputDecoration(hintText: 'Из валюты',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),),
                        items: <String>['USD', 'EUR', 'RUB', 'GBP','JPU']
                            .map((String value) => DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),))
                            .toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _fromCurrency = newValue!;});},),),),
                  SizedBox(width: 16.0),
                  Expanded(
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),),
                      child: DropdownButtonFormField<String>(
                        value: _toCurrency,
                        decoration: InputDecoration(hintText: 'В валюту',
                          border: InputBorder.none, contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),),
                        items: <String>['USD', 'EUR', 'RUB', 'GBP','JPU']
                            .map((String value) => DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),))
                            .toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _toCurrency = newValue!;});},),),),],),
              SizedBox(height: 16.0),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _convertCurrency();}},
                  child: Text('Конвертировать'),
                  style: ElevatedButton.styleFrom(primary: Colors.indigo[400],
                    onPrimary: Colors.black, padding:EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                    textStyle:
                    TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),),),],),),),
  bottomNavigationBar: SizedBox(
      height: 60,
      child: BottomAppBar(
        color: Colors.indigo[400], // Темно-фиолетовый
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: Icon(Icons.comment_bank, color: Colors.white),
              onPressed: () {},),
            IconButton(
              icon: Icon(Icons.currency_bitcoin, color: Colors.white),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CryptoPage(), // Remove the user: user argument
                  ),
                );
                // Переход на CryptoPage без использования user
              },
            ),
            IconButton(
              icon: Icon(Icons.star, color: Colors.white),
              onPressed: () {
                // Переход на CryptoPage без использования user
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FavoritesPage(), // Remove the user: user argument
                  ),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.settings, color: Colors.white),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WorkPage(),
                  ),
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

