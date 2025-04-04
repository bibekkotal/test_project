import 'utils/app_exports.dart';
import 'dart:ui' as ui;
import 'navigation/app_routes.dart';

void main() {
  RenderErrorBox.backgroundColor = Colors.black26;
  RenderErrorBox.textStyle = ui.TextStyle(color: Colors.white);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: AppColors.white,
    systemNavigationBarIconBrightness: Brightness.light,
    statusBarColor: AppColors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: false,
      ensureScreenSize: true,
      useInheritedMediaQuery: true,
      builder: (
        BuildContext context,
        Widget? widget,
      ) =>
          MaterialApp(
        debugShowCheckedModeBanner: false,
        title: StaticStrings.appName,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: AppColors.primary,
          ),
          useMaterial3: false,
          fontFamily: CustomFonts.rany,
          typography: Typography.material2021(),
          splashFactory: InkRipple.splashFactory,
          splashColor: AppColors.grey.withOpacity(0.3),
        ),
        onGenerateRoute: RouteGenerator.generateRoute,
        initialRoute: RouteNames.home,
        navigatorKey: NavigatorService.navigatorKey,
      ),
    );
  }
}
