import 'package:flutter/material.dart';
import 'ConversePage.dart';
import 'CryptoPage.dart';
import 'FauoritePage.dart';
class WorkPage extends StatefulWidget {
  @override
  _WorkPageState createState() => _WorkPageState();
}
class _WorkPageState extends State<WorkPage> {
  String _selectedLanguage = 'Русский'; // язык по умолчанию
  String _selectedTheme = 'Светлая';
  bool _notificationsEnabled = false; // добавлено
  // Переводы для русского и английского
  Map<String, Map<String, String>> _translations = {
    'Русский': {'Настройки': 'Настройки', 'Общие настройки': 'Общие настройки', 'Выберите валюту': 'Выберите валюту', 'Выберите язык': 'Выберите язык', 'Выберите тему': 'Выберите тему', 'Включены': 'Включены', 'Светлая': 'Светлая', 'Тёмная': 'Тёмная', 'Выключены': 'Выключены', 'Основная валюта': 'Основная валюта', 'Уведомления': 'Уведомления', 'Темы': 'Темы', 'Язык': 'Язык', 'Сохранить настройки': 'Сохранить настройки',}, 'English': {'Настройки': 'Settings', 'Общие настройки': 'General Settings', 'Выберите валюту': 'Choose currency', 'Выберите язык': 'Choose language', 'Выберите тему': 'Choose theme', 'Включены': 'Enabled', 'Светлая': 'Light', 'Тёмная': 'Dark', 'Выключены': 'Disabled', 'Основная валюта': 'Main currency', 'Уведомления': 'Notifications', 'Темы': 'Themes', 'Язык': 'Language', 'Сохранить настройки': 'Save settings',},};
  String _currentLanguage = 'Русский';
  String _currentTheme = 'Светлая';
  ThemeData _themeData = ThemeData.light();
  String t(String key) => _translations[_currentLanguage]?[key] ?? key;
  void _updateTheme(String theme) {
    setState(() {
      _currentTheme = theme;
      if (theme == 'Темная') {
        _themeData = ThemeData.dark();
      } else {
        _themeData = ThemeData.light();
      }});}
  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(t('Выберите язык')),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RadioListTile<String>(
                title: Text('Русский'),
                value: 'Русский',
                groupValue: _currentLanguage,
                onChanged: (String? value) {
                  setState(() {
                    _currentLanguage = value!;});
                  Navigator.of(context).pop();},),
              RadioListTile<String>(
                title: Text('English'),
                value: 'English',
                groupValue: _currentLanguage,
                onChanged: (String? value) {
                  setState(() {
                    _currentLanguage = value!;});
                  Navigator.of(context).pop();},),],),);},);}
  void _showThemeDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(t('Выберите тему')),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RadioListTile<String>(
                title: Text('Светлая'),
                value: 'Светлая',
                groupValue: _currentTheme,
                onChanged: (String? value) {
                  _updateTheme(value!);
                  Navigator.of(context).pop();
                },
              ),
              RadioListTile<String>(
                title: Text('Темная'),
                value: 'Темная',
                groupValue: _currentTheme,
                onChanged: (String? value) {
                  _updateTheme(value!);
                  Navigator.of(context).pop();},),],),);},);}
  void _showNotificationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(t('Уведомления')),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RadioListTile<bool>(
                title: Text(t('Включены')),
                value: true,
                groupValue: _notificationsEnabled,
                onChanged: (bool? value) {
                  setState(() {
                    _notificationsEnabled = value!;
                  });
                  Navigator.of(context).pop();
                },
              ),
              RadioListTile<bool>(
                title: Text(t('Выключены')),
                value: false,
                groupValue: _notificationsEnabled,
                onChanged: (bool? value) {
                  setState(() {
                    _notificationsEnabled = value!;});
                  Navigator.of(context).pop();},),],),);},);}
  Widget _buildSettingItem(String title, String value, IconData icon,
      VoidCallback? onTap, {bool isSwitch = false}) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      leading: Icon(icon, color: Colors.indigo[400]),
      title: Text(title, style: TextStyle(fontSize: 18)),
      trailing: isSwitch
          ? Switch(
          value: _notificationsEnabled,
          onChanged: (bool newValue) {
            setState(() {
              _notificationsEnabled = newValue;});})
          : Text(value,
          style: TextStyle(fontSize: 18, color: Colors.black54)),
      onTap: onTap,);}
  void _showCurrencyDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String selectedCurrency = 'USD';
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text(t('Выберите валюту')),
              content: DropdownButton<String>(
                value: selectedCurrency,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedCurrency = newValue!;});},
                items: ['USD', 'EUR', 'RUB']
                    .map<DropdownMenuItem<String>>((String currency) {
                  return DropdownMenuItem<String>(
                    value: currency,
                    child: Text(currency),);}).toList(),),
              actions: [
                TextButton(
                  onPressed: () {
                    // Тут можно сохранить выбранную валюту
                    Navigator.of(context).pop();},
                  child: Text('OK'),),],);},);},);}
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: _themeData,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.indigo[400],
          title: Text(t('Настройки'), style: TextStyle(color: Colors.white)),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),),),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(t('Общие настройки'),
                  style: TextStyle(fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo[400])),
              SizedBox(height: 15),
              Card(elevation: 4,
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  children: [
                    _buildSettingItem(t('Основная валюта'),
                        'USD',
                        Icons.monetization_on,
                        _showCurrencyDialog),
                    Divider(),
                    _buildSettingItem(t('Уведомления'),
                        _notificationsEnabled ? t('Включены') : t('Выключены'),
                        Icons.notifications,
                        _showNotificationDialog),
                    Divider(),
                    _buildSettingItem(t('Темы'),
                        _currentTheme,
                        Icons.brightness_6,
                        _showThemeDialog),
                    Divider(),
                    _buildSettingItem(t('Язык'),
                        _currentLanguage,
                        Icons.language,
                        _showLanguageDialog),],),),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo[400],
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),),
                child: Text(
                  t('Сохранить настройки'),
                  style: TextStyle(
                    color: Colors.white, // Цвет текста
                    fontSize: 18,
                    fontWeight: FontWeight.bold,),),),],),),
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
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CryptoPage(),),);},),
                      IconButton(
                        icon: Icon(Icons.star, color: Colors.white),
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FavoritesPage()),);},),
                      IconButton(
                        icon: Icon(Icons.currency_bitcoin, color: Colors.white),
                        onPressed: () {},),]),),),)),);}}