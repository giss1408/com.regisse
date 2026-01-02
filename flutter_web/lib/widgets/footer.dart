import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:regisse_business/constants/app_constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Footer extends StatefulWidget {
  final int currentIndex;
  final Function(int) onTabTapped;
  final bool isCompact;

  const Footer({
    super.key,
    required this.currentIndex,
    required this.onTabTapped,
    this.isCompact = false,
  });

  @override
  State<Footer> createState() => _FooterState();
}

class _FooterState extends State<Footer> {
  OverlayEntry? _overlayEntry;
  Timer? _hideTimer;

  void _showOverlay() {
    if (_overlayEntry != null) return;
    _overlayEntry = OverlayEntry(builder: (context) {
      return Positioned(
        left: 0,
        right: 0,
        bottom: 0,
        child: MouseRegion(
          onEnter: (_) => _cancelHide(),
          onExit: (_) => _scheduleHide(),
          child: Material(
            color: Colors.transparent,
            child: Container(
              color: AppColors.primary,
              padding: const EdgeInsets.all(40),
              child: _buildFullFooterContent(context),
            ),
          ),
        ),
      );
    });

    Overlay.of(context).insert(_overlayEntry!);
  }

  void _hideOverlayNow() {
    _hideTimer?.cancel();
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  void _scheduleHide() {
    _hideTimer?.cancel();
    _hideTimer = Timer(const Duration(milliseconds: 300), () {
      _hideOverlayNow();
    });
  }

  void _cancelHide() {
    _hideTimer?.cancel();
  }

  @override
  void dispose() {
    _hideTimer?.cancel();
    _overlayEntry?.remove();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isCompact) {
      return MouseRegion(
        onEnter: (_) => _showOverlay(),
        onExit: (_) => _scheduleHide(),
        child: GestureDetector(
          onTap: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (ctx) {
                return DraggableScrollableSheet(
                  expand: false,
                  initialChildSize: 0.75,
                  minChildSize: 0.4,
                  maxChildSize: 0.95,
                  builder: (_, controller) {
                    return Container(
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                      ),
                      padding: const EdgeInsets.all(24),
                      child: SingleChildScrollView(
                        controller: controller,
                        child: _buildFullFooterContent(ctx),
                      ),
                    );
                  },
                );
              },
            );
          },
          child: Container(
            color: AppColors.primary,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    AppStrings.companyName,
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 8),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () {},
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints.tightFor(width: 36, height: 36),
                      icon: const FaIcon(FontAwesomeIcons.facebook, color: Colors.white, size: 16),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      onPressed: () {},
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints.tightFor(width: 36, height: 36),
                      icon: const FaIcon(FontAwesomeIcons.twitter, color: Colors.white, size: 16),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      onPressed: () {},
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints.tightFor(width: 36, height: 36),
                      icon: const FaIcon(FontAwesomeIcons.linkedin, color: Colors.white, size: 16),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Container(
      color: AppColors.primary,
      padding: const EdgeInsets.all(40),
      child: _buildFullFooterContent(context),
    );
  }

  Widget _buildFullFooterContent(BuildContext context) {
    void onTabTapped(int index) {
      widget.onTabTapped(index);
      _hideOverlayNow();
    }

    return LayoutBuilder(builder: (context, constraints) {
      // Use a column on narrow screens, row on wide screens
      final isWide = constraints.maxWidth > 800;
      if (!isWide) {
        return _buildMobileFooter(context);
      }

      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Company Info
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.companyName,
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  AppStrings.tagline,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: Colors.white.withOpacity(0.9),
                    height: 1.6,
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  children: const [
                    FaIcon(FontAwesomeIcons.facebook, color: Colors.white),
                    SizedBox(width: 16),
                    FaIcon(FontAwesomeIcons.twitter, color: Colors.white),
                    SizedBox(width: 16),
                    FaIcon(FontAwesomeIcons.linkedin, color: Colors.white),
                    SizedBox(width: 16),
                    FaIcon(FontAwesomeIcons.instagram, color: Colors.white),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(width: 40),

          // Quick Links
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Quick Links',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                ...['Home', 'Services', 'Locations', 'Blog', 'Contact'].map((item) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: InkWell(
                      onTap: () {
                        final index = ['Home', 'Services', 'Locations', 'Blog', 'Contact']
                            .indexOf(item);
                        onTabTapped(index);
                      },
                      child: Text(
                        item,
                        style: GoogleFonts.poppins(
                          color: Colors.white.withOpacity(0.8),
                          fontSize: 16,
                        ),
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),

          const SizedBox(width: 40),

          // Contact Info
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Contact Us',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                _buildContactItem(Icons.location_on, AppStrings.address),
                const SizedBox(height: 12),
                _buildContactItem(Icons.phone, AppStrings.phone),
                const SizedBox(height: 12),
                _buildContactItem(Icons.email, AppStrings.email),
                const SizedBox(height: 12),
                _buildContactItem(Icons.access_time, AppStrings.workingHours),
              ],
            ),
          ),
        ],
      );
    });
  }

  Widget _buildMobileFooter(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Company Info
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppStrings.companyName,
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              AppStrings.tagline,
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.white.withOpacity(0.9),
                height: 1.6,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: const [
                FaIcon(FontAwesomeIcons.facebook, color: Colors.white),
                SizedBox(width: 16),
                FaIcon(FontAwesomeIcons.twitter, color: Colors.white),
                SizedBox(width: 16),
                FaIcon(FontAwesomeIcons.linkedin, color: Colors.white),
                SizedBox(width: 16),
                FaIcon(FontAwesomeIcons.instagram, color: Colors.white),
              ],
            ),
          ],
        ),

        const SizedBox(height: 30),

        // Quick Links
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Quick Links',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 20,
              runSpacing: 12,
              children: ['Home', 'Services', 'Locations', 'Blog', 'Contact'].map((item) {
                return InkWell(
                  onTap: () {
                    final index = ['Home', 'Services', 'Locations', 'Blog', 'Contact']
                        .indexOf(item);
                    widget.onTabTapped(index);
                    Navigator.of(context).maybePop();
                  },
                  child: Text(
                    item,
                    style: GoogleFonts.poppins(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 14,
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),

        const SizedBox(height: 30),

        // Contact Info
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Contact Us',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            _buildContactItem(Icons.location_on, AppStrings.address),
            const SizedBox(height: 8),
            _buildContactItem(Icons.phone, AppStrings.phone),
            const SizedBox(height: 8),
            _buildContactItem(Icons.email, AppStrings.email),
            const SizedBox(height: 8),
            _buildContactItem(Icons.access_time, AppStrings.workingHours),
          ],
        ),
      ],
    );
  }

  Widget _buildContactItem(IconData icon, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: AppColors.accent, size: 20),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: GoogleFonts.poppins(
              color: Colors.white.withOpacity(0.9),
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }
}