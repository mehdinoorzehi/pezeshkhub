import 'package:get/get.dart';
import '../api/post_api.dart';

//! کنترل استیت پست ها به وسیله ی پکیج گت ایکس
class PostController extends GetxController {
  final PostApi api = PostApi();

  var posts = <dynamic>[].obs;
  var isLoading = true.obs;
  var isLoadingMore = false.obs;
  var hasMore = true.obs;
  var error = ''.obs;

  int _page = 1;

  @override
  void onInit() {
    super.onInit();
    fetchPosts();
  }

  Future<void> fetchPosts({bool retry = false}) async {
    if (retry) {
      resetState();
      return;
    }

    if (!hasMore.value || isLoadingMore.value) return;

    isLoadingMore.value = true;
    try {
      final newPosts = await api.fetchPosts(_page);
      if (newPosts.isEmpty) {
        hasMore.value = false;
      } else {
        _page++;
        posts.addAll(newPosts);
        posts.refresh();
      }
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
      isLoadingMore.value = false;
    }
  }

  void resetState() {
    _page = 1;
    hasMore.value = true;
    posts.clear();
    error.value = '';
    isLoading.value = true;
    fetchPosts();
  }
}
