// lib/screens/blog_screen.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:regisse_business/constants/app_constants.dart';

class BlogScreen extends StatelessWidget {
  const BlogScreen({super.key});

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
                  'Blog & Insights',
                  style: GoogleFonts.poppins(
                    fontSize: 48,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Latest trends, insights, and success stories from African businesses',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
              ],
            ),
          ),

          // Search and filter
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search articles...',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                PopupMenuButton<String>(
                  icon: const Icon(Icons.filter_list),
                  onSelected: (value) {},
                  itemBuilder: (context) {
                    return [
                      'All Topics',
                      'Government Tech',
                      'Retail Innovation',
                      'Hospitality Trends',
                      'Mobile Solutions',
                      'Success Stories',
                    ].map((category) {
                      return PopupMenuItem(
                        value: category,
                        child: Text(category),
                      );
                    }).toList();
                  },
                ),
              ],
            ),
          ),

          // Featured post
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Card(
              elevation: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(8),
                    ),
                    child: Image.network(
                      'https://picsum.photos/seed/digital-transformation/1200/300',
                      height: 300,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Container(
                          height: 300,
                          color: AppColors.accent.withOpacity(0.3),
                          child: const Center(child: CircularProgressIndicator()),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 300,
                          color: AppColors.accent,
                          child: const Icon(Icons.broken_image, size: 64, color: AppColors.primary),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Chip(
                          label: const Text('Featured'),
                          backgroundColor: AppColors.primary,
                          labelStyle: const TextStyle(color: Colors.white),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Digital Transformation in African Governments: 2024 Trends',
                          style: GoogleFonts.poppins(
                            fontSize: 28,
                            fontWeight: FontWeight.w700,
                            color: AppColors.primary,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Explore how African governments are leveraging technology to improve public services and drive economic growth.',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: AppColors.textLight,
                            height: 1.6,
                          ),
                        ),
                        const SizedBox(height: 24),
                        Row(
                          children: [
                            const CircleAvatar(
                              radius: 20,
                              backgroundImage: NetworkImage('https://picsum.photos/seed/author-kwame/100/100'),
                            ),
                            const SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Kwame Appiah',
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  'January 15, 2024 • 8 min read',
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    color: AppColors.textLight,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Blog posts grid
          Padding(
            padding: const EdgeInsets.all(20),
            child: _buildBlogGrid(),
          ),

          // Newsletter subscription
          Container(
            padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
            color: AppColors.accent.withOpacity(0.3),
            child: Column(
              children: [
                Text(
                  'Stay Updated',
                  style: GoogleFonts.poppins(
                    fontSize: 36,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Subscribe to our newsletter for the latest insights and updates',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    color: AppColors.textLight,
                  ),
                ),
                const SizedBox(height: 30),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 500),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Enter your email address',
                      suffixIcon: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.horizontal(
                              right: Radius.circular(8),
                            ),
                          ),
                        ),
                        child: const Text('Subscribe'),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'By subscribing, you agree to our Privacy Policy',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: AppColors.textLight,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBlogGrid() {
    final posts = [
      {
        'title': 'Mobile Payments Revolution in African Retail',
        'category': 'Retail Innovation',
        'date': 'Jan 12, 2024',
        'image': 'https://picsum.photos/seed/mobile-payments/800/600',
      },
      {
        'title': 'Sustainable Tourism Tech Solutions',
        'category': 'Hospitality Trends',
        'date': 'Jan 10, 2024',
        'image': 'https://picsum.photos/seed/tourism-tech/800/600',
      },
      {
        'title': 'Building Resilient Cloud Infrastructure',
        'category': 'Technology',
        'date': 'Jan 8, 2024',
        'image': 'https://picsum.photos/seed/cloud-infrastructure/800/600',
      },
      {
        'title': 'Ghana\'s Digital Government Success Story',
        'category': 'Success Stories',
        'date': 'Jan 5, 2024',
        'image': 'https://picsum.photos/seed/ghana-digital-government/800/600',
      },
      {
        'title': 'AI in African Business: Opportunities & Challenges',
        'category': 'Technology',
        'date': 'Jan 3, 2024',
        'image': 'https://picsum.photos/seed/ai-business/800/600',
      },
      {
        'title': 'E-commerce Growth in West Africa',
        'category': 'Retail Innovation',
        'date': 'Dec 28, 2023',
        'image': 'https://picsum.photos/seed/ecommerce-west-africa/800/600',
      },
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        childAspectRatio: 0.75,
      ),
      itemCount: posts.length,
      itemBuilder: (context, index) {
        final post = posts[index];
        return Card(
          elevation: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(8),
                  ),
                  child: Image.network(
                    post['image']!,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        color: AppColors.accent.withOpacity(0.2),
                        child: const Center(child: CircularProgressIndicator()),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: AppColors.accent.withOpacity(0.2),
                        child: const Center(child: Icon(Icons.broken_image, size: 48, color: Colors.grey)),
                      );
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Chip(
                      label: Text(post['category']!),
                      backgroundColor: AppColors.accent,
                      labelStyle: GoogleFonts.poppins(fontSize: 10),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      post['title']!,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textDark,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      post['date']!,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: AppColors.textLight,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}