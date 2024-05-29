import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_hunt/auth/loginPage.dart';
import 'package:music_hunt/utlis/utils.dart';

class OnBoarding_Screen extends StatefulWidget {
  const OnBoarding_Screen({Key? key}) : super(key: key);

  @override
  State<OnBoarding_Screen> createState() => _OnBoarding_ScreenState();
}

class _OnBoarding_ScreenState extends State<OnBoarding_Screen> {

  final PageController _pageController = PageController();
  int _currentPage = 0;
  final List<Map<String, dynamic>> onboardingPages = [
    {
      'title': 'DISCOVER',
      'subtitle': 'Find Live music near you that\nmatch your music preferences.',
      'subtitles': "Fill out your profile and we'll find\nthe best live bands for you.",
      'image': "images/onbordingicons/1st.PNG",
    },
    {
      'title': 'CONNECT',
      'subtitle': "Connect with bands and bars to get\nnotified of live music events.",
      'subtitles': "Make friends with people that\nshare you taste in music",
      'image': "images/onbordingicons/2nd.PNG",
    },
    {
      'title': 'WIN',
      'subtitle': 'The more you share your taste\nin music the more point you get!',
      'subtitles': "points will get you discounts\nand free stuff from the bars!",
      'image': "images/onbordingicons/3rd.PNG",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 20, bottom: 40),
        child: Column(
          children: [
            SizedBox(height: Get.height * 0.06),
            Center(child: Image.asset("images/logo.png")),
            SizedBox(height: Get.height * 0.05),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: onboardingPages.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        onboardingPages[index]['title']!,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 32,
                          color: AppColors.themecolor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: Get.height * 0.06),
                      Text(
                        onboardingPages[index]['subtitle']!,
                        style: TextStyle(
                          color: AppColors.txtcolor,
                          fontSize: 18,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: Get.height * 0.03),
                      Text(
                        onboardingPages[index]['subtitles']!,
                        style: TextStyle(
                          color: AppColors.txtcolor,
                          fontSize: 18,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: Get.height * 0.09),
                      Container(
                        height:130,
                        width:130,
                        child: Image.asset(
                          onboardingPages[index]['image'],
                          fit: BoxFit.contain,
                        ),
                      ),
                      Spacer(),
                    ],
                  );
                },
              ),
            ),

            SizedBox(height: 20), 
            Container(
              height: 40,
              width: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: AppColors.themecolor,
              ),
              child: TextButton(
                onPressed: () {
                  if (_currentPage < onboardingPages.length - 1) {
                    _pageController.nextPage(duration: Duration(milliseconds: 500), curve: Curves.ease);
                  } else {
                    // Navigate to home page
                    Get.offAll(Login_Page());
                  }
                },
                child: Text(
                  _currentPage < onboardingPages.length - 1 ? 'Next' : 'Get Started',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                onboardingPages.length,
                    (index) => Container(
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentPage == index ? AppColors.themecolor : Colors.grey,
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}

