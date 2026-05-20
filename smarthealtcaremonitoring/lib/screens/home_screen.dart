import 'package:flutter/material.dart';
import '../utils/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hello, Kevin',
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: screenWidth * 0.055,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Wednesday, May 20',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.8),
                              fontSize: screenWidth * 0.032,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: screenWidth * 0.12,
                        height: screenWidth * 0.12,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.3),
                          borderRadius:
                              BorderRadius.circular(screenWidth * 0.03),
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
                      color: AppColors.tealGreen,
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
                                'All Systems Normal',
                                style: TextStyle(
                                  color: AppColors.white,
                                  fontSize: screenWidth * 0.035,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Your health metrics are looking great!',
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.9),
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
                          value: '72',
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
                          value: '120 / 80',
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
                          value: '36.6',
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
                          title: 'Steps',
                          subtitle: 'Today',
                          value: '8,542',
                          unit: 'steps',
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
                      ),
                      _QuickActionButton(
                        icon: Icons.bar_chart,
                        label: 'Analytics',
                        color: AppColors.greenAccent,
                        screenWidth: screenWidth,
                        screenHeight: screenHeight,
                      ),
                      _QuickActionButton(
                        icon: Icons.medical_services,
                        label: 'Medicines',
                        color: AppColors.orangeAccent,
                        screenWidth: screenWidth,
                        screenHeight: screenHeight,
                      ),
                      _QuickActionButton(
                        icon: Icons.emergency,
                        label: 'Emergency',
                        color: AppColors.red,
                        screenWidth: screenWidth,
                        screenHeight: screenHeight,
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
                          color: Colors.black.withOpacity(0.05),
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
                        ...[
                          'Drink at least 8 glasses of water',
                          'Take a 30-minute walk after',
                        ].map(
                          (tip) => Padding(
                            padding: EdgeInsets.only(bottom: screenHeight * 0.01),
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
            color: Colors.black.withOpacity(0.05),
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
              color: iconBgColor.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: iconBgColor,
              size: screenWidth * 0.04,
            ),
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

  const _QuickActionButton({
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
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {},
            borderRadius: BorderRadius.circular(screenWidth * 0.03),
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: screenHeight * 0.02,
              ),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(screenWidth * 0.03),
              ),
              child: Column(
                children: [
                  Icon(
                    icon,
                    color: AppColors.white,
                    size: screenWidth * 0.055,
                  ),
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
