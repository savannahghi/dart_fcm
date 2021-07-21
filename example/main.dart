import 'package:dart_fcm/dart_fcm.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const YourAppName());
}

/// [YourAppName] marks as the entry point to your application.
///
class YourAppName extends StatefulWidget {
  const YourAppName({Key? key}) : super(key: key);

  @override
  _YourAppNameState createState() => _YourAppNameState();
}

class _YourAppNameState extends State<YourAppName> {
  bool hasFinishedLaunching = false;

  @override
  void didChangeDependencies() {
    if (!hasFinishedLaunching) {
      /// [configure] is responsible for correctly setting
      /// up local notifications ( and asking for permission if needed) and wiring-up
      /// firebase messaging [onMessage] callback to show fcm messages
      SILFCM().configure(context: context);
      hasFinishedLaunching = true;
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
          // Your application
          ),
    );
  }
}

