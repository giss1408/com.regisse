// lib/screens/locations_screen.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:regisse_business/constants/app_constants.dart';

class LocationsScreen extends StatelessWidget {
  const LocationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
            color: AppColors.primary,
            child: Column(
              children: [
                Text(
                  'Our Locations',
                  style: GoogleFonts.poppins(
                    fontSize: 48,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Serving businesses and governments across Africa',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
              ],
            ),
          ),

          // Map placeholder
          Container(
            height: 400,
            color: AppColors.accent.withOpacity(0.3),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.map,
                    size: 64,
                    color: AppColors.primary,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Interactive Map Coming Soon',
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'We\'re currently expanding our presence',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: AppColors.textLight,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Locations list
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
            child: Column(
              children: [
                Text(
                  'Our Offices',
                  style: GoogleFonts.poppins(
                    fontSize: 36,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 40),
                _buildLocationList(),
              ],
            ),
          ),

          // Coverage section
          Container(
            padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
            color: AppColors.accent.withOpacity(0.2),
            child: Column(
              children: [
                Text(
                  'Countries We Serve',
                  style: GoogleFonts.poppins(
                    fontSize: 36,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 30),
                Wrap(
                  spacing: 20,
                  runSpacing: 20,
                  alignment: WrapAlignment.center,
                  children: [
                    'Ghana', 'Nigeria', 'Kenya', 'South Africa',
                    'Senegal', 'Ivory Coast', 'Ethiopia', 'Tanzania',
                    'Uganda', 'Rwanda', 'Zambia', 'Botswana',
                  ].map((country) {
                    return Chip(
                      label: Text(country),
                      backgroundColor: AppColors.primary,
                      labelStyle: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 8,
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationList() {
    final locations = [
      {
        'city': 'Accra, Ghana',
        'address': '123 Business District, Accra',
        'phone': '+233 123 456 789',
        'email': 'ghana@regissebusiness.com',
        'hours': 'Mon-Fri: 8AM-6PM',
      },
      {
        'city': 'Lagos, Nigeria',
        'address': '456 Victoria Island, Lagos',
        'phone': '+234 123 456 789',
        'email': 'nigeria@regissebusiness.com',
        'hours': 'Mon-Fri: 8AM-6PM',
      },
      {
        'city': 'Nairobi, Kenya',
        'address': '789 Westlands, Nairobi',
        'phone': '+254 123 456 789',
        'email': 'kenya@regissebusiness.com',
        'hours': 'Mon-Fri: 8AM-6PM',
      },
      {
        'city': 'Johannesburg, South Africa',
        'address': '101 Sandton City, Johannesburg',
        'phone': '+27 123 456 789',
        'email': 'sa@regissebusiness.com',
        'hours': 'Mon-Fri: 8AM-6PM',
      },
    ];

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: locations.length,
      separatorBuilder: (context, index) => const Divider(height: 40),
      itemBuilder: (context, index) {
        final location = locations[index];
        return Card(
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      location['city']!,
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.directions),
                      color: AppColors.primary,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _buildLocationInfo(Icons.location_on, location['address']!),
                const SizedBox(height: 12),
                _buildLocationInfo(Icons.phone, location['phone']!),
                const SizedBox(height: 12),
                _buildLocationInfo(Icons.email, location['email']!),
                const SizedBox(height: 12),
                _buildLocationInfo(Icons.access_time, location['hours']!),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Schedule Visit'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildLocationInfo(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: AppColors.textLight, size: 20),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: GoogleFonts.poppins(
              fontSize: 16,
              color: AppColors.textLight,
            ),
          ),
        ),
      ],
    );
  }
}