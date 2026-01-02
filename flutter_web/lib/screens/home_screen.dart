import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:regisse_business/constants/app_constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:regisse_business/models/service.dart';
import 'package:regisse_business/widgets/service_card.dart';
//import 'package:regisse_business/widgets/animated_cube.dart';
//import 'package:regisse_business/widgets/rolling_rbs_cube.dart';
//import 'package:regisse_business/widgets/hero_animation.dart';
import 'package:regisse_business/widgets/advanced_cube_animation.dart';

class HomeScreen extends StatelessWidget {
  final void Function(int) onNavigate;

  const HomeScreen({super.key, required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Hero Section
          _buildHeroSection(context),
          
          // Services Preview
          _buildServicesSection(context),
          
          // Stats Section
          _buildStatsSection(context),
          
          // Testimonials
          _buildTestimonialsSection(context),
          
          // CTA Section
          _buildCTASection(context),
        ],
      ),
    );
  }

  Widget _buildHeroSection(BuildContext context) {
    return Container(
      height: 600,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.primary.withOpacity(0.9),
            AppColors.primary.withOpacity(0.7),
          ],
        ),
      ),
      child: Stack(
        children: [
          // Background Image with overlay
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                image: NetworkImage(
                  'https://picsum.photos/seed/hero-business/1200/600',
                ),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  AppColors.primary.withOpacity(0.6),
                  BlendMode.darken,
                ),
              ),
            ),
          ),
          
          // Content
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppLocalizations.of(context)!.readyToTransform,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: MediaQuery.of(context).size.width < 768 ? 32 : 48,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Digital solutions for governments, retail, and hospitality sectors\nacross Africa with mobile-first approach',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      color: Colors.white.withOpacity(0.9),
                      height: 1.6,
                    ),
                  ),
                  const SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () => onNavigate(1),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: AppColors.primary,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 32,
                            vertical: 16,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          AppLocalizations.of(context)!.exploreServices,
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      OutlinedButton(
                        onPressed: () => onNavigate(4),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.white,
                          side: const BorderSide(color: Colors.white),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 32,
                            vertical: 16,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          AppLocalizations.of(context)!.contactUs,
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
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
    );
  }

  Widget _buildServicesSection(BuildContext context) {
    final services = Service.sampleServices.take(3).toList();
    
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
      color: AppColors.background,
      child: Column(
        children: [
            /*Column(
            children: [
              // Modern cube animation
              const AnimatedCube(size: 120),

              // Optional: Add a subtitle with fade-in effect
              AnimatedOpacity(
                duration: const Duration(seconds: 2),
                opacity: 1,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 40),
                  child: Text(
                    'Transforming businesses through innovative technology',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      color: AppColors.textLight,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ),
            ],
          ),*/
          //const RollingRbsCube(height: 150),
          const AdvancedCubeAnimation(size: 150),
          const SizedBox(height: 40),

          Text(
            'Our Core Solutions',
            style: GoogleFonts.poppins(
              fontSize: 36,
              fontWeight: FontWeight.w700,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Tailored for African markets and business environments',
            style: GoogleFonts.poppins(
              fontSize: 18,
              color: AppColors.textLight,
            ),
          ),
          const SizedBox(height: 50),
          
          if (MediaQuery.of(context).size.width >= 768)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: services.map((service) {
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: ServiceCard(service: service),
                  ),
                );
              }).toList(),
            )
          else
            CarouselSlider(
              options: CarouselOptions(
                height: 450,
                autoPlay: true,
                enlargeCenterPage: true,
                viewportFraction: 0.8,
              ),
              items: services.map((service) {
                return ServiceCard(service: service);
              }).toList(),
            ),
          
          const SizedBox(height: 40),
          TextButton(
            onPressed: () => onNavigate(1),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'View All Services',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(width: 8),
                const Icon(Icons.arrow_forward, color: AppColors.primary),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsSection(BuildContext context) {
    final stats = [
      {'value': '50+', 'label': 'Government Partners'},
      {'value': '200+', 'label': 'Business Clients'},
      {'value': '15+', 'label': 'African Countries'},
      {'value': '99%', 'label': 'Client Satisfaction'},
    ];
    
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
      color: AppColors.accent.withOpacity(0.3),
      child: Column(
        children: [
          Text(
            'Trusted Across Africa',
            style: GoogleFonts.poppins(
              fontSize: 36,
              fontWeight: FontWeight.w700,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 50),
          
          if (MediaQuery.of(context).size.width >= 768)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: stats.map((stat) {
                return Column(
                  children: [
                    Text(
                      stat['value']!,
                      style: GoogleFonts.poppins(
                        fontSize: 48,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      stat['label']!,
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        color: AppColors.textLight,
                      ),
                    ),
                  ],
                );
              }).toList(),
            )
          else
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 30,
              ),
              itemCount: stats.length,
              itemBuilder: (context, index) {
                final stat = stats[index];
                return Column(
                  children: [
                    Text(
                      stat['value']!,
                      style: GoogleFonts.poppins(
                        fontSize: 36,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      stat['label']!,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: AppColors.textLight,
                      ),
                    ),
                  ],
                );
              },
            ),
        ],
      ),
    );
  }

  Widget _buildTestimonialsSection(BuildContext context) {
    final testimonials = [
      {
        'name': 'Kwame Mensah',
        'role': 'Minister of Digitalization, Ghana',
        'text': 'Regisse transformed our government services. Their solutions are perfectly adapted to our local context.',
        'avatar': 'GM',
      },
      {
        'name': 'Amina Diallo',
        'role': 'CEO, Hotel Royale Senegal',
        'text': 'The hotel management system increased our efficiency by 40%. Excellent support team!',
        'avatar': 'AD',
      },
      {
        'name': 'Chukwu Emeka',
        'role': 'Owner, MegaMart Nigeria',
        'text': 'Best retail technology solution for African markets. Mobile-first approach is exactly what we needed.',
        'avatar': 'CE',
      },
    ];
    
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
      color: AppColors.background,
      child: Column(
        children: [
          Text(
            'What Our Clients Say',
            style: GoogleFonts.poppins(
              fontSize: 36,
              fontWeight: FontWeight.w700,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 50),
          
          CarouselSlider(
            options: CarouselOptions(
              height: 300,
              autoPlay: true,
              enlargeCenterPage: true,
              viewportFraction: MediaQuery.of(context).size.width < 768 ? 0.9 : 0.7,
            ),
            items: testimonials.map((testimonial) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: AppColors.accent,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          testimonial['avatar']!,
                          style: GoogleFonts.poppins(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      testimonial['text']!,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: AppColors.textLight,
                        fontStyle: FontStyle.italic,
                        height: 1.6,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      testimonial['name']!,
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      testimonial['role']!,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: AppColors.textLight,
                      ),
                    ),
                  ],
                ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildCTASection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
      color: AppColors.primary,
      child: Column(
        children: [
          Text(
            AppLocalizations.of(context)!.readyToTransform,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 36,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Join hundreds of businesses and governments across Africa\nusing our solutions to drive growth and efficiency',
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 18,
              color: Colors.white.withOpacity(0.9),
            ),
          ),
          const SizedBox(height: 40),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: AppColors.primary,
              padding: const EdgeInsets.symmetric(
                horizontal: 48,
                vertical: 18,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              AppLocalizations.of(context)!.startYourDigitalJourney,
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}