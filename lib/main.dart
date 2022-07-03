import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'modules/home_page/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      builder: (BuildContext context, _) => ProviderScope(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Marvel Preview',
          theme: ThemeData(
            backgroundColor: Colors.white,
            fontFamily: 'Cairo',
          ),
          home: const MyHomePage(),
        ),
      ),
    );
  }
}
