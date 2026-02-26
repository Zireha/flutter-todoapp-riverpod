import 'package:flutter/material.dart';
import 'package:todoapp_riverpod/config/theme/my_colors.dart';

class Utils {
  // bisa pake integer value atau string value buat ngambil warna
  // dari prioritas
  static Color labelColor({int? priority, String? priorityName}) {
    if (priority == 1 || priorityName == "rendah") {
      return MyColors.lowPriority;
    } else if (priority == 2 || priorityName == "sedang") {
      return MyColors.mediumPriority;
    } else if (priority == 3 || priorityName == "tinggi") {
      return MyColors.highPriority;
    }
    return MyColors.foreground;
  }
}
