import 'package:flutter/material.dart';

class ExpenseFormScreen extends StatelessWidget {
  const ExpenseFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Expense Claim'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Text('Expense claim form'),
        ),
      ),
    );
  }
}
