import 'package:test_project/features/booking/booking_screen.dart';

import '../features/discover/discover_screen.dart';
import '../features/home/home_screen.dart';
import '../utils/app_exports.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case RouteNames.discover:
        return MaterialPageRoute(builder: (_) => const DiscoverScreen());
      case RouteNames.booking:
        return MaterialPageRoute(builder: (_) => const BookingScreen());
      default:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
    }
  }
}

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(StaticStrings.error)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(StaticStrings.pageNotFound),
            ElevatedButton(
              child: Text(StaticStrings.goToHome),
              onPressed: () {
                // Navigator.pushNamedAndRemoveUntil(
                //     context,
                //     RouteNames.home,
                //         (route) => false
                // );
              },
            ),
          ],
        ),
      ),
    );
  }
}
