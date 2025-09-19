import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatelessWidget {
  final double latitude;
  final double longitude;
  final String siteName;

  const MapScreen({
    super.key,
    required this.latitude,
    required this.longitude,
    required this.siteName,
  });

  @override
  Widget build(BuildContext context) {
    final LatLng siteLocation = LatLng(latitude, longitude);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigoAccent,
        title: Text(
          siteName,
          style: GoogleFonts.aBeeZee(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(target: siteLocation, zoom: 15),
        markers: {
          Marker(
            markerId: const MarkerId("site_marker"),
            position: siteLocation,
            infoWindow: InfoWindow(title: siteName),
          ),
        },
      ),
    );
  }
}
