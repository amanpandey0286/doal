import 'package:doal/pages/forgot_pwd_page.dart';
import 'package:doal/pages/home_page.dart';
import 'package:doal/pages/sign_in_page.dart';
import 'package:doal/pages/sign_up_page.dart';
import 'package:doal/pages/to_do_add_page.dart';
import 'package:doal/pages/view_edit_todo.dart';
import 'package:doal/utils/routes.dart';
import 'package:doal/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:lottie/lottie.dart';
import 'package:timezone/data/latest_10y.dart' as tz;

FlutterLocalNotificationsPlugin notificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();
  AndroidInitializationSettings androidSettings =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  InitializationSettings initializationSettings =
      InitializationSettings(android: androidSettings);
  bool? initialized =
      await notificationsPlugin.initialize(initializationSettings);
  notificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()!
      .requestNotificationsPermission();
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.dark.copyWith(
      systemNavigationBarColor:
          Colors.black, // Set the navigation bar background color
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ConnectivityResult _connectivityResult = ConnectivityResult.none;
  @override
  void initState() {
    initConnectivity();
    Connectivity().onConnectivityChanged.listen((result) {
      setState(() {
        _connectivityResult = result;
      });
    });
  }

  Future<void> initConnectivity() async {
    ConnectivityResult result = await Connectivity().checkConnectivity();
    setState(() {
      _connectivityResult = result;
    });
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (_connectivityResult == ConnectivityResult.none) {
            return Scaffold(
              body: Center(
                child: SizedBox(
                  height: 200,
                  child: Card(
                      color: Colors.transparent,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: const BorderSide(
                            width: 1.5,
                            color: Colors.white54,
                          )),
                      child: Lottie.asset('assets/images/no_internet.json')),
                ),
              ),
            );
          } else if (snapshot.hasData) {
            return const HomePage();
          } else {
            return const SignUpPage(
              email: '',
            );
          }
        },
      ),
      theme: MyTheme.MyThemeData(),
      routes: {
        MyRoutes.homeRoute: (context) => const HomePage(),
        MyRoutes.signUpRoute: (context) => const SignUpPage(
              email: '',
            ),
        MyRoutes.signInRoute: (context) => const SignInPage(),
        MyRoutes.addtodo: (context) => const AddToDoWidget(),
        MyRoutes.forgotpwd: (context) => const ForgotPasseordPage(),
        MyRoutes.viewtodo: (context) => const ViewToDoWidget(
              taskId: '',
            ),
      },
    );
  }
}
