import 'package:flutter/material.dart';

class ExpenseDetailScreen extends StatelessWidget {
  final String expenseId;
  
  const ExpenseDetailScreen({super.key, required this.expenseId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Text('Expense details for: $expenseId'),
        ),
      ),
    );
  }
}
