import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_cubit/presentation/Auth_Module/Registar/Ui/Widgets/Footer_widgets.dart';

import 'Widgets/Header_widgets.dart';
import 'Widgets/body_widgets.dart';

class RegistarPage extends StatelessWidget {
  const RegistarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding:EdgeInsets.symmetric(horizontal:31.w,vertical: 31.h ),
              child: Column(
                children: [
                   HeaderRegistarWidgets(),
                  SizedBox(height: 31.h,),
                  BodyRegistarwidgets(),
                  FooterRegistarWidgets()
                ],
              ),
            ),
          ),
        )
    );
  }
}