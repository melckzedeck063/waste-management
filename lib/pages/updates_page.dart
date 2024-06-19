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
    {"title": "Proper waste management", "description": "Proper waste management is crucial for environmental sustainability as it reduces pollution, conserves resources, prevents health hazards.","link"  : "https://blog.cleanhub.com/what-is-waste-management#what-is-it"},
    {"title": "Ways To Reduce Waste", "description": "Ways used to reduce waste at home and business areas in order to keep our environment safe and reduce environmental polution","link" : "https://images.app.goo.gl/ZY9FEYVdnPQnSijm9"},
    {"title": "Environmental awareness", "description": "Environmental awareness refers to the understanding and knowledge of the natural environment and the impact of human activities on it","link" : "https://www.earthreminder.com/why-is-environmental-awareness-important/"},
    {"title": "Improper solid waste disposal", "description": "Improper solid waste disposal can have negative consequences on human health. It leads to water, soil, and air contamination, posing risks to nearby communities","link" : "https://organicabiotech.com/negative-effects-of-improper-solid-waste-disposal-on-human-health/"}
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