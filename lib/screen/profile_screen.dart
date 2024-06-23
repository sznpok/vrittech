import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vrititech/utils/size.dart';

import '../constants/color_constant.dart';
import '../database_helper/db_helper.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final user = FirebaseAuth.instance.currentUser;
  File? _image;
  final ImagePicker picker = ImagePicker();
  final databaseHelper = DatabaseHelper();

  @override
  void initState() {
    readImage();
    super.initState();
  }

  Future<void> readImage() async {
    final imageData = await databaseHelper.getImage();
    if (imageData != null) {
      setState(() {
        _image = File(imageData.base64Image); // Decode base64 to File
      });
    }
  }

  void chooseGalleryImage() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      final bytes = await File(image.path).readAsBytes();
      final base64Image = base64Encode(bytes); // Encode to base64
      setState(() {
        _image = File(image.path);
        writeImage(base64Image);
      });
    }
    Navigator.pop(context);
  }

  void chooseCameraImage() async {
    final XFile? image = await picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      final bytes = await File(image.path).readAsBytes();
      final base64Image = base64Encode(bytes);
      setState(() {
        _image = File(image.path);
        writeImage(base64Image);
      });
    }
    Navigator.pop(context);
  }

  Future<void> writeImage(String base64Image) async {
    await databaseHelper.saveImage(base64Image);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                user!.displayName.toString(),
              ),
              SizedBox(
                height: SizeConfig.screenHeight! * 0.01,
              ),
              Text(
                user!.email!,
              ),
              SizedBox(
                height: SizeConfig.screenHeight! * 0.1,
              ),
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  if (_image != null)
                    CircleAvatar(
                      radius: SizeConfig.screenWidth! * 0.15,
                      backgroundImage: (_image != null &&
                                  _image!.path.endsWith('.jpg')) ||
                              (_image != null &&
                                  _image!.path.endsWith('.png')) ||
                              (_image != null && _image!.path.endsWith('.jpeg'))
                          ? FileImage(_image!) as ImageProvider
                          : (_image != null)
                              ? MemoryImage(base64Decode(_image!.path))
                                  as ImageProvider
                              : null, // Handle case where no image available
                    ),
                  IconButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    IconButton(
                                      onPressed: chooseCameraImage,
                                      icon: const Column(
                                        children: [
                                          Icon(Icons.camera),
                                          Text("Camera"),
                                        ],
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: chooseGalleryImage,
                                      icon: const Column(
                                        children: [
                                          Icon(Icons.photo),
                                          Text("Gallery"),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    icon: Icon(
                      Icons.camera_alt,
                      color: _image != null ? Colors.white : primaryColor,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
