import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:manage_waste/provider/booking_provider.dart';
import 'package:provider/provider.dart';
import '../provider/user_details_provider.dart';
import 'package:toastification/toastification.dart';

class ConfirmPayment extends StatefulWidget {

  const ConfirmPayment({
    Key? key,
    // required this.arguments,
  });

  @override
  ConfirmPaymentState createState() => ConfirmPaymentState();
}

class ConfirmPaymentState extends State<ConfirmPayment> {

  DateTime selectedDate = DateTime.now();
  String selectedProvider = 'AzamPesa'; // Default value
  String defaultPrice  = "5000";
  String phoneNumber =  "";
  String externalId = "MW123";
  String  currency  =  "TZS";


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
          title: const Text('Checkout',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.white
            ),
          )
      ),
      body: Consumer<BookingProvider>(
        builder: (context, book, child) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Text(
                    'Monthly Service Payment',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 40),

                Card(
                  elevation: 4.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Payment Details',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        Row(
                          children: [
                            const Text(
                              'Customer Name  : ',
                              style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold
                              ),
                            ),

                            FutureBuilder<String>(
                              future: CurrentUserProvider().getFirstName(),
                              // Future method to get user's first name from shared preferences
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  // Show a loading indicator while waiting for the data
                                  return CircularProgressIndicator();
                                } else if (snapshot.hasError) {
                                  // Show an error message if an error occurs
                                  return Text(
                                    'Error: ${snapshot.error}',
                                    style: TextStyle(color: Colors.red),
                                  );
                                } else {
                                  // Display the user's first name if data is retrieved successfully
                                  return Text(
                                    '${snapshot.data}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.grey[700],
                                    ),
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 10,),
                        Row(
                          children: [
                            const Text(
                              'Account Number  : ',
                              style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold
                              ),
                            ),

                            FutureBuilder<String>(
                              future: CurrentUserProvider().getPhone(),
                              // Future method to get user's first name from shared preferences
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  // Show a loading indicator while waiting for the data
                                  return CircularProgressIndicator();
                                } else if (snapshot.hasError) {
                                  // Show an error message if an error occurs
                                  return Text(
                                    'Error: ${snapshot.error}',
                                    style: TextStyle(color: Colors.red),
                                  );
                                } else {
                                  phoneNumber = snapshot.data!;
                                  // Display the user's first name if data is retrieved successfully
                                  return Text(
                                    '${snapshot.data}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.grey[700],
                                    ),
                                  );
                                }
                              },
                            ),
                          ],
                        ),

                        const SizedBox(height: 10,),
                        Row(
                          children: [
                            const Text(
                              'Amount  : ',
                              style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold
                              ),
                            ),

                            Text(defaultPrice,
                              style: const TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w600
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 10,),
                        const Row(
                          children: [
                            Text(
                              'Currency  : ',
                              style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold
                              ),
                            ),

                            Text(
                              'TZS',
                              style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w600
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 10,),
                        Row(
                          children: [
                            const Text(
                              'Provider  : ',
                              style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold
                              ),
                            ),

                            DropdownButton<String>(
                              value: selectedProvider,
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedProvider = newValue!;
                                });
                              },
                              items: <String>[
                                'Mpesa',
                                'Airtel',
                                'Tigo',
                                'Halopesa',
                                'AzamPesa'
                              ]
                                  .map<DropdownMenuItem<String>>(
                                    (String value) =>
                                    DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey[800],
                                        ),
                                      ),
                                    ),
                              )
                                  .toList(),
                            ),
                          ],
                        ),

                      ],
                    ),
                  ),
                ),

                SizedBox(height: 20),

                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    String provider = selectedProvider.toString(); // Default value
                    String amount  = defaultPrice;
                    String accountNumber =  phoneNumber;
                    String externalId = "1234";
                    String  currency  =  "TZS";

                    book.initiatePaymment(accountNumber: accountNumber, amount: amount, provider: provider, currency: currency, externalId: externalId, context: context);

                    Future.delayed(Duration(seconds: 3), (){
                      if(book.requestSuccessful == true) {
                        toastification.show(
                            context: context,
                            style: ToastificationStyle.fillColored,
                            type: ToastificationType.success,
                            description: RichText(text: TextSpan(text: book.resMessage)),
                            alignment: Alignment.topRight,
                            autoCloseDuration: const Duration(seconds: 4),
                            icon: const Icon(Icons.check_circle),
                            primaryColor: Colors.green[700],
                            backgroundColor: Colors.white
                        );
                      }
                      else {
                        toastification.show(
                            context: context,
                            style: ToastificationStyle.fillColored,
                            type: ToastificationType.error,
                            description: RichText(text: TextSpan(text: book.resMessage)),
                            alignment: Alignment.topRight,
                            autoCloseDuration: const Duration(seconds: 4),
                            icon: const Icon(Icons.cancel, color: Colors.white,),
                            primaryColor: Colors.red[300],
                            backgroundColor: Colors.white
                        );
                      }
                    });

                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    textStyle: TextStyle(fontSize: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Center(
                    child: Text('Pay Now'),
                  ),
                ),
              ],
            ),
          );
        }
      ),
    );
  }
}
