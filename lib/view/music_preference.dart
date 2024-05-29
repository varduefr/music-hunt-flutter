import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_hunt/utlis/utils.dart';

import '../widgets/custombutton.dart';

class MusicPreference extends StatefulWidget {
  const MusicPreference({Key? key}) : super(key: key);

  @override
  State<MusicPreference> createState() => _MusicPreferenceState();
}

class _MusicPreferenceState extends State<MusicPreference> {
  List<int> selectedIndices = [];
  List<String> buttonTitles = [
    'Rock',
    'Pop',
    'Hip Hop',
    'Jazz',
    'Electronic',
    'Classical',
    'Metal',
    'Folk',
    'Country',
    'R&B',
    'Reggae',
    'Blues',
    'Alternative',
    'Indie',
    'Punk',
    'Grunge',
    'Experimental',
    'Ambient',
    'Techno',
    'House',
    'Trance',
    'Dubstep',
    'Drum and Bass',
    'Trap',
    'Hardcore',
    'Psychedelic',
    'Ska',
    'Reggaeton',
    'Latin',
    'World Music',
    'Fusion',
    'Acoustic',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 25, top: 60, bottom: 20),
        child: Column(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.arrow_back_ios, size: 22, color: AppColors.txtcolor),
                Text(
                  "Music Preferences",
                  style: TextStyle(fontSize: 20, color: AppColors.txtcolor),
                ),
                Icon(Icons.search, size: 22, color: AppColors.txtcolor),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              "Select your music preferences so MusicHunt\n     can recommend bands you may like!",
              style: TextStyle(fontSize: 14, color: AppColors.txtcolor),
            ),
            const SizedBox(height: 20),
            Expanded( // Ensure the GridView can take up all available vertical space
              child: SingleChildScrollView(
                child: GridView.count(
                  crossAxisCount: 3, // Change this according to your needs
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(), // Disable GridView's scrolling
                  children: List.generate(
                    buttonTitles.length,
                        (index) => CustomButton(
                          height:30,
                          width: 100,
                      color: selectedIndices.contains(index) ? AppColors.themecolor : AppColors.scaffloadcolor,
                      text: buttonTitles[index], // Use the button title from the list
                      textStyle: selectedIndices.contains(index) ? AppStyles.black13 : AppStyles.txt13,
                      onTap: () {
                        setState(() {
                          handleButtonTap(index);
                        });
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void handleButtonTap(int index) {
    setState(() {
      if (selectedIndices.contains(index)) {
        // If button is already selected, remove it from the list
        selectedIndices.remove(index);
      } else {
        // If button is not selected, add it to the list
        selectedIndices.add(index);
      }
    });
  }
}
