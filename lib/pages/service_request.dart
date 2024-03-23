import 'package:flutter/material.dart';

class ServiceRequest extends StatefulWidget {
  const ServiceRequest({super.key});

  @override
  State<ServiceRequest> createState() => _ServiceRequestState();
}

class _ServiceRequestState extends State<ServiceRequest> {
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
        title: const Text("Request Service",
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white
        ),
        ),
      ),

      body: Container(
        child: Column(
          children: [
            Expanded(
              flex: 2,
                child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
            )
            )
          ],
        ),
      ),
      
      bottomNavigationBar: Container(
        height: 350,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))
        ),

        child: Column(
          children: [
            Container(
              width: 180,
              height: 5,
              margin: const EdgeInsets.symmetric(vertical: 6),
              decoration: BoxDecoration(
                color: Colors.cyan[800]
              ),
            ),

            // const SizedBox(height: 8,),
            //
            // Container(
            //   child: Text("Request Details",
            //     style: TextStyle(
            //       fontWeight: FontWeight.bold,
            //       fontSize: 18,
            //       color: Colors.grey[700]
            //     ),
            //   ),
            // ),

            const  SizedBox(height: 15,),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      height: 40,
                      width: 40,
                      margin: const EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(60),
                        color: Colors.cyan[600]
                      ),

                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: const Icon(Icons.location_on, color: Colors.white, size: 32,),
                      ),
                    ),

                        Text("Location",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[700]
                        ),
                    )
                  ],
                ),


                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Chamwino Dodoma",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[700]
                      ),
                    ),
                    Text("6 Road - Chato Street",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[600]
                      ),
                    )
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
