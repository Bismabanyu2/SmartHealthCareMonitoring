import 'package:flutter/material.dart';
import '../utils/colors.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({Key? key}) : super(key: key);

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Analytics',
          style: TextStyle(
            color: AppColors.darkText,
            fontSize: screenWidth * 0.045,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(screenWidth * 0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Tabs
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    'Avg BPM',
                    'Health Score',
                    'Days',
                  ]
                      .map(
                        (tab) => GestureDetector(
                          onTap: () => setState(
                            () => _selectedTab =
                                ['Avg BPM', 'Health Score', 'Days']
                                    .indexOf(tab),
                          ),
                          child: Container(
                            margin: EdgeInsets.only(right: screenWidth * 0.02),
                            padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.04,
                              vertical: screenHeight * 0.01,
                            ),
                            decoration: BoxDecoration(
                              color: _selectedTab ==
                                      ['Avg BPM', 'Health Score', 'Days']
                                          .indexOf(tab)
                                  ? AppColors.white
                                  : Colors.transparent,
                              borderRadius:
                                  BorderRadius.circular(screenWidth * 0.06),
                              border: Border.all(
                                color: _selectedTab ==
                                        ['Avg BPM', 'Health Score', 'Days']
                                            .indexOf(tab)
                                    ? AppColors.lightGrey
                                    : AppColors.greyText,
                              ),
                            ),
                            child: Text(
                              tab,
                              style: TextStyle(
                                color: _selectedTab ==
                                        ['Avg BPM', 'Health Score', 'Days']
                                            .indexOf(tab)
                                    ? AppColors.primaryBlue
                                    : AppColors.greyText,
                                fontSize: screenWidth * 0.032,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
              SizedBox(height: screenHeight * 0.03),
              // Heart Rate Card
              _TrendCard(
                title: 'Heart Rate',
                subtitle: 'Trend',
                value: '72 BPM',
                change: '↑ 2%',
                changeColor: AppColors.greenAccent,
                icon: Icons.favorite,
                iconBgColor: AppColors.heartRed,
                chartColor: AppColors.red,
                screenWidth: screenWidth,
                screenHeight: screenHeight,
              ),
              SizedBox(height: screenHeight * 0.02),
              // Blood Pressure Card
              _BloodPressureCard(
                screenWidth: screenWidth,
                screenHeight: screenHeight,
              ),
              SizedBox(height: screenHeight * 0.02),
              // Weekly Summary Card
              _WeeklySummaryCard(
                screenWidth: screenWidth,
                screenHeight: screenHeight,
              ),
              SizedBox(height: screenHeight * 0.02),
            ],
          ),
        ),
      ),
    );
  }
}

class _TrendCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String value;
  final String change;
  final Color changeColor;
  final IconData icon;
  final Color iconBgColor;
  final Color chartColor;
  final double screenWidth;
  final double screenHeight;

  const _TrendCard({
    required this.title,
    required this.subtitle,
    required this.value,
    required this.change,
    required this.changeColor,
    required this.icon,
    required this.iconBgColor,
    required this.chartColor,
    required this.screenWidth,
    required this.screenHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.04,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: screenWidth * 0.1,
                height: screenWidth * 0.1,
                decoration: BoxDecoration(
                  color: iconBgColor.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: iconBgColor,
                  size: screenWidth * 0.05,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '$title',
                    style: TextStyle(
                      color: AppColors.darkText,
                      fontSize: screenWidth * 0.035,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: AppColors.greyText,
                      fontSize: screenWidth * 0.028,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: screenHeight * 0.02),
          // Simple chart placeholder
          Container(
            width: double.infinity,
            height: screenHeight * 0.15,
            decoration: BoxDecoration(
              color: chartColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(screenWidth * 0.02),
            ),
            child: Stack(
              children: [
                Positioned(
                  left: screenWidth * 0.05,
                  bottom: screenHeight * 0.02,
                  child: Container(
                    width: screenWidth * 0.05,
                    height: screenHeight * 0.08,
                    decoration: BoxDecoration(
                      color: chartColor,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                Positioned(
                  left: screenWidth * 0.15,
                  bottom: screenHeight * 0.035,
                  child: Container(
                    width: screenWidth * 0.05,
                    height: screenHeight * 0.065,
                    decoration: BoxDecoration(
                      color: chartColor,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                Positioned(
                  left: screenWidth * 0.25,
                  bottom: screenHeight * 0.02,
                  child: Container(
                    width: screenWidth * 0.05,
                    height: screenHeight * 0.08,
                    decoration: BoxDecoration(
                      color: chartColor,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                Positioned(
                  left: screenWidth * 0.35,
                  bottom: screenHeight * 0.045,
                  child: Container(
                    width: screenWidth * 0.05,
                    height: screenHeight * 0.055,
                    decoration: BoxDecoration(
                      color: chartColor,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: screenHeight * 0.02),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    value,
                    style: TextStyle(
                      color: AppColors.darkText,
                      fontSize: screenWidth * 0.04,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Last 7 days',
                    style: TextStyle(
                      color: AppColors.greyText,
                      fontSize: screenWidth * 0.028,
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.02,
                  vertical: screenHeight * 0.005,
                ),
                decoration: BoxDecoration(
                  color: changeColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(screenWidth * 0.02),
                ),
                child: Text(
                  change,
                  style: TextStyle(
                    color: changeColor,
                    fontSize: screenWidth * 0.03,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _BloodPressureCard extends StatelessWidget {
  final double screenWidth;
  final double screenHeight;

  const _BloodPressureCard({
    required this.screenWidth,
    required this.screenHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.04,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: screenWidth * 0.1,
                height: screenWidth * 0.1,
                decoration: BoxDecoration(
                  color: AppColors.primaryBlue.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.show_chart,
                  color: AppColors.primaryBlue,
                  size: screenWidth * 0.05,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Blood Pressure',
                    style: TextStyle(
                      color: AppColors.darkText,
                      fontSize: screenWidth * 0.035,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Stable',
                    style: TextStyle(
                      color: AppColors.greenAccent,
                      fontSize: screenWidth * 0.028,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: screenHeight * 0.02),
          // Chart
          Container(
            width: double.infinity,
            height: screenHeight * 0.15,
            decoration: BoxDecoration(
              color: AppColors.lightGrey,
              borderRadius: BorderRadius.circular(screenWidth * 0.02),
            ),
            child: Center(
              child: Text(
                'Blood Pressure Trend',
                style: TextStyle(
                  color: AppColors.greyText,
                  fontSize: screenWidth * 0.032,
                ),
              ),
            ),
          ),
          SizedBox(height: screenHeight * 0.02),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Container(
                    width: screenWidth * 0.08,
                    height: screenWidth * 0.08,
                    decoration: BoxDecoration(
                      color: AppColors.primaryBlue.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Container(
                        width: screenWidth * 0.04,
                        height: screenWidth * 0.04,
                        decoration: const BoxDecoration(
                          color: AppColors.primaryBlue,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.005),
                  Text(
                    'Systolic',
                    style: TextStyle(
                      color: AppColors.greyText,
                      fontSize: screenWidth * 0.028,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                    width: screenWidth * 0.08,
                    height: screenWidth * 0.08,
                    decoration: BoxDecoration(
                      color: AppColors.tealGreen.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Container(
                        width: screenWidth * 0.04,
                        height: screenWidth * 0.04,
                        decoration: const BoxDecoration(
                          color: AppColors.tealGreen,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.005),
                  Text(
                    'Diastolic',
                    style: TextStyle(
                      color: AppColors.greyText,
                      fontSize: screenWidth * 0.028,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _WeeklySummaryCard extends StatelessWidget {
  final double screenWidth;
  final double screenHeight;

  const _WeeklySummaryCard({
    required this.screenWidth,
    required this.screenHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.04,
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
          Text(
            'Weekly Summary',
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
              _SummaryItem(
                label: 'Average Heart Rate',
                value: '72 BPM',
                screenWidth: screenWidth,
                screenHeight: screenHeight,
              ),
              _SummaryItem(
                label: 'Avg Blood Pressure',
                value: '120/80 mmHg',
                screenWidth: screenWidth,
                screenHeight: screenHeight,
              ),
            ],
          ),
          SizedBox(height: screenHeight * 0.015),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _SummaryItem(
                label: 'Health Consistency',
                value: 'Excellent',
                screenWidth: screenWidth,
                screenHeight: screenHeight,
              ),
              _SummaryItem(
                label: 'Data Logged',
                value: '7/7 days',
                screenWidth: screenWidth,
                screenHeight: screenHeight,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SummaryItem extends StatelessWidget {
  final String label;
  final String value;
  final double screenWidth;
  final double screenHeight;

  const _SummaryItem({
    required this.label,
    required this.value,
    required this.screenWidth,
    required this.screenHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              color: AppColors.greyText,
              fontSize: screenWidth * 0.026,
            ),
          ),
          SizedBox(height: screenHeight * 0.005),
          Text(
            value,
            style: TextStyle(
              color: AppColors.darkText,
              fontSize: screenWidth * 0.032,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
