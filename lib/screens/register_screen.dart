import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../utils/colors.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _agreeTerms = false;
  bool _isLoading = false;

  Future<void> register() async {
    if (_nameController.text.trim().isEmpty ||
        _emailController.text.trim().isEmpty ||
        _passwordController.text.trim().isEmpty ||
        _confirmPasswordController.text.trim().isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Semua field wajib diisi")));
      return;
    }

    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Password tidak sama")));
      return;
    }

    if (!_agreeTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Setujui Terms & Conditions terlebih dahulu"),
        ),
      );
      return;
    }

    try {
      setState(() {
        _isLoading = true;
      });

      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Register berhasil")));

        Navigator.pop(context);
      }
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.message ?? "Register gagal")));
    } finally {
      if (context.mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: SingleChildScrollView(
            child: Column(
              children: [
                //================ HEADER =================//
                Container(
                  width: double.infinity,
                  height: screenHeight * 0.30,
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
                  child: Stack(
                    children: [
                      Positioned(
                        top: screenHeight * 0.05,
                        left: screenWidth * 0.08,
                        child: Container(
                          width: screenWidth * 0.16,
                          height: screenWidth * 0.16,
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.10),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),

                      Center(
                        child: Container(
                          width: screenWidth * 0.22,
                          height: screenWidth * 0.22,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: .15),
                                blurRadius: 12,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Icon(
                            Icons.person_add_alt_1,
                            color: AppColors.primaryBlue,
                            size: screenWidth * .10,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                //============== CONTENT =================//
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * .08,
                    vertical: screenHeight * .04,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Create Account",
                        style: TextStyle(
                          fontSize: screenWidth * .065,
                          fontWeight: FontWeight.bold,
                          color: AppColors.darkText,
                        ),
                      ),

                      const SizedBox(height: 8),

                      Text(
                        "Create your Smart Health Monitor account",
                        style: TextStyle(
                          fontSize: screenWidth * .032,
                          color: AppColors.greyText,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: screenHeight * .04),

                //====================
                // PART 2 DIMULAI DISINI
                //====================

                //================ FULL NAME =================//
                Text(
                  "Full Name",
                  style: TextStyle(
                    color: AppColors.darkText,
                    fontSize: screenWidth * .035,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                SizedBox(height: screenHeight * .01),

                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    hintText: "Enter your full name",
                    hintStyle: TextStyle(
                      color: AppColors.greyText.withValues(alpha: .5),
                    ),
                    prefixIcon: const Icon(Icons.person_outline),
                    filled: true,
                    fillColor: AppColors.lightGrey,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(screenWidth * .03),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: screenWidth * .04,
                      vertical: screenHeight * .02,
                    ),
                  ),
                ),

                SizedBox(height: screenHeight * .025),

                //================ EMAIL =================//
                Text(
                  "Email",
                  style: TextStyle(
                    color: AppColors.darkText,
                    fontSize: screenWidth * .035,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                SizedBox(height: screenHeight * .01),

                TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: "example@gmail.com",
                    hintStyle: TextStyle(
                      color: AppColors.greyText.withValues(alpha: .5),
                    ),
                    prefixIcon: const Icon(Icons.email_outlined),
                    filled: true,
                    fillColor: AppColors.lightGrey,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(screenWidth * .03),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: screenWidth * .04,
                      vertical: screenHeight * .02,
                    ),
                  ),
                ),

                SizedBox(height: screenHeight * .025),

                //================ PASSWORD =================//
                Text(
                  "Password",
                  style: TextStyle(
                    color: AppColors.darkText,
                    fontSize: screenWidth * .035,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                SizedBox(height: screenHeight * .01),

                TextField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    hintText: "Minimum 6 characters",
                    hintStyle: TextStyle(
                      color: AppColors.greyText.withValues(alpha: .5),
                    ),
                    prefixIcon: const Icon(Icons.lock_outline),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                    filled: true,
                    fillColor: AppColors.lightGrey,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(screenWidth * .03),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: screenWidth * .04,
                      vertical: screenHeight * .02,
                    ),
                  ),
                ),

                SizedBox(height: screenHeight * .025),

                //================ CONFIRM PASSWORD =================//
                Text(
                  "Confirm Password",
                  style: TextStyle(
                    color: AppColors.darkText,
                    fontSize: screenWidth * .035,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                SizedBox(height: screenHeight * .01),

                TextField(
                  controller: _confirmPasswordController,
                  obscureText: _obscureConfirmPassword,
                  decoration: InputDecoration(
                    hintText: "Repeat your password",
                    hintStyle: TextStyle(
                      color: AppColors.greyText.withValues(alpha: .5),
                    ),
                    prefixIcon: const Icon(Icons.lock_reset_outlined),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureConfirmPassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureConfirmPassword = !_obscureConfirmPassword;
                        });
                      },
                    ),
                    filled: true,
                    fillColor: AppColors.lightGrey,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(screenWidth * .03),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: screenWidth * .04,
                      vertical: screenHeight * .02,
                    ),
                  ),
                ),

                SizedBox(height: screenHeight * .02),

                //================ TERMS =================//
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Checkbox(
                      value: _agreeTerms,
                      activeColor: AppColors.primaryBlue,
                      onChanged: (value) {
                        setState(() {
                          _agreeTerms = value ?? false;
                        });
                      },
                    ),

                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                            color: AppColors.greyText,
                            fontSize: screenWidth * .03,
                          ),
                          children: const [
                            TextSpan(text: "I agree to the "),
                            TextSpan(
                              text: "Terms & Conditions",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(text: " and "),
                            TextSpan(
                              text: "Privacy Policy",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: screenHeight * .03),

                //=====================
                // PART 3 DIMULAI DISINI
                //=====================
                SizedBox(
                  width: double.infinity,
                  height: screenHeight * 0.065,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryBlue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(screenWidth * 0.04),
                      ),
                      elevation: 0,
                    ),
                    onPressed: _isLoading
                        ? null
                        : () async {
                            if (_nameController.text.trim().isEmpty ||
                                _emailController.text.trim().isEmpty ||
                                _passwordController.text.trim().isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Semua data wajib diisi"),
                                ),
                              );
                              return;
                            }

                            try {
                              setState(() {
                                _isLoading = true;
                              });

                              UserCredential userCredential = await FirebaseAuth
                                  .instance
                                  .createUserWithEmailAndPassword(
                                    email: _emailController.text.trim(),
                                    password: _passwordController.text.trim(),
                                  );

                              await FirebaseFirestore.instance
                                  .collection("users")
                                  .doc(userCredential.user!.uid)
                                  .set({
                                    "fullName": _nameController.text.trim(),
                                    "email": _emailController.text.trim(),
                                    "role": "Patient",
                                    "createdAt": Timestamp.now(),
                                  });

                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Registrasi berhasil"),
                                  ),
                                );

                                Navigator.pop(context);
                              }
                            } on FirebaseAuthException catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    e.message ?? "Registrasi gagal",
                                  ),
                                ),
                              );
                            } finally {
                              if (context.mounted) {
                                setState(() {
                                  _isLoading = false;
                                });
                              }
                            }
                          },
                    child: _isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : Text(
                            "Create Account",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: screenWidth * 0.04,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),

                SizedBox(height: screenHeight * .02),

                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already have an account? "),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Login",
                          style: TextStyle(
                            color: AppColors.primaryBlue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
