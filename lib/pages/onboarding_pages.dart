import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:manage_waste/pages/login_screen.dart';
import 'package:manage_waste/utils/promo_content.dart';


class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  int currentPage = 0;
  List<Map<String, String>> splashData = [
    {
      "text": "Welcome Waste Management App",
      "image": "lib/icons/truck.png",
      "desc" : "By following these steps, you should be able to resolve the issue and prevent the RenderFlex children have non-zero flex but incoming heigh"
    },
    {
      "text": "We offer different services like Incineration",
      "image": "lib/icons/tank.png",
      "desc" : "By following these steps, you should be able to resolve the issue and prevent the RenderFlex children have non-zero flex but incoming heigh"
    },
    {
      "text": "We also offer Waste Collection and Recycling",
      "image": "lib/icons/recycle-bin.png",
      "desc" : "By following these steps, you should be able to resolve the issue and prevent the RenderFlex children have non-zero flex but incoming heigh"
    },
  ];

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark
    ));
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 50,),
              Expanded(
                flex: 3,
                child: PageView.builder(
                  onPageChanged: (value) {
                    setState(() {
                      currentPage = value;
                    });
                  },
                  itemCount: splashData.length,
                  itemBuilder: (context, index) => PromoContent(
                    title: splashData[index]["text"] ?? "",
                    desc : splashData[index]["desc"] ?? "",
                    image: splashData[index]["image"] ?? "",
                  ),
                ),
              ),

              Expanded(
                child: Column(
                  children: <Widget>[
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                            splashData.length, (index) => buildDot(index: index))
                    ),

                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context, MaterialPageRoute(builder: (context) => const LoginScreen() ));
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.cyan[700], padding: const EdgeInsets.all(8)),
                        child: const Center(
                            child: Text(
                              "Continue",
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                            )),
                      ),
                    ),

                    Spacer(),
                  ],
                ),
              ),



            ],
          ),
        ),
      ),
    );
  }

  AnimatedContainer buildDot({required int index}) {
    return AnimatedContainer(
      margin: const EdgeInsets.only(right: 6),
      height: 6,
      width: currentPage == index ? 20 : 6,
      decoration: BoxDecoration(
          color: currentPage == index ? Colors.cyan[800] : Colors.cyan[600],
          borderRadius: BorderRadius.circular(3)),
      duration: const Duration(milliseconds: 500), // Corrected to Duration object
    );
  }
}


class DefaultButton extends StatelessWidget {

  final String text;
  final VoidCallback press;
  const DefaultButton(
      {Key? key,
        required this.text,
        required this.press
      });

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: ElevatedButton(
            onPressed: press,
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[700], padding: const EdgeInsets.all(8)),
            child:  Center(
                child: Text(
                  text,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                )),
          ),
        ),
      ),
    );
  }

}
