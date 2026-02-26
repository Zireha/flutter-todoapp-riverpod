import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todoapp_riverpod/config/fonts/my_fonts.dart';
import 'package:todoapp_riverpod/config/theme/my_colors.dart';
import 'package:todoapp_riverpod/widgets/bottom_sheet_nav.dart';
import 'package:todoapp_riverpod/widgets/home_screen_body.dart';
import 'package:todoapp_riverpod/widgets/priority_picker.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: MyColors.background,
      appBar: AppBar(
        backgroundColor: MyColors.foreground,
        title: Text(
          "Todo App",
          style: MyFonts.primaryDisplayLarge.copyWith(color: Colors.white),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: MyColors.foreground,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (context) => BottomSheetNav(isEditing: false,),
          );
        },
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // header
              Text(
                "Halo, user!",
                style: MyFonts.primaryDisplayLarge.copyWith(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4),
              Text(
                "Apa aja aktivitasmu hari ini?",
                style: MyFonts.secondaryTitleMedium.copyWith(fontSize: 16),
              ),

              // chip button
              SizedBox(height: 24),
              Text(
                "Semua Tugas",
                style: MyFonts.primaryDisplayLarge.copyWith(),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: PriorityPicker(),
              ),

              // body
              SizedBox(height: 8),
              HomeScreenBody(),
            ],
          ),
        ),
      ),
    );
  }
}
