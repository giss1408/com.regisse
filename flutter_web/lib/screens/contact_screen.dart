// lib/screens/contact_screen.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:regisse_business/constants/app_constants.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _messageController = TextEditingController();
  String _selectedTopic = 'General Inquiry';

  final List<String> _topics = [
    'General Inquiry',
    'Government Solutions',
    'Retail Technology',
    'Hotel Management',
    'Mobile Apps',
    'Cloud Services',
    'Consulting',
    'Partnership',
    'Support',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Handle form submission
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Message sent successfully!'),
          backgroundColor: AppColors.success,
        ),
      );
      _formKey.currentState!.reset();
    }
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
                  'Contact Us',
                  style: GoogleFonts.poppins(
                    fontSize: 48,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Get in touch with our team for business solutions',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
              ],
            ),
          ),

          // Contact info and form
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
            child: Column(
              children: [
                if (MediaQuery.of(context).size.width >= 768)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Contact info
                      Expanded(
                        flex: 1,
                        child: _buildContactInfo(),
                      ),
                      const SizedBox(width: 40),

                      // Contact form
                      Expanded(
                        flex: 2,
                        child: _buildContactForm(),
                      ),
                    ],
                  )
                else
                  Column(
                    children: [
                      _buildContactInfo(),
                      const SizedBox(height: 40),
                      _buildContactForm(),
                    ],
                  ),
              ],
            ),
          ),

          // FAQ Section
          Container(
            padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
            color: AppColors.accent.withOpacity(0.3),
            child: Column(
              children: [
                Text(
                  'Frequently Asked Questions',
                  style: GoogleFonts.poppins(
                    fontSize: 36,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 40),
                _buildFAQ(),
              ],
            ),
          ),

          // CTA Section
          Container(
            padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
            color: AppColors.primary,
            child: Column(
              children: [
                Text(
                  'Ready to Start Your Digital Transformation?',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 36,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Schedule a free consultation with our experts',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => _buildScheduleDialog(),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Schedule Consultation',
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

  Widget _buildContactInfo() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Get In Touch',
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 24),
            _buildInfoItem(
              Icons.location_on,
              'Address',
              AppStrings.address,
            ),
            const SizedBox(height: 20),
            _buildInfoItem(
              Icons.phone,
              'Phone',
              AppStrings.phone,
            ),
            const SizedBox(height: 20),
            _buildInfoItem(
              Icons.email,
              'Email',
              AppStrings.email,
            ),
            const SizedBox(height: 20),
            _buildInfoItem(
              Icons.access_time,
              'Working Hours',
              AppStrings.workingHours,
            ),
            const SizedBox(height: 30),
            Text(
              'Emergency Support',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '24/7 support available for critical business systems',
              style: GoogleFonts.poppins(
                color: AppColors.textLight,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Emergency: +233 987 654 321',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                color: AppColors.error,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem(IconData icon, String title, String content) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: AppColors.primary, size: 24),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                content,
                style: GoogleFonts.poppins(
                  color: AppColors.textLight,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildContactForm() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Send us a Message',
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 24),

              // Name field
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Full Name',
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Email field
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email Address',
                  prefixIcon: Icon(Icons.email),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!value.contains('@')) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Phone field
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  prefixIcon: Icon(Icons.phone),
                ),
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 16),

              // Topic dropdown
              DropdownButtonFormField<String>(
                value: _selectedTopic,
                decoration: const InputDecoration(
                  labelText: 'Topic',
                  prefixIcon: Icon(Icons.topic),
                ),
                items: _topics.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedTopic = value!;
                  });
                },
              ),
              const SizedBox(height: 16),

              // Message field
              TextFormField(
                controller: _messageController,
                decoration: const InputDecoration(
                  labelText: 'Message',
                  alignLabelWithHint: true,
                ),
                maxLines: 5,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your message';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),

              // Submit button
              ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Send Message',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFAQ() {
    final faqs = [
      {
        'question': 'What regions in Africa do you serve?',
        'answer':
            'We serve businesses and governments across 15+ African countries including Ghana, Nigeria, Kenya, South Africa, Senegal, and more.',
      },
      {
        'question': 'Do you offer custom solutions?',
        'answer':
            'Yes, we specialize in custom solutions tailored to specific business needs and local market requirements.',
      },
      {
        'question': 'What is your typical project timeline?',
        'answer':
            'Timelines vary by project complexity. Government solutions typically take 3-6 months, while retail systems can be deployed in 4-8 weeks.',
      },
      {
        'question': 'Do you provide training and support?',
        'answer':
            'Yes, we offer comprehensive training programs and 24/7 support for all our solutions.',
      },
      {
        'question': 'What payment options are available?',
        'answer':
            'We offer flexible payment plans including upfront payment, installment plans, and subscription models.',
      },
    ];

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: faqs.length,
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (context, index) {
        final faq = faqs[index];
        return ExpansionTile(
          title: Text(
            faq['question']!,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
            ),
          ),
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                faq['answer']!,
                style: GoogleFonts.poppins(
                  color: AppColors.textLight,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildScheduleDialog() {
    return AlertDialog(
      title: Text(
        'Schedule a Consultation',
        style: GoogleFonts.poppins(
          fontWeight: FontWeight.w600,
          color: AppColors.primary,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Our team will contact you within 24 hours to schedule a consultation at your convenience.',
            style: GoogleFonts.poppins(
              color: AppColors.textLight,
            ),
          ),
          const SizedBox(height: 20),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Preferred Contact Method',
              hintText: 'Email or Phone',
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Preferred Time (GMT)',
              hintText: 'e.g., Weekdays 9AM-5PM',
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Consultation request submitted!'),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
          ),
          child: const Text('Submit'),
        ),
      ],
    );
  }
}