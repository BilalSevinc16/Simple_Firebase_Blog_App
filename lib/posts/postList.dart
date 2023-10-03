//Getting post list widget from database
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:simple_firebase_blog_app/posts/showPost.dart';

Widget postList() {
  return Column(
    children: [
      StreamBuilder(
        stream: FirebaseFirestore.instance.collection("Posts").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                DocumentSnapshot documentData = snapshot.data!.docs[index];
                return ShowPost(
                  imageUrl: documentData["imageUrl"],
                  title: documentData["title"],
                  authorName: documentData["authorName"],
                  description: documentData["description"],
                );
              },
            );
          }
          return Container();
        },
      ),
    ],
  );
}
