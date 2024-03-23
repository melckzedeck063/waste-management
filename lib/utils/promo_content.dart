import 'package:flutter/material.dart';

class PromoContent extends StatelessWidget {

  final String desc;
  final String title;
  final String image;

  const PromoContent({
    Key? key,
    required this.desc,
    required this.title,
    required this.image
});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [

          Container(
            // height: 150,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                image,
                fit: BoxFit.cover,
              ),
            ),
          ),

          SizedBox(height: 5),

          Container(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.cyan[700]
              ),
            ),

          ),

          const SizedBox(height: 10),

          Container(
            child: Text(
              desc,

              style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700]
              ),
            ),

          )
        ],
      ),
    );
  }
}
