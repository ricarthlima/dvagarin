import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class LocationMap extends StatelessWidget {
  final Position position;
  final double zoom;

  const LocationMap({super.key, required this.position, this.zoom = 15.0});

  @override
  Widget build(BuildContext context) {
    final LatLng centerPoint = LatLng(position.latitude, position.longitude);

    return FlutterMap(
      options: MapOptions(initialCenter: centerPoint, initialZoom: zoom),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.example.vagarin_app',
        ),
        MarkerLayer(
          markers: [
            Marker(
              width: 80.0,
              height: 80.0,
              point: centerPoint,
              child: const Icon(
                Icons.location_pin,
                color: Colors.red,
                size: 40.0,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
