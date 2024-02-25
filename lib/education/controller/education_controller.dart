import 'package:get/get.dart';

class EducationController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  void fetchSafeZones(String type) async {
    final String baseUrl =
        'https://d29cb15c-e309-44ed-9ea7-cb7577a0c6e5.mock.pstmn.io/instruction/quiz';
    final Uri uri = Uri.parse('$baseUrl?type=$type');

    update(); // Update markers
  }
}
