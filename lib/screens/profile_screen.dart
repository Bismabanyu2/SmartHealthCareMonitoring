import 'package:flutter/material.dart';
import '../utils/colors.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/health_data_model.dart';
import '../services/firestore_service.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final FirestoreService _firestoreService = FirestoreService();

  HealthData? latestHealthData;

  String fullName = "";
  String email = "";
  String role = "";

  bool isLoading = true;

  //==========================
  // initState
  //==========================
  @override
  void initState() {
    super.initState();
    loadData();
  }

  //==========================
  // Ambil data dari Firebase
  //==========================
  Future<void> loadData() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    final userDoc = await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .get();

    final data = await _firestoreService.getLatestHealthData();

    if (mounted) {
      setState(() {
        fullName = userDoc["fullName"];
        email = userDoc["email"];
        role = userDoc["role"];

        latestHealthData = data;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.05,
                vertical: screenHeight * 0.03,
              ),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColors.blueGradientStart,
                    AppColors.blueGradientEnd,
                  ],
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Profile',
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: screenWidth * 0.055,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        width: screenWidth * 0.12,
                        height: screenWidth * 0.12,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.3),
                          borderRadius: BorderRadius.circular(
                            screenWidth * 0.03,
                          ),
                        ),
                        child: Icon(
                          Icons.settings,
                          color: AppColors.white,
                          size: screenWidth * 0.06,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  // User info card
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.04,
                      vertical: screenHeight * 0.02,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(screenWidth * 0.04),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.2),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: screenWidth * 0.15,
                          height: screenWidth * 0.15,
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.1),
                                blurRadius: 5,
                              ),
                            ],
                          ),
                          child: Icon(
                            Icons.person,
                            color: AppColors.primaryBlue,
                            size: screenWidth * 0.1,
                          ),
                        ),
                        SizedBox(width: screenWidth * 0.03),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                fullName.isEmpty ? "Loading..." : fullName,
                                style: TextStyle(
                                  color: AppColors.white,
                                  fontSize: screenWidth * 0.04,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                email,
                                style: TextStyle(
                                  color: Colors.white.withValues(alpha: 0.8),
                                  fontSize: screenWidth * 0.028,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Body
            Padding(
              padding: EdgeInsets.all(screenWidth * 0.04),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Achievements
                  Text(
                    'Achievements',
                    style: TextStyle(
                      color: AppColors.darkText,
                      fontSize: screenWidth * 0.04,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _AchievementBadge(
                        icon: Icons.calendar_today,
                        label: '30-Day\nStreak',
                        color: AppColors.primaryBlue,
                        screenWidth: screenWidth,
                        screenHeight: screenHeight,
                      ),
                      _AchievementBadge(
                        icon: Icons.trending_up,
                        label: 'Healthy\nMileage',
                        color: AppColors.greenAccent,
                        screenWidth: screenWidth,
                        screenHeight: screenHeight,
                      ),
                      _AchievementBadge(
                        icon: Icons.lock_clock,
                        label: 'Data Logger',
                        color: AppColors.purpleAccent,
                        screenWidth: screenWidth,
                        screenHeight: screenHeight,
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  // Your Progress
                  Text(
                    'Your Progress',
                    style: TextStyle(
                      color: AppColors.darkText,
                      fontSize: screenWidth * 0.04,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.04,
                      vertical: screenHeight * 0.02,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(screenWidth * 0.03),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 5,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        _ProgressItem(
                          label: 'Total Health Records',
                          value: '247',
                          screenWidth: screenWidth,
                          screenHeight: screenHeight,
                        ),
                        Divider(
                          color: AppColors.lightGrey,
                          height: screenHeight * 0.03,
                        ),
                        _ProgressItem(
                          label: 'Current Streak',
                          value: '7 days',
                          badge: '🔥',
                          screenWidth: screenWidth,
                          screenHeight: screenHeight,
                        ),
                        Divider(
                          color: AppColors.lightGrey,
                          height: screenHeight * 0.03,
                        ),
                        _ProgressItem(
                          label: 'Health Score',
                          value: '85/100',
                          screenWidth: screenWidth,
                          screenHeight: screenHeight,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  // Health History
                  Text(
                    'Health History',
                    style: TextStyle(
                      color: AppColors.darkText,
                      fontSize: screenWidth * 0.04,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  _SettingsTile(
                    icon: Icons.history,
                    title: 'View past records',
                    screenWidth: screenWidth,
                    screenHeight: screenHeight,
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  // Account Settings
                  Text(
                    'Account Settings',
                    style: TextStyle(
                      color: AppColors.darkText,
                      fontSize: screenWidth * 0.04,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  _SettingsTile(
                    icon: Icons.person,
                    title: 'Manage your account',
                    screenWidth: screenWidth,
                    screenHeight: screenHeight,
                  ),
                  SizedBox(height: screenHeight * 0.015),
                  _SettingsTile(
                    icon: Icons.notifications_outlined,
                    title: 'Notification Settings',
                    subtitle: 'Customize alerts',
                    screenWidth: screenWidth,
                    screenHeight: screenHeight,
                  ),
                  SizedBox(height: screenHeight * 0.015),
                  _SettingsTile(
                    icon: Icons.dark_mode_outlined,
                    title: 'Dark Mode',
                    subtitle: 'Easy on the eyes',
                    screenWidth: screenWidth,
                    screenHeight: screenHeight,
                  ),
                  SizedBox(height: screenHeight * 0.015),
                  _SettingsTile(
                    icon: Icons.help_outline,
                    title: 'Help & Support',
                    subtitle: 'Get support',
                    screenWidth: screenWidth,
                    screenHeight: screenHeight,
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  // Logout button
                  SizedBox(
                    width: double.infinity,
                    height: screenHeight * 0.065,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            screenWidth * 0.03,
                          ),
                        ),
                        elevation: 0,
                      ),
                      onPressed: () {},
                      icon: const Icon(Icons.logout),
                      label: Text(
                        'Logout',
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: screenWidth * 0.035,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AchievementBadge extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final double screenWidth;
  final double screenHeight;

  const _AchievementBadge({
    required this.icon,
    required this.label,
    required this.color,
    required this.screenWidth,
    required this.screenHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.01),
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.02,
          vertical: screenHeight * 0.02,
        ),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(screenWidth * 0.03),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 5,
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              width: screenWidth * 0.12,
              height: screenWidth * 0.12,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: screenWidth * 0.06),
            ),
            SizedBox(height: screenHeight * 0.01),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.darkText,
                fontSize: screenWidth * 0.026,
                fontWeight: FontWeight.w600,
                height: 1.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProgressItem extends StatelessWidget {
  final String label;
  final String value;
  final String? badge;
  final double screenWidth;
  final double screenHeight;

  const _ProgressItem({
    required this.label,
    required this.value,
    this.badge,
    required this.screenWidth,
    required this.screenHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                color: AppColors.greyText,
                fontSize: screenWidth * 0.032,
              ),
            ),
            SizedBox(height: screenHeight * 0.005),
            Text(
              value,
              style: TextStyle(
                color: AppColors.darkText,
                fontSize: screenWidth * 0.04,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        if (badge != null)
          Text(badge!, style: TextStyle(fontSize: screenWidth * 0.045)),
      ],
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final double screenWidth;
  final double screenHeight;

  const _SettingsTile({
    required this.icon,
    required this.title,
    this.subtitle,
    required this.screenWidth,
    required this.screenHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.04,
        vertical: screenHeight * 0.015,
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(screenWidth * 0.03),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 5),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: screenWidth * 0.08,
            height: screenWidth * 0.08,
            decoration: BoxDecoration(
              color: AppColors.primaryBlue.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: AppColors.primaryBlue,
              size: screenWidth * 0.04,
            ),
          ),
          SizedBox(width: screenWidth * 0.03),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: AppColors.darkText,
                    fontSize: screenWidth * 0.032,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (subtitle != null)
                  Text(
                    subtitle!,
                    style: TextStyle(
                      color: AppColors.greyText,
                      fontSize: screenWidth * 0.026,
                    ),
                  ),
              ],
            ),
          ),
          Icon(
            Icons.arrow_forward_ios,
            color: AppColors.greyText,
            size: screenWidth * 0.04,
          ),
        ],
      ),
    );
  }
}
