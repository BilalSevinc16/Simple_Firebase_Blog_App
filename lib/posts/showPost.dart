// Show posts widget design
import 'package:flutter/material.dart';

class ShowPost extends StatelessWidget {
  String imageUrl, title, authorName, description;

  ShowPost({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.authorName,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            imageUrl,
            fit: BoxFit.cover,
            height: 200,
            width: MediaQuery.of(context).size.width,
          ),
        ),
        Container(
          height: 200,
          decoration: BoxDecoration(
            color: Colors.black54.withOpacity(0.3),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 30),
              ),
              Text(
                description,
                style: const TextStyle(fontSize: 30),
              ),
              Text(
                authorName,
                style: const TextStyle(fontSize: 30),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
