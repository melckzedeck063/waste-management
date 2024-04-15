import 'package:flutter/material.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
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
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Center(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 600,
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 25) ,
                        child: Text("Basic",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                              color: Colors.grey[800]
                          ),
                        ),
                      ),

                      const SizedBox(height: 15,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            child: Column(
                              children: [
                                Row(
                                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(right: 4,top: 2),
                                      child: Text("Tsh",
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey[600]
                                        ),
                                      ),
                                    ),

                                    Text("80000",
                                      style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey[700]
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  margin: const EdgeInsets.only(left: 4),
                                  child: Text("Weekly",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey[600]
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),

                          Column(
                            children: [
                              Row(
                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(right: 4,top: 2),
                                    child: Text("Tsh",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey[600]
                                      ),
                                    ),
                                  ),

                                  Text("17000",
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey[700]
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                margin: const EdgeInsets.only(left: 4),
                                child: Text("Monthly",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[600]
                                  ),
                                ),
                              )
                            ],
                          ),

                          Column(
                            children: [
                              Row(
                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(right: 4,top: 2),
                                    child: Text("Tsh",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey[600]
                                      ),
                                    ),
                                  ),

                                  Text("49000",
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey[700]
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                margin: const EdgeInsets.only(left: 4),
                                child: Text("Annualy",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[600]
                                  ),
                                ),
                              )
                            ],
                          ),

                        ],
                      ),

                      const  SizedBox(height: 20,),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                        child: Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 14),
                              child: Row(
                                children: [
                                  Container(
                                      margin : const EdgeInsets.only(right: 14,),
                                      child: Icon(Icons.done, size: 24, color: Colors.green[600],)
                                  ),

                                  const Text("1 Site visit per week",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500
                                    ),
                                  )
                                ],
                              ),
                            ),

                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 14),
                              child: Row(
                                children: [
                                  Container(
                                      margin : const EdgeInsets.only(right: 14,),
                                      child: Icon(Icons.done, size: 24, color: Colors.green[600],)
                                  ),

                                  const Text("Solid Waste Collection",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500
                                    ),
                                  )
                                ],
                              ),
                            ),

                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 14),
                              child: Row(
                                children: [
                                  Container(
                                      margin : const EdgeInsets.only(right: 14,),
                                      child: Icon(Icons.done, size: 24, color: Colors.green[600],)
                                  ),

                                  const Text("Liquid Waste Collection",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500
                                    ),
                                  )
                                ],
                              ),
                            ),

                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 14),
                              child: Row(
                                children: [
                                  Container(
                                      margin : const EdgeInsets.only(right: 14,),
                                      child: Icon(Icons.done, size: 24, color: Colors.green[600],)
                                  ),

                                  const Text("Incineration Services",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500
                                    ),
                                  )
                                ],
                              ),
                            ),

                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 14),
                              child: Row(
                                children: [
                                  Container(
                                      margin : const EdgeInsets.only(right: 14,),
                                      child: Icon(Icons.done, size: 24, color: Colors.green[600],)
                                  ),

                                  const Text("Membership Card",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500
                                    ),
                                  )
                                ],
                              ),
                            ),

                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 14),
                              child: Row(
                                children: [
                                  Container(
                                      margin : const EdgeInsets.only(right: 14,),
                                      child: Icon(Icons.done, size: 24, color: Colors.green[600],)
                                  ),

                                  const Text("Emergency Visit",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),


                      const SizedBox(height: 15,),
                      Row(
                        children: [
                          Container(
                            width: 105,
                            padding:  const EdgeInsets.symmetric(horizontal: 5.0),
                            child: ElevatedButton(
                              onPressed: () {
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(builder: (context) => const LandingScreen())
                                // );
                              },

                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.cyan[700],
                                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2)
                              ),
                              child: const Center(
                                  child: Text("Weekly",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white
                                    ),
                                  )),
                            ),
                          ),

                          Container(
                            width: 105,
                            padding:  const EdgeInsets.symmetric(horizontal: 5.0),
                            child: ElevatedButton(
                              onPressed: () {
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(builder: (context) => const LandingScreen())
                                // );
                              },

                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.yellow[800],
                                  padding: const EdgeInsets.all(6)
                              ),
                              child: const Center(
                                  child: Text("Montly",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white
                                    ),
                                  )),
                            ),
                          ),

                          Container(
                            width: 105,
                            padding:  const EdgeInsets.symmetric(horizontal: 5.0),
                            child: ElevatedButton(
                              onPressed: () {
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(builder: (context) => const LandingScreen())
                                // );
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.orange[700],
                                  padding: const EdgeInsets.all(6)
                              ),
                              child: const Center(
                                  child: Text("Annually",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white
                                    ),
                                  )),
                            ),
                          ),
                        ],
                      )


                    ],
                  ),
                ),
              ],
            ),
          )
        ),
      ),
    );
  }
}
