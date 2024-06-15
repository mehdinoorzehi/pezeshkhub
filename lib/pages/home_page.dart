import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../controllers/post_controller.dart';
import '../widgets/appbar.dart';

class HomePage extends StatelessWidget {
  final ScrollController _scrollController = ScrollController();

  HomePage({super.key}) {
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 100) {
      Get.find<PostController>().fetchPosts();
    }
  }

  void _retryFetchPosts(PostController postController) {
    postController.fetchPosts(retry: true); // متد fetchPosts با حالت retry
  }

  @override
  Widget build(BuildContext context) {
    final postController = Get.put(PostController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: myAppbar1(),
      body: Obx(() {
        if (postController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (postController.error.value != '') {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Error: ${postController.error.value}'),
                SizedBox(height: 2.h),
                ElevatedButton(
                  onPressed: () => _retryFetchPosts(postController),
                  child: const Text('تلاش دوباره'),
                ),
              ],
            ),
          );
        } else {
          final posts = postController.posts;
          final isLoading = postController.isLoadingMore.value;
          final hasMore = postController.hasMore.value;

          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            controller: _scrollController,
            itemCount: posts.length + (isLoading ? 1 : 0),
            itemBuilder: (context, index) {
              if (index == posts.length) {
                if (isLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (!hasMore) {
                  return const Center(child: Text('No more data available'));
                } else {
                  return Container();
                }
              }

              final post = posts[index];
              final user = post['user'] ?? {};
              final media = post['media'] ?? [];
              final postId = post['id'];

              return Container(
                margin: EdgeInsets.symmetric(vertical: 1.h, horizontal: 3.w),
                padding: EdgeInsets.all(2.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 5,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: user['avatar_url'] != null
                              ? NetworkImage(user['avatar_url'])
                              : null,
                          radius: 4.w,
                          child: user['avatar_url'] == null
                              ? const Icon(Icons.account_circle)
                              : null,
                        ),
                        SizedBox(width: 2.w),
                        Text(
                          user['fullname'] ?? 'No Name',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 2.h),
                    if (media.isNotEmpty && media[0]['media_url'] != null)
                      Image.network(
                        media[0]['media_url'],
                        width: double.infinity,
                        height: 40.h,
                        fit: BoxFit.cover,
                      ),
                    SizedBox(height: 1.h),
                    Text(
                      post['description'] ?? 'No Description',
                      style: TextStyle(fontSize: 10.sp),
                    ),
                  ],
                ),
              );
            },
          );
        }
      }),
    );
  }
}
