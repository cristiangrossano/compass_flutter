import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:math' as math;

import 'neu_circle.dart';

void main(L) {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _hasPermissions = false;

  @override
  void initState() {
    super.initState();
  }

  void _fetchPermissionStatus() {
    Permission.locationWhenInUse.status.then((status) {
      if (mounted) {
        setState(() {
          _hasPermissions = (status == PermissionStatus.granted);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Builder(
          builder: (context) {
            if (_hasPermissions) {
              return _buildCompass();
            } else {
              return _buildPermissionSheet();
            }
          },
        ),
      ),
    );
  }

  // compass widget
  Widget _buildCompass() {
    return StreamBuilder<CompassEvent>(
      stream: FlutterCompass.events,
      builder: ((context, snapshot) {
        if (snapshot.hasError) {
          return Text("Errore ${snapshot.error}");
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        double? direction = snapshot.data!.heading;

        if (direction == null) {
          return const Text("Il dispositivo non supporta i sensori");
        }

        return NeuCircle(
          child: Transform.rotate(
            angle: direction * (math.pi / 180) * -1,
            child: Image.asset(
              "lib/images/bussola.png",
              color: Colors.black,
              fit: BoxFit.fill,
            ),
          ),
        );
      }),
    );
  }

  // permission sheet
  Widget _buildPermissionSheet() {
    return Center(
      child: ElevatedButton(
        child: const Text(
          'Richiesta Permessi',
        ),
        onPressed: () {
          Permission.locationWhenInUse.request().then(
            (value) {
              _fetchPermissionStatus();
            },
          );
        },
      ),
    );
  }
}
