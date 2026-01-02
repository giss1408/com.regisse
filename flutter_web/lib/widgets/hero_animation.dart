// lib/widgets/hero_animation.dart
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:google_fonts/google_fonts.dart';
import 'package:regisse_business/constants/app_constants.dart';

class HeroCubeAnimation extends StatefulWidget {
  final double size;
  
  const HeroCubeAnimation({
    super.key,
    this.size = 100,
  });

  @override
  State<HeroCubeAnimation> createState() => _HeroCubeAnimationState();
}

class _HeroCubeAnimationState extends State<HeroCubeAnimation> 
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotation;
  late Animation<double> _position;
  late Animation<double> _scale;
  late Animation<double> _textScale;
  late Animation<Color?> _color;
  
  @override
  void initState() {
    super.initState();
    
    _controller = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat(reverse: true);
    
    // Create staggered animations
    _rotation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween<double>(begin: 0, end: pi * 2), weight: 3),
      TweenSequenceItem(tween: Tween<double>(begin: pi * 2, end: pi * 4), weight: 2),
    ]).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.5, curve: Curves.easeInOut),
    ));
    
    _position = TweenSequence<double>([
      TweenSequenceItem(tween: Tween<double>(begin: 0, end: -50), weight: 1),
      TweenSequenceItem(tween: Tween<double>(begin: -50, end: 50), weight: 1),
      TweenSequenceItem(tween: Tween<double>(begin: 50, end: 0), weight: 1),
    ]).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.3, curve: Curves.easeInOut),
    ));
    
    _scale = TweenSequence<double>([
      TweenSequenceItem(tween: Tween<double>(begin: 1, end: 1.5), weight: 1),
      TweenSequenceItem(tween: Tween<double>(begin: 1.5, end: 0.5), weight: 1),
      TweenSequenceItem(tween: Tween<double>(begin: 0.5, end: 0), weight: 1),
    ]).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.5, 0.7, curve: Curves.easeInOut),
    ));
    
    _textScale = TweenSequence<double>([
      TweenSequenceItem(tween: Tween<double>(begin: 0, end: 1.2), weight: 1),
      TweenSequenceItem(tween: Tween<double>(begin: 1.2, end: 1), weight: 1),
    ]).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.7, 1.0, curve: Curves.easeInOut),
    ));
    
    _color = ColorTween(
      begin: AppColors.primary,
      end: Colors.white,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.7, 1.0, curve: Curves.easeInOut),
    ));
  }
  
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          final rotation = _rotation.value;
          final position = _position.value;
          final scale = _scale.value;
          final textScale = _textScale.value;
          final color = _color.value;
          
          final isCubePhase = _controller.value < 0.7;
          final isTextPhase = _controller.value >= 0.7;
          
          return Stack(
            alignment: Alignment.center,
            children: [
              // Background glow
              AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                width: isTextPhase ? 400 : 300,
                height: isTextPhase ? 200 : 300,
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    colors: [
                      AppColors.primary.withOpacity(isTextPhase ? 0.1 : 0.4),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
              
              if (isCubePhase)
                Transform.translate(
                  offset: Offset(0, position),
                  child: Transform.scale(
                    scale: scale,
                    child: Transform(
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, 0.001)
                        ..rotateX(rotation)
                        ..rotateY(rotation * 0.7)
                        ..rotateZ(rotation * 0.3),
                      alignment: Alignment.center,
                      child: _buildGlowingCube(rotation),
                    ),
                  ),
                ),
              
              if (isTextPhase)
                Transform.scale(
                  scale: textScale,
                  child: _buildTextAnimation(color!),
                ),
              
              // Trail effect
              if (isCubePhase)
                ..._buildTrailEffect(rotation, position),
            ],
          );
        },
      ),
    );
  }
  
  Widget _buildGlowingCube(double rotation) {
    return Container(
      width: widget.size,
      height: widget.size,
      decoration: BoxDecoration(
        gradient: SweepGradient(
          colors: [
            AppColors.primary,
            AppColors.accent,
            Colors.white,
            AppColors.primary,
          ],
          stops: const [0.0, 0.3, 0.7, 1.0],
          startAngle: rotation,
          endAngle: rotation + 2 * pi,
        ),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.5),
            blurRadius: 30,
            spreadRadius: 10,
          ),
        ],
      ),
      child: Center(
        child: Container(
          width: widget.size * 0.7,
          height: widget.size * 0.7,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 20,
              ),
            ],
          ),
          child: Center(
            child: Text(
              'RBS',
              style: GoogleFonts.poppins(
                fontSize: widget.size * 0.25,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
          ),
        ),
      ),
    );
  }
  
  Widget _buildTextAnimation(Color color) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Gradient text with animation
        ShaderMask(
          shaderCallback: (bounds) {
            return LinearGradient(
              colors: [
                color,
                color.withOpacity(0.7),
                AppColors.accent,
              ],
              stops: const [0.0, 0.5, 1.0],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ).createShader(bounds);
          },
          child: Text(
            'Mobile Solutions',
            style: GoogleFonts.poppins(
              fontSize: 48,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            ),
          ),
        ),
        
        const SizedBox(height: 10),
        
        // Animated subtitle
        AnimatedOpacity(
          duration: const Duration(milliseconds: 1000),
          opacity: _controller.value > 0.8 ? 1 : 0,
          child: Text(
            'For Your Business',
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: AppColors.textLight,
              letterSpacing: 1,
            ),
          ),
        ),
        
        // Animated underline
        AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          width: 300 * (_controller.value - 0.7).clamp(0, 1),
          height: 3,
          margin: const EdgeInsets.only(top: 10),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.primary, AppColors.accent],
            ),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ],
    );
  }
  
  List<Widget> _buildTrailEffect(double rotation, double position) {
    final trails = <Widget>[];
    final trailCount = 5;
    
    for (int i = 0; i < trailCount; i++) {
      final offset = (trailCount - i) * 5.0;
      final opacity = 0.5 * (1 - i / trailCount);
      
      trails.add(
        Transform.translate(
          offset: Offset(0, position + offset),
          child: Transform(
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateX(rotation - i * 0.1)
              ..rotateY(rotation * 0.7 - i * 0.1)
              ..rotateZ(rotation * 0.3 - i * 0.1),
            alignment: Alignment.center,
            child: Container(
              width: widget.size * (1 - i * 0.1),
              height: widget.size * (1 - i * 0.1),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(opacity),
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
      );
    }
    
    return trails;
  }
}

