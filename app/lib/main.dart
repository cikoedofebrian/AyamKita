import 'package:app/controller/chickenpricecontroller.dart';
import 'package:app/controller/dailycontroller.dart';
import 'package:app/controller/feedcontroller.dart';
import 'package:app/controller/usercontroller.dart';
import 'package:app/controller/weathercontroller.dart';
import 'package:app/view/auth/login.dart';
import 'package:app/view/auth/register.dart';
import 'package:app/view/features/farms/add_data.dart';
import 'package:app/view/features/weather/weather_hours.dart';
import 'package:app/view/home/home.dart';
import 'package:app/view/profile/profile_details.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intl/date_symbol_data_local.dart';
// import 'package:loading_animation_widget/loading_animation_widget.dart';
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
        '/register': (context) => const RegisterPage(),
        '/weather-hours': (context) => const WeatherHours(),
        '/add-data': (context) => const AddData(),
        '/profile-details': (context) => const ProfileDetails(),
      },
    );
  }
}

// class Home extends StatelessWidget {
//   const Home({super.key});

//   Future<List<Weather>> getWeatherData() async {
//     List<Weather> temp = [];
//     final url = Uri.parse(
//         "https://api.openweathermap.org/data/2.5/forecast?q=london&appid=81ffc2ddca6b4448afce3e5018be62a9&units=metric");

//     final result = await http.get(url);
//     if (result.statusCode == 200) {
//       final parsedJson = jsonDecode(result.body) as Map<String, dynamic>;
//       for (var i = 0; i < 8; i++) {
//         temp.add(Weather.fromJson(parsedJson["list"][i]));
//       }
//     }
//     return temp;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('AyamKita'),
//       ),
//       // body: ElevatedButton(child: Text('ss'), onPressed: getWeatherData),
//       body: FutureBuilder(
//           future: getWeatherData(),
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return Center(child: CircularProgressIndicator());
//             }
//             return Column(
//               children: [
//                 Container(
//                   color: Colors.green,
//                   height: 150,
//                   alignment: Alignment.center,
//                   padding: EdgeInsets.symmetric(vertical: 20),
//                   child: ListView.builder(
//                     padding: EdgeInsets.symmetric(horizontal: 10),
//                     scrollDirection: Axis.horizontal,
//                     itemCount: snapshot.data!.length,
//                     itemBuilder: (context, index) => Container(
//                       margin: EdgeInsets.symmetric(horizontal: 10),
//                       height: 120,
//                       width: 70,
//                       decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(10)),
//                       alignment: Alignment.center,
//                       padding: EdgeInsets.all(12),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Icon(
//                             Icons.cloudy_snowing,
//                           ),
//                           SizedBox(
//                             height: 10,
//                           ),
//                           FittedBox(
//                             child: Text(
//                                 "${snapshot.data![index].main.temp.toString()}°C"),
//                           ),
//                           SizedBox(
//                             height: 5,
//                           ),
//                           FittedBox(
//                             child: Text(
//                               DateFormat('hh:mm a').format(
//                                   DateTime.fromMillisecondsSinceEpoch(
//                                           snapshot.data![index].dt * 1000,
//                                           isUtc: true)
//                                       .toLocal()),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             );
//           }),
//     );
//   }
// }
