import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../utlis/utils.dart';
import '../../widgets/reuseablerow.dart'; // Adjust your imports accordingly

class Nearby extends StatefulWidget {
  const Nearby({Key? key}) : super(key: key);

  @override
  State<Nearby> createState() => _NearbyState();
}

class _NearbyState extends State<Nearby> {
  late GoogleMapController mapController;
  LocationData? currentLocation;
  Location location = Location();
  List<Marker> _markers = [];
  List<Map<String, dynamic>> _nearbyBars = [];
  TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _getLocation();
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text;
        _fetchNearbyBars();
      });
    });
  }

  Future<void> _getLocation() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    currentLocation = await location.getLocation();
    setState(() {
      _fetchNearbyBars();
    });
  }

  Future<void> _fetchNearbyBars() async {
    if (currentLocation == null) return;

    final barsCollection = FirebaseFirestore.instance.collection('Bars');
    final querySnapshot = await barsCollection.get();

    List<Marker> markers = [];
    List<Map<String, dynamic>> nearbyBars = [];

    for (var doc in querySnapshot.docs) {
      final data = doc.data() as Map<String, dynamic>;
      final barName = data['name'] as String;
      final latitude = data['latitude'] as double;
      final longitude = data['longitude'] as double;

      final distance = calculateDistance(
        currentLocation!.latitude!,
        currentLocation!.longitude!,
        latitude,
        longitude,
      );

      if (distance <= 2000 && // Within 2km
          (_searchQuery.isEmpty || barName.toLowerCase().contains(_searchQuery.toLowerCase()))) {
        markers.add(
          Marker(
            markerId: MarkerId(doc.id),
            position: LatLng(latitude, longitude),
            infoWindow: InfoWindow(title: barName),
          ),
        );

        nearbyBars.add({
          'name': barName,
          'latitude': latitude,
          'longitude': longitude,
        });
      }
    }

    setState(() {
      _markers = markers;
      _nearbyBars = nearbyBars;
    });
  }

  double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    const double R = 6371e3; // Earth's radius in meters
    final double phi1 = lat1 * pi / 180;
    final double phi2 = lat2 * pi / 180;
    final double deltaPhi = (lat2 - lat1) * pi / 180;
    final double deltaLambda = (lon2 - lon1) * pi / 180;

    final double a = sin(deltaPhi / 2) * sin(deltaPhi / 2) +
        cos(phi1) * cos(phi2) *
            sin(deltaLambda / 2) * sin(deltaLambda / 2);
    final double c = 2 * atan2(sqrt(a), sqrt(1 - a));

    return R * c;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: currentLocation == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        child: Column(
          children: [
            const ListTile(
              title: Text(
                "Nearby Bars",
                style: TextStyle(
                  color: AppColors.txtcolor,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              subtitle: Text(
                "Within 2km",
                style: TextStyle(
                  color: AppColors.txtcolor,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              trailing: Icon(
                Icons.more_vert_sharp,
                color: AppColors.txtcolor,
              ),
            ),
            Container(
              height: 160,
              width: double.infinity,
              child: GoogleMap(
                mapType: MapType.normal,
                onMapCreated: (GoogleMapController controller) {
                  mapController = controller;
                },
                initialCameraPosition: CameraPosition(
                  target: LatLng(
                      currentLocation!.latitude!, currentLocation!.longitude!
                  ),
                  zoom: 14.0,
                ),
                markers: Set<Marker>.of(_markers),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(

                style: TextStyle(color: Colors.white),

                controller: _searchController,
                decoration: const InputDecoration(
                  labelStyle:TextStyle(color: Colors.white),
                  labelText: 'Search by bar name',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            ..._nearbyBars.map((bar) => CustomListItem(
              title: bar['name'],
              subtitle: bar['name'],
              time: "N/A", // Adjust the time if needed
              imagePath: "images/band.jpg",
            )).toList(),
          ],
        ),
      ),
    );
  }
}
