import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp, // 橫向模式（設備右側向上）
    DeviceOrientation.portraitDown, // 橫向模式（設備左側向上）
  ]).then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Artboard? riveArtboard;
  SMITrigger? isWritingTriggerPressed;
  SMITrigger? isLocationTriggerPressed;

  late StateMachineController _controller;

  void onInit(Artboard artboard) {
    _controller =
        StateMachineController.fromArtboard(
          artboard,
          artboard.stateMachines.isNotEmpty
              ? artboard.stateMachines.first.name
              : '',
        )!;

    artboard.addController(_controller);
    _controller.addEventListener(onRiveEvent);
  }

  void onRiveEvent(RiveEvent event) {
    // Access custom properties defined on the event
    log('onRiveEvent');
    print(event.properties);
    // var rating = event.properties['rating'] as double;
    // // Schedule the setState for the next frame, as an event can be
    // // triggered during a current frame update
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   setState(() {
    //     ratingValue = 'Rating: $rating';
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    return RiveAnimation.asset(
      'assets/interface6.riv',
      onInit: onInit,
      fit: BoxFit.contain,
    );
  }
}
