import 'package:flutter/material.dart';
import 'package:manage_waste/utils/pricing_card.dart';

class PricingPages extends StatefulWidget {
  const PricingPages({super.key});

  @override
  State<PricingPages> createState() => _PricingPagesState();
}

class _PricingPagesState extends State<PricingPages> {

  final List<Map<String,dynamic>> plans = [
    {"package": "Basic", "weekly": "8000", "monthly"  : "14000", "annually" : "39000", "services" : ["1 Site Visit per Week",  "Solid Waste Collection", "Liquid Waste Collection", "Incineration Services" ] },
    {"package": "Standard", "weekly": "10000", "monthly"  : "17000", "annually" : "49000", "services" : ["1 Site Visit per Week",  "Solid Waste Collection", "Liquid Waste Collection", "Incineration Services", "Membership Card" ] },
    {"package": "Premium", "weekly": "12000", "monthly"  : "19000", "annually" : "65000", "services" : ["1 Site Visit per Week",  "Solid Waste Collection", "Liquid Waste Collection", "Incineration Services","Emergency Visit", "Membership Card" ] },
    // {"package": "Basic", "weekly": "8000", "monthly"  : "14000", "anually" : "39000", "services" : ["1 Site Visit per Week",  "Solid Waste Collection", "Liquid Waste Collection", "Incineration Services" ] },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.cyan[700],
        title: const Text(
          "Pricing",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Colors.white,
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body:  SafeArea(
        child: Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  child: Text("Choose your favourite plan here",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: Colors.grey[700]
                  ),
                  ),
                ),

                Expanded(
                  flex: 1,
                  child: ListView.builder(
                    itemCount: plans.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) =>
                           PricingCard(
                            package: plans[index]["package"],
                            weekly: plans[index]["weekly"],
                             monthly: plans[index]["monthly"],
                             annually: plans[index]['annually'],
                             services: plans[index]['services'],
                          ),
                  ),
                )
              ],
            ),
          ),
        ),
      )

    );
  }
}
