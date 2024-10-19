import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_cubit/Core/Widgets/Custom_Button.dart';
import 'package:test_cubit/Core/Widgets/Custom_Textfromfield.dart';
import 'package:test_cubit/Core/themes/Colors/ColorsStyle.dart';
import '../../../../../Core/Server/ApiService.dart';
import '../../../../../Core/themes/TextStyles/fontstyle.dart';
import '../../../../Screens/HomeScreen/Ui/HomeScreen.dart';
import '../../data/repository/Login_Repo.dart';
import '../../logic/login_cubit.dart';

class BodyLoginWidgets extends StatefulWidget {
  @override
  State<BodyLoginWidgets> createState() => _BodyLoginWidgetsState();
}

class _BodyLoginWidgetsState extends State<BodyLoginWidgets> {
  var isObscure = true;

  @override
  void initState() {
    super.initState();
    // Initialize LoginCubit here
    context.read<LoginCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is Loginloading) {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return Container(
                    color: Colors.black45,
                    height: double.infinity,
                    child: const Center(
                        child: SizedBox(
                            height: 50,
                            width: 50,
                            child:
                            CircularProgressIndicator(
                              color: Colors
                                  .blueAccent,
                              strokeWidth: 7,
                            ))));
              });
        } else if (state is LoginSuccess) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => Homescreen(),
          ));
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Login successful!')),
          );
        } else if (state is LoginFailure) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${state.error}')),
          );
        }
      },
      child: Form(
        key: context.read<LoginCubit>().formKey,
        child: Column(
          children: [
            Column(
              children: [
                CustomTextfromfield(
                  hintText: "Email",
                  Controller: context.read<LoginCubit>().emailController,
                ),
                SizedBox(height: 15.h),
                CustomTextfromfield(
                  hintText: "Password",
                  isObscure: isObscure,
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        isObscure = !isObscure;
                      });
                    },
                    child: Icon(
                      isObscure ? Icons.visibility_off : Icons.visibility,
                      color: ColorStyle.primaryblue,
                    ),
                  ),
                  Controller: context.read<LoginCubit>().passwordController,
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      "Forgot Password?",
                      style: FontStyles.font14w400blue,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h),
              child: BlocBuilder<LoginCubit, LoginState>(
                builder: (context, state) {
                  return CustomButton(
                    name: "Login",
                    ontap: () {
                      if (context.read<LoginCubit>().formKey.currentState!.validate()) {
                        context.read<LoginCubit>().login(); // Call login method
                      }
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
