import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_cubit/Core/Widgets/Custom_Button.dart';
import 'package:test_cubit/Core/Widgets/Custom_Textfromfield.dart';

import '../../../../../Core/Server/ApiService.dart';
import '../../../login/data/repository/Login_Repo.dart';
import '../../../login/logic/login_cubit.dart';

class BodyRegistarwidgets extends StatelessWidget {
  BodyRegistarwidgets({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(LoginRepository(ApiService())),
      child: Column(
        children: [
          Container(
              height: 197.h,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomTextfromfield(
                    hintText: "Email",
                    Controller:context.read<LoginCubit>().emailController,
                  ),
                  CustomTextfromfield(
                    hintText: "Password",
                    isObscure: true,
                    Controller:context.read<LoginCubit>().passwordController,
                  ),
                  CustomTextfromfield(
                      hintText: "Your number", Controller: context.read<LoginCubit>().passwordController,),
                ],
              )),
          // SizedBox(height: 14.h,),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h),
            child: CustomButton(name: "Create Account", ontap: () async {}),
          )
        ],
      ),
    );
  } // Ensure you close the build method
}
