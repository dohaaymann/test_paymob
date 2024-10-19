import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../Core/themes/Colors/ColorsStyle.dart';
import '../../../../../Core/themes/TextStyles/fontstyle.dart';
import '../../../login/Ui/login_page.dart';
class FooterRegistarWidgets extends StatelessWidget {
  const FooterRegistarWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
        padding: EdgeInsets.symmetric(vertical: 24.h),
        child: Image.asset("images/Text.png"),
      ),
      Padding(
        padding:EdgeInsets.symmetric(vertical: 32.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: ColorStyle.lightgray,
              radius: 30.r,
              child: Image.asset(
                "images/google.png",
                width: 22.w,
                height: 26.h,
              ),
            ),
            SizedBox(
              width: 15.w,
            ),
            CircleAvatar(
              backgroundColor: ColorStyle.lightgray,
              radius: 30.r,
              child: Image.asset(
                "images/face.png",
                width: 22.w,
                height: 26.h,
              ),
            ),
          ],
        ),
      ),
      Padding(
        padding:EdgeInsets.symmetric(vertical: 24.h),
        child: Column(children: [
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: "By continuing, you agree to our ",
              style: FontStyles.font11w400gray,  // Your custom style
              children: [
                TextSpan(
                  text: "Terms of Service",
                  style: FontStyles.font11w400black,  // Style for clickable text
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      // Handle Terms of Service tap
                      print("Terms of Service tapped");
                    },
                ),
                TextSpan(
                  text: " and \n",
                  style: FontStyles.font11w400gray,  // Your custom style
                ),
                TextSpan(
                  text: "Privacy Policy",
                  style: FontStyles.font11w400black,  // Style for clickable text
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      // Handle Privacy Policy tap
                      print("Privacy Policy tapped");
                    },
                ),
              ],
            ),
          ),
          SizedBox(height: 15.h,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RichText(
                text: TextSpan(
                  text: "Already have an account? ",
                  style: FontStyles.font14w400black, // Main text style
                  children: [
                    TextSpan(
                      text: "Signin",
                      style: FontStyles.font14w400blue, // Style for clickable text
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginPage(),));
                        },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],),
      )

    ]);
  }
}
