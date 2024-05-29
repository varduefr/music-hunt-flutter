import 'package:flutter/material.dart';

import '../utlis/utils.dart';
import '../widgets/custombandwidget.dart';
class Bands extends StatefulWidget {
  const Bands({Key? key}) : super(key: key);

  @override
  State<Bands> createState() => _BandsState();
}

class _BandsState extends State<Bands> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff141424),
        automaticallyImplyLeading: false,
        leading: Icon(Icons.arrow_back_ios,size: 20,color: AppColors.txtcolor,),
        title: Text(
          'Bands',
          style: TextStyle(
              fontSize: 20,
              color: AppColors.txtcolor,
              fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        actions: [
          Icon(Icons.favorite,color: AppColors.txtcolor,),
          SizedBox(width: 15,),
        ],
      ),
      body: Column(
             children: [
               Container(
                 width: double.infinity,
                 child: Image.asset("images/bands.webp",),
               ),
               SizedBox(height: 10,),
               ListTile(
                 leading: Image.asset("images/band.jpg",),
                 title: Text(
                   "Pub Lunatic",
                   style: TextStyle(
                       color: AppColors.txtcolor,
                       fontSize: 18,
                       fontWeight: FontWeight.w600),
                 ),
                 subtitle: Text(
                   "Pub Lunatic",
                   style: TextStyle(
                       color: AppColors.txtcolor,
                       fontSize: 14,
                       fontWeight: FontWeight.w400),
                 ),
                 trailing: Icon(
                   Icons.share,
                   color: AppColors.txtcolor,
                 ),
               ),
               SizedBox(height: 20,),
               CustomStatsWidget(
                 likes: "55",
                 title: "Diamound",
                 subtitle: "Orginal",
                 duration: "3:24",
               ),
               Divider(
                 color: AppColors.txtcolor,
               ),
               CustomStatsWidget(
                 likes: "55",
                 title: "Diamound",
                 subtitle: "Orginal",
                 duration: "3:24",
               ),
               Divider(
                 color: AppColors.txtcolor,
               ),
               CustomStatsWidget(
                 likes: "55",
                 title: "Diamound",
                 subtitle: "Orginal",
                 duration: "3:24",
               ),
               Divider(
                 color: AppColors.txtcolor,
               ),
               CustomStatsWidget(
                 likes: "55",
                 title: "Diamound",
                 subtitle: "Orginal",
                 duration: "3:24",
               ),
               Divider(
                 color: AppColors.txtcolor,
               ),
               CustomStatsWidget(
                 likes: "55",
                 title: "Diamound",
                 subtitle: "Orginal",
                 duration: "3:24",
               ),
               Divider(
                 color: AppColors.txtcolor,
               ),
               CustomStatsWidget(
                 likes: "55",
                 title: "Diamound",
                 subtitle: "Orginal",
                 duration: "3:24",
               ),
               Divider(
                 color: AppColors.txtcolor,
               ),
               CustomStatsWidget(
                 likes: "55",
                 title: "Diamound",
                 subtitle: "Orginal",
                 duration: "3:24",
               ),
               Divider(
                 color: AppColors.txtcolor,
               ),


             ],
      ),
    );
  }
}
