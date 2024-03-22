import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:valetclub_valet/common/common_widgets.dart';
import 'package:valetclub_valet/common/map_key.dart';
import 'package:valetclub_valet/components/sidebar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Location _locationController = Location();
  late StreamSubscription<LocationData> _locationSubscription;

  final Completer<GoogleMapController> _mapController =
      Completer<GoogleMapController>();
  static const LatLng _pGooglePlex = LatLng(37.4223, -122.0848);

  static const LatLng _pGooglePark = LatLng(37.3346, -122.0090);
  LatLng? _currentP;

  bool _isSidebarOpen = false;

  @override
  void initState() {
    super.initState();
    getLocationUpdates();
    getPolylinePoints().then((coordinates) {
      print(coordinates);
    });
  }

  @override
  void dispose() {
    _locationSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          //Map
          _buildMap(),
          // Bottom icons
          bottomBar(context),
          // Sidebar Left Button
          _buildSidebarLeftButton(),
          // Sidebar
          if (_isSidebarOpen) const Sidebar(),
          // Sidebar Right Button
          _buildSidebarRightButton(),
        ],
      ),
    );
  }

  Widget _buildMap() {
    return GestureDetector(
      onTap: () {
        if (_isSidebarOpen) {
          setState(() {
            _isSidebarOpen = false;
          });
        }
      },
      child: _currentP == null
          ? const Center(
              child: Text("Open Your Location"),
            )
          : GoogleMap(
              onMapCreated: (GoogleMapController controller) =>
                  _mapController.complete(controller),
              initialCameraPosition: const CameraPosition(
                target: _pGooglePlex,
                zoom: 13,
              ),
              mapType: MapType.normal,
              markers: {
                Marker(
                  markerId: const MarkerId("_currentLocation"),
                  icon: BitmapDescriptor.defaultMarker,
                  position: _currentP!,
                ),
                const Marker(
                  markerId: MarkerId("_sourceLocation"),
                  icon: BitmapDescriptor.defaultMarker,
                  position: _pGooglePlex,
                ),
                const Marker(
                  markerId: MarkerId("_destinationLocation"),
                  icon: BitmapDescriptor.defaultMarker,
                  position: _pGooglePark,
                )
              },
            ),
    );
  }

  Widget _buildSidebarLeftButton() {
    return Positioned(
      top: 50,
      left: 10,
      child: GestureDetector(
        onTap: () {
          setState(() {
            _isSidebarOpen = !_isSidebarOpen;
          });
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(13),
            color: const Color(0xFFE23777),
            // color: Colors.black,
          ),
          padding: const EdgeInsets.all(8),
          child: Image.asset(
            'assets/images/menu.png',
            width: 24,
            height: 24,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildSidebarRightButton() {
    return Positioned(
      top: 50,
      right: 10,
      child: GestureDetector(
        onTap: () {},
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(13),
            color: const Color(0xFFE23777),
            // color: Colors.black,
          ),
          padding: const EdgeInsets.all(8),
          child: Image.asset(
            'assets/images/reclamation.png',
            width: 24,
            height: 24,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Future<void> _cameraToPosition(LatLng pos) async {
    final GoogleMapController controller = await _mapController.future;
    CameraPosition _newCameraPosition = CameraPosition(
      target: pos,
      zoom: 13,
    );
    await controller
        .animateCamera(CameraUpdate.newCameraPosition(_newCameraPosition));
  }

  void getLocationUpdates() {
    _locationSubscription = _locationController.onLocationChanged
        .listen((LocationData currentLocation) {
      if (currentLocation.latitude != null &&
          currentLocation.longitude != null) {
        setState(() {
          _currentP =
              LatLng(currentLocation.latitude!, currentLocation.longitude!);
          _cameraToPosition(_currentP!);
        });
      }
    });
  }

  Future<List<LatLng>> getPolylinePoints() async {
    List<LatLng> polylineCoordinates = [];
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      mapKey,
      PointLatLng(_pGooglePlex.latitude, _pGooglePlex.longitude),
      PointLatLng(_pGooglePark.latitude, _pGooglePark.longitude),
      travelMode: TravelMode.driving,
    );
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    } else {
      print(result.errorMessage);
    }
    return polylineCoordinates;
  }
}
