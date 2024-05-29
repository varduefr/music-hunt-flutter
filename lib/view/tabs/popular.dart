// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:music_hunt/view/bar_details.dart';
//
// class Popular extends StatefulWidget {
//   const Popular({Key? key}) : super(key: key);
//
//   @override
//   State<Popular> createState() => _PopularState();
// }
//
// class _PopularState extends State<Popular> {
//   final List<String> images = [
//     'images/logo.png', // Example asset image path
//     'images/1.jpeg',
//     'images/2.jpeg',
//     'images/3.jpeg',
//     'images/4.jpeg',
//     'images/7.jpeg',
//     'images/8.jpeg',
//     'images/9.jpeg',
//     'images/10.jpeg',
//     'images/download.jpeg',
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Row(
//               children: [
//                 Expanded(
//                   flex: 3,
//                   child: Container(
//                     height: 200,
//                     color: Colors.blue,
//                     child: Center(
//                       child: Image.asset(
//                         images[0],
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ),
//                 ),
//                 Expanded(
//                   flex: 2, // Each small container takes 2/5 of the width
//                   child: Column(
//                     children: [
//                       _buildSmallGridCell(images[1]), // Example: Using the second image
//                       SizedBox(height: 8),
//                       _buildSmallGridCell(images[6]), // Example: Using the third image
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//
//           //  _buildRegularGridRow(images[5], images[4], images[9]),
//             // _buildRegularGridRow(images[7], images[6], images[3]),
//             // _buildRegularGridRow(images[9], images[0], images[1]),
//             // _buildRegularGridRow(images[1], images[3], images[4]),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildRegularGridRow(String image1, String image2, String image3) {
//     return Row(
//       children: [
//         _buildRegularGridCell(image1),
//         _buildRegularGridCell(image2),
//         _buildRegularGridCell(image3),
//       ],
//     );
//   }
//
//   Widget _buildSmallGridCell(String imagePath) {
//     return InkWell(
//       onTap: (){
//         Get.to(Bars_Details());
//       },
//       child: Container(
//         height: 100,
//         color: Colors.green,
//         child: Center(
//           child: Image.asset(
//             imagePath,
//             fit: BoxFit.cover,
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildRegularGridCell(String imagePath) {
//     return Expanded(
//       child: InkWell(
//         onTap: (){
//           Get.to(Bars_Details());
//         },
//         child: Container(
//           height: 100,
//           color: Colors.orange,
//           child: Center(
//             child: Image.asset(
//               imagePath,
//               fit: BoxFit.cover,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:music_hunt/view/bar_details.dart';

class Popular extends StatefulWidget {
  const Popular({Key? key}) : super(key: key);

  @override
  State<Popular> createState() => _PopularState();
}

class _PopularState extends State<Popular> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: StreamBuilder(
        stream: _firestore.collection('Bars').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          List<Map<String, dynamic>> bars = snapshot.data!.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();

          return GridView.builder(
            padding: const EdgeInsets.all(8.0),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
            ),
            itemCount: bars.length,
            itemBuilder: (context, index) {
              return _buildGridCell(bars[index]);
            },
          );
        },
      ),
    );
  }

  Widget _buildGridCell(Map<String, dynamic> bar) {
    return InkWell(
      onTap: () {
        Get.to(() => Bars_Details(
          name: bar['name'],
          address: bar['address'], // Ensure 'address' field exists in your Firestore document
          city: bar['city'], // Ensure 'city' field exists in your Firestore document
          openTime: bar['openTime'], // Ensure 'openTime' field exists in your Firestore document
          image:bar['image'], // Ensure 'images' field exists in your Firestore document and is a List<String>
        ));
      },
      child: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.orange,
                image: DecorationImage(
                  image: NetworkImage(bar['image']),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(height: 4),
          Text(
            bar['name'],
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
