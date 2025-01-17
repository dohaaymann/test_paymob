import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paymob/flutter_paymob.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pay_with_paymob/paymob_payment.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_cubit/Core/Routing/app_routes.dart';
import 'package:test_cubit/Core/extentions/Navigation_extention.dart';
import 'package:test_cubit/paymob_view.dart';
import 'package:test_cubit/presentation/Auth_Module/login/Ui/login_page.dart';
import 'package:test_cubit/presentation/Screens/GoogleMap/googleMap.dart';
import 'package:test_cubit/presentation/Screens/HomeScreen/Ui/HomeScreen.dart';
import 'Core.dart';
import 'Core/Routing/Routes.dart';
import 'Core/themes/Colors/ColorsStyle.dart';
import 'Paymob_manager.dart';

void main()async{
  await ScreenUtil.ensureScreenSize();
  // FlutterPaymob.instance.initialize(
  //     apiKey:kconst.apiKeys, //  // from dashboard Select Settings -> Account Info -> API Key
  //     integrationID:int.parse(kconst.cardPaymentMethodIntegrationId) , // // from dashboard Select Developers -> Payment Integrations -> Online Card ID
  //     walletIntegrationId:int.parse(kconst.walletIntegrationId), // // from dashboard Select Developers -> Payment Integrations -> Online wallet
  //     iFrameID: 872933,
  //
  // );
  PaymentData.initialize(
    apiKey: kconst.apiKeys, // (Required) getting it from dashboard Select Settings -> Account Info -> API Key
    iframeId: '872933', // (Required) getting it from paymob Select Developers -> iframes
    integrationCardId: kconst.cardPaymentMethodIntegrationId, // (Required) getting it from dashboard Select Developers -> Payment Integrations -> Online Card ID
    integrationMobileWalletId: kconst.walletIntegrationId, // (Required) getting it from dashboard Select Developers -> Payment Integrations -> Mobile Wallet ID

    // // Optional User Data
    // userData: UserData(
    //   email: "User Email", // (Optional) Email | Default: 'NA'
    //   phone: "User Phone", // (Optional) Phone | Default: 'NA'
    //   firstName: "User First Name", // (Optional) First Name | Default: 'NA'
    //   lastName: "User Last Name", // (Optional) Last Name | Default: 'NA'
    // ),
    //
    // // Optional Style
    // style: Style(
    //   primaryColor: Colors.blue, // (Optional) Default: Colors.blue
    //   scaffoldColor: Colors.white, // (Optional) Default: Colors.white
    //   appBarBackgroundColor: Colors.blue, // (Optional) Default: Colors.blue
    //   appBarForegroundColor: Colors.white, // (Optional) Default: Colors.white
    //   textStyle: TextStyle(), // (Optional) Default: TextStyle()
    //   buttonStyle: ElevatedButton.styleFrom(), // (Optional) Default: ElevatedButton.styleFrom(...)
    //   circleProgressColor: Colors.blue, // (Optional) Default: Colors.blue
    //   unselectedColor: Colors.grey, // (Optional) Default: Colors.grey
    //   showMobileWalletIcons: true, // (Optional) Default: true
    // ),
  );
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      child:MaterialApp(
        onGenerateRoute: AppRoutes.generateRoute,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
        scaffoldBackgroundColor: ColorStyle.white,
        colorScheme: ColorScheme.fromSeed(seedColor:ColorStyle.primaryblue),
        useMaterial3: true,
      ),
      home: PaymentView(
        onPaymentSuccess: () {
          // Handle payment success
          // context.pushNamed(Routes.login);
          Navigator.of(context).push(MaterialPageRoute(builder: (context) =>LoginPage(),));

        },
        onPaymentError: () {
          // Handle payment error
        },
        price: 100, // (Required) Total Price e.g. 100 => 100 LE
      ),
      // home:Homescreen(),
      // home:Homescreen(),
    ),
    );
 
  }
}

