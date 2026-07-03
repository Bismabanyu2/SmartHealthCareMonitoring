import 'package:flutter/material.dart';
import '../widgets/bottom_nav_bar.dart';
import 'home_screen_original.dart';
import 'input_health_screen.dart';
import 'analytics_screen.dart';
import 'reminder_screen.dart';
import 'profile_screen.dart';

class MainAppScreen extends StatefulWidget {
  const MainAppScreen({super.key, this.initialIndex = 0});

  final int initialIndex;

  @override
  State<MainAppScreen> createState() => _MainAppScreenState();
}

class _MainAppScreenState extends State<MainAppScreen> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  Widget getCurrentScreen() {
    switch (_currentIndex) {
      case 0:
        return const HomeScreen();

      case 1:
        return const InputHealthScreen();

      case 2:
        return const AnalyticsScreen();

      case 3:
        return const ReminderScreen();

      case 4:
        return const ProfileScreen();

      default:
        return const HomeScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: getCurrentScreen(),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        screenWidth: screenWidth,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
