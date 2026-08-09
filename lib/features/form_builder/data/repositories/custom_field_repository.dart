import 'package:climb_coach/core/database/database_helper.dart';
import 'package:climb_coach/core/database/tables.dart';
import 'package:climb_coach/features/form_builder/domain/models/custom_field.dart';

class CustomFieldRepository {
  Future<int> insertField(CustomField field) async {
    final db = await DatabaseHelper.instance.database;

    return db.insert(
      Tables.customFields,
      field.toMap(),
    );
  }

  Future<List<CustomField>> getAllFields() async {
    final db = await DatabaseHelper.instance.database;

    final result = await db.query(
      Tables.customFields,
      orderBy: 'display_order ASC',
    );

    return result.map((e) => CustomField.fromMap(e)).toList();
  }

  Future<void> deleteField(String id) async {
    final db = await DatabaseHelper.instance.database;

    await db.delete(
      Tables.customFields,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
