import 'package:flutter/material.dart';

import '../../domain/models/athlete.dart';

class AthleteHealthCard extends StatelessWidget {
  final Athlete athlete;
  final Future<void> Function(Athlete) onChanged;

  const AthleteHealthCard({
    super.key,
    required this.athlete,
    required this.onChanged,
  });

  Future<void> _edit(BuildContext context) async {
    var status = athlete.healthStatus == 'injured' ? 'injured' : 'healthy';
    final areas = {...athlete.injuryAreas};
    DateTime? recovery = athlete.recoveryUntil;

    const injuryOptions = ['شانه', 'آرنج', 'مچ دست', 'انگشتان', 'کمر', 'زانو', 'مچ پا'];

    await showDialog<void>(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('وضعیت سلامت ورزشکار'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SegmentedButton<String>(
                  segments: const [
                    ButtonSegment(value: 'healthy', label: Text('سالم'), icon: Icon(Icons.check_circle_outline)),
                    ButtonSegment(value: 'injured', label: Text('مصدوم'), icon: Icon(Icons.healing_outlined)),
                  ],
                  selected: {status},
                  onSelectionChanged: (value) => setState(() => status = value.first),
                ),
                if (status == 'injured') ...[
                  const SizedBox(height: 18),
                  const Text('ناحیه آسیب‌دیده', style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: injuryOptions.map((area) => FilterChip(
                      label: Text(area),
                      selected: areas.contains(area),
                      onSelected: (selected) => setState(() {
                        selected ? areas.add(area) : areas.remove(area);
                      }),
                    )).toList(),
                  ),
                  const SizedBox(height: 18),
                  OutlinedButton.icon(
                    onPressed: () async {
                      final picked = await showDatePicker(
                        context: context,
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(const Duration(days: 3650)),
                        initialDate: recovery != null && recovery!.isAfter(DateTime.now()) ? recovery! : DateTime.now().add(const Duration(days: 30)),
                      );
                      if (picked != null) setState(() => recovery = picked);
                    },
                    icon: const Icon(Icons.calendar_month),
                    label: Text(recovery == null ? 'تعیین زمان بهبودی' : 'بهبودی تا ${recovery!.year}/${recovery!.month}/${recovery!.day}'),
                  ),
                  if (recovery != null)
                    TextButton(
                      onPressed: () => setState(() => recovery = null),
                      child: const Text('حذف تاریخ بهبودی'),
                    ),
                ],
              ],
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(dialogContext), child: const Text('انصراف')),
            FilledButton(
              onPressed: () async {
                final updated = Athlete(
                  id: athlete.id,
                  firstName: athlete.firstName,
                  lastName: athlete.lastName,
                  gender: athlete.gender,
                  age: athlete.age,
                  height: athlete.height,
                  weight: athlete.weight,
                  profileImage: athlete.profileImage,
                  healthStatus: status,
                  injuryAreas: status == 'injured' ? areas.toList() : const [],
                  injurySince: status == 'injured' ? (athlete.injurySince ?? DateTime.now()) : null,
                  recoveryUntil: status == 'injured' ? recovery : null,
                  createdAt: athlete.createdAt,
                  updatedAt: DateTime.now(),
                  isDeleted: athlete.isDeleted,
                );
                await onChanged(updated);
                if (dialogContext.mounted) Navigator.pop(dialogContext);
              },
              child: const Text('ذخیره'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final expired = athlete.healthStatus == 'injured' &&
        athlete.recoveryUntil != null &&
        !athlete.recoveryUntil!.isAfter(DateTime.now());
    final injured = athlete.healthStatus == 'injured' && !expired;

    return Card(
      margin: const EdgeInsets.only(top: 12),
      child: ListTile(
        leading: Icon(injured ? Icons.healing : Icons.health_and_safety, color: injured ? Colors.orange : Colors.green),
        title: Text(expired ? 'نیازمند تعیین وضعیت مجدد' : (injured ? 'مصدوم' : 'سالم'), style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: expired
            ? const Text('مدت بهبودی تمام شده است؛ قبل از تخصیص تمرین، وضعیت سلامت دوباره تعیین شود.')
            : injured
                ? Text('آسیب: ${athlete.injuryAreas.isEmpty ? 'نامشخص' : athlete.injuryAreas.join('، ')}${athlete.recoveryUntil == null ? '' : '\nبهبودی تا: ${athlete.recoveryUntil!.year}/${athlete.recoveryUntil!.month}/${athlete.recoveryUntil!.day}'}')
                : const Text('تمرین‌های عمومی مجاز هستند.'),
        isThreeLine: injured,
        trailing: const Icon(Icons.edit_outlined),
        onTap: () => _edit(context),
      ),
    );
  }
}
