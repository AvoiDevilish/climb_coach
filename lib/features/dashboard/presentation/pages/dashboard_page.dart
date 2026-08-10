import 'package:flutter/material.dart';

import '../../../athletes/presentation/controllers/athlete_controller.dart';

import '../widgets/dashboard_header.dart';
import '../widgets/dashboard_sessions.dart';
import '../widgets/dashboard_activity.dart';

import '../../../../core/design/app_spacing.dart';


class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() =>
      _DashboardPageState();
}


class _DashboardPageState
    extends State<DashboardPage> {

  final AthleteController controller =
      AthleteController();


  @override
  void initState() {
    super.initState();

    controller.loadAthletes();

    controller.addListener(_refresh);
  }


  void _refresh() {
    if (mounted) {
      setState(() {});
    }
  }


  @override
  void dispose() {

    controller.removeListener(_refresh);

    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text(
          'Eye Club',
        ),
        centerTitle: true,
      ),


      body: ListView(

        padding: const EdgeInsets.all(
          AppSpacing.md,
        ),


        children: [

          const DashboardHeader(),


          const SizedBox(
            height: AppSpacing.lg,
          ),


          const DashboardSessions(),


          const SizedBox(
            height: AppSpacing.lg,
          ),


          const DashboardActivity(),

        ],
      ),
    );
  }
}