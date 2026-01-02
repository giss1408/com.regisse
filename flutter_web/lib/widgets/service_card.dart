// lib/widgets/service_card.dart - UPDATED VERSION
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:regisse_business/constants/app_constants.dart';
import 'package:regisse_business/models/service.dart';

class ServiceCard extends StatelessWidget {
  final Service service;

  const ServiceCard({
    super.key,
    required this.service,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          minHeight: 400,
          maxHeight: 500,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Image - Fixed height
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              child: Image.network(
                service.imageUrl,
                height: 150, // Reduced from 180
                width: double.infinity,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(
                    height: 150,
                    color: AppColors.accent.withOpacity(0.3),
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 150,
                    color: AppColors.accent,
                    child: const Icon(
                      Icons.business,
                      size: 48,
                      color: AppColors.primary,
                    ),
                  );
                },
              ),
            ),
            
            // Content - Use Expanded to take remaining space
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Title
                    Text(
                      service.title,
                      style: GoogleFonts.poppins(
                        fontSize: 16, // Reduced from 18
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    
                    const SizedBox(height: 8),
                    
                    // Description - Use Expanded to handle overflow
                    Expanded(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Text(
                          service.description,
                          style: GoogleFonts.poppins(
                            fontSize: 13, // Reduced from 14
                            color: AppColors.textLight,
                            height: 1.4,
                          ),
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 12),
                    
                    // Features - Limited height with scroll
                    SizedBox(
                      height: 60, // Fixed height for features
                      child: SingleChildScrollView(
                        child: Wrap(
                          spacing: 6,
                          runSpacing: 4,
                          children: service.features.take(3).map<Widget>((feature) {
                            return Chip(
                              label: Text(
                                feature,
                                style: GoogleFonts.poppins(
                                  fontSize: 11, // Reduced from 12
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              backgroundColor: AppColors.accent,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 2,
                              ),
                              visualDensity: VisualDensity.compact,
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Price and Button
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Starting at \$${service.startingPrice.toStringAsFixed(0)}',
                            style: GoogleFonts.poppins(
                              fontSize: 14, // Reduced from 16
                              fontWeight: FontWeight.w600,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            visualDensity: VisualDensity.compact,
                          ),
                          child: Text(
                            'Learn More',
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}