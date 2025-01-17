import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_paymob/flutter_paymob.dart';
import 'package:pay_with_paymob/paymob_payment.dart';
import 'package:test_cubit/Core.dart';
import 'package:url_launcher/url_launcher.dart';
import 'Core/Widgets/Custom_Textfromfield.dart';
import 'Paymob/paymob_service.dart';
import 'Paymob_manager.dart';

class PaymobView extends StatefulWidget {
  const PaymobView({super.key});

  @override
  State<PaymobView> createState() => _PaymobViewState();
}

class _PaymobViewState extends State<PaymobView> {
  InAppWebViewController? webViewController;
  String paymentUrl = '';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
  }
  void initiatePayment(var phone) async {
    try {
      final paymobService = PaymobService();

      // Step 1: Authenticate
      final token = await paymobService.authenticate();

      // Step 2: Create Order (You would pass the order details, like amount)
// Step 2: Create Order (You would pass the order details, like amount)
      final orderId = await paymobService.createOrder(token, 1284, 10000);
      // Step 3: Generate Payment Key (with user billing data)
      final paymentKey = await paymobService.generatePaymentKey(
        token: token,
        orderId: orderId,
        amountCents: 10000,
        billingData: {
          "first_name": "John",
          "last_name": "Doe",
          "phone_number": phone,
          "email": "john@example.com",
          "apartment": "NA",
          "floor": "NA",
          "street": "123 Street",
          "building": "NA",
          "shipping_method": "NA",
          "postal_code": "12345",
          "city": "Cairo",
          "state": "Cairo",
          "country": "EGY",
        },
        integrationId: kconst.walletIntegrationId,
      );

      // Step 4: Pay using wallet
      final redirectUrl = await paymobService.payWithWallet(paymentKey, phone);
      // Now open the URL in the browser
      if(await canLaunch(redirectUrl)) {
        await launch(redirectUrl);
      } else {
        throw 'Could not launch $redirectUrl';
      }
      // Now redirect to this URL in a WebView or open in browser
      print("Redirect to: $redirectUrl");
    } catch (e) {
      print("Payment initiation failed: $e");
    }
  }

  Future<void> _pay() async {
    try {
      // Get the payment key using PaymobManager
      String paymentKey = await PaymobManager()
          // .getPaymentKey(1000, "EGP");
          .getWalletPaymentKey(10, "EGP", "+201028789903");

      print(paymentKey);

      // Launch the URL with the payment token 872934
      final url = "https://accept.paymob.com/api/acceptance/iframes/+201028789903?payment_token=$paymentKey";
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      print('Error during payment: $e');
      // Handle any errors (e.g., show a message to the user)
    }
  }
  Future<void> _payWithWallet() async {
    try {
      // Get the wallet payment key using PaymobManager
      String paymentKey = await PaymobManager().getWalletPaymentKey(1000, "EGP", "+201028789903");

      print('Payment key for wallet: $paymentKey');

      // The payment process is now handled within the PaymobManager
      // You can show success/failure based on the response from PaymobManager
    } catch (e) {
      print('Error during wallet payment: $e');
      // Handle any errors (e.g., show a message to the user)
    }
  }
// Initiates a payment with a card using the FlutterPaymob instance
   wallet(){
     FlutterPaymob.instance.payWithWallet(
       context: context,
       currency: "EGP",
       amount: 100,
       number: "01028789903",
       onPayment: (response) {
         response.success == true
             ? ScaffoldMessenger.of(context).showSnackBar(SnackBar(
             content: Text(response.message ?? "Successes")))
             : null;
       },
     );
   }
  card() {
    FlutterPaymob.instance.payWithCard(
      context: context,
      // Passes the BuildContext required for UI interactions
      currency: "EGP",
      // Specifies the currency for the transaction (Egyptian Pound)
      amount: 100,
      // Sets the amount of money to be paid (100 EGP)
      // Optional callback function invoked when the payment process is completed
      onPayment: (response) {
        // Checks if the payment was successful
        if (response.success == true) {
          // If successful, displays a snackbar with the success message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(response.message ??
                  "Success"), // Shows "Success" message or response message
            ),
          );
        }
      },
    );
  }
  var isvisiable=false;
  var Controller=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Paymob Payment'),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: ()async{
                initiatePayment(Controller.text);
                 // isvisiable=true;
                 // isvisiable?i:null;
              }, // Call _pay when the button is pressed
              child: const Text('Pay with wallet'),
            ),
            CustomTextfromfield(
              Controller:Controller ,hintText: "phone number",
            ),
            ElevatedButton(
              onPressed: ()async{
                 // card();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PaymentView(
                    onPaymentSuccess: () {
                      // Handle payment success
                      print(("object"));
                    },
                    onPaymentError: () {
                      // Handle payment error
                    },
                    price: 100, // (Required) Total Price e.g. 100 => 100 LE
                  )),
                );
              }, // Call _pay when the button is pressed
              child: const Text('Pay with card'),
            ),
          ],
        ),
      ),
    );
  }
}
