import 'package:flutter/material.dart';

import '../../../features/dashboard/presentation/pages/dashboard_page.dart';
import '../../../features/athletes/presentation/pages/athlete_list_page.dart';
import '../../../features/movements/presentation/pages/movement_browser_page.dart';
import '../../../features/assessments/presentation/pages/assessment_browser_page.dart';
import '../../../features/sessions/presentation/pages/session_management_page.dart';

import '../eye_bottom_navigation.dart';

class MainNavigationPage extends StatefulWidget {
  const MainNavigationPage({super.key});

  @override
  State<MainNavigationPage> createState() =>
      _MainNavigationPageState();
}

class _MainNavigationPageState
    extends State<MainNavigationPage> {

  int currentIndex = 0;

  late final List<Widget> pages = [

    const DashboardPage(),

    const AthleteListPage(),

    const SessionManagementPage(),

    const MovementBrowserPage(),

    const AssessmentBrowserPage(),

    const Scaffold(
      body: Center(
        child: Text("تنظیمات"),
      ),
    ),

  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: IndexedStack(

        index: currentIndex,

        children: pages,

      ),

      bottomNavigationBar: EyeBottomNavigation(

        currentIndex: currentIndex,

        onTap: (index) {

          setState(() {

            currentIndex = index;

          });

        },

      ),

    );

  }
}