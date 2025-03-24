import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pixel_photo/db_pixel/db_pixel.dart';
import 'package:pixel_photo/pages/feedback/feedback_binding.dart';
import 'package:pixel_photo/pages/feedback/feedback_view.dart';
import 'package:pixel_photo/pages/no_network/no_network_binding.dart';
import 'package:pixel_photo/pages/no_network/no_network_view.dart';
import 'package:pixel_photo/pages/pixel_add/pixel_add_binding.dart';
import 'package:pixel_photo/pages/pixel_add/pixel_add_view.dart';
import 'package:pixel_photo/pages/pixel_main/pixel_main_binding.dart';
import 'package:pixel_photo/pages/pixel_main/pixel_main_view.dart';
import 'package:pixel_photo/pages/pixel_setting/pixel_setting_binding.dart';
import 'package:pixel_photo/pages/pixel_setting/pixel_setting_view.dart';

Color primaryColor = Colors.black;
Color bgColor = const Color(0xfff8f8f8);

List<Color> colorList = [
  Colors.black,
  Colors.white,
  const Color(0xfff2f2f2),
  const Color(0xffffb600),
  const Color(0xfff99800),
  const Color(0xffffde00),
  const Color(0xffffed70),
  const Color(0xffff34ff),
  const Color(0xff007fff),
  const Color(0xffa7ff00),
  const Color(0xff67ff60),
  const Color(0xff88ff9f),
  const Color(0xffd0ffd7),
  const Color(0xff79fff5),
  const Color(0xff8965ff),
  const Color(0xffff0000),
  const Color(0xffff6c00),
  const Color(0xff8000ff),
];

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Get.putAsync(() => DBPixel().init());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: Pixels,
      initialRoute: '/pixelMain',
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: primaryColor,
        scaffoldBackgroundColor: bgColor,
        colorScheme: ColorScheme.light(
          primary: primaryColor,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          scrolledUnderElevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 20,
          ),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: primaryColor,
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        cardTheme: const CardTheme(
          color: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        dialogTheme: const DialogTheme(
          actionsPadding: EdgeInsets.only(right: 10, bottom: 5),
        ),
        dividerTheme: DividerThemeData(
          thickness: 1,
          color: Colors.grey[200],
        ),
      ),
    );
  }
}
List<GetPage<dynamic>> Pixels = [
  GetPage(name: '/networkCheck', page: () => NoNetworkPage(), binding: NoNetworkBinding()),
  GetPage(name: '/pixelMain', page: () => const PixelMainPage(), binding: PixelMainBinding()),
  GetPage(name: '/pixelAdd', page: () => const PixelAddPage(), binding: PixelAddBinding()),
  GetPage(name: '/pixelSetting', page: () => PixelSettingPage(), binding: PixelSettingBinding()),
  GetPage(name: '/feedback', page: () => FeedbackPage(), binding: FeedbackBinding()),
];