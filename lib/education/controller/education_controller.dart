import 'dart:convert';

import 'package:get/get.dart';
import 'package:safeline_ku/common/model/quiz_model.dart';
import 'package:http/http.dart' as http;
import 'package:safeline_ku/education/view/education_quiz_view_page.dart';

class EducationController extends GetxController {
  final quizzes = <Quiz>[].obs;

  @override
  void onInit() {
    super.onInit();
  }

  void fetchQuizzes(String? disasterType) async {
    final String baseUrl =
        'https://d29cb15c-e309-44ed-9ea7-cb7577a0c6e5.mock.pstmn.io';
    final String url = '$baseUrl/instruction/quiz?type=$disasterType';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final List<dynamic> quizList = jsonData['quiz'];

        if (quizList.isNotEmpty) {
          final imageUrl = quizList[0]['image']; // Get the first quiz image URL
          Get.to(() => EducationQuizViewPage(imageUrl: imageUrl));
        } else {
          Get.snackbar('Error', 'No quiz data available');
        }
      } else {
        throw Exception('Failed to load quizzes');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch quiz data: $e');
    }
  }
}
