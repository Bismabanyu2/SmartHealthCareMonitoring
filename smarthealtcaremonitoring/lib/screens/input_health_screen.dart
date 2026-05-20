import 'package:flutter/material.dart';
import '../utils/colors.dart';

class InputHealthScreen extends StatefulWidget {
  const InputHealthScreen({Key? key}) : super(key: key);

  @override
  State<InputHealthScreen> createState() => _InputHealthScreenState();
}

class _InputHealthScreenState extends State<InputHealthScreen> {
  final _heartRateController = TextEditingController();
  final _systolicController = TextEditingController();
  final _diastolicController = TextEditingController();
  final _temperatureController = TextEditingController();
  final _weightController = TextEditingController();
  final _notesController = TextEditingController();

  @override
  void dispose() {
    _heartRateController.dispose();
    _systolicController.dispose();
    _diastolicController.dispose();
    _temperatureController.dispose();
    _weightController.dispose();
    _notesController.dispose();
    super.dispose();
  }

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
          'Input Health Data',
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
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.05,
            vertical: screenHeight * 0.02,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header card
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.04,
                  vertical: screenHeight * 0.02,
                ),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppColors.tealGreen,
                      Color(0xFF10B981),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(screenWidth * 0.03),
                ),
                child: Text(
                  'Record your daily health metrics',
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: screenWidth * 0.035,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.03),
              // Heart Rate field
              _InputField(
                label: 'Heart Rate (BPM)',
                icon: Icons.favorite,
                controller: _heartRateController,
                hint: '72',
                keyboardType: TextInputType.number,
                screenWidth: screenWidth,
                screenHeight: screenHeight,
              ),
              SizedBox(height: screenHeight * 0.02),
              // Blood Pressure fields
              Text(
                'Blood Pressure (mmHg)',
                style: TextStyle(
                  color: AppColors.darkText,
                  fontSize: screenWidth * 0.035,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _systolicController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'Systolic',
                        hintStyle: TextStyle(
                          color: AppColors.greyText.withOpacity(0.5),
                        ),
                        filled: true,
                        fillColor: AppColors.white,
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(screenWidth * 0.03),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.03,
                          vertical: screenHeight * 0.015,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.03),
                  Expanded(
                    child: TextField(
                      controller: _diastolicController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'Diastolic',
                        hintStyle: TextStyle(
                          color: AppColors.greyText.withOpacity(0.5),
                        ),
                        filled: true,
                        fillColor: AppColors.white,
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(screenWidth * 0.03),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.03,
                          vertical: screenHeight * 0.015,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.02),
              // Temperature field
              _InputField(
                label: 'Body Temperature (°C)',
                icon: Icons.thermostat,
                controller: _temperatureController,
                hint: '36.6',
                keyboardType: TextInputType.number,
                screenWidth: screenWidth,
                screenHeight: screenHeight,
              ),
              SizedBox(height: screenHeight * 0.02),
              // Weight field
              _InputField(
                label: 'Weight (kg)',
                icon: Icons.scale,
                controller: _weightController,
                hint: '70.5',
                keyboardType: TextInputType.number,
                screenWidth: screenWidth,
                screenHeight: screenHeight,
              ),
              SizedBox(height: screenHeight * 0.02),
              // Date field
              Text(
                'Date',
                style: TextStyle(
                  color: AppColors.darkText,
                  fontSize: screenWidth * 0.035,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              TextField(
                readOnly: true,
                decoration: InputDecoration(
                  hintText: '20/05/2026',
                  hintStyle: TextStyle(
                    color: AppColors.greyText.withOpacity(0.5),
                  ),
                  prefixIcon: Icon(
                    Icons.calendar_today,
                    color: AppColors.greyText,
                    size: screenWidth * 0.05,
                  ),
                  filled: true,
                  fillColor: AppColors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(screenWidth * 0.03),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.04,
                    vertical: screenHeight * 0.015,
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              // Notes field
              Text(
                'Notes (Optional)',
                style: TextStyle(
                  color: AppColors.darkText,
                  fontSize: screenWidth * 0.035,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              TextField(
                controller: _notesController,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: 'Add any additional notes about your health...',
                  hintStyle: TextStyle(
                    color: AppColors.greyText.withOpacity(0.5),
                  ),
                  filled: true,
                  fillColor: AppColors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(screenWidth * 0.03),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.04,
                    vertical: screenHeight * 0.015,
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.03),
              // Buttons
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: screenHeight * 0.065,
                      child: OutlinedButton.icon(
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(screenWidth * 0.03),
                          ),
                          side: const BorderSide(
                            color: AppColors.greyText,
                            width: 1.5,
                          ),
                        ),
                        onPressed: () {
                          _heartRateController.clear();
                          _systolicController.clear();
                          _diastolicController.clear();
                          _temperatureController.clear();
                          _weightController.clear();
                          _notesController.clear();
                        },
                        icon: const Icon(Icons.refresh),
                        label: Text(
                          'Reset',
                          style: TextStyle(
                            color: AppColors.darkText,
                            fontSize: screenWidth * 0.035,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.03),
                  Expanded(
                    child: SizedBox(
                      height: screenHeight * 0.065,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryBlue,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(screenWidth * 0.03),
                          ),
                          elevation: 0,
                        ),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Text('Health data saved!'),
                              duration: const Duration(seconds: 2),
                              backgroundColor: AppColors.primaryBlue,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(screenWidth * 0.03),
                              ),
                            ),
                          );
                        },
                        icon: const Icon(Icons.save),
                        label: Text(
                          'Save Data',
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: screenWidth * 0.035,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.02),
            ],
          ),
        ),
      ),
    );
  }
}

class _InputField extends StatelessWidget {
  final String label;
  final IconData icon;
  final TextEditingController controller;
  final String hint;
  final TextInputType keyboardType;
  final double screenWidth;
  final double screenHeight;

  const _InputField({
    required this.label,
    required this.icon,
    required this.controller,
    required this.hint,
    required this.keyboardType,
    required this.screenWidth,
    required this.screenHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: AppColors.darkText,
            fontSize: screenWidth * 0.035,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: screenHeight * 0.01),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              color: AppColors.greyText.withOpacity(0.5),
            ),
            prefixIcon: Icon(
              icon,
              color: AppColors.greyText,
              size: screenWidth * 0.05,
            ),
            filled: true,
            fillColor: AppColors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(screenWidth * 0.03),
              borderSide: BorderSide.none,
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.04,
              vertical: screenHeight * 0.015,
            ),
          ),
        ),
      ],
    );
  }
}
