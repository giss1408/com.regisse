import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:regisse_business/constants/app_constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NavBar extends StatefulWidget {
  final void Function(int) onItemSelected;
  final void Function(String)? onLocaleChanged;
  final String currentLocale;

  NavBar({super.key, required this.onItemSelected, this.onLocaleChanged, this.currentLocale = 'en'});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _selectedIndex = 0;
  
  List<Map<String, dynamic>> _navItems(BuildContext context) => [
        {'label': AppLocalizations.of(context)!.home, 'icon': Icons.home},
        {'label': AppLocalizations.of(context)!.services, 'icon': Icons.business_center},
        {'label': AppLocalizations.of(context)!.locations, 'icon': Icons.location_on},
        {'label': AppLocalizations.of(context)!.blog, 'icon': Icons.article},
        {'label': AppLocalizations.of(context)!.contact, 'icon': Icons.contact_mail},
      ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // Desktop Navigation
          if (MediaQuery.of(context).size.width >= 768)
            Row(
              children: List.generate(_navItems(context).length, (index) {
                final label = _navItems(context)[index]['label'] as String;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        _selectedIndex = index;
                      });
                      widget.onItemSelected(index);
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: _selectedIndex == index
                          ? AppColors.primary
                          : AppColors.textLight,
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      label,
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: _selectedIndex == index
                            ? FontWeight.w600
                            : FontWeight.w400,
                      ),
                    ),
                  ),
                );
              }),
            )
          else
            // Mobile menu button
            IconButton(
              onPressed: () {
                _showMobileMenu(context);
              },
              icon: const Icon(Icons.menu, color: AppColors.primary),
            ),
          
          // CTA Button
          const SizedBox(width: 16),
          // Language selector (flag icons) — disable splash/highlight so it
          // doesn't stay grey after interaction.
          Theme(
            data: Theme.of(context).copyWith(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              hoverColor: Colors.transparent,
            ),
            child: DropdownButton<String>(
              dropdownColor: Colors.white,
              value: widget.currentLocale,
              underline: const SizedBox.shrink(),
              iconEnabledColor: AppColors.primary,
              items: [
                DropdownMenuItem(
                  value: 'en',
                  child: SvgPicture.asset('assets/flags/gb.svg', width: 24, height: 16),
                ),
                DropdownMenuItem(
                  value: 'fr',
                  child: SvgPicture.asset('assets/flags/fr.svg', width: 24, height: 16),
                ),
                DropdownMenuItem(
                  value: 'de',
                  child: SvgPicture.asset('assets/flags/de.svg', width: 24, height: 16),
                ),
              ],
              onChanged: (val) {
                if (val != null && widget.onLocaleChanged != null) {
                  widget.onLocaleChanged!(val);
                }
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              // Navigate to contact page
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 12,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              elevation: 0,
              shadowColor: Colors.transparent,
            ),
            child: Text(
              'Get Started',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showMobileMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Menu',
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primary,
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close, color: AppColors.primary),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              ...List.generate(_navItems(context).length, (index) {
                return ListTile(
                  leading: Icon(
                    _navItems(context)[index]['icon'],
                    color: _selectedIndex == index 
                        ? AppColors.primary 
                        : AppColors.textLight,
                  ),
                  title: Text(
                    _navItems(context)[index]['label'],
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: _selectedIndex == index 
                          ? FontWeight.w600 
                          : FontWeight.w400,
                      color: _selectedIndex == index 
                          ? AppColors.primary 
                          : AppColors.textDark,
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      _selectedIndex = index;
                    });
                    Navigator.pop(context);
                    widget.onItemSelected(index);
                  },
                );
              }),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    widget.onItemSelected(4);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Get Started',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}