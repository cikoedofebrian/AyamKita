import 'package:app/controller/chickenpricecontroller.dart';
import 'package:app/controller/consultationrequest.dart';
import 'package:app/controller/dailycontroller.dart';
import 'package:app/controller/farmcontroller.dart';
import 'package:app/controller/feedcontroller.dart';
import 'package:app/controller/findoctorcontroller.dart';
import 'package:app/controller/usercontroller.dart';
import 'package:app/controller/weathercontroller.dart';
import 'package:app/controller/workinghourscontroller.dart';
import 'package:app/view/auth/adddokter.dart';
import 'package:app/view/auth/addfarm.dart';
import 'package:app/view/auth/login.dart';
import 'package:app/view/auth/register.dart';
import 'package:app/view/farm/add_musim.dart';
import 'package:app/view/farm/change_skema.dart';
import 'package:app/view/farm/farmdata.dart';
import 'package:app/view/farm/pengelolalist.dart';
import 'package:app/view/farm/add_data.dart';
import 'package:app/view/farm/datahistory.dart';
import 'package:app/view/farm/seasonhistory.dart';
import 'package:app/view/features/consultation/doctorview.dart';
import 'package:app/view/features/consultation/finddoc.dart';
import 'package:app/view/features/price/price_list.dart';
import 'package:app/view/features/request/request.dart';
import 'package:app/view/features/request/requestdetails.dart';
import 'package:app/view/features/request/requestlist.dart';
import 'package:app/view/features/weather/weather_hours.dart';
import 'package:app/view/features/workhours/change_workhours.dart';
import 'package:app/view/home/home.dart';
import 'package:app/view/profile/profile_details.dart';
import 'package:app/view/profile/profiledummy.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  initializeDateFormatting('id_ID').then(
    (_) => runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => UserController(),
          ),
          ChangeNotifierProvider(
            create: (context) => DailyController(),
          ),
          ChangeNotifierProvider(
            create: (context) => WeatherController(),
          ),
          ChangeNotifierProvider(
            create: (context) => ChickenPriceController(),
          ),
          ChangeNotifierProvider(
            create: (context) => FeedController(),
          ),
          ChangeNotifierProvider(
            create: (context) => ConsultationRequestController(),
          ),
          ChangeNotifierProvider(
            create: (context) => PeternakanController(),
          ),
          ChangeNotifierProvider(
            create: (context) => ConsultationRequestController(),
          ),
          ChangeNotifierProvider(
            create: (context) => WorkingHoursControllers(),
          ),
          ChangeNotifierProvider(
            create: (context) => FindDoctorController(),
          )
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        inputDecorationTheme: const InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1.5),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 1.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 1.5),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 1.5),
          ),
        ),
        textTheme: GoogleFonts.poppinsTextTheme(),
        primarySwatch: Colors.blue,
      ),
      home: StreamBuilder(
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            return const Home();
          } else {
            return const LoginPage();
          }
        },
        stream: FirebaseAuth.instance.authStateChanges(),
      ),
      routes: {
        '/login': (context) => const LoginPage(),
        '/home': (context) => const Home(),
        '/add-dokter': (context) => const AddDokter(),
        '/register': (context) => const RegisterPage(),
        '/weather-hours': (context) => const WeatherHours(),
        '/add-data': (context) => const AddData(),
        '/profile-details': (context) => const ProfileDetails(),
        '/data-history': (context) => const DataHistory(),
        '/request': (context) => const Request(),
        '/request-list': (context) => const RequestList(),
        '/request-details': (context) => const RequestDetails(),
        '/add-farm': (context) => const AddFarm(),
        '/farm-data': (context) => const FarmData(),
        '/pengelola-list': (context) => const PengelolaList(),
        '/profile-dummy': (context) => const ProfileDummy(),
        '/add-musim': (context) => const AddMusim(),
        '/season-list': (context) => const SeasonHistory(),
        '/change-skema': (context) => const ChangeSkema(),
        '/price-list': (context) => const PriceList(),
        '/change-work-hours': (context) => const ChangeWorkHours(),
        '/find-doctor': (context) => const FindDoctor(),
        '/doctor-view': (context) => const DoctorView(),
      },
    );
  }
}
