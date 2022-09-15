import 'package:flutter/material.dart';
import 'screens/home.dart';
import 'screens/screen_two.dart';
import 'screens/screen_three.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    // final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => Home());
      case '/screen_two':
        return MaterialPageRoute(builder: (_) => ScreenTwo());
      case '/screen_three':
        return MaterialPageRoute(builder: (_) => ScreenThree());
      default:
        // If there is no such named route in the switch statement, e.g. /third
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
