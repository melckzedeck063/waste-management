import 'package:flutter/material.dart';
import 'package:manage_waste/utils/service_card.dart';
import 'package:manage_waste/utils/update_component.dart';

class UpdatesScreen extends StatefulWidget {
  const UpdatesScreen({super.key});

  @override
  State<UpdatesScreen> createState() => _UpdatesScreenState();

}

class _UpdatesScreenState extends State<UpdatesScreen> {

  final List<Map<String,String>> news = [
    {"title": "Importance of environmental awareness", "description": "Environmental awareness refers to the understanding and knowledge of the nature environment and impact of human activities on it","link"  : "https://education.nationalgeographic.org/resource/conserving-earth/"},
    {"title": "Tools fro waste collection", "description": "Several ways and tools used for waste collection  ensure environment is kept safe in markets and different places", "link" : "https://images.app.goo.gl/ZY9FEYVdnPQnSijm9"},
    {"title": "Ways To Reduce Waste", "description": "Ways used to reduce waste at home and business areas in order to keep our environment safe and reduce environmental polution","link" : "https://images.app.goo.gl/ZY9FEYVdnPQnSijm9"}
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.cyan[700],
        title: const Text(
          "News & Updates",
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child:  Column(
              children: [

                const SizedBox(height: 10,),
                Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 1),
                      child: ListView.builder(
                        itemCount: news.length,
                          itemBuilder: (context, index) =>
                              UpdateCard(
                                  title: news[index]["title"] ?? "",
                                  description: news[index]["description"] ?? "",
                                pageUrl: news[index]["link"] ?? "",
                              )
                      ),
                    )
                ),

                const SizedBox(height: 10,),

                   ],
            ),
          ),
        ),
      ),
    );
  }

}