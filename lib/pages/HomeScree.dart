import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:manage_waste/utils/service_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

  class _HomeScreenState extends State<HomeScreen> {

  final List services =[
    {"name": "Recycling", "image" : "lib/icons/recycle-bin.png"},
    {"name": "Waste Collecting", "image" : "lib/icons/truck.png"},
    {"name": "Incinerating", "image" : "lib/icons/tank.png"},
    {"name": "Recycling", "image" : "lib/icons/recycle-bin.png"},
    {"name": "Recycling", "image" : "lib/icons/truck.png"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.cyan[700],
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              // height: 140,
              padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
              decoration: BoxDecoration(
                  color: Colors.cyan[700],
                borderRadius: const BorderRadius.only(bottomRight: Radius.circular(20), bottomLeft: Radius.circular(20))
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Hi Mary",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                                color: Colors.white
                            ),
                          ),

                          Text("Welcome to our App",
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[300]
                            ),
                          )
                        ],
                      ),

                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            color: Colors.cyan[200],
                            borderRadius: BorderRadius.circular(30)
                        ),

                        child: const Icon(
                          Icons.notifications,
                          size: 30,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),

                  const SizedBox(height: 20,),
                  Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Waste Collectors",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey[800]
                                      ),
                                    ),
                                    const SizedBox(height: 7),
                                    Text("Request for waste collection",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey[700]
                                      ),
                                    )
                                  ],
                                ),
                                
                                Container(
                                  height: 75,
                                  width: 75,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50)
                                  ),
                                  child: Icon(
                                    Icons.recycling,
                                    size: 60,
                                    color: Colors.cyan[700],
                                  ),
                                )
                              ],
                            ),

                          ],
                        ),
                      ),


                    ],
                  )
                ],
              )
            ),

            const  SizedBox(height: 18,),
            Column(
                children:[
                  Container(
                  padding: const EdgeInsets.symmetric(horizontal: 7),
                  decoration: const BoxDecoration(
                    // color: Colors.white,
                    borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20))
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Services",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[700]
                            ),
                          )
                        ],
                      ),

                      const SizedBox(height: 13),


                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 1),
                          height: 375,
                          child: ListView.builder(
                        itemCount: (services.length / 2).ceil(),
                          itemBuilder: (context, index){
                          final int firstColumn= index * 2;
                          final int secondColumn =  firstColumn + 1;

                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,

                            children: [
                              if(firstColumn < services.length)
                                ServiceCard(name: services[firstColumn]["name"], image: services[firstColumn]["image"],),

                              if(secondColumn < services.length)
                                ServiceCard(name: services[secondColumn]["name"], image: services[secondColumn]["image"],),
                            ],
                          );
                          }
                      ),
                        )
                    ],
                  ),
                ),
    ]
            ),

          ],
        ),
      ),
    );
  }
}
