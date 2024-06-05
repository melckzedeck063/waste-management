import 'package:flutter/material.dart';
import 'package:manage_waste/pages/confirm_payment.dart';
import 'package:manage_waste/pages/payment_page2.dart';

class PaymentIntroductionScreen extends StatelessWidget {
  const PaymentIntroductionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.cyan[700],
          leading: GestureDetector(
            onTap: (){
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
          ),
          title: const Text('Payment Required',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.white
            ),
          )
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Welcome to Our Services!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'To continue using our services and a identified as a valuable customer, you need to pay your bill through AzamPay.',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 40),

            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Navigate to the payment page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ConfirmPayment()),
                  );
                },
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    textStyle: const TextStyle(fontSize: 18, color: Colors.white),
                    backgroundColor: Colors.cyan[700]
                ),
                child: const Text('Monthly Payment', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),),
              ),
            ),

            const SizedBox(height: 15,),

            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Navigate to the payment page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ConfirmServicePayment()),
                  );
                },
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    textStyle: const TextStyle(fontSize: 18, color: Colors.white),
                    backgroundColor: Colors.cyan[900]
                ),
                child: const Text('Emergency Service Payment', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
