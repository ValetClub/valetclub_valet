import 'dart:async';

import 'package:flutter/material.dart';
// import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
// import 'package:valetclub_valet/common/common_widgets.dart';
// import 'package:valetclub_valet/common/map_key.dart';
import 'package:valetclub_valet/components/sidebar.dart';
import 'package:valetclub_valet/custom/bottombar_icons.dart';
import 'package:valetclub_valet/pages/activity_screen.dart';
import 'package:valetclub_valet/pages/notification_screen.dart';
import 'package:valetclub_valet/pages/profile_screen.dart';
import 'package:valetclub_valet/pages/scan_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Location _locationController = Location();
  late StreamSubscription<LocationData> _locationSubscription;

  final Completer<GoogleMapController> _mapController =
      Completer<GoogleMapController>();
  static const LatLng _sourceLocation = LatLng(33.610442, -7.653565);

  static const LatLng _destinationLocation = LatLng(33.592076, -7.625269);
  LatLng? _currentPosition;
  BitmapDescriptor sourceIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor destinationIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor currentLocationIcon = BitmapDescriptor.defaultMarker;
  bool showClientInfo = false;
  String? clientAddress;
  bool _destinationMarkerVisibility = true;

  // List<LatLng> polylineCoordinates = [];

  // void getPolylinePoints() async {
  //   PolylinePoints polylinePoints = PolylinePoints();
  //   PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
  //     mapKey,
  //     PointLatLng(_sourceLocation.latitude, _sourceLocation.longitude),
  //     PointLatLng(
  //         _destinationLocation.latitude, _destinationLocation.longitude),
  //     travelMode: TravelMode.driving,
  //   );
  //   if (result.points.isNotEmpty) {
  //     result.points.forEach(
  //       (PointLatLng point) => polylineCoordinates.add(
  //         LatLng(point.latitude, point.longitude),
  //       ),
  //     );
  //     setState(() {});
  //   } else {
  //     print(result.errorMessage);
  //   }
  // }

  void setCustomMarkerIcon() {
    // BitmapDescriptor.fromAssetImage(
    //   const ImageConfiguration(size: Size(48, 48)),
    //   "assets/images/logo_valet.png",
    // ).then(
    //   (icon) {
    //     sourceIcon = icon;
    //   },
    // );

    BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(48, 38)),
      "assets/images/current_location.png",
    ).then(
      (icon) {
        destinationIcon = icon;
      },
    );

    BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(
          // size: Size(48, 48),
          ),
      "assets/images/current_marker.png",
    ).then(
      (icon) {
        currentLocationIcon = icon;
      },
    );
  }

  // final Polyline _keyPolyLine = const Polyline(
  //   polylineId: PolylineId("route"),
  //   points: [
  //     _sourceLocation,
  //     _destinationLocation,
  //   ],
  //   color: Colors.blue,
  //   width: 6,
  //   visible: true,
  // );
  int _selectedTabIndex = 0;

  late List<Widget> _widgetOptions;
  void widgetOptions() {
    _widgetOptions = [
      _content(),
      const ActivityScreen(),
      const ScanScreen(),
      const NotificationScreen(),
      const ProfileScreen(),
    ];
  }

  @override
  void initState() {
    super.initState();

    getLocationUpdates();
    setCustomMarkerIcon();
    // getPolylinePoints();
    widgetOptions();
  }

  @override
  void dispose() {
    _locationSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget content = _selectedTabIndex == 0
        ? _content()
        : (_widgetOptions[_selectedTabIndex]);

    return Scaffold(
      key: _scaffoldKey,
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          // Close the sidebar when the  taps outside
          if (_scaffoldKey.currentState?.isDrawerOpen == true) {
            // Open the Drawer(sidebar)
            _scaffoldKey.currentState?.closeDrawer();
          }
        },
        child: content,
      ),
      backgroundColor: Colors.transparent,

      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: _selectedTabIndex,
        onTabChange: (index) {
          setState(() {
            _selectedTabIndex = index;
          });
        },
      ),

      // Drawer (Sidebar)
      drawer: const Sidebar(),
    );
  }

  Widget _content() {
    return Stack(
      children: [
        Column(
          children: [
            // Map Container
            Expanded(
              child: _buildMap(),
            ),
            // Client  Information Card
            if (showClientInfo)
              _buildClientInfoDrawer(() {
                setState(() {
                  showClientInfo = false;
                  clientAddress = null;
                  _destinationMarkerVisibility = true;
                });
              }),
          ],
        ),

        // Sidebar Left Button
        _buildSidebarLeftButton(),
        // Sidebar Right Button
        _buildSidebarRightButton(),
      ],
    );
  }

  Widget _buildMap() {
    return Container(
      height: double.infinity,
      color: Colors.white,
      width: double.infinity,
      child: Listener(
        behavior: HitTestBehavior.opaque,
        child: _currentPosition == null
            ? const Center(
                child: Text("Open Your Location"),
              )
            : GoogleMap(
                onMapCreated: (GoogleMapController controller) =>
                    _mapController.complete(controller),
                initialCameraPosition: const CameraPosition(
                  target: _sourceLocation,
                  zoom: 13,
                ),
                mapType: MapType.normal,
                // polylines: {
                //   _keyPolyLine,
                // },
                markers: {
                  Marker(
                    markerId: const MarkerId("_currentLocation"),
                    icon: currentLocationIcon,
                    position: _currentPosition!,
                  ),
                  // Marker(
                  //   markerId: const MarkerId("_sourceLocation"),
                  //   icon: sourceIcon,
                  //   position: _sourceLocation,
                  // ),
                  if (_destinationMarkerVisibility)
                    Marker(
                      markerId: const MarkerId("_destinationLocation"),
                      icon: destinationIcon,
                      position: _destinationLocation,
                      onTap: () {
                        setState(() {
                          clientAddress = "Client  destination address ";
                          showClientInfo = true;
                          _destinationMarkerVisibility = false;
                        });
                      },
                    ),
                },
              ),
      ),
    );
  }

  Widget _buildSidebarLeftButton() {
    return Positioned(
      top: 50,
      left: 10,
      child: GestureDetector(
        onTap: () {
          // Hide the icon when the sidebar is opened
          if (!_scaffoldKey.currentState!.isDrawerOpen) {
            // Open the Drawer
            _scaffoldKey.currentState?.openDrawer();
          }
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

  Future<void> _cameraToPosition(LatLng position) async {
    final GoogleMapController controller = await _mapController.future;
    CameraPosition _newCameraPosition = CameraPosition(
      target: position,
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
          _currentPosition =
              LatLng(currentLocation.latitude!, currentLocation.longitude!);
          _cameraToPosition(_currentPosition!);
        });
      }
    });
  }
}

Widget _buildClientInfoDrawer(
  Function() onClose,
) {
  String? clientAddress;
  return Positioned(
    bottom: 0,
    left: 0,
    right: 0,
    child: Container(
      color: const Color(0xFFE23777),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
            child: Text(
              "Call for a new Trip",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 8),
          const Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.grey,
                backgroundImage: AssetImage('assets/images/logo_valet.png'),
              ),
              SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Reda El Kadi",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "Client ID :122e93",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(
                Icons.location_on,
                color: Colors.white,
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Address",
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    clientAddress ?? "Unknown Address",
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () {
                  onClose();
                },
                child: const Text("Close"),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
