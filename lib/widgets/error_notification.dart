import 'package:flutter/material.dart';

class ErrorNotification extends StatelessWidget {
  final String error;
  const ErrorNotification({super.key, required this.error});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Icon(Icons.error)],
      ),
    );
  }
}
