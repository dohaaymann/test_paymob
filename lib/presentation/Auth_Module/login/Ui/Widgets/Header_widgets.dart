import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../Core/themes/TextStyles/fontstyle.dart';

class HeaderloginWidgets extends StatelessWidget {
  const HeaderloginWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 119.h,
      child: Column(
      crossAxisAlignment:CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome Back',
            style: FontStyles.font24boldblue
          ),
           SizedBox(height: 8.h,),
           Text(
            'We\'re excited to have you back, can\'t wait to see what you\'ve been up to since you last logged in.',
            style: FontStyles.font14w400darkgray)
        ],
      ),
    );
  }
}