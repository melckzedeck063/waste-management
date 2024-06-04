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
    {"title": "Why Waste management is important", "description": "To display the whole description when the card is clicked, you can maintain the card's state to toggle between showing the truncated and full description. Here's the updated","link" : "https://blog.cleanhub.com/what-is-waste-management#what-is-it"},
    {"title": "Importance of environmental awareness", "description": "To display the whole description when the card is clicked, you can maintain the card's state to toggle between showing the truncated and full description. Here's the updated","link"  : "https://education.nationalgeographic.org/resource/conserving-earth/"},
    {"title": "Tools fro waste collection", "description": "To display the whole description when the card is clicked, you can maintain the card's state to toggle between showing the truncated and full description. Here's the updated", "link" : "https://images.app.goo.gl/ZY9FEYVdnPQnSijm9"},
    {"title": "Payment Changes", "description": "To display the whole description when the card is clicked, you can maintain the card's state to toggle between showing the truncated and full description. Here's the updated","link" : "https://images.app.goo.gl/ZY9FEYVdnPQnSijm9"}
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