import 'package:flutter/material.dart';
import '../utils/colors.dart';
import '../models/health_data_model.dart';

class ReminderScreen extends StatefulWidget {
  const ReminderScreen({super.key});

  @override
  State<ReminderScreen> createState() => _ReminderScreenState();
}

class _ReminderScreenState extends State<ReminderScreen> {
  List<Medicine> medicines = [
    Medicine(
      name: 'Aspirin',
      dosage: '500mg',
      time: '08:00 AM',
      color: AppColors.primaryBlue,
      taken: true,
    ),
    Medicine(
      name: 'Ibuprofen',
      dosage: '200mg',
      time: '12:00 PM',
      color: AppColors.greenAccent,
      taken: false,
    ),
    Medicine(
      name: 'Vitamin D',
      dosage: '1000 IU',
      time: '02:00 PM',
      color: AppColors.orangeAccent,
      taken: false,
    ),
    Medicine(
      name: 'Omega-3',
      dosage: '500mg',
      time: '08:00 PM',
      color: AppColors.tealGreen,
      taken: false,
    ),
    Medicine(
      name: 'Multivitamin',
      dosage: '1 tablet',
      time: '09:00 PM',
      color: AppColors.purpleAccent,
      taken: false,
    ),
  ];

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
          'Reminder',
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
              // Progress card
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.04,
                  vertical: screenHeight * 0.02,
                ),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [AppColors.tealGreen, Color(0xFF10B981)],
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Today's Progress",
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: screenWidth * 0.035,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.015),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: LinearProgressIndicator(
                        value: 1 / medicines.length,
                        minHeight: 8,
                        backgroundColor: Colors.white.withValues(alpha: 0.3),
                        valueColor: AlwaysStoppedAnimation<Color>(
                          AppColors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    Text(
                      '1/${medicines.length} medicines taken',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.9),
                        fontSize: screenWidth * 0.03,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              // Add medicine button
              SizedBox(
                width: double.infinity,
                height: screenHeight * 0.05,
                child: OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(screenWidth * 0.03),
                    ),
                    side: const BorderSide(
                      color: AppColors.tealGreen,
                      width: 2,
                    ),
                  ),
                  onPressed: () {},
                  icon: Icon(
                    Icons.add,
                    color: AppColors.tealGreen,
                    size: screenWidth * 0.05,
                  ),
                  label: Text(
                    'Add New Medicine',
                    style: TextStyle(
                      color: AppColors.tealGreen,
                      fontSize: screenWidth * 0.032,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.03),
              // Medicines List
              Text(
                "Today's Schedule",
                style: TextStyle(
                  color: AppColors.darkText,
                  fontSize: screenWidth * 0.04,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              ...medicines.map(
                (medicine) => _MedicineCard(
                  medicine: medicine,
                  onToggle: (taken) {
                    setState(() {
                      medicine = Medicine(
                        name: medicine.name,
                        dosage: medicine.dosage,
                        time: medicine.time,
                        taken: taken,
                        color: medicine.color,
                      );
                    });
                  },
                  screenWidth: screenWidth,
                  screenHeight: screenHeight,
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              // Smart Notifications Card
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.04,
                  vertical: screenHeight * 0.02,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primaryBlue.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(screenWidth * 0.03),
                  border: Border.all(
                    color: AppColors.primaryBlue.withValues(alpha: 0.3),
                  ),
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
                            color: AppColors.primaryBlue.withValues(alpha: 0.2),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.notifications_outlined,
                            color: AppColors.primaryBlue,
                            size: screenWidth * 0.04,
                          ),
                        ),
                        SizedBox(width: screenWidth * 0.02),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Smart Notifications',
                              style: TextStyle(
                                color: AppColors.darkText,
                                fontSize: screenWidth * 0.032,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Get reminders for your medicines',
                              style: TextStyle(
                                color: AppColors.greyText,
                                fontSize: screenWidth * 0.026,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Switch(
                          value: true,
                          onChanged: (value) {},
                          activeThumbColor: AppColors.primaryBlue,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              // Recent Activity
              Text(
                'Recent Activity',
                style: TextStyle(
                  color: AppColors.darkText,
                  fontSize: screenWidth * 0.04,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              _ActivityItem(
                icon: Icons.check_circle,
                iconColor: AppColors.greenAccent,
                title: 'Aspirin taken at 08:00 AM',
                time: 'Today',
                screenWidth: screenWidth,
                screenHeight: screenHeight,
              ),
              _ActivityItem(
                icon: Icons.schedule,
                iconColor: AppColors.orangeAccent,
                title: 'All medicines taken',
                time: 'Yesterday',
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

class _MedicineCard extends StatelessWidget {
  final Medicine medicine;
  final Function(bool) onToggle;
  final double screenWidth;
  final double screenHeight;

  const _MedicineCard({
    required this.medicine,
    required this.onToggle,
    required this.screenWidth,
    required this.screenHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: screenHeight * 0.015),
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.04,
        vertical: screenHeight * 0.015,
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
      child: Row(
        children: [
          Container(
            width: screenWidth * 0.1,
            height: screenWidth * 0.1,
            decoration: BoxDecoration(
              color: medicine.color.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.medical_services,
              color: medicine.color,
              size: screenWidth * 0.05,
            ),
          ),
          SizedBox(width: screenWidth * 0.03),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  medicine.name,
                  style: TextStyle(
                    color: AppColors.darkText,
                    fontSize: screenWidth * 0.035,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${medicine.dosage} - ${medicine.time}',
                  style: TextStyle(
                    color: AppColors.greyText,
                    fontSize: screenWidth * 0.028,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: screenWidth * 0.08,
            height: screenWidth * 0.08,
            decoration: BoxDecoration(
              color: medicine.taken ? medicine.color : Colors.transparent,
              border: Border.all(color: medicine.color, width: 2),
              shape: BoxShape.circle,
            ),
            child: medicine.taken
                ? Icon(
                    Icons.check,
                    color: AppColors.white,
                    size: screenWidth * 0.04,
                  )
                : null,
          ),
        ],
      ),
    );
  }
}

class _ActivityItem extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String time;
  final double screenWidth;
  final double screenHeight;

  const _ActivityItem({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.time,
    required this.screenWidth,
    required this.screenHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: screenHeight * 0.01),
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.04,
        vertical: screenHeight * 0.015,
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
      child: Row(
        children: [
          Icon(icon, color: iconColor, size: screenWidth * 0.06),
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
                Text(
                  time,
                  style: TextStyle(
                    color: AppColors.greyText,
                    fontSize: screenWidth * 0.028,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
