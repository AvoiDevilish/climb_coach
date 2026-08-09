import 'package:flutter/material.dart';

import '../../domain/models/session.dart';
import '../../domain/models/session_summary.dart';
import '../../data/repositories/session_summary_repository.dart';

import '../../../session_members/presentation/widgets/session_member_list.dart';
import '../../../session_members/presentation/pages/add_session_member_page.dart';

import '../../../../core/utils/number_helper.dart';

class SessionDetailPage extends StatefulWidget {
  final Session session;

  const SessionDetailPage({
    super.key,
    required this.session,
  });

  @override
  State<SessionDetailPage> createState() =>
      _SessionDetailPageState();
}

class _SessionDetailPageState
    extends State<SessionDetailPage> {

  int refreshKey = 0;

  final SessionSummaryRepository summaryRepository =
      SessionSummaryRepository();


  SessionSummary? summary;

  Future loadSummary() async {

    if (widget.session.id == null) return;


    final result =
        await summaryRepository.getSummary(
          widget.session.id!,
        );


    if (mounted) {

      setState(() {

        summary = result;

      });

    }

  }

  @override
  void initState() {

    super.initState();

    loadSummary();

  }

  @override
  Widget build(BuildContext context) {

    final session = widget.session;

    return Scaffold(

      appBar: AppBar(
        title: Text(session.title),
      ),

      body: Padding(

        padding: const EdgeInsets.all(16),

        child: Column(

          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            Text(
              session.title,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            Text(
              '${session.startTime} تا ${session.endTime}',
            ),

            const SizedBox(height: 12),

            Column(

              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [

                Text(
                  'ظرفیت کل: ${NumberHelper.toPersian(
                    session.capacity,
                  )} نفر',
                ),


                if (summary != null) ...[

                  const SizedBox(
                    height: 6,
                  ),


                  Text(
                    'اعضای فعال: ${NumberHelper.toPersian(
                      summary!.activeMembers,
                    )} نفر',
                  ),


                  const SizedBox(
                    height: 6,
                  ),


                  Text(
                    'ظرفیت باقی‌مانده: ${NumberHelper.toPersian(
                      summary!.availableCapacity,
                    )} نفر',
                  ),

                ],

              ],

            ),

            const SizedBox(height: 24),

            const Text(
              'ورزشکاران',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            SizedBox(

              width: double.infinity,

              child: ElevatedButton.icon(

                icon: const Icon(
                  Icons.person_add,
                ),

                label: const Text(
                  'افزودن ورزشکار',
                ),

                onPressed: session.id == null
                    ? null
                    : () async {

                        await Navigator.push(

                          context,

                          MaterialPageRoute(

                            builder: (_) =>
                                AddSessionMemberPage(
                              sessionId:
                                  session.id!,
                            ),

                          ),

                        );

                        await loadSummary();

                        if (mounted) {

                          setState(() {

                            refreshKey++;

                          });

                        }

                      },

              ),

            ),

            const SizedBox(height: 12),

            Expanded(

              child: session.id == null

                  ? const Center(
                      child: Text(
                        'شناسه سانس نامعتبر است',
                      ),
                    )

                  : SessionMemberList(

                      key: ValueKey(refreshKey),

                      sessionId: session.id!,

                      capacity: session.capacity,

                    ),

            ),

          ],

        ),

      ),

    );

  }
}