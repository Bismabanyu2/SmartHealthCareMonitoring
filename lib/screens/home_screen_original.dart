import 'package:flutter/material.dart';
import '../utils/colors.dart';
import 'main_app_screen.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/health_data_model.dart';
import '../services/firestore_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirestoreService _firestoreService = FirestoreService();

  HealthData? latestHealthData;

  String fullName = "";
  String email = "";
  String role = "";

  String healthTitle = "";
  String healthMessage = "";
  Color healthColor = Colors.green;

  String healthTip = "";
  IconData healthIcon = Icons.favorite;

  bool isLoading = true;
  Future<void> loadData() async {
    try {
      print("LOAD DATA MULAI");

      setState(() {
        isLoading = true;
      });

      final uid = FirebaseAuth.instance.currentUser!.uid;
      print("UID HOME = $uid");

      final userDoc = await FirebaseFirestore.instance
          .collection("users")
          .doc(uid)
          .get();

      print("USER BERHASIL");

      final data = await _firestoreService.getLatestHealthData();

      print("HEALTH BERHASIL");

      print(data);

      if (!mounted) return;

      setState(() {
        fullName = userDoc["fullName"];
        email = userDoc["email"];
        role = userDoc["role"];
        latestHealthData = data;
        analyzeHealth();
        isLoading = false;
      });

      print("SETSTATE BERHASIL");
    } catch (e, s) {
      print("ERROR LOAD DATA");
      print(e);
      print(s);
    }
  }

  void analyzeHealth() {
    if (latestHealthData == null) return;

    final heartRate = int.tryParse(latestHealthData!.heartRate) ?? 0;

    final systolic = int.tryParse(latestHealthData!.systolic) ?? 0;

    final diastolic = int.tryParse(latestHealthData!.diastolic) ?? 0;

    final temperature = double.tryParse(latestHealthData!.temperature) ?? 0;

    final weight = double.tryParse(latestHealthData!.weight) ?? 0;

    // Default
    healthTitle = "All Systems Normal";
    healthMessage = "Your health metrics are looking great!";
    healthColor = Colors.green;

    healthTip =
        "Maintain a balanced diet, exercise regularly, sleep at least 7–8 hours, and drink enough water every day.";

    healthIcon = Icons.favorite;

    if (temperature >= 38) {
      healthTitle = "Possible Fever";
      healthMessage = "Your body temperature is above normal.";
      healthColor = Colors.red;
      healthIcon = Icons.thermostat;

      healthTip =
          "Drink plenty of water, rest well, and seek medical attention if the fever continues.";
    }

    if (heartRate > 100) {
      healthTitle = "High Heart Rate";
      healthMessage = "Your heart rate is above normal.";
      healthColor = Colors.orange;
      healthIcon = Icons.monitor_heart;

      healthTip =
          "Take a short rest, avoid caffeine, stay hydrated, and monitor your heart rate again after 15 minutes.";
    }

    if (systolic >= 140 || diastolic >= 90) {
      healthTitle = "High Blood Pressure";
      healthMessage = "Please monitor your blood pressure.";
      healthColor = Colors.red;

      healthIcon = Icons.bloodtype;

      healthTip =
          "Reduce salty foods, avoid stress, drink enough water, and measure your blood pressure again later.";
    }

    if (weight < 45) {
      healthTitle = "Low Body Weight";
      healthMessage = "Consider improving your nutrition.";
      healthColor = Colors.amber;

      healthIcon = Icons.restaurant;

      healthTip =
          "Increase protein intake, eat nutritious meals regularly, and consult a nutritionist if necessary.";
    }

    if ((heartRate > 100 && systolic >= 140) || temperature >= 39) {
      healthTitle = "Critical Condition";
      healthMessage = "Multiple health indicators are abnormal.";
      healthColor = Colors.red;
      healthIcon = Icons.warning_amber;

      healthTip =
          "Please seek immediate medical attention or visit the nearest healthcare facility.";
    }
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hello, $fullName',
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: screenWidth * 0.055,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Wednesday, May 20',
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.8),
                              fontSize: screenWidth * 0.032,
                            ),
                          ),
                        ],
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
                          Icons.notifications_outlined,
                          color: AppColors.white,
                          size: screenWidth * 0.06,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  // Health Status Card
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.04,
                      vertical: screenHeight * 0.02,
                    ),
                    decoration: BoxDecoration(
                      color: healthColor,
                      borderRadius: BorderRadius.circular(screenWidth * 0.04),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.heart_broken,
                          color: AppColors.white,
                          size: screenWidth * 0.05,
                        ),
                        SizedBox(width: screenWidth * 0.02),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                healthTitle,
                                style: TextStyle(
                                  color: AppColors.white,
                                  fontSize: screenWidth * 0.035,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                healthMessage,
                                style: TextStyle(
                                  color: Colors.white.withValues(alpha: 0.9),
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
            // Health Metrics
            Padding(
              padding: EdgeInsets.all(screenWidth * 0.04),
              child: Column(
                children: [
                  // First row - Heart Rate and Blood Pressure
                  Row(
                    children: [
                      Expanded(
                        child: _HealthMetricCard(
                          icon: Icons.favorite,
                          iconBgColor: AppColors.heartRed,
                          title: 'Heart Rate',
                          subtitle: 'Current',
                          value: latestHealthData?.heartRate ?? "-",
                          unit: 'BPM',
                          screenWidth: screenWidth,
                          screenHeight: screenHeight,
                        ),
                      ),
                      SizedBox(width: screenWidth * 0.03),
                      Expanded(
                        child: _HealthMetricCard(
                          icon: Icons.show_chart,
                          iconBgColor: AppColors.primaryBlue,
                          title: 'Blood Pressure',
                          subtitle: 'Current',
                          value:
                              "${latestHealthData?.systolic ?? '-'} / ${latestHealthData?.diastolic ?? '-'}",
                          unit: 'mmHg',
                          screenWidth: screenWidth,
                          screenHeight: screenHeight,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  // Second row - Temperature and Steps
                  Row(
                    children: [
                      Expanded(
                        child: _HealthMetricCard(
                          icon: Icons.thermostat,
                          iconBgColor: AppColors.orangeAccent,
                          title: 'Temperature',
                          subtitle: 'Current',
                          value: latestHealthData?.temperature ?? "-",
                          unit: '°C',
                          screenWidth: screenWidth,
                          screenHeight: screenHeight,
                        ),
                      ),
                      SizedBox(width: screenWidth * 0.03),
                      Expanded(
                        child: _HealthMetricCard(
                          icon: Icons.directions_walk,
                          iconBgColor: AppColors.greenAccent,
                          title: 'Weight',
                          subtitle: 'Today',
                          value: latestHealthData?.weight ?? "-",
                          unit: 'kg',
                          screenWidth: screenWidth,
                          screenHeight: screenHeight,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  // Quick Actions
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Quick Actions',
                        style: TextStyle(
                          color: AppColors.darkText,
                          fontSize: screenWidth * 0.045,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _QuickActionButton(
                        icon: Icons.add,
                        label: 'Input Data',
                        color: AppColors.primaryBlue,
                        screenWidth: screenWidth,
                        screenHeight: screenHeight,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const MainAppScreen(initialIndex: 1),
                            ),
                          );
                        },
                      ),
                      _QuickActionButton(
                        icon: Icons.bar_chart,
                        label: 'Analytics',
                        color: AppColors.greenAccent,
                        screenWidth: screenWidth,
                        screenHeight: screenHeight,
                        onTap: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  const MainAppScreen(initialIndex: 1),
                            ),
                          );

                          loadData();
                        },
                      ),
                      _QuickActionButton(
                        icon: Icons.medical_services,
                        label: 'Medicines',
                        color: AppColors.orangeAccent,
                        screenWidth: screenWidth,
                        screenHeight: screenHeight,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const MainAppScreen(initialIndex: 3),
                            ),
                          );
                        },
                      ),
                      _QuickActionButton(
                        icon: Icons.emergency,
                        label: 'Emergency',
                        color: AppColors.red,
                        screenWidth: screenWidth,
                        screenHeight: screenHeight,
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (_) {
                              return AlertDialog(
                                title: Text("Emergency"),
                                content: Text(
                                  "Emergency feature is under development.",
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text("OK"),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  // Daily Tips
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.04,
                      vertical: screenHeight * 0.02,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(screenWidth * 0.04),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 5,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: screenWidth * 0.08,
                              height: screenWidth * 0.08,
                              decoration: BoxDecoration(
                                color: AppColors.tealGreen,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.lightbulb,
                                color: AppColors.white,
                                size: screenWidth * 0.04,
                              ),
                            ),
                            SizedBox(width: screenWidth * 0.02),
                            Text(
                              'Daily Health Tips',
                              style: TextStyle(
                                color: AppColors.darkText,
                                fontSize: screenWidth * 0.04,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: screenHeight * 0.015),
                        ...[healthTip].map(
                          (tip) => Padding(
                            padding: EdgeInsets.only(
                              bottom: screenHeight * 0.01,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '•',
                                  style: TextStyle(
                                    color: AppColors.greyText,
                                    fontSize: screenWidth * 0.04,
                                  ),
                                ),
                                SizedBox(width: screenWidth * 0.02),
                                Expanded(
                                  child: Text(
                                    tip,
                                    style: TextStyle(
                                      color: AppColors.greyText,
                                      fontSize: screenWidth * 0.032,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
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

class _HealthMetricCard extends StatelessWidget {
  final IconData icon;
  final Color iconBgColor;
  final String title;
  final String subtitle;
  final String value;
  final String unit;
  final double screenWidth;
  final double screenHeight;

  const _HealthMetricCard({
    required this.icon,
    required this.iconBgColor,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.unit,
    required this.screenWidth,
    required this.screenHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.03,
        vertical: screenHeight * 0.02,
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(screenWidth * 0.03),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: screenWidth * 0.08,
            height: screenWidth * 0.08,
            decoration: BoxDecoration(
              color: iconBgColor.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconBgColor, size: screenWidth * 0.04),
          ),
          SizedBox(height: screenHeight * 0.01),
          Text(
            title,
            style: TextStyle(
              color: AppColors.greyText,
              fontSize: screenWidth * 0.028,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: screenHeight * 0.005),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                value,
                style: TextStyle(
                  color: AppColors.darkText,
                  fontSize: screenWidth * 0.05,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: screenWidth * 0.01),
              Text(
                unit,
                style: TextStyle(
                  color: AppColors.greyText,
                  fontSize: screenWidth * 0.024,
                ),
              ),
            ],
          ),
          SizedBox(height: screenHeight * 0.005),
          Text(
            subtitle,
            style: TextStyle(
              color: AppColors.greyText,
              fontSize: screenWidth * 0.022,
            ),
          ),
        ],
      ),
    );
  }
}

class _QuickActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final double screenWidth;
  final double screenHeight;
  final VoidCallback? onTap;

  const _QuickActionButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.screenWidth,
    required this.screenHeight,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.01),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(screenWidth * 0.03),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(screenWidth * 0.03),
              ),
              child: Column(
                children: [
                  Icon(icon, color: AppColors.white, size: screenWidth * 0.055),
                  SizedBox(height: screenHeight * 0.005),
                  Text(
                    label,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: screenWidth * 0.022,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
