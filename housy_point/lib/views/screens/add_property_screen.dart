import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddPropertyScreen extends StatefulWidget {
  const AddPropertyScreen({super.key});

  @override
  State<AddPropertyScreen> createState() => _AddPropertyScreenState();
}

class _AddPropertyScreenState extends State<AddPropertyScreen> {
  ImagePicker _picker = ImagePicker();
  List<XFile>? files;
  XFile? file;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 400,
            width: double.infinity,
            color: Colors.grey,
            child: Center(
              child: file == null
                  ? const Text('Image not picked')
                  : Image.file(
                      File(file!.path),
                      fit: BoxFit.cover,
                    ),
            ),
          ),
          ElevatedButton(
              onPressed: () async {
                final XFile? photo =
                    await _picker.pickImage(source: ImageSource.gallery);
                setState(() {
                  file = photo;
                });
              },
              child: const Text('Pick Image')),
          ElevatedButton(
              onPressed: () async {
                final List<XFile>? photos = await _picker.pickMultiImage();
                setState(() {
                  files = photos;
                });
              },
              child: const Text('Pick Multiple Images')),
        ],
      ),
    );
  }
}
