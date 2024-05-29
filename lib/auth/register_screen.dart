import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:music_hunt/utlis/utils.dart';
import '../model/user_model.dart';
import '../widgets/textfield.dart';
import 'loginPage.dart';

class RegidterScreen extends StatefulWidget {
  const RegidterScreen({Key? key}) : super(key: key);

  @override
  State<RegidterScreen> createState() => _RegidterScreenState();
}

class _RegidterScreenState extends State<RegidterScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  bool isLoading = false;
  registerUser() async {
    isLoading = true;
    setState(() {});

    try {
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
        id: userId, // Use Firebase UID as ID

      );

      // Check if the email is already registered in Firestore
      var existingUser = await FirebaseFirestore.instance
          .collection("users")
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
            .collection("users")
            .doc(userId) // Use Firebase UID as document ID
            .set(dataModel.toJson());

        isLoading = false;
        setState(() {});
        Fluttertoast.showToast(msg: 'Account created successfully');
        Navigator.push(context, MaterialPageRoute(builder: (context) => const Login_Page()));
      }
    } catch (e) {
      isLoading = false;
      setState(() {});
      Fluttertoast.showToast(msg: 'Some error occurred');
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
          padding: const EdgeInsets.only(top: 20, bottom: 40),
          child: Column(
            children: [
              const SizedBox(
                height: 40,
              ),
              const Center(
                  child: Text(
                    "Music Hunt",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w900,
                        color: AppColors.themecolor),
                  )),
              const SizedBox(
                height: 30,
              ),
              Image.asset("images/logo.png"),
              const SizedBox(height: 50,),
              CustomTextField(
                controller: userNameController,
                hintText: "name",
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

              const SizedBox(height: 30,),
              isLoading?const CircularProgressIndicator():
              GestureDetector(
                onTap: (){
                  registerUser();
                },
                child: Container(
                  height: 35,
                  width: MediaQuery.of(context).size.width * 0.6,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: AppColors.themecolor
                  ),
                  child: const Center(child: Text("Save",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),)),
                ),
              ),
              const SizedBox(height: 30,),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const Login_Page()));
                },
                child: Container(
                    color: AppColors.blackcolor,
                    child: const Text("Login",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600,color: AppColors.themecolor),)),
              ),
              const SizedBox(height: 30,),
              const Text("Register WITH FACEBOOK",style: TextStyle(fontSize: 17,fontWeight:FontWeight.w700,color: AppColors.txtcolor),),
              const Spacer(),
              const Text("Are You Band or a Bar?",style: TextStyle(fontSize: 17,fontWeight:FontWeight.w600,color: AppColors.txtcolor),),
              const SizedBox(height: 20,),
              const Text("By Siging up you agree to adhare to our tems and policy",style: TextStyle(fontSize: 12,color: AppColors.txtcolor),),

            ],
          ),
        ),
      ),
    );
  }
}
