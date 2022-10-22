import 'package:flutter/material.dart';

class NeuCircle extends StatelessWidget {
  final child;
  const NeuCircle({
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      alignment: Alignment.center,
      margin: EdgeInsets.all(40.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.brown[600],
        boxShadow: [
          BoxShadow(
              color: Colors.brown.shade800,
              offset: Offset(4.0, 4.0),
              blurRadius: 15.0,
              spreadRadius: 1.0),
          BoxShadow(color: Colors.brown.shade500, offset: Offset(-4.0, -4.0))
        ],
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.brown.shade500,
              Colors.brown.shade600,
              Colors.brown.shade700,
              Colors.brown.shade800,
            ],
            stops: [
              0.1,
              0.3,
              0.8,
              1
            ]),
      ),
      child: child,
    );
  }
}
