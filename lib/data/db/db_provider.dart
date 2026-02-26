import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todoapp_riverpod/data/db/db_helper.dart';

// ini sebagai bridge kalo ada file yang mau minta
// data ke db
final dbProvider = Provider<DbHelper>((ref) {
  return DbHelper();
});
