import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:safeline_ku/common/global_widget/marker.dart';
import 'package:safeline_ku/common/util/common_color.dart';
import 'package:safeline_ku/map/controller/map_controller.dart';

class MapViewPage extends StatelessWidget {
  final MapController mapController = Get.put(MapController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GetBuilder<MapController>(
            builder: (controller) {
              return GoogleMap(
                polylines: Set<Polyline>.of(mapController.polylines.values),
                onMapCreated: controller.onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: controller.center,
                  zoom: 12.0,
                ),
                markers: Set.from(mapController.markers),
                myLocationEnabled: true, // 실시간 현재 위치 표시
                myLocationButtonEnabled: false,
                mapToolbarEnabled: true,
              );
            },
          ),
          Positioned(
            top: 50.0,
            right: 16.0,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorTheme.primaryColor, // 버튼의 배경색 설정
              ),
              onPressed: () {
                mapController.getCurrentLocationAndShowNearestSafezone();
              },
              child: Row(
                children: [
                  Icon(
                    Icons.location_pin,
                    color: ColorTheme.white,
                  ),
                  Text(
                    'Find Nearest Safezone',
                    style: TextStyle(color: ColorTheme.white),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 100.0,
            right: 16.0,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorTheme.primaryColor, // 버튼의 배경색 설정
              ),
              onPressed: () {
                mapController.fetchSafeZones();
              },
              child: Row(
                children: [
                  Icon(
                    Icons.home_filled,
                    color: ColorTheme.white,
                  ),
                  Text(
                    ' Shelter',
                    style: TextStyle(color: ColorTheme.white),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 150.0,
            right: 16.0,
            child: FloatingActionButton(
              foregroundColor: ColorTheme.white,
              backgroundColor: ColorTheme.primaryColor,
              onPressed: () {
                mapController.getCurrentLocationAndShowOnMap();
              },
              child: Icon(Icons.my_location),
            ),
          ),
        ],
      ),
    );
  }
}
