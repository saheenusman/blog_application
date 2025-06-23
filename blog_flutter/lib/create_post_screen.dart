import 'package:flutter/material.dart';
import 'api_service.dart';

class CreatePostScreen extends StatefulWidget {
  final String token;

  CreatePostScreen({required this.token});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  bool isSubmitting = false;

  void submitPost() async {
    setState(() {
      isSubmitting = true;
    });

    final result = await ApiService.createPost(
      widget.token,
      titleController.text,
      contentController.text,
    );

    setState(() {
      isSubmitting = false;
    });

    if (result != null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Post created successfully')));
      Navigator.pop(context, true);
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Failed to create post')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create New Post')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            SizedBox(height: 8),
            TextField(
              controller: contentController,
              decoration: InputDecoration(labelText: 'Content'),
              maxLines: 6,
            ),
            SizedBox(height: 16),
            isSubmitting
                ? CircularProgressIndicator()
                : ElevatedButton(onPressed: submitPost, child: Text('Submit')),
          ],
        ),
      ),
    );
  }
}
