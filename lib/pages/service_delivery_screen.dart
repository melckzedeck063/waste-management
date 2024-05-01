import 'package:flutter/material.dart';
import 'package:manage_waste/pages/delivery_screen.dart';
import 'package:manage_waste/provider/user_details_provider.dart';
import 'package:toastification/toastification.dart';

class ServiceDelivery extends StatefulWidget {
  final BookingArguments  arguments;

  const ServiceDelivery({
    Key? key,
    required  this.arguments
});

  @override
  State<ServiceDelivery> createState() => _ServiceRequestState();
}

class _ServiceRequestState extends State<ServiceDelivery> {

  bool showVisitButton = false;

  @override
  void initState() {
    checkUserRole();
    super.initState();
  }

  void  checkUserRole() async {
    String role =  await CurrentUserProvider().getUserRole();

    // print("ROLE : $role");
    setState(() {
      showVisitButton = (role == "ADMIN" || role == "SUPER_ADMIN");
    });
  }

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
        title: const Text("Request Details",
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white
          ),
        ),
      ),

      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10,  vertical: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(top: 1,left: 1),
                        decoration: BoxDecoration(
                            color: Colors.cyan[600]
                        ),
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(topLeft: Radius.circular(20)),
                          child: Image.asset(
                            widget.arguments.servicePhoto,
                            height: 150,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 1,right: 10, bottom: 2),
                        child: Text("Service Details",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 19,
                              color: Colors.cyan[800]
                          ),
                        ),
                      ),

                      Container(
                        margin: const EdgeInsets.only(top: 3,right: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Name: ",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[700]
                              ),
                            ),

                            Text(widget.arguments.title,
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[700],
                                  fontWeight: FontWeight.bold
                              ),
                            )
                          ],
                        ),
                      ),

                      Container(
                        margin: const EdgeInsets.only(top: 10,right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("From: ",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[700]
                              ),
                            ),

                            Text("09:00 AM",
                              maxLines: 2,
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[700],
                                  fontWeight: FontWeight.bold
                              ),
                            )
                          ],
                        ),
                      ),

                      Container(
                        margin: const EdgeInsets.only(top: 10,right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("T0: ",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[700]
                              ),
                            ),

                            Text("05:00 AM",
                              maxLines: 2,
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[700],
                                  fontWeight: FontWeight.bold
                              ),
                            )
                          ],
                        ),
                      ),

                      Container(
                        margin: const EdgeInsets.only(top: 10,right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Cost: ",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[700]
                              ),
                            ),

                            Text("@ 5000",
                              maxLines: 2,
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[700],
                                  fontWeight: FontWeight.bold
                              ),
                            )
                          ],
                        ),
                      )

                    ],
                  ),

                ],
              ),

              const  SizedBox(height: 20,),


            ],
          ),

        ),
      ),

      bottomNavigationBar: Container(
        height: 485,
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

            const SizedBox(height: 8,),

            Text("Request Details",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.grey[700]
              ),
            ),

            const  SizedBox(height: 15,),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 5),
                    padding: const EdgeInsets.symmetric(horizontal: 3,vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Container(
                              height: 28,
                              width: 28,
                              decoration: BoxDecoration(
                                  color: Colors.cyan[700],
                                  borderRadius: BorderRadius.circular(50)
                              ),
                              child: const Icon(Icons.location_on, color: Colors.white, size: 24,),
                            ),
                            Container(
                              height: 40,
                              width: 5,
                              decoration: BoxDecoration(
                                color: Colors.cyan[800],
                              ),
                            )
                          ],
                        ),

                        Container(
                          margin: const EdgeInsets.only(right: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Makulu Dodoma",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.grey[700]
                                ),
                              ),
                              const SizedBox(height: 7,),
                              Text("6th Road Chato Street",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[800]
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),

                  Container(
                    margin: const EdgeInsets.only(bottom: 5),
                    padding: const EdgeInsets.symmetric(horizontal: 3,vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Container(
                              height: 28,
                              width: 28,
                              decoration: BoxDecoration(
                                  color: Colors.cyan[700],
                                  borderRadius: BorderRadius.circular(50)
                              ),
                              child: const Icon(Icons.person_2_rounded, color: Colors.white, size: 24,),
                            ),
                            Container(
                              height: 40,
                              width: 5,
                              decoration: BoxDecoration(
                                color: Colors.cyan[800],
                              ),
                            )
                          ],
                        ),

                        Container(
                          margin: const EdgeInsets.only(right: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Text("Pickup Location",
                              //  textAlign: TextAlign.center,
                              //  style: TextStyle(
                              //    fontWeight: FontWeight.bold,
                              //    fontSize: 16,
                              //    color: Colors.grey[800]
                              //  ),
                              // ),
                              Text("Neema Hammedan",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.grey[700]
                                ),
                              ),
                              const SizedBox(height: 7,),
                              Text("+255743767676",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[800]
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),

                  Container(
                    margin: const EdgeInsets.only(bottom: 5),
                    padding: const EdgeInsets.symmetric(horizontal: 3,vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Container(
                              height: 28,
                              width: 28,
                              decoration: BoxDecoration(
                                  color: Colors.cyan[700],
                                  borderRadius: BorderRadius.circular(50)
                              ),
                              child: const Icon(Icons.date_range, color: Colors.white, size: 24,),
                            ),
                            Container(
                              height: 40,
                              width: 5,
                              decoration: BoxDecoration(
                                color: Colors.cyan[800],
                              ),
                            )
                          ],
                        ),

                        Container(
                          margin: EdgeInsets.only(right: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Scheduled Date",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.grey[700]
                                ),
                              ),
                              const SizedBox(height: 7,),
                              Text(widget.arguments.pickupdate.substring(0,10),
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[800]
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 3,vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Container(
                              height: 28,
                              width: 28,
                              decoration: BoxDecoration(
                                  color: Colors.cyan[700],
                                  borderRadius: BorderRadius.circular(50)
                              ),
                              child: const Icon(Icons.recycling, color: Colors.white, size: 24,),
                            ),
                            Container(
                              height: 40,
                              width: 5,
                              decoration: BoxDecoration(
                                color: Colors.cyan[800],
                              ),
                            )
                          ],
                        ),

                        Container(
                          margin: EdgeInsets.only(right: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Waste Category",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.grey[700]
                                ),
                              ),
                              const SizedBox(height: 7,),
                              Text(widget.arguments.wasteType,
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[800]
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                ],
              ),
            ),


            const SizedBox(height: 10),

            if(showVisitButton)
            Padding(
              padding:  const EdgeInsets.symmetric(horizontal: 25.0),
              child: ElevatedButton(
                onPressed: () {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(builder: (context) => const DeliveryScreen())
                  // );

                  toastification.show(
                      context: context,
                      style: ToastificationStyle.fillColored,
                      type: ToastificationType.info,
                      description: RichText(text:  const TextSpan(text: "Please verify payment first", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16))),
                      alignment: Alignment.bottomLeft,
                      autoCloseDuration: const Duration(seconds: 4),
                      icon: const Icon(Icons.info),
                      primaryColor: Colors.orange[500],
                      backgroundColor: Colors.white
                  );
                },

                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.cyan[700],
                    padding: const EdgeInsets.all(8)
                ),
                child: const Center(
                    child: Text("Visit Now",
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
    );
  }
}


class BookingArguments {

   String title;
   String orderNo;
   String status;
   String date;
   String pickupdate;
   String wasteType;
   String servicePhoto;
  // final LatLng latitude;
  // final LatLng longtude;

  BookingArguments({
    required this.title,
    required this.orderNo,
    required this.status,
    required this.date,
    required this.pickupdate,
    required this.wasteType,
    required this.servicePhoto,
    // required this.latitude,
    // required this.longtude
  });

}