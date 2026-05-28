import 'package:flutter/material.dart';
import 'package:omnikart/views/Auth/login_screen.dart';
import 'package:omnikart/views/Auth/signup_screen.dart';
import 'package:omnikart/views/home/HomeScreen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Notifier_provider/Provider_SignUp.dart';
import 'Notifier_provider/Provider_profile.dart';
import 'Notifier_provider/Theme_provider.dart';
import 'connectivity_service/connectivity_service.dart';
import 'views/auth/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isLogin = prefs.getBool('isLogin') ?? false;

  // ✅ Initialize Theme
  ThemeProvider themeProvider = ThemeProvider();
  await themeProvider.init();

  runApp(MyApp(isLogin: isLogin, themeProvider: themeProvider));
}

class MyApp extends StatelessWidget {
  final bool isLogin;
  final ThemeProvider themeProvider;  // ✅ ADD THIS

  const MyApp({
    super.key,
    required this.isLogin,
    required this.themeProvider,   // ✅ ADD THIS
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // ✅ ADD ThemeProvider
        ChangeNotifierProvider(
          create: (_) => themeProvider,
        ),

        ChangeNotifierProvider(
          create: (_) => ConnectivityService(),
        ),

        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),

        // ProfileProvider with ConnectivityService
        ChangeNotifierProxyProvider<ConnectivityService, ProfileProvider>(
          create: (context) => ProfileProvider(
            Provider.of<ConnectivityService>(context, listen: false),
          ),
          update: (context, connectivityService, previous) =>
              ProfileProvider(connectivityService),
        ),
      ],
      child: Consumer<ThemeProvider>(      // ✅ ADD THIS
        builder: (context, themeProvider, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            routes: {
              '/login': (context) => const LoginScreen(),
              '/signup': (context) => const SignUpScreen(),
              '/home': (context) => const HomeScreen(),
            },
            // ✅ UPDATE THEME PROPERTIES
            theme: ThemeProvider.lightTheme,
            darkTheme: ThemeProvider.darkTheme,
            themeMode: themeProvider.isDarkMode
                ? ThemeMode.dark
                : ThemeMode.light,

            home: isLogin
                ? const HomeScreen()
                : OmniKartSplash(),
          );
        },
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
