import 'package:flutter/material.dart';

class LeaveFormScreen extends StatelessWidget {
  const LeaveFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Apply for Leave'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Text('Leave application form'),
        ),
      ),
    );
  }
}
