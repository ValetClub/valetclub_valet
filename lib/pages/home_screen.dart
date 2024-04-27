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
  const HomeScreen({super.key, });

  @override
  State<HomeScreen> createState() => TrackingState();
}

class TrackingState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Location _locationController = Location();
  late StreamSubscription<LocationData> _locationSubscription;

  final Completer<GoogleMapController> _mapController =
      Completer<GoogleMapController>();

  static const LatLng _destinationLocation = LatLng(33.592076, -7.625999);
  LatLng? _currentPosition;
  BitmapDescriptor sourceIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor destinationIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor currentLocationIcon = BitmapDescriptor.defaultMarker;
  bool showClientInfo = false;
  String? clientAddress;
  bool _destinationMarkerVisibility = true;

  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  late Polyline _keyPolyLine;

  void getPolylinePoints(LatLng start, LatLng destination) async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      mapKey,
      PointLatLng(start.latitude, start.longitude),
      PointLatLng(destination.latitude, destination.longitude),
      travelMode: TravelMode.driving,
    );
    if (result.points.isNotEmpty) {
      result.points.forEach(
        (PointLatLng point) => polylineCoordinates.add(
          LatLng(point.latitude, point.longitude),
        ),
      );
      setState(() {});
      print("Polyline points: $polylineCoordinates");
    } else {
      print("No polyline points found. Error message: ${result.errorMessage}");
    }
  }

  void setCustomMarkerIcon() {
    BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(),
      "assets/images/current_location.png",
    ).then(
      (icon) {
        destinationIcon = icon;
      },
    );

    BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(),
      "assets/images/current_marker.png",
    ).then(
      (icon) {
        currentLocationIcon = icon;
      },
    );
  }

  int _selectedTabIndex = 0;
  bool isFromBottomNavBar = true;
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
    widgetOptions();
  }

  @override
  void dispose() {
    _locationSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _keyPolyLine = Polyline(
      polylineId: const PolylineId("route"),
      points: [
        if (_currentPosition != null) _currentPosition!,
        _destinationLocation,
      ],
      color: MainTheme.thirdColor,
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
                Expanded(
                  child: _buildMap(),
                ),
              ],
            );
          },
        ),
        _buildSidebarLeftButton(),
        _buildSidebarRightButton(),
        if (showClientInfo || !_destinationMarkerVisibility)
          _buildBottomSheet(),
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
                  Polyline(
                    polylineId: const PolylineId("route"),
                    points: polylineCoordinates,
                    color: MainTheme.thirdColor,
                    width: 3,
                  ),
                  // _keyPolyLine,
                },
                markers: {
                  Marker(
                    markerId: const MarkerId("_currentLocation"),
                    icon: currentLocationIcon,
                    position: _currentPosition!,
                  ),
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
          if (!_scaffoldKey.currentState!.isDrawerOpen) {
            _scaffoldKey.currentState?.openDrawer();
          }
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(13),
            color: MainTheme.mainColor,
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

  Widget _buildBottomSheet() {
    double _currentChildSize = 0.28;

    return DraggableScrollableSheet(
      initialChildSize: _currentChildSize,
      minChildSize: 0.1,
      maxChildSize: 0.9,
      builder: (BuildContext context, ScrollController scrollController) {
        return GestureDetector(
          behavior: HitTestBehavior.translucent,
          onVerticalDragUpdate: (details) {
            double newChildSize = (_currentChildSize -
                    details.primaryDelta! / MediaQuery.of(context).size.height)
                .clamp(0.1, 0.9);
            setState(() {
              _currentChildSize = newChildSize;
            });
          },
          onVerticalDragEnd: (details) {
            if (details.primaryVelocity! > 0) {
              setState(() {
                _currentChildSize = 0.1;
              });
            } else if (details.primaryVelocity! < 0) {
              setState(() {
                _currentChildSize = 0.9;
              });
            }
          },
          child: SingleChildScrollView(
            controller: scrollController,
            child: Container(
              color: MainTheme.mainColor,
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 50,
                      child: const Divider(
                        color: MainTheme.greyColor,
                        thickness: 2,
                        height: 8,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
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
                        backgroundImage:
                            AssetImage('assets/images/logo_valet.png'),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Reda El Kadi",
                                  style: TextStyle(
                                    color: MainTheme.secondaryColor,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Nv1",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: MainTheme.secondaryColor,
                                      ),
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: MainTheme.warningColor,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Client ID :122e93",
                                      style: TextStyle(
                                        color: MainTheme.secondaryColor,
                                      ),
                                    ),
                                    Text(
                                      "MT :B35670",
                                      style: TextStyle(
                                        color: MainTheme.secondaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(
                                      "Distance",
                                      style: TextStyle(
                                        color: MainTheme.secondaryColor,
                                      ),
                                    ),
                                    Text(
                                      "5.8 mi",
                                      style: TextStyle(
                                        color: MainTheme.secondaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: MainTheme.secondaryColor,
                      ),
                      SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Address",
                            style: TextStyle(color: MainTheme.secondaryColor),
                          ),
                          Text(
                            "Client destination address",
                            style: TextStyle(color: MainTheme.secondaryColor),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Card(
                    color: Colors.white,
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.map,
                                    color: MainTheme.thirdColor,
                                  ),
                                  SizedBox(width: 8),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Details"),
                                      Text(
                                        "Trip Details",
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Arrival"),
                                  Text("02:30 PM"),
                                ],
                              ),
                              SizedBox(height: 8),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Distance"),
                                  Text("5.8 mi"),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Center(
                            child: Text(
                              "Total Summary",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: MainTheme.darkColor,
                              ),
                            ),
                          ),
                          SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Parking"),
                              Text("35 MAD"),
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Lavage (Service Additional)"),
                              Text("50 MAD"),
                            ],
                          ),
                          SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Valet Tips"),
                              Text("10 MAD"),
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Total",
                                style: TextStyle(
                                    color: MainTheme.darkColor,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "95 MAD",
                                style: TextStyle(
                                    color: MainTheme.darkColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Center(
                    child: Text(
                      "Recharge wallet by the valet",
                      style: TextStyle(
                        color: MainTheme.secondaryColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Center(
                    child: Column(
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                MainTheme.secondaryColor),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          child: const Text(
                            "Confirmez",
                            style: TextStyle(color: MainTheme.darkColor),
                          ),
                        ),
                        const SizedBox(height: 8),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              showClientInfo = false;
                              _destinationMarkerVisibility = true;
                            });
                            print("Bottom sheet closed");
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.transparent),
                          ),
                          child: const Text(
                            "Annuler",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
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
        LatLng currentPosition =
            LatLng(currentLocation.latitude!, currentLocation.longitude!);

        setState(() {
          _currentPosition = currentPosition;
          // LatLng(currentLocation.latitude!, currentLocation.longitude!);
          _cameraToPosition(_currentPosition!);
        });
        getPolylinePoints(currentPosition, _destinationLocation);
      }
    });
  }
}
