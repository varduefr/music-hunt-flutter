import 'package:flutter/material.dart';

class Bars_Details extends StatefulWidget {
  final String name;
  final String address;
  final String city;
  final String openTime;
  final String image; // Single image URL

  const Bars_Details({
    Key? key,
    required this.name,
    required this.address,
    required this.city,
    required this.openTime,
    required this.image,
  }) : super(key: key);

  @override
  State<Bars_Details> createState() => _Bars_DetailsState();
}

class _Bars_DetailsState extends State<Bars_Details> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff141424),
        automaticallyImplyLeading: true,
        leading: GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },

            child: const Icon(Icons.arrow_back_ios, size: 20, color: Colors.white)),
        title: const Text(
          'Bar',
          style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        actions: [
          const Icon(Icons.favorite, color: Colors.white),
          const SizedBox(width: 15),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 300.0,
            decoration: BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                image: NetworkImage(widget.image), // Display the single image
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.name,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w500, color: Colors.white),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.address,
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 15),
                    ),
                    Text(
                      widget.city,
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 13),
                    ),
                  ],
                ),
                const Spacer(),
                const Icon(Icons.favorite, color: Colors.white),
                const SizedBox(width: 15),
                const Icon(Icons.share, color: Colors.white),
                const SizedBox(width: 15),
                const Column(
                  children: [
                    Text("55", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                    Text("Likes", style: TextStyle(color: Colors.white)),
                  ],
                ),
                const SizedBox(width: 10),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              "Open At ${widget.openTime}",
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}
