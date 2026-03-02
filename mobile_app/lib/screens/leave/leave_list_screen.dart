import 'package:flutter/material.dart';

class LeaveListScreen extends StatelessWidget {
  const LeaveListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Leave Applications'),
      ),
      body: const Center(
        child: Text('Leave list screen'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
