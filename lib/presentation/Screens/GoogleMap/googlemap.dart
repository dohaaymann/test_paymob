import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:test_cubit/Core/Widgets/Custom_Textfromfield.dart';

import 'Address_Model.dart';
const String apiKeymap="AIzaSyDJx73U3qe9YC-aZ6XewWXmMDtOlob_evQ";
class googlemap extends StatefulWidget {
  const googlemap({Key? key}) : super(key: key);

  @override
  State<googlemap> createState() => _googlemapState();
}

class _googlemapState extends State<googlemap> {
  late CameraPosition initialCameraPosition ;
  late bool serviceEnabled;
  late LocationPermission permission;
  List<LatLng> polylineCoordinates = [];
  StreamSubscription<Position>? positionStream;
  PolylinePoints polylinePoints = PolylinePoints();
  late GoogleMapController mapController;
  List<Marker> markers = [
    Marker(
      markerId: const MarkerId("2"),
      position: const LatLng(30.474218522464017, 31.200131804267798),
      infoWindow: const InfoWindow(title: "Origin"),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
    ),
    const Marker(
      markerId: MarkerId("3"),
      position: LatLng(30.456037743966284, 31.18070324659635),
    ),
  ];

  final Set<Polyline> _polylines = {};
  getCurrentPosition() async {
   var x=await Geolocator.getCurrentPosition().then((position) {
     print(position.longitude);
     print(position.latitude);
     markers.add(Marker(markerId: MarkerId("1"),position: LatLng(position.latitude, position.longitude)));
     initialCameraPosition=CameraPosition(target: LatLng(position.latitude, position.longitude),zoom: 17);
     mapController.moveCamera(CameraUpdate.newCameraPosition(initialCameraPosition,),);
   },);
   return initialCameraPosition;
 }
  Future<Address?> _getAddressFromLatLng() async {
    Address? address; // Make the address nullable initially
    try {
      Position position = await Geolocator.getCurrentPosition();
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      Placemark place = placemarks[0];

      setState(() {
        address = Address(
          latitude: position.latitude,
          longitude: position.longitude,
          city: place.subAdministrativeArea ?? '',
          country: place.country ?? '',
          line1: place.street ?? '',
          postalCode: place.postalCode ?? '',
          state: place.administrativeArea ?? '',
        );
        print('Address Object: $address');
        // Convert the Address object to JSON using toJson() method
        Map<String, dynamic> addressJson = address!.toJson();
        print('Address as JSON: $addressJson');
        add_details_controller.text=addressJson.toString();
      });
      // Print the address

    } catch (e) {
      print('Error: $e');
    }

    return address;
  }
  @override
  void initState() {
    super.initState();
    initialCameraPosition =CameraPosition(target: LatLng(30.474218522464017, 31.200131804267798),zoom: 17);
        getCurrentPosition();
    // _checkLocationPermission();
    _getAddressFromLatLng();
  }

  Future<void> _checkLocationPermission() async {
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    if (permission == LocationPermission.whileInUse) {
      positionStream = Geolocator.getPositionStream().listen(
            (Position? position) {
          if (position != null && mounted) {
            initialCameraPosition = CameraPosition(
              target:LatLng(position.latitude, position.longitude),
              zoom: 17,
            );
            mapController.animateCamera(
              CameraUpdate.newLatLng(
                LatLng(position.latitude, position.longitude),
              ),
            );
            setState(() {
              markers.add(
                Marker(
                  markerId: const MarkerId("1"),
                  icon:BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
                  position: LatLng(position.latitude, position.longitude),
                ),
              );
            });
          }
        },
      );
    }
  }

  @override
  void dispose() {
    // Cancel the position stream when the widget is disposed
    positionStream?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add New Address"),
        actions: [
          TextButton(onPressed: (){
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
              ),
              builder: (BuildContext context) {
                return AddressBottomSheet();
              },
            );
          }, child: const Text("Save",style: TextStyle(color: Colors.purple),))
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 30, bottom: 5),
        child: Align(
          alignment: Alignment.bottomLeft,
          child: FloatingActionButton(
            backgroundColor: Colors.purple,
            child: const Icon(Icons.location_on, color: Colors.white),
            onPressed: () async {
              var address;

              await _getAddressFromLatLng();
              // PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
              //   googleApiKey:apiKeymap,
              //   request: PolylineRequest(
              //     origin: PointLatLng(
              //       markers[1].position.latitude,
              //       markers[1].position.longitude,
              //     ),
              //     destination:PointLatLng(
              //       markers[0].position.latitude,
              //       markers[0].position.longitude,),
              //     mode: TravelMode.driving,
              //     wayPoints: [PolylineWayPoint(location: "Sabo, Yaba Lagos Nigeria")],
              //   ),
              // );
              //
              // if (result.points.isNotEmpty && mounted) {
              //   setState(() {
              //     polylineCoordinates = result.points
              //         .map((e) => LatLng(e.latitude, e.longitude))
              //         .toList();
              //     _polylines.add(
              //       Polyline(
              //         polylineId: const PolylineId("polyline"),
              //         points: polylineCoordinates,
              //         color: Colors.green,
              //       ),
              //     );
              //   });
              // }
            },
          ),
        ),
      ),
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: initialCameraPosition,
            onMapCreated: (controller) {
              mapController = controller;
            },
            // polylines: _polylines,
            markers: markers.toSet(),
          ),
        ],
      ),
    );
  }
}

// Position position = await Geolocator.getCurrentPosition();
// Markers.add(Marker(markerId: MarkerId("1"),position: LatLng(position.latitude, position.longitude)));
// mapController.moveCamera(CameraUpdate.newCameraPosition(
//     CameraPosition(target: LatLng(position.latitude, position.longitude),zoom: 14)));

TextEditingController add_details_controller=TextEditingController();
class AddressBottomSheet extends StatelessWidget {
  TextEditingController name_add_controller=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 16),
          Text(
            'Address Details',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          Divider(),
          // SizedBox(height: 16),
          CustomTextfromfield(hintText: "Name Address", Controller:name_add_controller),
          SizedBox(height: 16),
          Text("Address Details"),
          CustomTextfromfield(hintText: "", Controller:add_details_controller),

          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              // Handle add address action
            },
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 40),
            ),
            child: Text("Add"),
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}