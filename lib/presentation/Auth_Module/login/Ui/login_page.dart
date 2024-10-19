import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../Core/Server/ApiService.dart';
import '../data/repository/Login_Repo.dart';
import '../logic/login_cubit.dart';
import 'Widgets/Footer_widgets.dart';
import 'Widgets/Header_widgets.dart';
import 'Widgets/body_widgets.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(LoginRepository(ApiService())),
      child: Scaffold(
          body: SingleChildScrollView(
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 31.w, vertical: 31.h),
                child: Column(
                  children: [
                    HeaderloginWidgets(),
                    SizedBox(height: 31.h,),
                    BodyLoginWidgets(),
                    FooterloginWidgets()
                  ],
                ),
              ),
            ),
          )
      ),
    );
  }
}