import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:regisse_business/constants/app_constants.dart';

class RollingRbsCube extends StatefulWidget {
  final double height;
  const RollingRbsCube({super.key, this.height = 140});

  @override
  State<RollingRbsCube> createState() => _RollingRbsCubeState();
}

class _RollingRbsCubeState extends State<RollingRbsCube>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctr;
  bool _showMobile = false;

  @override
  void initState() {
    super.initState();
    _ctr = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 9000),
    )..repeat(reverse: true);
    // Toggle heading state when animation reaches ends (start or end)
    _ctr.addListener(() {
      final v = _ctr.value;
      if (v >= 0.995 && !_showMobile) {
        setState(() {
          _showMobile = true;
        });
      } else if (v <= 0.005 && _showMobile) {
        setState(() {
          _showMobile = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _ctr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final width = constraints.maxWidth;
      final cubeSize = (widget.height * 0.6).clamp(48.0, 120.0);

      return SizedBox(
        height: widget.height,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Animated heading (switches when cube near center)
            Positioned(
              top: 8,
              left: 0,
              right: 0,
              child: AnimatedBuilder(
                animation: _ctr,
                builder: (context, _) {
                    // Use the latched _showMobile which toggles only when animation hits ends
                    final showMobile = _showMobile;
                  return Center(
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 350),
                      transitionBuilder: (child, anim) => FadeTransition(
                        opacity: anim,
                        child: SlideTransition(
                          position: Tween(begin: const Offset(0, 0.08), end: Offset.zero).animate(anim),
                          child: child,
                        ),
                      ),
                      child: Text(
                        showMobile ? 'Mobile solutions for your business' : 'Transforming your businesses in Africa',
                        key: ValueKey(showMobile),
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontSize: width < 768 ? 22 : 36,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            // Cube rolling from left to right
            AnimatedBuilder(
              animation: _ctr,
              builder: (context, _) {
                final t = _ctr.value; // 0..1
                // Map t to x position from -cubeSize to width + cubeSize
                final start = -cubeSize - 20.0;
                final end = width + cubeSize + 20.0;
                final x = start + (end - start) * t;

                // rotation angle for rolling effect
                final rotations = 0.8; // gentler spin
                final angle = (start - x) / cubeSize * -rotations * math.pi;

                // Parabolic bounce centered at t=0.5 producing a single hop
                final f = 1 - (2 * (t - 0.5)).abs();
                final clipped = f.clamp(0.0, 1.0);
                final hop = clipped * clipped * 12.0; // amplitude

                // Slight squash on vertical axis proportional to hop height
                final squash = 1.0 - (hop / 120.0).clamp(0.0, 0.08);

                final matrix = Matrix4.identity()
                  ..translate(0.0, 0.0)
                  ..rotateZ(angle)
                  ..scale(1.0, squash, 1.0)
                  ..setEntry(3, 2, 0.001);

                return Positioned(
                  bottom: 8 + hop,
                  left: x.clamp(0.0, width - cubeSize),
                  child: Transform(
                    alignment: Alignment.center,
                    transform: matrix,
                    child: _buildCube(cubeSize),
                  ),
                );
              },
            ),
          ],
        ),
      );
    });
  }

  Widget _buildCube(double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: LinearGradient(
          colors: [AppColors.primary, AppColors.accent.withOpacity(0.9)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.18), blurRadius: 10, offset: const Offset(0, 6)),
        ],
      ),
      child: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('R', style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.w800, fontSize: size * 0.36)),
            const SizedBox(width: 4),
            Text('B', style: GoogleFonts.poppins(color: Colors.white70, fontWeight: FontWeight.w800, fontSize: size * 0.36)),
            const SizedBox(width: 4),
            Text('S', style: GoogleFonts.poppins(color: Colors.white54, fontWeight: FontWeight.w800, fontSize: size * 0.36)),
          ],
        ),
      ),
    );
  }
}
