// lib/screens/menu_screen.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:regisse_business/constants/app_constants.dart';
import 'package:regisse_business/models/service.dart';
import 'package:regisse_business/widgets/service_card.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  List<Service> _filteredServices = Service.sampleServices;
  String _selectedCategory = 'all';

  final Map<String, String> _categories = {
    'all': 'All Services',
    'government': 'Government',
    'retail': 'Retail',
    'hospitality': 'Hospitality',
    'technology': 'Technology',
    'consulting': 'Consulting',
  };

  void _filterServices(String category) {
    setState(() {
      _selectedCategory = category;
      if (category == 'all') {
        _filteredServices = Service.sampleServices;
      } else {
        _filteredServices = Service.sampleServices
            .where((service) => service.category == category)
            .toList();
      }
    });
  }

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
                  'Our Services',
                  style: GoogleFonts.poppins(
                    fontSize: 48,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Comprehensive business solutions for African markets',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
              ],
            ),
          ),

          // Filter chips
          Container(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: _categories.entries.map((entry) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: FilterChip(
                      label: Text(entry.value),
                      selected: _selectedCategory == entry.key,
                      selectedColor: AppColors.primary,
                      checkmarkColor: Colors.white,
                      backgroundColor: Colors.grey[200],
                      onSelected: (selected) {
                        _filterServices(entry.key);
                      },
                    ),
                  );
                }).toList(),
              ),
            ),
          ),

          // Services grid
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: _buildServicesGrid(context),
          ),

          // CTA Section
          Container(
            padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
            color: AppColors.accent.withOpacity(0.3),
            child: Column(
              children: [
                Text(
                  'Need a Custom Solution?',
                  style: GoogleFonts.poppins(
                    fontSize: 36,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Contact us for tailored solutions specific to your business needs',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    color: AppColors.textLight,
                  ),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Request Custom Quote',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServicesGrid(BuildContext context) {
    if (MediaQuery.of(context).size.width >= 1024) {
      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          childAspectRatio: 0.8,
        ),
        itemCount: _filteredServices.length,
        itemBuilder: (context, index) {
          return ServiceCard(service: _filteredServices[index]);
        },
      );
    } else if (MediaQuery.of(context).size.width >= 768) {
      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          childAspectRatio: 0.8,
        ),
        itemCount: _filteredServices.length,
        itemBuilder: (context, index) {
          return ServiceCard(service: _filteredServices[index]);
        },
      );
    } else {
      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: _filteredServices.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: ServiceCard(service: _filteredServices[index]),
          );
        },
      );
    }
  }
}