import 'package:flutter/material.dart';
import 'package:r7_currency_converter/app/app_strings.dart';
import 'package:r7_currency_converter/presentation/screens/converter_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 640),
      minTextAdapt: true,
      builder: (context , child) {
        return child!;
      },
      child: MaterialApp(
        title: AppStrings.currencyConverter,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: ConverterScreen(),
      ),
    );
  }
}
