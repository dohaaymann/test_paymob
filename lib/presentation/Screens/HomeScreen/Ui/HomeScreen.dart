import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pay_with_paymob/paymob_payment.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_cubit/presentation/Auth_Module/LogOut/data/repository/logOut_Repository.dart';
import 'package:test_cubit/presentation/Auth_Module/LogOut/logic/log_out_cubit.dart';
import 'package:test_cubit/presentation/Auth_Module/login/Ui/login_page.dart';

import '../../Recommenation_Doctor/Ui/RecommendDoc.dart';

class Homescreen extends StatelessWidget {
  const Homescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Screen"),
      ),
      body: BlocProvider(
        create: (context) => LogOutCubit(LogoutRepository()),
        child: Center(
          child: BlocBuilder<LogOutCubit, LogOutState>(
            builder: (context, state) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PaymentView(
                          onPaymentSuccess: () {
                            // Handle payment success here, show a confirmation dialog or navigate to another page.
                            print("Payment successful!");
                          },
                          onPaymentError: () {
                            // Handle payment failure, show error dialog or retry options.
                            print("Payment failed!");
                          },
                          price: 100, // (Required) Total Price e.g. 100 => 100 LE
                        )),
                      );

                      // Navigator.of(context).push(MaterialPageRoute(builder: (context) => RecommendDoc(),));
                      // context.read<LogOutCubit>().LogOut().then((value) {
                      //   print(value);
                      //       Navigator.of(context).pushAndRemoveUntil(
                      //           MaterialPageRoute(
                      //               builder: (context) => const LoginPage()),
                      //             (route) => false);
                      // },);
                    },
                    child: const Text("Logout"),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
