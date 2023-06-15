import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_core/amplify_core.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_analytics_pinpoint/amplify_analytics_pinpoint.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_api/amplify_api.dart';
import 'package:flutter_login/flutter_login.dart';

import 'amplifyconfiguration.dart';

import 'models/ModelProvider.dart';
import 'package:flutter/material.dart';
import 'page1_summary.dart';
import 'page2_exercise.dart';
import 'page3_category.dart';
import 'page4_routine.dart';
import 'page5_workout.dart';
import 'data.dart';

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  Hive.registerAdapter(ExerciseAdapter());
  Hive.registerAdapter(CategoryAdapter());
  Hive.registerAdapter(RoutineAdapter());
  await Hive.initFlutter();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Workout Planner",
      home: FutureBuilder(
        future: Future.wait([
          Hive.openBox<MyExercise>('exercises'),
          Hive.openBox('historical_data'),
          Hive.openBox<Category>('categories'),
          Hive.openBox<MyRoutine>('routines'),
        ]),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              print(snapshot.error);
              return Scaffold(
                body: Center(
                  child: Text(snapshot.error.toString()),
                ),
              );
            } else {
              return LoginPage();
            }
          } else {
            return Scaffold();
          }
        },
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  int currentIndex = 0;
  bool isSignedIn = false;
  String username = "";
  final confirmationCodeController = TextEditingController();
  @override
  initState() {
    super.initState();
    _configureAmplify();
    currentIndex = 0;
    isSignedIn = false;
    username = "";
    _signOut();
  }

  void _configureAmplify() async {
    if (!mounted) return;
    if (Amplify.isConfigured) {
      print("Amplify Already Configured");
      return;
    }
    // Once Plugins are added, configure Amplify
    // Note: Amplify can only be configured once.
    try {
      // Add Pinpoint and Cognito Plugins, or any other plugins you want to use
      AmplifyAnalyticsPinpoint analyticsPlugin = AmplifyAnalyticsPinpoint();
      AmplifyAuthCognito authPlugin = AmplifyAuthCognito();
      Amplify.addPlugins([authPlugin]);
      AmplifyAPI apiPlugin = AmplifyAPI();
      AmplifyDataStore datastorePlugin =
          AmplifyDataStore(modelProvider: ModelProvider.instance);
      Amplify.addPlugins(
          [authPlugin, analyticsPlugin, apiPlugin, datastorePlugin]);

      await Amplify.configure(amplifyconfig);
      print("Successfully configured.");
    } on AmplifyAlreadyConfiguredException {
      print(
          "Tried to reconfigure Amplify; this can occur when your app restarts on Android.");
    }
  }

  void showMessage(BuildContext context, String title, String message) {
    showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void showEnterConfirmationCodeDialog(BuildContext context) async {
    showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Verification Code Sent To Your Email"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: confirmationCodeController,
                decoration: InputDecoration(
                  hintText: "Your verification code...",
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('CANCEL'),
              onPressed: () {
                Navigator.pop(context);
                showMessage(context, "Sign Up Failed", "Use another email.");
              },
            ),
            TextButton(
              child: Text('CONFIRM'),
              onPressed: () async {
                bool isSignUpComplete = false;
                try {
                  SignUpResult res = await Amplify.Auth.confirmSignUp(
                      username: username,
                      confirmationCode: confirmationCodeController.text);
                  isSignUpComplete = res.isSignUpComplete;
                } on AuthException catch (e) {
                  confirmationCodeController.text = "";
                  Navigator.pop(context);
                  showMessage(context, "Sign Up Failed", "Use another email.");
                  print(e.message);
                  return;
                }
                setState(() {
                  confirmationCodeController.text = "";
                  Navigator.pop(context);
                  if (isSignUpComplete) {
                    showMessage(context, "Sign Up Success",
                        "You can try to login now.");
                  } else {
                    showMessage(
                        context, "Sign Up Failed", "Use another email.");
                  }
                });
              },
            ),
          ],
        );
      },
    );
  }

  Future<String> _signUp(LoginData data) async {
    _signOut();
    print("Start to Register:");
    print("username: " + data.name);
    print("password: " + data.password);
    try {
      username = data.name;
      Map<String, String> userAttributes = {
        "email": data.name,
      };
      SignUpResult res = await Amplify.Auth.signUp(
          username: data.name,
          password: data.password,
          options: CognitoSignUpOptions(userAttributes: userAttributes));
      setState(() {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
        if (res.isSignUpComplete) {
          print("Sign Up Partially Complete, Confirmation Code Sent.");
          showEnterConfirmationCodeDialog(context);
        } else {
          print("Confirmation Code Not Sent.");
        }
      });
    } on AuthException catch (e) {
      print(e.toString());
      return "Email existed or password not long enough.";
    }
    return "";
  }

  Future<String> _signIn(LoginData data) async {
    _signOut();
    print("Start to Sign In:");
    print("username: " + data.name);
    print("password: " + data.password);
    try {
      SignInResult res = await Amplify.Auth.signIn(
          username: data.name.trim(), password: data.password.trim());
      setState(() {
        isSignedIn = res.isSignedIn;
        if (res.isSignedIn) {
          print("Login success. Navigating to main page...");
        } else {
          print("still not signed in");
        }
      });
    } catch (e) {
      print("Login Failed Due to Some Error:");
      print(e.toString());
      return "Incorrect username or password.";
    }
    return "";
  }

  void _signOut() {
    print("Try to sign out now:");
    try {
      Amplify.Auth.signOut();
      print("Sign Out Successful.");
    } on AuthException catch (e) {
      print("Sign Out Failed. Error message:");
      print(e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!isSignedIn) {
      return SafeArea(
        child: FlutterLogin(
            onLogin: _signIn,
            onSignup: _signUp,
            onRecoverPassword: (_) => null,
            hideForgotPasswordButton: true,
            title: 'Workout Planner'),
      );
    } else {
      return Scaffold(
        body: [
          SummaryPage(onSignOut: () {
            setState(() {
              isSignedIn = false;
              _signOut();
            });
          }),
          ExercisePage(onSignOut: () {
            setState(() {
              isSignedIn = false;
              _signOut();
            });
          }),
          CategoryPage(onSignOut: () {
            setState(() {
              isSignedIn = false;
              _signOut();
            });
          }),
          RoutinePage(onSignOut: () {
            setState(() {
              isSignedIn = false;
              _signOut();
            });
          }),
          WorkoutPage(onSignOut: () {
            setState(() {
              isSignedIn = false;
              _signOut();
            });
          })
        ][currentIndex], // new
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          onTap: (int index) {
            setState(() {
              currentIndex = index;
            });
          },
          currentIndex: currentIndex,
          items: [
            new BottomNavigationBarItem(
              icon: Icon(Icons.equalizer),
              label: 'SUMMARY',
            ),
            new BottomNavigationBarItem(
              icon: Icon(Icons.directions_bike),
              label: 'EXERCISE',
            ),
            new BottomNavigationBarItem(
                icon: Icon(Icons.category), label: 'CATEGORY'),
            new BottomNavigationBarItem(
                icon: Icon(Icons.event), label: 'ROUTINE'),
            new BottomNavigationBarItem(
                icon: Icon(Icons.add_circle_outline), label: 'WORKOUT'),
          ],
        ),
      );
    }
  }
}
