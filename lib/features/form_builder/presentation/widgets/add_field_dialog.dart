import 'package:flutter/material.dart';

class AddFieldDialog extends StatefulWidget {
  const AddFieldDialog({super.key});

  @override
  State<AddFieldDialog> createState() => _AddFieldDialogState();
}

class _AddFieldDialogState extends State<AddFieldDialog> {
  final titleController = TextEditingController();

  String fieldType = 'text';

  bool requiredField = false;

  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("افزودن فیلد جدید"),

      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: "نام فیلد",
              ),
            ),

            const SizedBox(height: 16),

            DropdownButtonFormField<String>(
              initialValue: fieldType,
              decoration: const InputDecoration(
                labelText: "نوع فیلد",
              ),
              items: const [

                DropdownMenuItem(
                  value: "text",
                  child: Text("متن"),
                ),

                DropdownMenuItem(
                  value: "number",
                  child: Text("عدد"),
                ),

                DropdownMenuItem(
                  value: "date",
                  child: Text("تاریخ"),
                ),

                DropdownMenuItem(
                  value: "boolean",
                  child: Text("بله / خیر"),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  fieldType = value!;
                });
              },
            ),

            const SizedBox(height: 16),

            CheckboxListTile(
              value: requiredField,
              title: const Text("فیلد اجباری"),
              onChanged: (value) {
                setState(() {
                  requiredField = value ?? false;
                });
              },
            ),
          ],
        ),
      ),

      actions: [

        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("انصراف"),
        ),

        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("ذخیره"),
        ),
      ],
    );
  }
}
