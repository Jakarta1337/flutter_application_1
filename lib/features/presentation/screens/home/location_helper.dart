// ignore_for_file: use_build_context_synchronously

import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';

Future<void> checkLocationAccess(BuildContext context) async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    _showLocationDialog(
      context,
      "Location services are disabled. Please enable them.",
    );
    return;
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      _showLocationDialog(
        context,
        "Location permission denied. Please allow access.",
      );
      return;
    }
  }

  if (permission == LocationPermission.deniedForever) {
    _showLocationDialog(
      context,
      "Location permission permanently denied. Enable it from app settings.",
    );
    return;
  }

  Position position = await Geolocator.getCurrentPosition(
    locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
  );

  const double centerLat = 33.9275;
  const double centerLng = -6.9063;
  const double perimeterRadius = 50;

  double distanceInMeters = Geolocator.distanceBetween(
    position.latitude,
    position.longitude,
    centerLat,
    centerLng,
  );

  if (distanceInMeters > perimeterRadius) {
    _showLocationDialog(context, "You are outside the allowed area.");
    return;
  }
}

void _showLocationDialog(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        title: const Text('Location Required'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              checkLocationAccess(context);
            },
            child: const Text('Retry'),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Cancel'),
          ),
        ],
      );
    },
  );
}
