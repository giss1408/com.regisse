// lib/models/service.dart
class Service {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final List<String> features;
  final String category;
  final double startingPrice;

  Service({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.features,
    required this.category,
    required this.startingPrice,
  });

  static List<Service> get sampleServices => [
    Service(
      id: '1',
      title: 'Government Digital Transformation',
      description: 'Complete digital solutions for government agencies.',
      imageUrl: 'https://images.pexels.com/photos/18515183/pexels-photo-18515183.jpeg',
      features: ['E-Governance', 'Citizen Portals', 'Document Management'],
      category: 'government',
      startingPrice: 50000,
    ),
    Service(
      id: '2',
      title: 'Retail Technology Solutions',
      description: 'POS systems and inventory management.',
      imageUrl: 'https://images.pexels.com/photos/4314673/pexels-photo-4314673.jpeg',
      features: ['POS Systems', 'Inventory Management', 'E-commerce'],
      category: 'retail',
      startingPrice: 1500,
    ),
    Service(
      id: '3',
      title: 'Hotel Management Systems',
      description: 'Hotel management software for operations.',
      imageUrl: 'https://images.pexels.com/photos/14212551/pexels-photo-14212551.jpeg',
      features: ['Booking Management', 'Guest Services', 'Billing'],
      category: 'hospitality',
      startingPrice: 3000,
    ),
    Service(
      id: '4',
      title: 'Mobile-First Business Apps',
      description: 'Custom mobile applications.',
      imageUrl: 'https://picsum.photos/seed/mobile-apps/800/600',
      features: ['iOS & Android', 'Offline Functionality', 'Local Payments'],
      category: 'technology',
      startingPrice: 5000,
    ),
    Service(
      id: '5',
      title: 'Cloud Infrastructure',
      description: 'Secure cloud solutions hosted locally.',
      imageUrl: 'https://picsum.photos/seed/cloud-services/800/600',
      features: ['African Data Centers', 'GDPR Compliance', '24/7 Support'],
      category: 'technology',
      startingPrice: 1000,
    ),
    Service(
      id: '6',
      title: 'Business Consulting',
      description: 'Strategic consulting services.',
      imageUrl: 'https://picsum.photos/seed/consulting/800/600',
      features: ['Digital Strategy', 'Process Optimization', 'Training'],
      category: 'consulting',
      startingPrice: 2000,
    ),
  ];
}