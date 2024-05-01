import 'package:flutter/material.dart';
import 'package:manage_waste/pages/service_request.dart';

class ServiceCard2 extends StatelessWidget {

  final String name;
  final String image;

  const ServiceCard2({
    Key? key,
    required this.name,
    required this.image
  }) : super(key: key) ;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>  ServiceRequest(
              arguments: ServiceArguments(
                  serviceName: name,
                servicePhoto: image
              ),

            ))
        );
      },
      child: Container(
        width: 380,
        padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 5),
        margin: const EdgeInsets.only(right: 5, left: 5, top: 5, bottom: 5 ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                  offset: Offset(0,0),
                  blurRadius: 0.2
              )
            ]
        ),
        child: Column(
          children: [
            Container(
              height: 120,
              width: 210,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(image,
                      fit: BoxFit.cover
                  )
              ),
            ),
            const SizedBox(height: 6,),
            Text(name,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.grey[700]
              ),
            )
          ],
        ),
      ),
    );
  }
}
