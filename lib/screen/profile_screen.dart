import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vrititech/constants/color_constant.dart';
import 'package:vrititech/utils/size.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final user = FirebaseAuth.instance.currentUser;

  File? _image;

  final ImagePicker picker = ImagePicker();

  void chooseGalleryImage() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
    }
  }

  void chooseCameraImage() async {
    final XFile? image = await picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
    }
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
                  _image != null
                      ? CircleAvatar(
                          radius: SizeConfig.screenWidth! * 0.15,
                          backgroundImage: FileImage(_image!),
                        )
                      : CircleAvatar(
                          radius: SizeConfig.screenWidth! * 0.15,
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
                                        onPressed: () {
                                          chooseCameraImage();
                                        },
                                        icon: const Column(
                                          children: [
                                            Icon(Icons.camera),
                                            Text("Camera"),
                                          ],
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          chooseGalleryImage();
                                        },
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
                          });
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
