import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart'; // 추가

class MapController extends GetxController {
  late GoogleMapController mapController;
  final LatLng _center = const LatLng(37.544381, 127.076198);
  final markers = <Marker>[];
  List<dynamic> safezoneList = [];

  @override
  void onInit() {
    super.onInit();
    dotenv.load(fileName: '.env');
  }

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  LatLng get center => _center;

  Future<void> fetchSafeZones(String location, String type) async {
    final String baseUrl =
        'https://d29cb15c-e309-44ed-9ea7-cb7577a0c6e5.mock.pstmn.io/safezone';
    final Uri uri = Uri.parse('$baseUrl?location=$location&type=$type');

    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        safezoneList = jsonData['safezone'];

        markers.clear(); // Clear existing markers

        for (var data in safezoneList) {
          markers.add(
            Marker(
              markerId: MarkerId(data['name']),
              position: LatLng(data['latitude'], data['longitude']),
              onTap: () {
                Get.defaultDialog(
                  title: data['name'],
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Address: ${data['address']}'),
                      Text('Area: ${data['area']}'),
                      Text('Distance: ${data['distance']}'),
                      Text('Ground Floor: ${data['ground_floor']}'),
                      Text('Basement Floor: ${data['basement_floor']}'),
                    ],
                  ),
                  confirm: ElevatedButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Text('Close'),
                  ),
                );
              },
            ),
          );
        }
      } else {
        Get.snackbar('Error', 'Failed to fetch safezone data');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch safezone data: $e');
    }
    update(); // Update markers
  }

  Future<void> getCurrentLocationAndShowOnMap() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      LatLng currentLocation = LatLng(position.latitude, position.longitude);

      // Move camera to current location
      mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: currentLocation,
            zoom: 17.0,
          ),
        ),
      );
    } catch (e) {
      Get.snackbar('Error', 'Failed to get current location: $e');
    }
  }

  Future<void> getCurrentLocationAndShowNearestSafezone() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      LatLng currentLocation = LatLng(position.latitude, position.longitude);

      double minDistance = double.infinity;
      LatLng nearestSafezoneLocation = LatLng(0.0, 0.0);

      // Calculate distance to each safezone and find the nearest one
      for (var data in safezoneList) {
        double distance = Geolocator.distanceBetween(currentLocation.latitude,
            currentLocation.longitude, data['latitude'], data['longitude']);

        if (distance < minDistance) {
          minDistance = distance;
          nearestSafezoneLocation = LatLng(data['latitude'], data['longitude']);
        }
      }

      // Clear previous markers and add new marker for nearest safezone
      markers.clear();
      markers.add(
        Marker(
          markerId: MarkerId('Nearest Safezone'),
          position: nearestSafezoneLocation,
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
        ),
      );

      // Move camera to nearest safezone location
      mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: nearestSafezoneLocation,
            zoom: 17.0,
          ),
        ),
      );

      // Show route between current location and nearest safezone
      showRouteOnMap(currentLocation, nearestSafezoneLocation);
    } catch (e) {
      Get.snackbar('Error', 'Failed to get current location: $e');
    }
  }

  Map<PolylineId, Polyline> polylines = {};

  void showRouteOnMap(LatLng start, LatLng destination) async {
    final mapKey = dotenv.env['MAPS_API_KEY'];
    String apiKey = mapKey.toString();
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print('key: ${apiKey}');
    String url =
        "https://maps.googleapis.com/maps/api/directions/json?origin=${position.latitude},${position.longitude}&destination=${destination.latitude},${destination.longitude}&mode=transit&departure_time=now&key=$apiKey";

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        var data = json.decode(response.body);

        // Check if routes are available
        if (data['routes'] != null && data['routes'].isNotEmpty) {
          List<LatLng> points = [];
          data['routes'][0]['legs'][0]['steps'].forEach((step) {
            points.add(
              LatLng(
                  step['start_location']['lat'], step['start_location']['lng']),
            );
            points.add(
              LatLng(step['end_location']['lat'], step['end_location']['lng']),
            );
          });

          // Create a Polyline instance
          Polyline polyline = Polyline(
            polylineId: PolylineId('route'),
            points: points,
            color: Colors.blue,
            width: 5,
          );

          // Update the polylines map to include the new polyline
          polylines[PolylineId('route')] = polyline;

          // Trigger the build method to reflect the changes on the map
          update();
        } else {
          Get.snackbar('Error', 'No routes available');
        }
      } else {
        Get.snackbar('Error', 'Failed to fetch route data');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch route data: $e');
    }
  }
}
