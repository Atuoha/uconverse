import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../constants/color.dart';
// import 'package:path_provider/path_provider.dart' as syspath;
// import 'package:path/path.dart' as path;
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ImageUploader extends StatefulWidget {
  final Function(XFile) selectImage;
  const ImageUploader({
    Key? key,
    required this.selectImage,
  }) : super(key: key);

  @override
  State<ImageUploader> createState() => _ImageUploaderState();
}

enum Source { camera, gallery }

class _ImageUploaderState extends State<ImageUploader> {
  // ignore: prefer_typing_uninitialized_variables
  var userDetails;
  var user = FirebaseAuth.instance.currentUser;
  var _isLoading = true;

  void loadProfileData() async {
    userDetails = await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get();
    setState(() {
      _isLoading = false;
    });
  }

  var isInit = true;
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (isInit) {
      loadProfileData();
    }
    setState(() {
      isInit = false;
    });
    super.didChangeDependencies();
  }

  XFile? uploadImage;

  Future seletImage(Source source) async {
    final XFile? pickedImage;
    switch (source) {
      case Source.camera:
        pickedImage = await ImagePicker().pickImage(
          source: ImageSource.camera,
          maxWidth: 900,
        );
        break;

      case Source.gallery:
        pickedImage = await ImagePicker().pickImage(
          source: ImageSource.gallery,
          maxWidth: 800,
        );
        break;
    }
    if (pickedImage == null) {
      return;
    }
    setState(() {
      uploadImage = pickedImage;
    });
    widget.selectImage(uploadImage!);
  }

  @override
  Widget build(BuildContext context) {
    Future avatarSource() {
      return showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Center(
            child: Text(
              'Select Avatar Source',
              style: TextStyle(
                color: primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          actions: [
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                primary: accentColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                seletImage(Source.camera);
                Navigator.of(context).pop();
              },
              label: const Text(
                'From Camera',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              icon: const Icon(Icons.camera),
            ),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                primary: accentColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                seletImage(Source.gallery);
                Navigator.of(context).pop();
              },
              label: const Text(
                'From Gallery',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              icon: const Icon(Icons.photo),
            ),
          ],
        ),
      );
    }

    return Column(
      children: [
        Container(
          height: 120,
          width: 120,
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: _isLoading
              ? const CircleAvatar(
                  backgroundColor: Colors.white,
                  child: CircularProgressIndicator(
                    color: primaryColor,
                  ),
                )
              : uploadImage != null
                  ? CircleAvatar(
                      backgroundColor: primaryColor,
                      radius: 150,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Image.file(
                          File(uploadImage!.path),
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  : userDetails!['image'] != ''
                      ? CircleAvatar(
                          backgroundColor: primaryColor,
                          radius: 150,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: Image.network(
                              userDetails!['image'],
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                      : CircleAvatar(
                          backgroundColor: primaryColor,
                          radius: 150,
                          child: Image.asset(
                            'assets/images/default.png',
                            fit: BoxFit.cover,
                          ),
                        ),
        ),
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            primary: accentColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: avatarSource,
          label: const Text(
            'Change Avatar',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          icon: const Icon(Icons.camera),
        ),
      ],
    );
  }
}
