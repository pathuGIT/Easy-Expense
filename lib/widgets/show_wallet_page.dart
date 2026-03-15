import 'package:flutter/material.dart';

// ignore: camel_case_types
class showWalletPage extends StatefulWidget {
  const showWalletPage({super.key});

  @override
  State<showWalletPage> createState() => _showWalletPageState();
}

// ignore: camel_case_types
class _showWalletPageState extends State<showWalletPage> {
  
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Column(children: [Text("data")]),
    );
  }
}
