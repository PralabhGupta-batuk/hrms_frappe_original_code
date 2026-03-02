import 'package:flutter/material.dart';

class LeaveDetailScreen extends StatelessWidget {
  final String leaveId;
  
  const LeaveDetailScreen({super.key, required this.leaveId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Leave Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Text('Leave details for: $leaveId'),
        ),
      ),
    );
  }
}
