import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:music_hunt/auth/bar_register.dart';
import 'package:music_hunt/auth/register_screen.dart';
import 'package:music_hunt/const/static_info.dart';
import 'package:music_hunt/utlis/utils.dart';
import '../view/navigationbar.dart';
import '../widgets/textfield.dart';

class Login_Page extends StatefulWidget {
  const Login_Page({Key? key}) : super(key: key);

  @override
  State<Login_Page> createState() => _Login_PageState();
}

class _Login_PageState extends State<Login_Page> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  bool isSwitched = false;

  void toggleSwitch(bool value) {
    setState(() {
      isSwitched = value;
      if (isSwitched) {
        Get.to(() => const BarRegisterScreen());
      } else {
        Get.to(() => const RegidterScreen());
      }
      print(isSwitched ? "Showing Text Bars" : "Showing Band");
    });
  }

  userLogin() async {
    isLoading = true;
    setState(() {});
    //SharedPreferences preferences = await SharedPreferences.getInstance();
    bool userNameExists;
    bool passwordExists;
    try {
      var authResult = await FirebaseFirestore.instance
          .collection("users")
          .where('email', isEqualTo: emailController.text)
          .get();
      userNameExists = authResult.docs.isNotEmpty;
      if (userNameExists) {
        var authResult = await FirebaseFirestore.instance
            .collection("users")
            .where('password', isEqualTo: passwordController.text.toLowerCase())
            .get();
        passwordExists = authResult.docs.isNotEmpty;
        if (passwordExists) {
          //await preferences.setString('userName', userName.text.trim());
          //  await preferences.setString('password', password.text.trim());
          var authResult = await FirebaseFirestore.instance
              .collection("users")
              .where('email', isEqualTo: emailController.text.toLowerCase()  )
              .get().then((value) {
            value.docs.forEach((result) async{
              print("result = ${result.data()}");
              print("result user id = ${result.id}");
              StaticInfo.userID = result.id;
              // await preferences.setBool('isLoggedIn', true);
              // await preferences.setString('userName', result.data()['name']);
              // await preferences.setString('userID', result.id.trim());
              //  StaticInfo.docId =result.data()['doc'];
            });
          });
          isLoading = false;
          setState(() {});
          Fluttertoast.showToast(msg: 'Successfully logged in');
          Get.to(const MaterialYou());
       //   Navigator.push(context, MaterialPageRoute(builder: (context)=> const BottomNavBar()));

        } else {
          isLoading = false;
          setState(() {});
          Fluttertoast.showToast(msg: 'Incorrect email or password');
        }
      } else {
        isLoading = false;
        setState(() {});
        Fluttertoast.showToast(msg: 'Incorrect email or password');
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
          padding: const EdgeInsets.only(top: 60, bottom: 40),
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
                controller: emailController,
                hintText: "Email",
              ),
             const SizedBox(height: 20,),
              CustomTextField(
                controller: passwordController,
                hintText: "Password",
              ),
              const SizedBox(height: 30,),
              isLoading?const CircularProgressIndicator():
              GestureDetector(
                onTap: (){
                  userLogin();
                },
                child: Container(
                  height: 35,
                  width: MediaQuery.of(context).size.width * 0.6,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: AppColors.themecolor
                  ),
                  child: const Center(child: Text("LOGIN",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),)),
                ),
              ),
              const SizedBox(height: 30,),
              InkWell(
                onTap: (){
                  Get.to(const RegidterScreen());
                },
                child: Container(
                    color: Colors.transparent,
                    child: const Text("REGISTER",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: AppColors.themecolor),)),
              ),
              const SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Are You a ",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              InkWell(
                //onTap: () => _navigateTo(context, 'Band'),
                child: Text(
                  "Band ",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: Colors.blue,
                  ),
                ),
              ),
              Text(
                "or a ",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              InkWell(
                onTap: () =>   Get.to(() => const BarRegisterScreen()),
                child: Text(
                  "Bar?",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: Colors.blue,
                  ),
                ),
              ),
              Text(
                " style",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              SizedBox(width: 10),
            ],
          ),

              // const Row(
              //   children: [
              //     Text("Are You Band or a Bar style",style: TextStyle(fontSize: 17,fontWeight:FontWeight.w600,color: AppColors.txtcolor),),
              //     SizedBox(width: 10,),
              //
              //   ],
              // ),

            //  if (isSwitched) Get.to(const BarRegidterScreen()) else Get.to(RegidterScreen());


              const SizedBox(height: 30,),
           // Text("LOGIN WITH FACEBOOK",style: TextStyle(fontSize: 17,fontWeight:FontWeight.w700,color: AppColors.txtcolor),),
            const Spacer(),

              const SizedBox(height: 20,),
            const Text("By Signing up you agree to adhere to our Terms and Privacy Policy",style: TextStyle(fontSize: 12,color: AppColors.txtcolor),),

        ],
          ),
        ),
      ),
    );
  }
}
