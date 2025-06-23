import 'package:flutter/material.dart';
import 'api_service.dart';
import 'post_detail_screen.dart';
import 'create_post_screen.dart';
import 'login_screen.dart';

class PostListScreen extends StatefulWidget {
  final String token;
  PostListScreen({required this.token});

  @override
  State<PostListScreen> createState() => _PostListScreenState();
}

class _PostListScreenState extends State<PostListScreen> {
  List<dynamic> posts = [];

  @override
  void initState() {
    super.initState();
    loadPosts();
  }

  void loadPosts() async {
    final data = await ApiService.fetchPosts();
    setState(() {
      posts = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blog Posts'),
        actions: [
          IconButton(icon: Icon(Icons.refresh), onPressed: loadPosts),
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
                (route) => false,
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          final post = posts[index];
          return ListTile(
            title: Text(post['title'] ?? ''),
            subtitle: Text(post['summary'] ?? post['content'] ?? ''),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PostDetailScreen(postId: post['id']),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreatePostScreen(token: widget.token),
            ),
          );

          if (result == true) {
            loadPosts();
          }
        },
        child: Icon(Icons.add),
        tooltip: 'Create Post',
      ),
    );
  }
}
