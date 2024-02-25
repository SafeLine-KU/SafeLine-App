import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class MapController extends GetxController {
  late GoogleMapController mapController;

  final LatLng _center = const LatLng(37.544381, 127.076198);

  final markers = <Marker>[];

  @override
  void onInit() {
    super.onInit();
  }

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  LatLng get center => _center;

  void fetchSafeZones(String location, String type) async {
    final String baseUrl = 'https://d29cb15c-e309-44ed-9ea7-cb7577a0c6e5.mock.pstmn.io/safezone';
    final Uri uri = Uri.parse('$baseUrl?location=$location&type=$type');

    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final List<dynamic> safezoneList = jsonData['safezone'];

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
}
