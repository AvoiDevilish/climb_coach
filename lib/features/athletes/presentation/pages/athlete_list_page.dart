import 'package:flutter/material.dart';

class AthleteListPage extends StatelessWidget {
  const AthleteListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ورزشکاران'),
        centerTitle: true,
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, '/athlete/new');
        },
        icon: const Icon(Icons.person_add),
        label: const Text('ثبت ورزشکار'),
      ),

      body: const Padding(
        padding: EdgeInsets.all(16),

        child: Column(
          children: [

            TextField(
              decoration: InputDecoration(
                hintText: 'جستجوی ورزشکار...',
                prefixIcon: Icon(Icons.search),
              ),
            ),

            SizedBox(height: 12),

            Row(
              children: [

                Icon(Icons.filter_alt),

                SizedBox(width: 8),

                Text('فیلترها (به‌زودی)'),

              ],
            ),

            SizedBox(height: 20),

            Expanded(
              child: Center(
                child: Text(
                  'لیست ورزشکاران اینجا نمایش داده خواهد شد.',
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}