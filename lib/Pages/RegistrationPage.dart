import 'package:flutter/material.dart';
import 'package:untitled/Pages/InitialPage.dart';
import 'package:untitled/Pages/user.dart';
import 'package:untitled/main.dart';

void main() => runApp(const RegistrationPage());

//
class RegistrationPage extends StatelessWidget {
  const RegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Отключение баннера отладки
      theme: ThemeData(
        primarySwatch: Colors.indigo, // Основной цвет приложения (indigo)
        // Дополнительные настройки темы по желанию
      ),
      routes: {
        '/': (context) => const SignUpScreen(),
        '/welcome': (context) => InitialPage(),
      },
    );
  }
}

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Регистрация', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.indigo[400],
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => InitialPage()));
          },
        ),
      ),
      backgroundColor: Colors.grey[200],
      body: Center(
        child: SizedBox(
          width: 400,
          child: Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20), // Скругленные углы карточки
            ),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: SingleChildScrollView( // Добавляем SingleChildScrollView
                child: SignUpForm(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

////////////

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _passwordTextController = TextEditingController();
  final _firstNameTextController = TextEditingController();
  final _lastNameTextController = TextEditingController();
  final _usernameTextController = TextEditingController();

  double _formProgress = 0;

  void _updateFormProgress() {
    var progress = 0.0;
    final controllers = [
      _firstNameTextController,
      _lastNameTextController,
      _usernameTextController,
      _passwordTextController,
    ];

    for (final controller in controllers) {
      if (controller.value.text.isNotEmpty) {
        progress += 1.0 / controllers.length; // Изменено: делим на количество полей
      }
    }
    print('_formProgress: $progress'); // Добавлено для отладки
    setState(() {
      _formProgress = progress;
    });
  }

  void _showWelcomeScreen() {
    Navigator.of(context).pushNamed('/welcome');
  }

  @override
  void initState() {
    super.initState();
    _firstNameTextController.addListener(_updateFormProgress);
    _lastNameTextController.addListener(_updateFormProgress);
    _usernameTextController.addListener(_updateFormProgress);
    _passwordTextController.addListener(_updateFormProgress);
  }

  @override
  void dispose() {
    _firstNameTextController.dispose();
    _lastNameTextController.dispose();
    _usernameTextController.dispose();
    _passwordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      onChanged: _updateFormProgress,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch, // Занимаем всю ширину
        children: [
          Text('Регистрация',
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              )),
          SizedBox(height: 20), // Отступ
          AnimatedProgressIndicator(value: _formProgress), // Импорт и использование
          SizedBox(height: 20), // Отступ
          TextFormField(
            controller: _firstNameTextController,
            decoration: InputDecoration(
              hintText: 'Имя',
              hintStyle: TextStyle(color: Colors.grey[600]),
              filled: true, // Заполняем фон
              fillColor: Colors.grey[200], // Серый фон
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10), // Скругленные углы
                borderSide: BorderSide.none, // Скрываем стандартную рамку
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10), // Скругленные углы
                borderSide: BorderSide(color: Colors.indigo), // Рамка при фокусе
              ),
            ),
          ),
          SizedBox(height: 16), // Отступ
          TextFormField(
            controller: _lastNameTextController,
            decoration: InputDecoration(
              hintText: 'Фамилия',
              hintStyle: TextStyle(color: Colors.grey[600]),
              filled: true,
              fillColor: Colors.grey[200],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.indigo),
              ),
            ),
          ),
          SizedBox(height: 16),
          TextFormField(
            controller: _usernameTextController,
            decoration: InputDecoration(
              hintText: 'Логин',
              hintStyle: TextStyle(color: Colors.grey[600]),
              filled: true,
              fillColor: Colors.grey[200],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.indigo),
              ),
            ),
          ),
          SizedBox(height: 16),
          TextFormField(
            controller: _passwordTextController,
            obscureText: true, // Скрываем пароль
            decoration: InputDecoration(
              hintText: 'Пароль',
              hintStyle: TextStyle(color: Colors.grey[600]),
              filled: true,
              fillColor: Colors.grey[200],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.indigo),
              ),
            ),
          ),
          SizedBox(height: 24), // Отступ
          ElevatedButton(
            onPressed: _formProgress == 1.0
                ? _showWelcomeScreen
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 16), // Отступ по вертикали
              textStyle: TextStyle(
                fontSize: 18, // Размер текста
                fontWeight: FontWeight.bold, // Жирный текст
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10), // Скругленные углы
              ),
            ),
            child: Text('Зарегистрироваться'),
          ),
        ],
      ),
    );
  }
}

class AnimatedProgressIndicator extends StatefulWidget {
  final double value;

  const AnimatedProgressIndicator({super.key, required this.value});

  @override
  _AnimatedProgressIndicatorState createState() =>
      _AnimatedProgressIndicatorState();
}

class _AnimatedProgressIndicatorState extends State<AnimatedProgressIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;
  late Animation<double> _curveAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    final colorTween = TweenSequence([
      TweenSequenceItem(
        tween: ColorTween(begin: Colors.indigo, end: Colors.indigoAccent),
        weight: 0.33,
      ),
      TweenSequenceItem(
        tween: ColorTween(begin: Colors.blueAccent, end: Colors.blue),
        weight: 0.33,
      ),
      TweenSequenceItem(
        tween: ColorTween(begin: Colors.blueGrey, end: Colors.grey),
        weight: 0.33,
      ),
    ]);

    _colorAnimation = _controller.drive(colorTween);
    _curveAnimation = _controller.drive(CurveTween(curve: Curves.easeIn));
  }

  @override
  void didUpdateWidget(oldWidget) {
    super.didUpdateWidget(oldWidget);
    _controller.animateTo(widget.value);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) => LinearProgressIndicator(
        value: _curveAnimation.value,
        valueColor: _colorAnimation,
        backgroundColor: _colorAnimation.value?.withOpacity(0.4),
      ),
    );
  }
}