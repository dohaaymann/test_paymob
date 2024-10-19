import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http; // Import http package

import 'Core.dart';

class PaymobManager{

  Future<String> getPaymentKey(int amount,String currency)async{
    try {
      String authanticationToken=await getAuthanticationToken();
      //

      int orderId= await _getOrderId(
        authanticationToken: authanticationToken,
        amount: (100*amount).toString(),
        currency: currency,
      );

      String paymentKey= await _getPaymentKey(
        authanticationToken: authanticationToken,
        amount: (100*amount).toString(),
        currency: currency,
        orderId: orderId.toString(),
      );
      return paymentKey;
    } catch (e) {
      print("Exc==========================================");
      print(e.toString());
      throw Exception();
    }
  }

  Future<String> getAuthanticationToken() async {
    try {
      final Response response = await Dio().post(
        "https://accept.paymob.com/api/auth/tokens",
        data: {
          "api_key": kconst.apiKeys,
        },
      );
      print("Token: ${response.data["token"]}");
      return response.data["token"];
    } on DioException catch (e) {
      if (e.response?.statusCode == 429) {
        print('Too many requests, retrying after a delay...');
        await Future.delayed(Duration(seconds: 5)); // Delay for 5 seconds
        return getAuthanticationToken(); // Retry the request
      } else {
        print('Error: ${e.message}');
        throw e;
      }
    }
  }

  Future<int>_getOrderId({
    required String authanticationToken,
    required String amount,
    required String currency,
  })async{
    final Response response=await Dio().post(
        "https://accept.paymob.com/api/ecommerce/orders",
        data: {
          "auth_token":  authanticationToken,
          "amount_cents":amount, //  >>(STRING)<<
          "currency": currency,//Not Req
          "delivery_needed": "false",
          "items": [],
        }
    );
    return response.data["id"];  //INTGER
  }

  Future<String> _getPaymentKey({
    required String authanticationToken,
    required String orderId,
    required String amount,
    required String currency,
  }) async{
    final Response response=await Dio().post(
        "https://accept.paymob.com/api/acceptance/payment_keys",
        data: {
          //ALL OF THEM ARE REQIERD
          "expiration": 3600,

          "auth_token": authanticationToken,//From First Api
          "order_id":orderId,//From Second Api  >>(STRING)<<
          "integration_id": kconst.cardPaymentMethodIntegrationId,//Integration Id Of The Payment Method

          "amount_cents": amount,
          "currency": currency,

          "billing_data": {
            //Have To Be Values
            "first_name": "Clifford",
            "last_name": "Nicolas",
            "email": "claudette09@exa.com",
            "phone_number": "+86(8)9135210487",

            //Can Set "NA"
            "apartment": "NA",
            "floor": "NA",
            "street": "NA",
            "building": "NA",
            "shipping_method": "NA",
            "postal_code": "NA",
            "city": "NA",
            "country": "NA",
            "state": "NA"
          },
        }
    );
    return response.data["token"];
  }
  Future<String> getWalletPaymentKey(int amount, String currency, String walletPhoneNumber) async {
    try {
      String authanticationToken = await getAuthanticationToken();

      int orderId = await _getOrderId(
        authanticationToken: authanticationToken,
        amount: (100 * amount).toString(),
        currency: currency,
      );
      print("orderId: $orderId");

      String paymentKey = await _getWalletPaymentKey(
        authanticationToken: authanticationToken,
        amount: (100 * amount).toString(),
        currency: currency,
        orderId: orderId.toString(),
        walletPhoneNumber: walletPhoneNumber,
      );
      print("paymentKey in manager: $paymentKey");
      return paymentKey;
    } catch (e) {
      print("Exc==========================================");
      print(e.toString());
      throw Exception();
    }
  }

  Future<String> _getWalletPaymentKey({
    required String authanticationToken,
    required String orderId,
    required String amount,
    required String currency,
    required String walletPhoneNumber,
  }) async {
    final Response response = await Dio().post(
      "https://accept.paymob.com/api/acceptance/payment_keys",
      options: Options(
        validateStatus: (_) => true,
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
      ),
      data: {
        //ALL OF THEM ARE REQIERD
        "expiration": 3600,

        "auth_token": authanticationToken,//From First Api
        "order_id":orderId,//From Second Api  >>(STRING)<<
        "integration_id": kconst.walletIntegrationId,//Integration Id Of The Payment Method

        "amount_cents": amount,
        "currency": currency,

        "billing_data": {
          //Have To Be Values
          "first_name": "Clifford",
          "last_name": "Nicolas",
          "email": "claudette09@exa.com",
          "phone_number": "${walletPhoneNumber}",
          //Can Set "NA"
          "apartment": "NA",
          "floor": "NA",
          "street": "NA",
          "building": "NA",
          "shipping_method": "NA",
          "postal_code": "NA",
          "city": "NA",
          "country": "NA",
          "state": "NA"
        },
      },
    );

    // Log the full response
    print("Response data: ${response.data}");

    // Check for a successful response and extract the paymentKey
    if (response.statusCode == 200 || response.statusCode == 201) {
      String paymentKey = response.data['payment_key']; // Adjust this to match the actual structure of the response
      return paymentKey;
    } else {
      throw Exception("Failed to retrieve wallet payment key: ${response.data}");
    }
  }


  Future createPaymentIntention() async {
    const String url = 'https://accept.paymob.com/api/acceptance/payments/pay';
    String apiKey = kconst.apiKeys; // Ensure this is a valid API key
    String walletIntegrationId = kconst.walletIntegrationId;

    final Map<String, dynamic> body = {
      'amount': 200000,
      'currency': 'EGP',
      'payment_methods': {
        'integration_id': walletIntegrationId,
      },
      'items': [
        {
          'name': 'Item Name',
          'amount': 200000,
          'description': 'Item Description',
          'quantity': 1,
        }
      ],
    };

    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey', // Uncomment this line
      },
      body: jsonEncode(body),
    );

    print("//\n ${response.body}");

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      print('Payment intention created: $responseData');
    } else {
      print('Failed to create payment intention: ${response.statusCode}');
    }
  }


}
