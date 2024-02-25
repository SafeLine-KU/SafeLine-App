import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:safeline_ku/common/global_widget/marker.dart';
import 'package:safeline_ku/map/controller/map_controller.dart';

class MapViewPage extends StatelessWidget {
  final MapController mapController = Get.put(MapController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<MapController>(
        builder: (controller) {
          return GoogleMap(
            onMapCreated: controller.onMapCreated,
            initialCameraPosition: CameraPosition(
              target: controller.center,
              zoom: 12.0,
            ),
            markers: Set.from(mapController.markers),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          mapController.fetchSafeZones('37.5436783,127.0775993', 'earthquake');
        },
        child: Icon(Icons.refresh),
      ),
    );
  }
}
