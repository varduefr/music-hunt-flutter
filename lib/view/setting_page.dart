import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import FirebaseFirestore
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:music_hunt/utlis/utils.dart';
import '../const/static_info.dart';
import 'music_preference.dart';
import 'navigationbar.dart';

class Seeting_Page extends StatefulWidget {
  const Seeting_Page({Key? key}) : super(key: key);

  @override
  State<Seeting_Page> createState() => _Seeting_PageState();
}

class _Seeting_PageState extends State<Seeting_Page> {
  bool profilevisibilty = false;
  File? _image;
  String? _userEmail; // To store user email
  String? _userName; // To store user email

  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _getUserEmail(); // Call the method to get user email when the widget initializes
  }

  // Method to get the current user's email
  Future<void> _getUserEmail() async {
    //User? user = FirebaseAuth.instance.currentUser;
    if ( StaticInfo.userID != null) {
      // Query Firestore to get user data
      DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance.collection('users').doc( StaticInfo.userID).get();
      if (snapshot.exists) {
        setState(() {
          _userEmail = snapshot.data()!['email'];
          _userName = snapshot.data()!['name'];
        });
      }
    }
  }

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(Icons.settings, color: AppColors.whitecolor)
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Stack(
              alignment: Alignment.bottomLeft,
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundColor: AppColors.themecolor,
                  backgroundImage: _image != null ? FileImage(_image!) : null,
                ),
                Positioned(
                  left: -10,
                  bottom: 0,
                  child: IconButton(
                    icon: const Icon(Icons.camera_alt, color: AppColors.txtcolor),
                    onPressed: getImage,
                    tooltip: 'Pick Image',
                  ),
                ),
              ],
            ),
            const SizedBox(

              height: 10,
            ),
            Text(
              _userName ?? 'user', // Display user email here
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.txtcolor),
            ),
            Text(
              _userEmail ?? 'user', // Display user email here
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.txtcolor),
            ),
            const Text(
              "34 Gracia",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: AppColors.txtcolor),
            ),
            const SizedBox(height: 20,),
            Container(
              width: 31,
              height: 15,
              child: Transform.scale(
                scale: 0.7,
                child: Switch(
                  value: profilevisibilty,
                  onChanged: (value) =>
                      setState(() => profilevisibilty = value),
                  inactiveThumbColor: AppColors.themecolor,
                  inactiveTrackColor: AppColors.scaffloadcolor,
                  activeTrackColor: AppColors.themecolor,
                  activeColor: AppColors.scaffloadcolor,
                ),
              ),
            ),
            const SizedBox(height: 10,),
            const Text("Profile visibility",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: AppColors.txtcolor),),
            const SizedBox(height: 20,),
            const Text("547",style: TextStyle(fontSize: 24,fontWeight: FontWeight.w700,color: AppColors.themecolor),),
            const Text("Music points",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: AppColors.themecolor),),
            const SizedBox(height: 10,),
            Container(
              height: 3,
              width: 140,
              color: AppColors.themecolor,
            ),
            const SizedBox(height: 25,),
            const Text("My Bars",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600,color: AppColors.txtcolor),),
            const SizedBox(height: 25,),
            InkWell(
                onTap: (){
                  Get.to(const MusicPreference());
                },
                child: const Text("Music preference",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600,color: AppColors.txtcolor),)),
            const SizedBox(height: 25,),
            const Text("Invite Friends",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600,color: AppColors.txtcolor),),
            const SizedBox(height: 25,),
            const Text("App Feedback",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600,color: AppColors.txtcolor),),
            const SizedBox(height: 25,),
            const Text("Help",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600,color: AppColors.txtcolor),),
            const SizedBox(height: 30,),
            InkWell(
                onTap: (){
                  Get.to(const MaterialYou());
                },
                child: const Icon(Icons.multiple_stop_rounded,color: AppColors.txtcolor,size: 40,)),
          ],
        ),
      ),
    );
  }
}
