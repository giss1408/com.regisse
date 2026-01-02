import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF4B2E83);
  static const Color accent = Color(0xFFF4E1D2);
  static const Color background = Color(0xFFFFFFFF);
  static const Color textDark = Color(0xFF333333);
  static const Color textLight = Color(0xFF666666);
  static const Color success = Color(0xFF28A745);
  static const Color warning = Color(0xFFFFC107);
  static const Color error = Color(0xFFDC3545);
  static const Color info = Color(0xFF17A2B8);
}

class AppTextStyles {
  static TextStyle headlineLarge(BuildContext context) {
    return TextStyle(
      fontSize: 48,
      fontWeight: FontWeight.w700,
      color: AppColors.primary,
      height: 1.2,
    );
  }

  static TextStyle headlineMedium(BuildContext context) {
    return TextStyle(
      fontSize: 36,
      fontWeight: FontWeight.w600,
      color: AppColors.primary,
    );
  }

  static TextStyle headlineSmall(BuildContext context) {
    return TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      color: AppColors.textDark,
    );
  }

  static TextStyle bodyLarge(BuildContext context) {
    return TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w400,
      color: AppColors.textLight,
      height: 1.6,
    );
  }

  static TextStyle bodyMedium(BuildContext context) {
    return TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: AppColors.textLight,
    );
  }

  static TextStyle bodySmall(BuildContext context) {
    return TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: AppColors.textLight,
    );
  }
}

class AppAssets {
  static const String heroImage = 'assets/images/hero-coffee.jpg';
  static const String logo = 'assets/images/logo.png';
  
  // Service images
  static const String govSolutions = 'assets/images/government-solutions.jpg';
  static const String retailTech = 'assets/images/retail-technology.jpg';
  static const String hotelManagement = 'assets/images/hotel-management.jpg';
  static const String mobileApps = 'assets/images/mobile-apps.jpg';
  static const String cloudServices = 'assets/images/cloud-services.jpg';
  static const String consulting = 'assets/images/consulting.jpg';
  
  // Social icons
  static const String facebook = 'assets/icons/facebook.svg';
  static const String twitter = 'assets/icons/twitter.svg';
  static const String linkedin = 'assets/icons/linkedin.svg';
  static const String instagram = 'assets/icons/instagram.svg';
}

class AppStrings {
  static const String companyName = 'Regisse Business Solutions';
  static const String tagline = 'Empowering African Businesses & Governments with Innovative Solutions';
  static const String description = 'We provide cutting-edge business solutions for governments, retail, and hospitality sectors across Africa. Our mobile-first approach ensures accessibility and efficiency.';
  
  static const String address = '123 Business District, Accra, Ghana';
  static const String phone = '+233 123 456 789';
  static const String email = 'contact@regissebusiness.com';
  static const String workingHours = 'Mon-Fri: 8AM-6PM, Sat: 9AM-1PM';
  
  static const String copyright = '© 2024 Regisse Business Solutions. All rights reserved.';
}