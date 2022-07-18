import 'package:flutter/material.dart';
import '../constants/color.dart';
import 'package:path_provider/path_provider.dart' as syspath;
import 'package:path/path.dart' as path;
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ImageUploader extends StatefulWidget {
  final Function(File) selectImage;
  const ImageUploader({
    Key? key,
    required this.selectImage,
  }) : super(key: key);

  @override
  State<ImageUploader> createState() => _ImageUploaderState();
}

enum Source { camera, gallery }

class _ImageUploaderState extends State<ImageUploader> {
  XFile? uploadImage;

  Future seletImage(Source source) async {
    final XFile? pickedImage;
    switch (source) {
      case Source.camera:
        pickedImage = await ImagePicker().pickImage(
          source: ImageSource.camera,
          maxWidth: 600,
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
    var appDir = await syspath.getApplicationDocumentsDirectory();
    var fileName = path.basename(pickedImage.path);
    File file = File(pickedImage.path);
    final savedImage = await file.copy('${appDir.path}/$fileName');
    widget.selectImage(savedImage);
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
          child: uploadImage != null
              ? Image.file(File(uploadImage!.path))
              : Image.asset(
                  'assets/images/default.png',
                  fit: BoxFit.cover,
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
