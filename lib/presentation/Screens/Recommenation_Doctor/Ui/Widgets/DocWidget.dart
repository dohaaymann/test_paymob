import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_cubit/presentation/Screens/Recommenation_Doctor/data/Model/GetAllDoc_Model.dart';

import '../../../../../Core/themes/TextStyles/fontstyle.dart';

class Docwidget extends StatelessWidget {
  final Data doctor; // Add this field to receive doctor data
  const Docwidget({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      margin: EdgeInsets.symmetric(vertical: 16.h),
      child:Row(
        children: [
          Container(
            height: 110.h,
            width: 110.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.r),
              color: Color(0xffFDFDFF),
              image: DecorationImage(image:NetworkImage("${doctor.photo}",),fit: BoxFit.fill),
            ),
    ),
          Container(
            // height: 75.h,
            margin: EdgeInsets.all(12.h),
            padding: EdgeInsets.symmetric(vertical: 12.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Dr.${doctor.name}",style:FontStyles.font16w700black,),
                Image.asset("images/Text (1).png",height: 15.h,),
                Image.asset("images/Reviews.png",height: 16.h,),
              ],
            ),
          )
        ],
      ),

    );
  }
}
