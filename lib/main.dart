import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todoapp_riverpod/app/todo_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // await DbHelper().seeder();

  runApp(const ProviderScope(child: TodoApp()));
}
