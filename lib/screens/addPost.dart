import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';
import 'package:simple_firebase_blog_app/database/database.dart';

class AddPost extends StatefulWidget {
  const AddPost({Key? key}) : super(key: key);

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  //text variables
  late String title, description, authorName;

  // Database Method
  Database database = Database();

  // Image Variables
  File? _pic;
  final selector = ImagePicker();

  // Progress Status
  bool progressStatus = false;

  //Taking an image from the gallery and transferring it to a variable
  Future getPicture() async {
    //Get image and pass it to variable
    final selectedFile = await selector.pickImage(source: ImageSource.gallery);
    setState(() {
      // Pass file path to variable
      _pic = File(selectedFile!.path);
    });
  }

  postUpload() async {
    if (_pic != null) {
      // Set progress to true
      setState(() {
        progressStatus = true;
      });
      // Send the picture
      Reference storagePath = FirebaseStorage.instance
          .ref()
          .child("blogPictures")
          .child(randomAlphaNumeric(9));
      //Upload task
      UploadTask imageUploadTask = storagePath.putFile(_pic!);
      //Get Image Url
      var imageUrl = await (await imageUploadTask).ref.getDownloadURL();
      Fluttertoast.showToast(msg: "Url: $imageUrl");
      //Multiple data
      Map<String, String> postMultipleData = {
        "imageUrl": imageUrl,
        "authorName": authorName,
        "title": title,
        "description": description
      };
      database.addData(postMultipleData).then((result) {
        Navigator.pop(context);
      });
    } else {
      Fluttertoast.showToast(msg: "Select image!!");
    }
  }

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
        actions: [
          GestureDetector(
            onTap: () {
              // Let firebase send the data
              postUpload();
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: const Icon(Icons.file_upload),
            ),
          )
        ],
      ),
      body: progressStatus
          ? Container(
              alignment: Alignment.center,
              child: const CircularProgressIndicator(),
            )
          : Column(
              children: [
                const SizedBox(
                  height: 12,
                ),
                GestureDetector(
                  onTap: () {
                    getPicture();
                  },
                  child: _pic != null
                      ? Container(
                          margin: const EdgeInsets.symmetric(horizontal: 9),
                          height: 200,
                          width: MediaQuery.of(context).size.width,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.file(
                              _pic!,
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                      : Container(
                          margin: const EdgeInsets.symmetric(horizontal: 18),
                          height: 200,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.add_a_photo,
                            color: Colors.black54,
                          ),
                        ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      TextField(
                        decoration: const InputDecoration(
                          hintText: "Write a Title",
                          labelText: "Title",
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) {
                          // Take it from control and transfer it to variable
                          title = value;
                        },
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      TextField(
                        decoration: const InputDecoration(
                          hintText: "Write a Description",
                          labelText: "Description",
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) {
                          // Take it from control and transfer it to variable
                          description = value;
                        },
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      TextField(
                        decoration: const InputDecoration(
                          hintText: "Type Author Name",
                          labelText: "Author Name",
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) {
                          // Take it from control and transfer it to variable
                          authorName = value;
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
