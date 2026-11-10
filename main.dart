import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'core/theme.dart';
import 'providers/pregnancy_provider.dart';
import 'screens/onboarding_screen.dart';
import 'screens/home_screen.dart';
import 'screens/calendar_screen.dart';
import 'screens/vitals_screen.dart';
import 'screens/education_screen.dart';
import 'screens/profile_screen.dart';

import 'services/notification_service.dart';
import 'models/appointment.dart';
import 'models/kick_log.dart';
import 'models/vitals.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://xaasawgbpslrbibtgpxo.supabase.co',
    publishableKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InhhYXNhd2dicHNscmJpYnRncHhvIiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODQwMTE3MDYsImV4cCI6MjA5OTU4NzcwNn0.i4gF51Tnb9j8d5MWgMyDcQR48BxhtjtJaKaP8Q6-Y8g',
  );
  await Hive.initFlutter();

  Hive.registerAdapter(AppointmentAdapter());
  Hive.registerAdapter(VitalsAdapter());
  Hive.registerAdapter(KickLogAdapter());

  await Hive.openBox<Appointment>('appointments_box');
  await Hive.openBox<Vitals>('vitals_box');
  await Hive.openBox<KickLog>('kick_log_box');

  await NotificationService.init();

  runApp(
    ChangeNotifierProvider(
      create: (context) => PregnancyProvider(),
      child: const AnteCareApp(),
    ),
  );
}

// ==================== AUTH GATE (currently bypassed for local testing) ====================
// To re-enable real Supabase auth, change `home: const InitializerGate()`
// in AnteCareApp below back to `home: const AuthGate()`.

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AuthState>(
      stream: Supabase.instance.client.auth.onAuthStateChange,
      builder: (context, snapshot) {
        final session = Supabase.instance.client.auth.currentSession;

        if (session == null) {
          return const LoginScreen();
        }

        return const InitializerGate();
      },
    );
  }
}

class AnteCareApp extends StatelessWidget {
  const AnteCareApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AnteCare',
      theme: AnteCareTheme.lightTheme,
      darkTheme: AnteCareTheme.darkTheme,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      home: const InitializerGate(), // ← BYPASS: skips AuthGate/login entirely
    );
  }
}

class InitializerGate extends StatelessWidget {
  const InitializerGate({super.key});

  @override
  Widget build(BuildContext context) {
    final pregnancy = Provider.of<PregnancyProvider>(context);

    if (pregnancy.isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (!pregnancy.isSetupComplete) {
      return const OnboardingScreen();
    }

    return const MainNavigationShell();
  }
}

class MainNavigationShell extends StatefulWidget {
  const MainNavigationShell({super.key});

  @override
  State<MainNavigationShell> createState() => _MainNavigationShellState();
}

class _MainNavigationShellState extends State<MainNavigationShell> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const CalendarScreen(),
    const VitalsScreen(),
    const EducationScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() => _currentIndex = index);
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_month_rounded), label: 'Appointments'),
          BottomNavigationBarItem(icon: Icon(Icons.monitor_heart_rounded), label: 'Vitals'),
          BottomNavigationBarItem(icon: Icon(Icons.menu_book_rounded), label: 'Education'),
          BottomNavigationBarItem(icon: Icon(Icons.settings_rounded), label: 'Settings'),
        ],
      ),
    );
  }
}