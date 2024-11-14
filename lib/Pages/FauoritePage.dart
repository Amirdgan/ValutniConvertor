import 'package:flutter/material.dart';
import 'package:untitled/Pages/ConversePage.dart';
import 'package:untitled/Pages/CryptoPage.dart';
import 'package:untitled/Pages/WorkPage.dart';
import 'package:untitled/Pages/InitialPage.dart';

class FauoritsPage extends StatefulWidget {
  @override
  _FauoritsPageState createState() => _FauoritsPageState();
}

class _FauoritsPageState extends State<FauoritsPage> {
  // Replace this with your actual currency data loading logic
  final Map<String, double> _currencies = {
    "USD": 1.0, // US Dollar
    "EUR": 0.91, // Euro
    "JPY": 137.44, // Japanese Yen
    "GBP": 0.78, // British Pound
    // ... Add more currencies as needed
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Избранное", style: TextStyle(fontSize: 22)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => InitialPage()));
          },
        ),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // ... (Your existing code) ...
          Expanded(
            child: ListView.builder(
              itemCount: _currencies.length,
              itemBuilder: (context, index) {
                final currencyCode = _currencies.keys.elementAt(index);
                final currencyValue = _currencies[currencyCode]!;
                return ListTile(
                  title: Text(
                    '$currencyCode = \$${currencyValue.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 18),
                  ),
                );
              },
            ),
          ),
        ],
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
                      builder: (context) => ConversePage(), // Navigate to ConversePage
                    ),
                  );
                },
              ),
              IconButton(
                icon: Icon(Icons.currency_bitcoin, color: Colors.white),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CryptoPage(), // Navigate to CryptoPage
                    ),
                  );
                },
              ),
              IconButton(
                icon: Icon(Icons.star, color: Colors.white),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FauoritsPage(),
                    ),
                  );
                },
              ),
              IconButton(
                icon: Icon(Icons.work, color: Colors.white),
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