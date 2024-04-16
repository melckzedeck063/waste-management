import 'package:flutter/material.dart';
import 'package:manage_waste/pages/payment_page.dart';

class PricingCard extends StatelessWidget {
  final String package;
  final String weekly;
  final String monthly;
  final String annually;
  final List<String> services; // Changed from Array to List<String>

  const PricingCard({
    Key? key,
    required this.package,
    required this.weekly,
    required this.monthly,
    required this.annually,
    required this.services,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 580,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 25),
                  child: Text(
                    package,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: Colors.grey[800],
                    ),
                  ),
                ),
                const SizedBox(height: 15,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    buildPriceInfo("Tsh", weekly, "Weekly"),
                    buildPriceInfo("Tsh", monthly, "Monthly"),
                    buildPriceInfo("Tsh", annually, "Annually"), // Used the annually value from the plans list
                  ],
                ),
                const SizedBox(height: 10,),
                buildServicesList(services),

                const SizedBox(height: 15),
                Container(
                  width: 300,
                  padding:  const EdgeInsets.symmetric(horizontal: 55.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>  PaymentPage(
                            arguments: PaymentArguments(
                              packageName: package,
                              weeklyCost : weekly,
                              monthlyCost :  monthly,
                              annualCost :  annually,
                              services: services
                            )
                          ))
                      );
                    },

                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.cyan[700],
                        padding: const EdgeInsets.all(8)
                    ),
                    child: const Center(
                        child: Text("Choose Plan",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white
                          ),
                        )),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPriceInfo(String currency, String value, String period) {
    return Container(
      margin: EdgeInsets.only(right: 8),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(right: 1,top: 2),
                child: Text(
                  currency,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ),
              Text(
                value,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[700],
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(left: 4),
            child: Text(
              period,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildServicesList(List<String> services) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: services.map((service) {
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 14),
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 14),
                  child: Icon(Icons.done, size: 24, color: Colors.green[600]),
                ),
                Text(
                  service,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
