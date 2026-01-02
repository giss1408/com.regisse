// lib/widgets/advanced_cube_animation.dart
import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:ui' as ui;
import 'package:google_fonts/google_fonts.dart';
import 'package:regisse_business/constants/app_constants.dart';

class AdvancedCubeAnimation extends StatefulWidget {
  final double size;
  
  const AdvancedCubeAnimation({
    super.key,
    this.size = 150,
  });

  @override
  State<AdvancedCubeAnimation> createState() => _AdvancedCubeAnimationState();
}

class _AdvancedCubeAnimationState extends State<AdvancedCubeAnimation> 
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotationY;
  late Animation<double> _rotationX;
  late Animation<double> _scale;
  late Animation<double> _textReveal;
  late Animation<Color?> _colorTransition;
  
  final List<CubeFace> _cubeFaces = [
    CubeFace(text: 'R', color: AppColors.primary),
    CubeFace(text: 'B', color: Color(0xFF3D2476)),
    CubeFace(text: 'S', color: Color(0xFF21103E)),
  ];
  
  @override
  void initState() {
    super.initState();
    
    _controller = AnimationController(
      duration: const Duration(seconds: 8),
      vsync: this,
    )..repeat(reverse: true);
    
    _rotationY = Tween<double>(
      begin: 0,
      end: 2 * pi,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.4, curve: Curves.easeInOut),
    ));
    
    _rotationX = Tween<double>(
      begin: 0,
      end: pi / 4,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.4, 0.5, curve: Curves.easeInOut),
    ));
    
    _scale = TweenSequence<double>([
      TweenSequenceItem(tween: Tween<double>(begin: 1, end: 0.5), weight: 1),
      TweenSequenceItem(tween: Tween<double>(begin: 0.5, end: 0.2), weight: 1),
    ]).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.5, 0.7, curve: Curves.easeInOut),
    ));
    
    _textReveal = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.7, 1.0, curve: Curves.easeInOut),
    ));
    
    _colorTransition = ColorTween(
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
    return Container(
      height: widget.size * 2,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          final rotationYValue = _rotationY.value;
          final rotationXValue = _rotationX.value;
          final scaleValue = _scale.value;
          final textRevealValue = _textReveal.value;
          final colorValue = _colorTransition.value;
          
          final isCubePhase = _controller.value < 0.5;
          final isTransformPhase = _controller.value >= 0.5 && _controller.value < 0.7;
          final isTextPhase = _controller.value >= 0.7;
          
          return Stack(
            alignment: Alignment.center,
            children: [
              // Animated background
              AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                width: isTextPhase ? MediaQuery.of(context).size.width * 0.8 : widget.size * 2,
                height: isTextPhase ? widget.size * 0.8 : widget.size * 2,
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    colors: [
                      AppColors.primary.withOpacity(isTextPhase ? 0.1 : 0.3),
                      Colors.transparent,
                    ],
                    stops: const [0.1, 0.8],
                  ),
                ),
              ),
              
              if (isCubePhase || isTransformPhase)
                // 3D Cube
                Transform(
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..rotateY(rotationYValue)
                    ..rotateX(rotationXValue)
                    ..scale(scaleValue),
                  alignment: Alignment.center,
                  child: _build3DCube(),
                ),
              
              if (isTextPhase)
                // Text reveal animation
                _buildTextReveal(textRevealValue, colorValue!),
              
              // Particle system
              if (!isTextPhase)
                ..._buildParticleSystem(rotationYValue),
            ],
          );
        },
      ),
    );
  }
  
  Widget _build3DCube() {
    return Container(
      width: widget.size,
      height: widget.size,
      child: Stack(
        children: List.generate(3, (index) {
          final angle = 2 * pi * index / 3;
          return Transform(
            transform: Matrix4.identity()
              ..rotateY(angle)
              ..translate(0.0, 0.0, widget.size / 2),
            child: Container(
              width: widget.size,
              height: widget.size,
              decoration: BoxDecoration(
                color: _cubeFaces[index].color,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    _cubeFaces[index].color,
                    _cubeFaces[index].color.withOpacity(0.7),
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 20,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  _cubeFaces[index].text,
                  style: GoogleFonts.poppins(
                    fontSize: widget.size * 0.4,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        color: Colors.black.withOpacity(0.5),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
  
  Widget _buildTextReveal(double revealValue, Color color) {
    final words = ['Mobile', 'Solutions', 'For', 'Your', 'Business'];
    
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Animated text with gradient
        ShaderMask(
          shaderCallback: (bounds) {
            return LinearGradient(
              colors: [
                color,
                color.withOpacity(0.7),
                AppColors.accent,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ).createShader(bounds);
          },
          child: Column(
            children: List.generate(words.length, (index) {
              final wordReveal = revealValue.clamp(
                index * 0.2,
                (index + 1) * 0.2,
              ).toDouble();
              
              return AnimatedOpacity(
                duration: const Duration(milliseconds: 300),
                opacity: wordReveal > 0 ? 1 : 0,
                child: Transform.translate(
                  offset: Offset(0, 20 * (1 - wordReveal)),
                  child: Text(
                    words[index],
                    style: GoogleFonts.poppins(
                      fontSize: index == 0 || index == 1 
                          ? widget.size * 0.25 
                          : widget.size * 0.15,
                      fontWeight: index < 2 ? FontWeight.bold : FontWeight.w600,
                      letterSpacing: 2,
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
        
        const SizedBox(height: 20),
        
        // Animated underline
        AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          width: 200 * revealValue,
          height: 3,
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
  
  List<Widget> _buildParticleSystem(double rotationValue) {
    final particles = <Widget>[];
    final particleCount = 12;
    
    for (int i = 0; i < particleCount; i++) {
      final angle = 2 * pi * i / particleCount + rotationValue;
      final distance = widget.size * (0.7 + 0.3 * sin(rotationValue + i));
      
      particles.add(
        Positioned(
          left: distance * cos(angle) + widget.size / 2,
          top: distance * sin(angle) + widget.size / 2,
          child: Transform.rotate(
            angle: rotationValue * 2,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              width: 6 + 4 * sin(rotationValue + i),
              height: 6 + 4 * sin(rotationValue + i),
              decoration: BoxDecoration(
                color: i % 3 == 0 
                    ? AppColors.primary 
                    : i % 3 == 1 
                        ? AppColors.accent 
                        : Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.5),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
    
    return particles;
  }
}

class CubeFace {
  final String text;
  final Color color;
  
  CubeFace({required this.text, required this.color});
}

