import 'package:bytebank/screens/transfers/list.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const BybankApp());
}

class BybankApp extends StatelessWidget {
  const BybankApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bytebank',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blueGrey,
          brightness: Brightness.dark,
        )
            .copyWith(
              background: Colors.black,
            )
            .copyWith(
              primary: Colors.blueAccent,
              secondary: Colors.white,
            ),
      ),
      home: TransferList(),
    );
  }
}
