import 'package:covac/challenges.dart';
import 'package:covac/cititzen_report.dart';
import 'package:covac/citizen.dart';
import 'package:covac/citizen_home.dart';
import 'package:covac/citizen_login_or_signup.dart';
import 'package:covac/citizen_registeration.dart';
import 'package:covac/covid_safety.dart';
import 'package:covac/faq.dart';
import 'package:covac/feedbacks.dart';
import 'package:covac/login_citizen.dart';
import 'package:covac/login_vaccinator.dart';
import 'package:covac/place.dart';
import 'package:covac/quiz.dart';
import 'package:covac/slotbooking.dart';
import 'package:covac/vaccinator_login_or_signup.dart';
import 'package:covac/vaccinator_registeration.dart';
import 'package:flutter/material.dart';
import 'vaccinator_home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'vaccinator.dart';
import 'booking_confirm.dart';
import 'confirmvaccination.dart';
import 'viewcertificate.dart';
import 'readreports.dart';
import 'manual.dart';
import 'badge.dart';
import 'image.dart';
import 'otp.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(MaterialApp(
    home: MyApp(),
    debugShowCheckedModeBanner: false,
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CovaC',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Raleway',
      ),
      home: MyHomePage(title: 'CovaC'),
      routes: {
        CitizenRegisteration.routeName: (ctx) => CitizenRegisteration(),
        VaccinatorRegisteration.routeName: (ctx) => VaccinatorRegisteration(),
        Faq.routename: (ctx) => Faq(),
        Place.routename: (ctx) => Place(),
        // Covid_Safety.routename:(ctx)=>Covid_Safety(),
        //  CovidQuiz.routename:(ctx)=>CovidQuiz(),
        // BookingConformationChecker.routename:(ctx)=>BookingConformationChecker(),
        Readreports.routename: (c) => Readreports(),
        Viewcertificate.routename: (c) => Viewcertificate(),
        Citizen_login_or_signup.routename: (context) =>
            Citizen_login_or_signup(),
        CitizenLogin.routename: (context) => CitizenLogin(),
        Vaccinator_login_or_signup.routename: (context) =>
            Vaccinator_login_or_signup(),
        VaccinatorLogin.routename: (context) => VaccinatorLogin(),
        Manuals.routename: (c) => Manuals(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == CitizenHomePage.routename) {
          final args = settings.arguments;
          return MaterialPageRoute(builder: (context) {
            return CitizenHomePage(args as Citizen);
          });
        } else if (settings.name == Covid_Safety.routename) {
          final args = settings.arguments;
          return (MaterialPageRoute(builder: (context) {
            return Covid_Safety(args as Citizen);
          }));
        } else if (settings.name == CovidQuiz.routename) {
          final args = settings.arguments;
          return (MaterialPageRoute(builder: (context) {
            return CovidQuiz(args as Citizen);
          }));
        } else if (settings.name == Citizen_Report.routename) {
          final args = settings.arguments;
          return (MaterialPageRoute(builder: (context) {
            return Citizen_Report(args as Citizen);
          }));
        } else if (settings.name == BookingConformationChecker.routename) {
          final args = settings.arguments;
          return (MaterialPageRoute(builder: (context) {
            return BookingConformationChecker(args as Vaccinator);
          }));
        } else if (settings.name == UploadImage.routename) {
          final args = settings.arguments;
          return MaterialPageRoute(builder: (context) {
            return UploadImage(args as Citizen);
          });
        } else if (settings.name == Badges.routename) {
          final args = settings.arguments;
          return MaterialPageRoute(builder: (context) {
            return Badges(args as Citizen);
          });
        } else if (settings.name == Challenges.routename) {
          final args = settings.arguments;
          return MaterialPageRoute(builder: (context) {
            return Challenges(args as Citizen);
          });
        } else if (settings.name == VaccinatorHomepage.routename) {
          final args = settings.arguments;
          return (MaterialPageRoute(builder: (context) {
            return VaccinatorHomepage(args as Vaccinator);
          }));
        } else if (settings.name == ConfirmVaccination.routename) {
          final args = settings.arguments;
          return (MaterialPageRoute(builder: (context) {
            return ConfirmVaccination(args as Vaccinator);
          }));
        } else if (settings.name == OTPScreen.routename) {
          final args = settings.arguments;
          return (MaterialPageRoute(builder: (context) {
            return OTPScreen(args as Citizen);
          }));
        } else if (settings.name == SlotBooking.routename) {
          final args = settings.arguments;
          return MaterialPageRoute(builder: (context) {
            return SlotBooking(args as Citizen);
          });
        } else if (settings.name == FeedBacksCitizen.routename) {
          final args = settings.arguments;
          return MaterialPageRoute(builder: (context) {
            return FeedBacksCitizen(args as Citizen);
          });
        }
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void func() {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                  width: 150,
                  height: 150,
                  child: ClipOval(
                      child: Image.asset('assets/images/vaccine.jpg'))),
              Text(
                "CovaC",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 45,
                ),
              ),
              Text(
                "'Got A Shot? No Covid for You!'",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 19,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Choose your role",
                style: TextStyle(
                    color: Colors.white,
                    fontStyle: FontStyle.italic,
                    fontSize: 15),
              ),
              SizedBox(height: 10)
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                onPressed: () => {
                  Navigator.pushNamed(
                      context, Citizen_login_or_signup.routename)
                },
                child: Text("Citizen",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                textColor: Colors.black,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              SizedBox(width: 20),
              RaisedButton(
                onPressed: () => {
                  Navigator.pushNamed(
                      context, Vaccinator_login_or_signup.routename)
                },
                child: Text("Vaccinator",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    )),
                textColor: Colors.black,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
            ],
          )
        ],
      ),
    );
  }
}
