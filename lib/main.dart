import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:roqqu/view_model/binance_data_view_model.dart';
import 'presentation/views/home/homepage.dart';
import 'utils/locator.dart';
import 'utils/theme.dart';
import 'services/binance_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setUpLocator();

  Directory tempDir = await getApplicationDocumentsDirectory();
  Hive.init(tempDir.path);

  runApp(MultiProvider(
    providers: [

      Provider(create: (_) => BinanceService()),
      ChangeNotifierProxyProvider<BinanceService, BinanceDataViewModel>(
        create: (context) => BinanceDataViewModel(context.read<BinanceService>()),
        update: (_, service, viewModel) => viewModel ?? BinanceDataViewModel(service),
      ),
      ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();

  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(newLocale);
  }
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;

  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return OverlaySupport.global(
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            darkTheme: AppTheme.darkTheme,
            theme: AppTheme.lightTheme,
            // themeMode: Theme.of(context).brightness == Brightness.dark ? ThemeMode.dark : ThemeMode.light,
            home: const HomePage(),
            builder: EasyLoading.init(),
          ),
        );
      },
      child: const SizedBox(),
    );
  }
}
