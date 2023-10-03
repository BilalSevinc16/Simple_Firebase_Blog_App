import 'package:flutter/material.dart';
import 'package:simple_firebase_blog_app/posts/postList.dart';
import 'package:simple_firebase_blog_app/screens/addPost.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              "Flutter",
              style: TextStyle(fontSize: 26),
            ),
            Text(
              "Blog",
              style: TextStyle(fontSize: 26, color: Colors.red),
            ),
          ],
        ),
      ),
      body: postList(),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FloatingActionButton(
            onPressed: () {
              //Go to blog adding page when clicked
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const AddPost(),
                ),
              );
            },
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
