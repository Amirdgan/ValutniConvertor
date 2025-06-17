import 'package:flutter/material.dart';
import 'package:untitled/Pages/ConversePage.dart';
import 'package:untitled/Pages/CryptoChartPage.dart';
import 'package:untitled/Pages/CryptoPage.dart';
import 'package:untitled/Pages/WorkPage.dart';
import 'package:untitled/Pages/InitialPage.dart';

class FavoritesPage extends StatefulWidget {
  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  // Данные о валютах
  final Map<String, double> _currencies = {
    "USD": 1.0, // US Dollar
    "EUR": 0.91, // Euro
    "JPY": 137.44, // Japanese Yen
    "GBP": 0.78, // British Pound
    // ... Добавьте больше валют по мере необходимости
  };

  // Данные о криптовалютах
  final Map<String, double> _cryptocurrencies = {
    "BTC": 45000.0, // Bitcoin
    "ETH": 3000.0, // Ethereum// Litecoin
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Курсы валют",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,),),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => InitialPage()),);},),
        backgroundColor: Colors.indigo[400],),
      body: Container(
        color: Colors.white, // Фон всего экрана
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Курсы валют',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo[400],),),),
            Expanded(
              child: ListView.separated(
                itemCount: _currencies.length,
                separatorBuilder: (context, index) => Divider(color: Colors.grey[300]),
                itemBuilder: (context, index) {
                  final currencyCode = _currencies.keys.elementAt(index);
                  final currencyValue = _currencies[currencyCode]!;
                  return Card(
                    elevation: 4,
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: ListTile(
                      title: Text(
                        '$currencyCode = ${currencyValue.toStringAsFixed(2)}',
                        style: TextStyle(fontSize: 18),),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CryptoChartPage(
                              title: currencyCode, ),),);},),);},),),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Курсы криптовалют',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo[400],
                ),
              ),
            ),
            Expanded(
              child: ListView.separated(
                itemCount: _cryptocurrencies.length,
                separatorBuilder: (context, index) => Divider(color: Colors.grey[300]),
                itemBuilder: (context, index) {
                  final cryptoCode = _cryptocurrencies.keys.elementAt(index);
                  final cryptoValue = _cryptocurrencies[cryptoCode]!;
                  return Card(
                    elevation: 4,
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: ListTile(
                      title: Text(
                        '$cryptoCode = ${cryptoValue.toStringAsFixed(2)}',
                        style: TextStyle(fontSize: 18),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CryptoChartPage(
                              title: cryptoCode, // Передаём название криптовалюты
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 60,
        child: BottomAppBar(
          color: Colors.indigo[400],
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: Icon(Icons.comment_bank, color: Colors.white),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => ConversePage()),
                  );
                },
              ),
              IconButton(

                icon: Icon(Icons.currency_bitcoin, color: Colors.white),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => CryptoPage()),
                  );
                },
              ),
              IconButton(
                icon: Icon(Icons.star, color: Colors.white),
                onPressed: () {
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
  }}