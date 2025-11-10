import 'package:car_stax/auth/login_or_register.dart';
import 'package:car_stax/backend/backend_functions.dart';
import 'package:car_stax/pages/home_page.dart';
import 'package:car_stax/theme/dark_mode.dart';
import 'package:car_stax/theme/light_mode.dart';
import 'package:flutter/material.dart';
import 'package:car_stax/auth/auth_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/services.dart';

extension HexColorExtension on String {
  Color toColor() {
    var hexString = this;
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff'); // Default to opaque if no alpha
    buffer.write(hexString.replaceFirst('#', '')); // Remove '#' if present
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}


void main() {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure binding is initialized
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp, // Lock to portrait mode
  ]);
  runApp(const ProviderScope(
      child: MyApp()
  )
  );
}



class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);

    return MaterialApp(       // <-- MaterialApp provides Directionality
      debugShowCheckedModeBanner: false,
      title: 'My App',
      theme: light_mode,
      darkTheme: dark_mode,
      home: authState == AuthState.authenticated
          ? const HomePage()
          : const LoginOrRegister(),
    );


    // return MaterialApp(
    //   home: LoginOrRegister(),
    //   theme: light_mode,
    //   darkTheme: dark_mode,
    //   routes: {
    //     '/login_register_page':(context) => LoginOrRegister(),
    //     '/home_page' : (context) => HomePage(),
    //
    //   },
    // );
  }
}
