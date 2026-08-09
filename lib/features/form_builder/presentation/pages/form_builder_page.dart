import 'package:flutter/material.dart';
import '../widgets/add_field_dialog.dart';

class FormBuilderPage extends StatelessWidget {
  const FormBuilderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("مدیریت فیلدها"),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) => const AddFieldDialog(),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: const Center(
        child: Text(
          "هنوز فیلدی تعریف نشده است.",
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
