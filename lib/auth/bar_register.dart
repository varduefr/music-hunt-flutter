import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:music_hunt/utlis/utils.dart';
import '../model/user_model.dart';
import '../widgets/textfield.dart';
import 'loginPage.dart';

class BarRegisterScreen extends StatefulWidget {
  const BarRegisterScreen({Key? key}) : super(key: key);

  @override
  State<BarRegisterScreen> createState() => _BarRegisterScreenState();
}

class _BarRegisterScreenState extends State<BarRegisterScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController postalCodeController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  bool isLoading = false;
  bool isBar = true; // New state for switch

  Future<Map<String, double>> _getLatLongFromAddress(String address) async {
    final String apiKey = 'AIzaSyAlWLuEzszKgldMmuo9JjtKLxe9MGk75_k';
    final String url =
        'https://maps.googleapis.com/maps/api/geocode/json?address=$address&key=$apiKey';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      if (data['status'] == 'OK') {
        var location = data['results'][0]['geometry']['location'];
        return {
          'latitude': location['lat'],
          'longitude': location['lng'],
        };
      } else {
        throw Exception('Error fetching coordinates');
      }
    } else {
      throw Exception('Failed to load coordinates');
    }
  }

  registerUser() async {
    isLoading = true;
    setState(() {});

    try {
      // Get the full address as a string
      String fullAddress =
          '${addressController.text}, ${cityController.text}, ${postalCodeController.text}, ${countryController.text}';

      // Fetch latitude and longitude from the address
      Map<String, double> coordinates = await _getLatLongFromAddress(fullAddress);

      // Register user with Firebase Authentication
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      // Get the unique ID assigned by Firebase Authentication
      String userId = userCredential.user!.uid;

      // Create data model
      AddUserModel dataModel = AddUserModel(
        name: userNameController.text,
        email: emailController.text,
        password: passwordController.text,
        address: addressController.text,
        postalCode: postalCodeController.text,
        city: cityController.text,
        country: countryController.text,
        latitude: coordinates['latitude']!,
        longitude: coordinates['longitude']!,
        id: userId, // Use Firebase UID as ID
      );

      // Check if the email is already registered in Firestore
      var existingUser = await FirebaseFirestore.instance
          .collection(isBar ? "Bars" : "Bands")
          .where('email', isEqualTo: emailController.text)
          .get();

      if (existingUser.docs.isNotEmpty) {
        // Email is already registered
        isLoading = false;
        setState(() {});
        Fluttertoast.showToast(msg: 'Email is already registered');
      } else {
        // Email is not registered, proceed with storing user data in Firestore
        await FirebaseFirestore.instance
            .collection(isBar ? "Bars" : "Bands")
            .doc(userId) // Use Firebase UID as document ID
            .set(dataModel.toJson());

        isLoading = false;
        setState(() {});
        Fluttertoast.showToast(msg: '${isBar ? "Bar" : "Band"} registered successfully');
        Navigator.push(context, MaterialPageRoute(builder: (context) => const Login_Page()));
      }
    } catch (e) {
      isLoading = false;
      setState(() {});
      print(e.toString());
      Fluttertoast.showToast(msg: 'Some error occurred: ${e.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/bg.jpg"),
            fit: BoxFit.fill,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15,),
          child: Column(
            children: [
              const Center(
                  child: Text(
                    "Music Hunt",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w900,
                        color: AppColors.themecolor),
                  )),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Are you a ${isBar ? "Bar" : "Band"}",
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                    ),
                  ),
                  SizedBox(width: 5,),
                  Switch(
                    value: isBar,
                    onChanged: (value) {
                      setState(() {
                        isBar = value;
                      });
                    },
                    activeColor: Colors.grey,
                  ),
                ],
              ),
              // const SizedBox(
              //   height: 15,
              // ),
              Image.asset("images/logo.png", height: 80, width: 100,),

              CustomTextField(
                controller: userNameController,
                hintText: "Bar/Band name",
              ),
              const SizedBox(height: 20,),
              CustomTextField(
                controller: emailController,
                hintText: "Email",
              ),
              const SizedBox(height: 20,),
              CustomTextField(
                controller: passwordController,
                hintText: "Password",
              ),
              const SizedBox(height: 20,),
              CustomTextField(
                controller: addressController,
                hintText: "Address",
              ),
              const SizedBox(height: 20,),
              CustomTextField(
                controller: postalCodeController,
                hintText: "Postal Code",
              ),
              const SizedBox(height: 20,),
              CustomTextField(
                controller: cityController,
                hintText: "City",
              ),
              const SizedBox(height: 20,),
              CustomTextField(
                controller: countryController,
                hintText: "Country",
              ),
              const SizedBox(height: 20,),
              isLoading ? const CircularProgressIndicator() :
              GestureDetector(
                onTap: () {
                  registerUser();
                },
                child: Container(
                  height: 35,
                  width: MediaQuery.of(context).size.width * 0.6,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: AppColors.themecolor
                  ),
                  child: const Center(child: Text("Save", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),)),
                ),
              ),
              const SizedBox(height: 30,),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const Login_Page()));
                },
                child: Container(
                    color: AppColors.blackcolor,
                    child: const Text("Login", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: AppColors.themecolor),)),
              ),
              const SizedBox(height: 30,),
              const Text("Register WITH FACEBOOK", style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700, color: AppColors.txtcolor),),
              const Spacer(),
              const Text("Are You Band or a Bar?", style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600, color: AppColors.txtcolor),),
              const SizedBox(height: 20,),
              const Text("By Signing up you agree to adhere to our terms and policy", style: TextStyle(fontSize: 12, color: AppColors.txtcolor),),
            ],
          ),
        ),
      ),
    );
  }
}

