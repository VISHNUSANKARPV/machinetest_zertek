import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:zartek_machine/view/screens/auth/auth_screen.dart';
import 'package:zartek_machine/view_model/auth_view_model.dart';
import 'package:zartek_machine/view_model/cart_view_model.dart';
import 'package:zartek_machine/view_model/home_view_model.dart';
import 'package:zartek_machine/view_model/otp_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 716),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => HomeViewModel()),
            ChangeNotifierProvider(create: (_) => CartViewModel()),
            ChangeNotifierProvider(create: (_) => AuthViewModel()),
             ChangeNotifierProvider(create: (_) => OtpController())
          ],
          child: MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(primarySwatch: Colors.blue),
              home: const AuthScreen()),
        );
      },
    );
  }
}
