import 'package:flutter/material.dart';

class DoRealization extends StatefulWidget {
  const DoRealization({super.key});

  @override
  State<DoRealization> createState() => _DoRealizationState();
}

class _DoRealizationState extends State<DoRealization> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF3A1078),
        elevation: 0.0,
        title: Text('DO Realization'),
      ),
      body: ListView(
        children: [],
      ),
    );
  }
}
