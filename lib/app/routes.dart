import '../features/athletes/presentation/pages/athlete_form_page.dart';
import '../features/splash/presentation/pages/splash_page.dart';
import '../features/athletes/presentation/pages/athlete_profile_page.dart';
import '../features/movements/presentation/pages/movement_browser_page.dart';
import '../features/movements/presentation/pages/movement_list_page.dart';
import '../features/assessments/presentation/pages/assessment_browser_page.dart';
import '../features/assessments/presentation/pages/assessment_detail_page.dart';
import '../features/assessments/presentation/pages/assessment_execution_page.dart';
import '../features/sessions/presentation/pages/create_session_page.dart';
import '../core/navigation/pages/main_navigation_page.dart';

class AppRoutes {
  static final routes = {
    '/': (context) => const SplashPage(),

    '/dashboard': (context) => const MainNavigationPage(),

    '/athletes': (context) => const AthleteFormPage(),

    '/athlete/new': (context) => const AthleteFormPage(),

    '/athlete/profile': (context) => const AthleteProfilePage(),

    '/movements': (context) => const MovementBrowserPage(),

    '/movements/list': (context) => const MovementListPage(),

    "/assessments": (_) => const AssessmentBrowserPage(),

    '/assessment/detail': (_) => const AssessmentDetailPage(),

    '/assessment/execution': (_) => const AssessmentExecutionPage(),

    '/session/create': (context) => const CreateSessionPage(),
  };
}