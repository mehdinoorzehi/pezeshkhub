import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../controllers/secure_storage_controller.dart';
import '../pages/check_mobile_page.dart';

//! تابع ارسال شماره ی صفحه برای دریافت پست ها
class PostApi {
  final Dio _dio = Dio();

  Future<String?> _getToken() async {
    return await Get.find<SecureStorageController>().storage.read(key: 'token');
  }

  Future<List<dynamic>> fetchPosts(int page) async {
    final token = await _getToken();
    if (token == null) throw Exception('Token not found');

    final response = await _dio.get(
      'https://developer-exam.pezeshkhub.com/api/Home',
      options: Options(headers: {'Authorization': 'Bearer $token'}),
      queryParameters: {'page': page.toString()},
    );

    if (response.statusCode == 200) {
      return response.data['data']['data'] ?? [];
    } else if (response.statusCode == 401) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('loginTime'); // حذف زمان ورود
      await Future.delayed(const Duration(seconds: 1));
      try {
        await Get.offAll(() => const CheckMobilePage());
        // ignore: empty_catches
      } catch (e) {}
      throw Exception('Failed to load posts');
    } else {
      throw Exception('Failed to load posts');
    }
  }
}
