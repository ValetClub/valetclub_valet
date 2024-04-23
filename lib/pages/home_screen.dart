import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:valetclub_valet/common/map_key.dart';
import 'package:valetclub_valet/common/theme.dart';
import 'package:valetclub_valet/components/reclamation.dart';

import 'package:valetclub_valet/components/sidebar.dart';
import 'package:valetclub_valet/custom/bottombar_icons.dart';
import 'package:valetclub_valet/pages/activity_screen.dart';
import 'package:valetclub_valet/pages/notification_screen.dart';
import 'package:valetclub_valet/pages/profile_screen.dart';
import 'package:valetclub_valet/pages/scan_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => tracking();
}

class tracking extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Location _locationController = Location();
  late StreamSubscription<LocationData> _locationSubscription;

  final Completer<GoogleMapController> _mapController =
      Completer<GoogleMapController>();
  // static const LatLng _sourceLocation = LatLng(33.610442, -7.653565);

  static const LatLng _destinationLocation = LatLng(33.592076, -7.625999);
  LatLng? _currentPosition;
  BitmapDescriptor sourceIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor destinationIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor currentLocationIcon = BitmapDescriptor.defaultMarker;
  bool showClientInfo = false;
  String? clientAddress;
  bool _destinationMarkerVisibility = true;

  List<LatLng> polylineCoordinates = [];
  late Polyline _keyPolyLine;

  void getPolylinePoints() async {
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      mapKey,
      PointLatLng(_currentPosition!.latitude, _currentPosition!.longitude),
      PointLatLng(
          _destinationLocation.latitude, _destinationLocation.longitude),
      travelMode: TravelMode.driving,
    );
    if (result.points.isNotEmpty) {
      result.points.forEach(
        (PointLatLng point) => polylineCoordinates.add(
          LatLng(point.latitude, point.longitude),
        ),
      );
      setState(() {});
    } else {
      print(result.errorMessage);
    }
  }

  void setCustomMarkerIcon() {
    // BitmapDescriptor.fromAssetImage(
    //   const ImageConfiguration(),
    //   "assets/images/logo_valet.png",
    // ).then(
    //   (icon) {
    //     sourceIcon = icon;
    //   },
    // );

    BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(),
      "assets/images/current_location.png",
    ).then(
      (icon) {
        destinationIcon = icon;
      },
    );

    BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(
          // size: Size(80, 80)
          ),
      "assets/images/current_marker.png",
    ).then(
      (icon) {
        currentLocationIcon = icon;
      },
    );
  }

  // Drawing a line between the source and the destination

  int _selectedTabIndex = 0;
  // Navigation Condition
  bool isFromBottomNavBar = true;

  // Switching between the pages
  late List<Widget> _widgetOptions;
  void widgetOptions() {
    _widgetOptions = [
      _content(),
      ActivityScreen(isFromBottomNavBar: isFromBottomNavBar),
      const ScanScreen(),
      const NotificationScreen(),
      ProfileScreen(isFromBottomNavBar: isFromBottomNavBar),
    ];
  }

  @override
  void initState() {
    super.initState();

    getLocationUpdates();
    setCustomMarkerIcon();
    if (_currentPosition != null) {
      getPolylinePoints();
    }
    widgetOptions();
  }

  @override
  void dispose() {
    _locationSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Update _keyPolyLine with current position
    _keyPolyLine = Polyline(
      polylineId: const PolylineId("route"),
      points: [
        if (_currentPosition != null) _currentPosition!,
        _destinationLocation,
      ],
      color: Colors.blue,
      width: 3,
      visible: true,
    );

    Widget content = _selectedTabIndex == 0
        ? _content()
        : (_widgetOptions[_selectedTabIndex]);

    return Scaffold(
      key: _scaffoldKey,
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          // Close the Drawer(sidebar) when the  taps outside
          if (_scaffoldKey.currentState?.isDrawerOpen == true) {
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
            isFromBottomNavBar = true;
          });
        },
      ),

      // Drawer (Sidebar)
      drawer: Sidebar(isFromBottomNavBar: !isFromBottomNavBar),
    );
  }

  Widget _content() {
    return Stack(
      children: [
        LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          return Column(
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
          );
        }),

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
      color: MainTheme.secondaryColor,
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
                initialCameraPosition: CameraPosition(
                  target: _currentPosition!,
                  zoom: 13,
                ),
                mapType: MapType.normal,
                polylines: {
                  _keyPolyLine,
                },
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
          // Hide the icon when the Drawer(sidebar) is opened
          if (!_scaffoldKey.currentState!.isDrawerOpen) {
            // Open the Drawer(sidebar)
            _scaffoldKey.currentState?.openDrawer();
          }
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(13),
            color: MainTheme.mainColor,
            // color: Colors.black,
          ),
          padding: const EdgeInsets.all(8),
          child: Image.asset(
            'assets/images/menu.png',
            width: 24,
            height: 24,
            color: MainTheme.secondaryColor,
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
        onTap: () {
          print('Context: $context');
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ReclamationScreen(),
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(13),
            color: MainTheme.mainColor,
            // color: Colors.black,
          ),
          padding: const EdgeInsets.all(8),
          child: Image.asset(
            'assets/images/reclamation.png',
            width: 24,
            height: 24,
            color: MainTheme.secondaryColor,
          ),
        ),
      ),
    );
  }

// keep tracking the device(user) in map  and update it's location whenever user moves
  Future<void> _cameraToPosition(LatLng position) async {
    final GoogleMapController controller = await _mapController.future;
    CameraPosition _newCameraPosition = CameraPosition(
      target: position,
      zoom: 13,
    );
    await controller
        .animateCamera(CameraUpdate.newCameraPosition(_newCameraPosition));
  }

// Location locator of Device(User)
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
        getPolylinePoints();
      }
    });
  }
}

//Showing  Information of Client(User)  Passed on click in Map
Widget _buildClientInfoDrawer(
  Function() onClose,
) {
  String? clientAddress;

  //! using Draggable Scrollable Bottom Sheet to Expand the Info of Client
  return Container(
    color: MainTheme.mainColor,
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
              color: MainTheme.secondaryColor,
            ),
          ),
        ),
        const SizedBox(height: 8),
        const Row(
          children: [
            CircleAvatar(
              backgroundColor: MainTheme.greyColor,
              backgroundImage: AssetImage('assets/images/logo_valet.png'),
            ),
            SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //? in condition of user doesn't register his name  what should we show here ???
                Text(
                  "Reda El Kadi",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: MainTheme.secondaryColor,
                  ),
                ),
                Text(
                  "Client ID :122e93",
                  style: TextStyle(
                    color: MainTheme.secondaryColor,
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
              color: MainTheme.secondaryColor,
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Address",
                  style: TextStyle(color: MainTheme.secondaryColor),
                ),
                Text(
                  //! Not Working  because of the null value in the data model
                  clientAddress ?? "Unknown Address",
                  style: const TextStyle(color: MainTheme.secondaryColor),
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
  );
}
