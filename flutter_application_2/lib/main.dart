import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // 设置系统UI样式
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  
  // 设置屏幕方向
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // 蓝色科技风配色
    const Color primaryColor = Color(0xFF3B82F6); // 亮蓝
    const Color primaryDark = Color(0xFF2563EB); // 深蓝
    const Color accentColor = Color(0xFF67E8F9); // 亮青
    const Color backgroundColor = Color(0xFFF8FAFC); // 极浅灰/白
    const Color cardColor = Color(0xFFE0E7FF); // 浅灰蓝
    const Color textColor = Color(0xFF222B45); // 深灰蓝

    return MaterialApp.router(
      title: '课件编辑器',
      theme: ThemeData(
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: primaryColor,
          onPrimary: Colors.white,
          secondary: accentColor,
          onSecondary: Colors.white,
          background: backgroundColor,
          onBackground: textColor,
          surface: Colors.white,
          onSurface: textColor,
          error: Colors.red,
          onError: Colors.white,
        ),
        scaffoldBackgroundColor: backgroundColor,
        cardColor: cardColor,
        appBarTheme: AppBarTheme(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          elevation: 0,
          titleTextStyle: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        navigationBarTheme: NavigationBarThemeData(
          backgroundColor: Colors.white,
          indicatorColor: accentColor,
          labelTextStyle: MaterialStateProperty.all(
            TextStyle(color: primaryDark, fontWeight: FontWeight.w500),
          ),
          iconTheme: MaterialStateProperty.all(
            const IconThemeData(color: primaryDark),
          ),
        ),
        textTheme: GoogleFonts.notoSansTextTheme().copyWith(
          displayLarge: GoogleFonts.notoSans(
            fontSize: 57,
            fontWeight: FontWeight.w400,
            color: textColor,
          ),
          displayMedium: GoogleFonts.notoSans(
            fontSize: 45,
            fontWeight: FontWeight.w400,
            color: textColor,
          ),
          displaySmall: GoogleFonts.notoSans(
            fontSize: 36,
            fontWeight: FontWeight.w400,
            color: textColor,
          ),
          headlineLarge: GoogleFonts.notoSans(
            fontSize: 32,
            fontWeight: FontWeight.w400,
            color: textColor,
          ),
          headlineMedium: GoogleFonts.notoSans(
            fontSize: 28,
            fontWeight: FontWeight.w400,
            color: textColor,
          ),
          headlineSmall: GoogleFonts.notoSans(
            fontSize: 24,
            fontWeight: FontWeight.w400,
            color: textColor,
          ),
          bodyLarge: GoogleFonts.notoSans(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: textColor,
          ),
          bodyMedium: GoogleFonts.notoSans(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: textColor,
          ),
          bodySmall: GoogleFonts.notoSans(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: textColor.withOpacity(0.7),
          ),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
        ),
        iconTheme: const IconThemeData(color: primaryDark),
        dividerColor: cardColor,
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: backgroundColor,
          border: OutlineInputBorder(
            borderSide: BorderSide(color: cardColor),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: primaryColor),
            borderRadius: BorderRadius.circular(8),
          ),
          labelStyle: TextStyle(color: textColor),
          hintStyle: TextStyle(color: textColor.withOpacity(0.6)),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            foregroundColor: Colors.white,
            textStyle: const TextStyle(fontWeight: FontWeight.bold),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: primaryDark,
            side: const BorderSide(color: primaryColor),
            textStyle: const TextStyle(fontWeight: FontWeight.bold),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
          ),
        ),
      ),
      routerConfig: router,
    );
  }
}
