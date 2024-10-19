import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../Core/themes/TextStyles/fontstyle.dart';

class HeaderRegistarWidgets extends StatelessWidget {
  const HeaderRegistarWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 119.h,
      child: Column(
      crossAxisAlignment:CrossAxisAlignment.start,
        children: [
          Text(
            'Create Account',
            style: FontStyles.font24boldblue
          ),
           SizedBox(height: 8.h,),
           Text(
            'Sign up now and start exploring all that our app has to offer. We\'re excited to welcome you to our community!.',
            style: FontStyles.font14w400darkgray)
        ],
      ),
    );
  }
}