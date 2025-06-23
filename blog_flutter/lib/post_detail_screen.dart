import 'package:flutter/material.dart';
import 'api_service.dart';

class PostDetailScreen extends StatelessWidget {
  final int postId;

  PostDetailScreen({required this.postId});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ApiService.fetchPostDetail(postId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(title: Text('Post Detail')),
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError || snapshot.data == null) {
          return Scaffold(
            appBar: AppBar(title: Text('Post Detail')),
            body: Center(child: Text('Failed to load post')),
          );
        } else {
          final post = snapshot.data as Map<String, dynamic>;
          return Scaffold(
            appBar: AppBar(title: Text(post['title'] ?? '')),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    post['title'] ?? '',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text("By: ${post['author'] ?? ''}"),
                  SizedBox(height: 8),
                  Text(post['created_at'] ?? ''),
                  SizedBox(height: 16),
                  Text(post['content'] ?? ''),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
