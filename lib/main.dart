import 'package:flutter/material.dart';
import 'package:omnikart/views/Auth/login_screen.dart';
import 'package:omnikart/views/Auth/signup_screen.dart';
import 'package:omnikart/views/home/HomeScreen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Notifier_provider/Provider_SignUp.dart';
import 'Notifier_provider/Provider_profile.dart';
import 'connectivity_service/connectivity_service.dart';
import 'views/auth/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences prefs =
  await SharedPreferences.getInstance();

  bool isLogin = prefs.getBool('isLogin') ?? false;

  runApp(MyApp(isLogin: isLogin));
}

class MyApp extends StatelessWidget {

  final bool isLogin;

  const MyApp({super.key, required this.isLogin});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [

        ChangeNotifierProvider(create: (_) => ConnectivityService()),

        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
        // ✅ ProfileProvider (ConnectivityService को pass करो)
        ChangeNotifierProxyProvider<ConnectivityService, ProfileProvider>(
          create: (context) => ProfileProvider(
            Provider.of<ConnectivityService>(context, listen: false),
          ),
          update: (context, connectivityService, previous) =>
              ProfileProvider(connectivityService),
        ),

      ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,

      routes: {
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignUpScreen(),
        '/home': (context) => const HomeScreen(),
      },
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
          home: isLogin
              ? const HomeScreen()
              : OmniKartSplash(),
    ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text(widget.title),
      ),
      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
