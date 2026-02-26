import 'package:flutter/material.dart';
import 'package:todoapp_riverpod/config/fonts/my_fonts.dart';
import 'package:todoapp_riverpod/config/theme/my_colors.dart';
import 'package:todoapp_riverpod/enums/priorities.dart';
import 'package:todoapp_riverpod/utils/utils.dart';

class FormSheet extends StatefulWidget {
  final TextEditingController textTitleController;
  final TextEditingController textDetailController;
  final TextEditingController textDateController;
  final TextEditingController textTimeController;
  final Function(Priorities) onPriorityChanged;
  final String title;
  final String buttonText;
  final Function()? onTap;
  Priorities? selectedPriority;

  FormSheet({
    super.key,
    required this.textTitleController,
    required this.textDetailController,
    required this.textDateController,
    required this.textTimeController,
    required this.onPriorityChanged,
    required this.title,
    required this.buttonText,
    required this.onTap,
    this.selectedPriority,
  });

  @override
  State<FormSheet> createState() => _FormSheetState();
}

class _FormSheetState extends State<FormSheet> {
  DateTime? selectedDate;
  DateTime currentDate = DateTime.now();
  TimeOfDay currentTime = TimeOfDay.now();

  Future<void> selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2026),
      lastDate: DateTime(2050),
    );

    setState(() {
      widget.textDateController.text = pickedDate == null
          ? "${currentDate.day}/${currentDate.month}/${currentDate.year}"
          : "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
    });
  }

  Future<void> selectTime() async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    setState(() {
      widget.textTimeController.text = pickedTime == null
          ? "${currentTime.hour.toString().padLeft(2, "0")} : ${currentTime.minute.toString().padLeft(2, "0")}"
          : "${pickedTime.hour.toString().padLeft(2, "0")} : ${pickedTime.minute.toString().padLeft(2, "0")}";
    });
  }

  void onTextChanged() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    widget.textTitleController.addListener(onTextChanged);
    widget.textDetailController.addListener(onTextChanged);

    final formattedDate =
        "${currentDate.day}/${currentDate.month}/${currentDate.year}";

    final formattedTime =
        "${currentDate.hour.toString().padLeft(2, "0")}:${currentDate.minute.toString().padLeft(2, "0")}";

    widget.textDateController.text = formattedDate;
    widget.textTimeController.text = formattedTime;
  }

  @override
  void dispose() {
    widget.textTitleController.removeListener(onTextChanged);
    widget.textDetailController.removeListener(onTextChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isValid =
        widget.textTitleController.text.trim().isNotEmpty &&
        widget.textDetailController.text.trim().isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          widget.title,
          style: MyFonts.primaryDisplayLarge.copyWith(
            color: MyColors.foreground,
            fontWeight: FontWeight.w800,
          ),
        ),
        SizedBox(height: 16),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Judul Tugas", style: MyFonts.primaryTitleLarge),
            const SizedBox(height: 4),
            TextFormField(
              controller: widget.textTitleController,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey.shade500),
                ),
                fillColor: Colors.white,
                filled: true,
              ),
              style: MyFonts.secondaryDisplaySmall,
            ),
          ],
        ),
        SizedBox(height: 8),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Detail Tugas", style: MyFonts.primaryTitleLarge),
            const SizedBox(height: 4),
            TextFormField(
              maxLines: 4,
              controller: widget.textDetailController,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey.shade500),
                ),
                fillColor: Colors.white,
                filled: true,
              ),
              style: MyFonts.secondaryDisplaySmall,
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // tanggal
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Tanggal", style: MyFonts.primaryTitleLarge),
                  const SizedBox(height: 4),
                  TextFormField(
                    readOnly: true,
                    controller: widget.textDateController,
                    style: MyFonts.secondaryDisplaySmall,
                    onTap: () => selectDate(),
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.grey.shade500),
                      ),
                      fillColor: Colors.white,
                      filled: true,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),

            // waktu
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Waktu", style: MyFonts.primaryTitleLarge),
                  const SizedBox(height: 4),
                  TextFormField(
                    readOnly: true,
                    controller: widget.textTimeController,
                    style: MyFonts.secondaryDisplaySmall,
                    onTap: () => selectTime(),
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.grey.shade500),
                      ),
                      fillColor: Colors.white,
                      filled: true,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 8),

        // prioritas
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Prioritas", style: MyFonts.primaryTitleLarge),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ...Priorities.values.where((p) => p != Priorities.semua).map((
                  priority,
                ) {
                  return GestureDetector(
                    onTap: () {
                      widget.onPriorityChanged(priority);
                    },
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 100),
                      opacity: widget.selectedPriority == priority ? 1.0 : 0.4,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Utils.labelColor(priorityName: priority.name),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 28,
                          vertical: 8,
                        ),
                        child: Text(
                          "${priority.name[0].toUpperCase()}${priority.name.substring(1)}",
                          style: MyFonts.secondaryDisplaySmall.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ],
            ),
          ],
        ),
        SizedBox(height: 16),

        // tombol tambah
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 2,
          children: [
            isValid
                ? SizedBox()
                : Text(
                    "Judul, detail, prioritas harus diisi dan dipilih",
                    style: MyFonts.secondaryDisplaySmall.copyWith(
                      color: Colors.red,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.left,
                  ),
            GestureDetector(
              onTap: isValid ? widget.onTap : null,
              child: Container(
                width: double.maxFinite,
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: isValid
                      ? MyColors.foreground
                      : MyColors.foreground.withAlpha(100),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  widget.buttonText,
                  style: MyFonts.secondaryDisplaySmall.copyWith(
                    color: MyColors.background,
                    fontWeight: FontWeight.w900,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
