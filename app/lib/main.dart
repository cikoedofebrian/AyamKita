import 'package:app/controller/c_harga_pasar.dart';
import 'package:app/controller/c_konsultasi.dart';
import 'package:app/controller/c_usulan_konsultasi.dart';
import 'package:app/controller/c_data_harian.dart';
import 'package:app/controller/c_peternakan.dart';
import 'package:app/controller/c_jadwal_pakan.dart';
import 'package:app/controller/c_doctor.dart';
import 'package:app/controller/c_auth.dart';
import 'package:app/controller/c_info_cuaca.dart';
import 'package:app/controller/c_jam_kerja.dart';
import 'package:app/view/auth/add_dokter.dart';
import 'package:app/view/auth/add_farm.dart';
import 'package:app/view/auth/login.dart';
import 'package:app/view/auth/register.dart';
import 'package:app/view/auth/splash_screen.dart';
import 'package:app/view/farm/add_musim.dart';
import 'package:app/view/farm/change_skema.dart';
import 'package:app/view/farm/farm_data.dart';
import 'package:app/view/farm/pengelola_list.dart';
import 'package:app/view/farm/add_data.dart';
import 'package:app/view/farm/data_harian.dart';
import 'package:app/view/farm/season_history.dart';
import 'package:app/view/features/chat/chat_view.dart';
import 'package:app/view/features/consultation/consultation_list.dart';
import 'package:app/view/features/consultation/consultation_view.dart';
import 'package:app/view/features/consultation/create_result.dart';
import 'package:app/view/features/consultation/doctor_view.dart';
import 'package:app/view/features/consultation/find_doc.dart';
import 'package:app/view/features/consultation/payment_success.dart';
import 'package:app/view/features/consultation/result_view.dart';
import 'package:app/view/features/consultation/select_payment.dart';
import 'package:app/view/features/consultation/view_farm_data.dart';
import 'package:app/view/features/price/price_list.dart';
import 'package:app/view/features/request/add_request.dart';
import 'package:app/view/features/request/request_details.dart';
import 'package:app/view/features/request/request_list.dart';
import 'package:app/view/features/weather/weather_hours.dart';
import 'package:app/view/features/workhours/change_workhours.dart';
import 'package:app/view/home/home.dart';
import 'package:app/view/profile/profile_details.dart';
import 'package:app/view/profile/profile_other_user.dart';
import 'package:app/widget/image_shower.dart';
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
            create: (context) => CAuth(),
          ),
          ChangeNotifierProvider(
            create: (context) => CDataHarian(),
          ),
          ChangeNotifierProvider(
            create: (context) => CInfoCuaca(),
          ),
          ChangeNotifierProvider(
            create: (context) => CHargaPasar(),
          ),
          ChangeNotifierProvider(
            create: (context) => CJadwalPakan(),
          ),
          ChangeNotifierProvider(
            create: (context) => CUsulanKonsultasi(),
          ),
          ChangeNotifierProvider(
            create: (context) => CPeternakan(),
          ),
          ChangeNotifierProvider(
            create: (context) => MJamKerjaControllers(),
          ),
          ChangeNotifierProvider(
            create: (context) => CDoctor(),
          ),
          ChangeNotifierProvider(
            create: (context) => CKonsultasi(),
          ),
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
            return const SplashScreen();
          }
        },
        stream: FirebaseAuth.instance.authStateChanges(),
      ),
      routes: {
        '/login': (context) => const LoginPage(),
        '/home': (context) => const Home(),
        '/add-dokter': (context) => const AddDokter(),
        '/register': (context) => const RegisterPage(),
        '/weather-hours': (context) => const MInfoCuacaHours(),
        '/add-data': (context) => const AddData(),
        '/profile-details': (context) => const ProfileDetails(),
        '/data-history': (context) => const DataHarian(),
        '/request': (context) => const AddRequest(),
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
        '/select-payment': (context) => const SelectPayment(),
        '/payment-success': (context) => const PaymentSuccess(),
        '/consultation-list': (context) => const ConsultationList(),
        '/consultation-view': (context) => const ConsultationView(),
        '/chat-view': (context) => const ChatView(),
        '/photo-view': (context) => const ImageShower(),
        '/create-result': (context) => const CreateResult(),
        '/result-view': (context) => const ResultView(),
        '/view-farm-data': (context) => const ViewFarmData(),
      },
    );
  }
}
