import 'package:flutter/material.dart';

import '../features/athletes/presentation/pages/athlete_basic_info_page.dart';
import '../features/athletes/presentation/pages/athlete_form_page.dart';
import '../features/athletes/presentation/pages/athlete_profile_page.dart';

import '../features/movements/presentation/pages/movement_browser_page.dart';
import '../features/movements/presentation/pages/movement_detail_page.dart';
import '../features/movements/presentation/pages/movement_list_page.dart';
import '../features/movements/presentation/pages/movement_performance_form_page.dart';

import '../features/assessments/presentation/pages/assessment_browser_page.dart';
import '../features/assessments/presentation/pages/assessment_detail_page.dart';
import '../features/assessments/presentation/pages/assessment_execution_page.dart';

import '../features/sessions/presentation/pages/create_session_page.dart';
import '../features/sessions/presentation/pages/today_sessions_page.dart';

import '../core/navigation/pages/main_navigation_page.dart';

import '../features/splash/presentation/pages/splash_page.dart';

class AppRoutes {
  static final Map<String, WidgetBuilder> routes = {
    '/': (context) =>
        const SplashPage(),

    '/dashboard': (context) =>
        const MainNavigationPage(),

    '/athletes': (context) =>
        const AthleteFormPage(),

    '/athlete/new': (context) =>
        const AthleteFormPage(),

    '/athlete/profile': (context) =>
        const AthleteProfilePage(),

    '/athlete/basic-info': (context) =>
        const AthleteBasicInfoPage(),

    '/movements': (context) =>
        const MovementBrowserPage(),

    '/movements/list': (context) =>
        const MovementListPage(),

    '/movement/detail': (context) =>
        const MovementDetailPage(),

    '/movement/performance': (context) =>
        const MovementPerformanceFormPage(),

    '/assessments': (context) =>
        const AssessmentBrowserPage(),

    '/assessment/detail': (context) =>
        const AssessmentDetailPage(),

    '/assessment/execution': (context) =>
        const AssessmentExecutionPage(),

    '/session/create': (context) =>
        const CreateSessionPage(),

    '/sessions/today': (context) =>
        const TodaySessionsPage(),
  };
}