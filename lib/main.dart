import 'package:doal/pages/home_page.dart';
import 'package:doal/pages/sign_in_page.dart';
import 'package:doal/pages/sign_up_page.dart';
import 'package:doal/pages/to_do_add_page.dart';
import 'package:doal/pages/view_edit_todo.dart';
import 'package:doal/utils/myalarm.dart';
import 'package:doal/utils/routes.dart';
import 'package:doal/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await AndroidAlarmManager.initialize();
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.dark.copyWith(
      systemNavigationBarColor:
          Colors.black, // Set the navigation bar background color
    ),
  );
  AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
            channelGroupKey: 'basic_channel_group',
            channelKey: 'basic_channel',
            channelName: 'Basic notifications',
            channelDescription: 'Notification channel for basic tests',
            defaultColor: Color(0xFF9D50DD),
            ledColor: Colors.white)
      ],
      // Channel groups are only visual and are not required
      channelGroups: [
        NotificationChannelGroup(
            channelGroupKey: 'basic_channel_group',
            channelGroupName: 'Basic group')
      ],
      debug: true);
  bool isAllowedToSendNotification =
      await AwesomeNotifications().isNotificationAllowed();
  if (!isAllowedToSendNotification) {
    AwesomeNotifications().requestPermissionToSendNotifications();
  }
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

    AwesomeNotifications().setListeners(
        onActionReceivedMethod: NotificationController.onActionReceivedMethod,
        onNotificationCreatedMethod:
            NotificationController.onNotificationCreatedMethod,
        onNotificationDisplayedMethod:
            NotificationController.onNotificationDisplayedMethod,
        onDismissActionReceivedMethod:
            NotificationController.onDismissActionReceivedMethod);
    super.initState();
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
        MyRoutes.viewtodo: (context) => const ViewToDoWidget(
              taskId: '',
            ),
      },
    );
  }
}
