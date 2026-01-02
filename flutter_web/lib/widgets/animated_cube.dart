// lib/widgets/animated_cube.dart
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:google_fonts/google_fonts.dart';
import 'package:regisse_business/constants/app_constants.dart';

class AnimatedCube extends StatefulWidget {
  final double size;
  final Duration animationDuration;
  
  const AnimatedCube({
    super.key,
    this.size = 120,
    this.animationDuration = const Duration(seconds: 6),
  });

  @override
  State<AnimatedCube> createState() => _AnimatedCubeState();
}

class _AnimatedCubeState extends State<AnimatedCube> 
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotationAnimation;
  late Animation<double> _transformAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;
  
  final List<String> _cubeTexts = ['R', 'B', 'S'];
  final List<String> _transformTexts = [
    'Mobile',
    'Solutions',
    'For',
    'Your',
    'Business'
  ];
  
  @override
  void initState() {
    super.initState();
    
    _controller = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    )..repeat(reverse: true);
    
    _rotationAnimation = Tween<double>(
      begin: 0,
      end: 2 * pi,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.5, curve: Curves.easeInOut),
    ));
    
    _transformAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.5, 0.7, curve: Curves.easeInOut),
    ));
    
    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween<double>(begin: 1, end: 1.2), weight: 1),
      TweenSequenceItem(tween: Tween<double>(begin: 1.2, end: 1), weight: 1),
    ]).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.7, 1.0, curve: Curves.easeInOut),
    ));
    
    _opacityAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween<double>(begin: 1, end: 1), weight: 6),
      TweenSequenceItem(tween: Tween<double>(begin: 1, end: 0), weight: 1),
      TweenSequenceItem(tween: Tween<double>(begin: 0, end: 1), weight: 1),
    ]).animate(_controller);
  }
  
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.size * 1.5,
      width: double.infinity,
      child: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            final rotationValue = _rotationAnimation.value;
            final transformValue = _transformAnimation.value;
            final scaleValue = _scaleAnimation.value;
            final opacityValue = _opacityAnimation.value;
            
            // Check if we're in transformation phase
            final isTransforming = _controller.value > 0.5;
            final isComplete = _controller.value > 0.7;
            
            return Stack(
              alignment: Alignment.center,
              children: [
                // Background glow effect
                if (!isComplete)
                  Container(
                    width: widget.size * 1.5,
                    height: widget.size * 1.5,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          AppColors.primary.withOpacity(0.3),
                          Colors.transparent,
                        ],
                        stops: const [0.1, 0.8],
                      ),
                    ),
                  ),
                
                // 3D Cube or Text Transformation
                if (!isTransforming)
                  // 3D Cube Phase
                  Transform(
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001) // Perspective
                      ..rotateX(rotationValue * 0.5)
                      ..rotateY(rotationValue)
                      ..rotateZ(rotationValue * 0.3),
                    alignment: Alignment.center,
                    child: _buildCube(),
                  )
                else
                  // Text Transformation Phase
                  Transform.scale(
                    scale: scaleValue,
                    child: Opacity(
                      opacity: opacityValue,
                      child: _buildTransformedText(transformValue),
                    ),
                  ),
                
                // Floating particles
                if (!isComplete)
                  ..._buildParticles(rotationValue),
              ],
            );
          },
        ),
      ),
    );
  }
  
  Widget _buildCube() {
    return Container(
      width: widget.size,
      height: widget.size,
      child: Stack(
        children: [
          // Front face
          Transform(
            transform: Matrix4.identity()..translate(0.0, 0.0, widget.size / 2),
            child: _buildCubeFace(0, Colors.white),
          ),
          
          // Back face
          Transform(
            transform: Matrix4.identity()..translate(0.0, 0.0, -widget.size / 2),
            child: _buildCubeFace(1, AppColors.primary.withOpacity(0.9)),
          ),
          
          // Left face
          Transform(
            transform: Matrix4.identity()
              ..translate(-widget.size / 2, 0.0, 0.0)
              ..rotateY(pi / 2),
            child: _buildCubeFace(2, AppColors.primary.withOpacity(0.8)),
          ),
          
          // Right face
          Transform(
            transform: Matrix4.identity()
              ..translate(widget.size / 2, 0.0, 0.0)
              ..rotateY(pi / 2),
            child: _buildCubeFace(0, AppColors.primary.withOpacity(0.7)),
          ),
          
          // Top face
          Transform(
            transform: Matrix4.identity()
              ..translate(0.0, -widget.size / 2, 0.0)
              ..rotateX(pi / 2),
            child: _buildCubeFace(1, AppColors.primary.withOpacity(0.9)),
          ),
          
          // Bottom face
          Transform(
            transform: Matrix4.identity()
              ..translate(0.0, widget.size / 2, 0.0)
              ..rotateX(pi / 2),
            child: _buildCubeFace(2, AppColors.primary.withOpacity(0.8)),
          ),
        ],
      ),
    );
  }
  
  Widget _buildCubeFace(int index, Color color) {
    return Container(
      width: widget.size,
      height: widget.size,
      decoration: BoxDecoration(
        color: color,
        border: Border.all(
          color: Colors.white.withOpacity(0.3),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Center(
        child: Text(
          _cubeTexts[index % _cubeTexts.length],
          style: GoogleFonts.poppins(
            fontSize: widget.size * 0.3,
            fontWeight: FontWeight.bold,
            color: index == 0 ? AppColors.primary : Colors.white,
          ),
        ),
      ),
    );
  }
  
  Widget _buildTransformedText(double transformValue) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Animated text with gradient
        ShaderMask(
          shaderCallback: (bounds) {
            return LinearGradient(
              colors: [
                AppColors.primary,
                AppColors.primary.withOpacity(0.7),
                AppColors.accent,
              ],
              stops: [0.0, 0.5, 1.0],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ).createShader(bounds);
          },
          child: Text(
            'Mobile Solutions',
            style: GoogleFonts.poppins(
              fontSize: widget.size * 0.3,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            ),
          ),
        ),
        
        const SizedBox(height: 8),
        
        // Animated subtitle
        AnimatedOpacity(
          duration: const Duration(milliseconds: 500),
          opacity: transformValue > 0.5 ? 1 : 0,
          child: Transform.translate(
            offset: Offset(0, 20 * (1 - transformValue)),
            child: Text(
              'For Your Business',
              style: GoogleFonts.poppins(
                fontSize: widget.size * 0.15,
                fontWeight: FontWeight.w600,
                color: AppColors.textLight,
              ),
            ),
          ),
        ),
      ],
    );
  }
  
  List<Widget> _buildParticles(double rotationValue) {
    final particles = <Widget>[];
    final particleCount = 8;
    
    for (int i = 0; i < particleCount; i++) {
      final angle = 2 * pi * i / particleCount + rotationValue;
      final distance = widget.size * 0.8;
      
      particles.add(
        Positioned(
          left: distance * cos(angle) + widget.size / 2,
          top: distance * sin(angle) + widget.size / 2,
          child: Transform.rotate(
            angle: rotationValue,
            child: Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: [
                  AppColors.primary,
                  AppColors.accent,
                  Colors.white,
                ][i % 3].withOpacity(0.7),
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
      );
    }
    
    return particles;
  }
}

