import 'package:flutter/material.dart';

class PaymentProcedures extends StatefulWidget {
  const PaymentProcedures({super.key});

  @override
  State<PaymentProcedures> createState() => _PaymentProceduresState();
}

class _PaymentProceduresState extends State<PaymentProcedures> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
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
          title: const Text('Payment',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.white
            ),
          )
      ),

      body: SafeArea(
        child: Center(
          child: Text("Payment procedures ..... "),
        ),
      ),
    );
  }
}
