import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:test_cubit/Core.dart';

class PaymobService {
  static const String baseUrl = "https://accept.paymobsolutions.com/api";
  String apiKey = kconst.apiKeys; // Get this from your .env or secure storage

  // Step 1: Authenticate and get token
  Future<String> authenticate() async {
    final url = "$baseUrl/auth/tokens";
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "api_key": apiKey,
      }),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      return jsonResponse['token'];
    } else {
      throw Exception('Failed to authenticate with Paymob');
    }
  }

  // Step 2: Create an order
  Future<int> createOrder(String token, int orderId, int amountCents) async {
    final url = "$baseUrl/ecommerce/orders";
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "auth_token": token,
        "delivery_needed": false,
        "amount_cents": amountCents,
        "merchant_order_id": orderId,
      }),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      return jsonResponse['id']; // The newly created order ID
    } else {
      // Print the status code and response body for debugging
      print('Failed to create order. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      throw Exception('Failed to create order');
    }
  }

  // Step 3: Generate Payment Key
  Future<String> generatePaymentKey({
    required String token,
    required int orderId,
    required int amountCents,
    required Map<String, String> billingData,
    required String integrationId,
  }) async {
    final url = "$baseUrl/acceptance/payment_keys";
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "auth_token": token,
        "expiration": 36000,
        "amount_cents": amountCents,
        "order_id": orderId,
        "billing_data": billingData,
        "currency": "EGP",
        "integration_id": integrationId,
      }),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      return jsonResponse['token']; // Payment Key
    } else {
      throw Exception('Failed to generate payment key');
    }
  }

  // Step 4: Wallet Payment
  Future<String> payWithWallet(String paymentToken, String walletNumber) async {
    final url = "$baseUrl/acceptance/payments/pay";
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "source": {
          "identifier": walletNumber,
          "subtype": "WALLET",
        },
        "payment_token": paymentToken,
      }),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      return jsonResponse['redirect_url']; // Redirect URL for payment
    } else {
      throw Exception('Failed to process wallet payment');
    }
  }
}
