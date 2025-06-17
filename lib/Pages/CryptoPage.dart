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

  // Статичные курсы обмена
  final Map<String, Map<String, double>> _exchangeRates = {
    'btc': {
      'usd': 50000.0, // Примерный курс BTC к USD
      'eur': 45000.0, // Примерный курс BTC к EUR
    },
    'eth': {
      'usd': 4000.0, // Примерный курс ETH к USD
      'eur': 3500.0, // Примерный курс ETH к EUR
    },
  };

  void _convertCrypto() {
    final String from = _fromCrypto.toLowerCase();
    final String to = _toCurrency.toLowerCase();
    final double amount = double.tryParse(_amountController.text) ?? 0;

    if (_exchangeRates.containsKey(from) && _exchangeRates[from]!.containsKey(to)) {
      final rate = _exchangeRates[from]![to]!;
      final converted = amount * rate;
      setState(() {
        _convertedAmount = converted.toStringAsFixed(2);
      });

      // Показываем результат в SnackBar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Результат: $_convertedAmount $to',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          duration: Duration(seconds: 3),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.indigo[400],
        ),
      );
    } else {
      setState(() {
        _convertedAmount = 'Ошибка';
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo[400],
        title: Text('Конвертер Криптовалют',
          style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,),),
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
            children: <Widget>[
              Text('Конвертация',
                style: TextStyle(fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo[400]),),
              SizedBox(height: 16.0),
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),),
                child: Padding(
                  padding: const EdgeInsets.all(16.0), // Отступы внутри Card
                  child: Form(
                    key: _formKey,
                    child: SizedBox(
                      width: 350, // Установите желаемую ширину
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
                  value: _fromCrypto,
                  decoration: InputDecoration(hintText: 'Из валюты',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),),
                  items: <String>['BTC','ETH']
                      .map((String value) => DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),))
                      .toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _fromCrypto = newValue!;});},),),),
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
              Center(child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _convertCrypto();}},
                  child: Text('Конвертировать'),
                  style: ElevatedButton.styleFrom(primary: Colors.indigo[400],
                    onPrimary: Colors.black,
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                    textStyle:
                    TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),),),],),),),
      bottomNavigationBar: SizedBox(
        height: 60,
        child: BottomAppBar(
          color: Colors.indigo[400],
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            // Горизонтальные отступы
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: Icon(Icons.comment_bank, color: Colors.white),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) =>
                            ConversePage()), // Переход на страницу ConversePage
                      );},),
                  IconButton(
                    icon: Icon(Icons.currency_bitcoin, color: Colors.white),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(Icons.star, color: Colors.white),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FavoritesPage()),
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

                ]
            ),
          ),
        ),
      ),
    );
  }
}





  double convertCurrency(double amount, String fromCrypto, String toCurrency) {
    // Пример коэффициентов конверсии (здесь должны быть реальные значения)
    Map<String, double> conversionRates = {
      'BTC': 60000, // Примерная цена BTC в USD
      'ETH': 4000, // Примерная цена ETH в USD
      // Добавьте остальные криптовалюты и их цены
    };

    // Преобразуем из криптовалюты в USD
    double amountInUSD = amount * (conversionRates[fromCrypto] ?? 1);

    // Здесь можно добавить логику для конвертации из USD в выбранную валюту
    Map<String, double> fiatConversionRates = {
      'USD': 1,
      'EUR': 0.85, // Примерный курс USD к EUR
      'RUB': 75, // Примерный курс USD к RUB
      'GBP': 0.75, // Примерный курс USD к GBP
    };

    return amountInUSD * (fiatConversionRates[toCurrency] ?? 1);
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

