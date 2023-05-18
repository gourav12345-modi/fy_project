import 'package:flutter/material.dart';
import 'package:peer_to_peer/screens/temp.dart';
import 'chat_home_screen.dart';
import 'components/appbar.dart';
import 'components/category.dart';
import 'components/sorting.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:peer_to_peer/model/product_model.dart';
import 'package:flutter/material.dart';
import '../constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

// create a home screen
class _HomeScreenState extends State<HomeScreen> {
  List<String> recentChat = ["Vikash","Gourav"]; // List to hold recent chat data
  List<Product> recentRecommendation = []; // List to hold recent recommendation data

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        children: [
          CustomeAppBar(),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Hi Julia",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          "Today is a good day\nto learn something new!",
                          style: TextStyle(
                            color: Colors.black54,
                            wordSpacing: 2.5,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Column(
                      children: [
                        Container(
                          height: 70,
                          width: 70,
                          decoration: BoxDecoration(
                              color: kpurple,
                              borderRadius: BorderRadius.circular(15.0)),
                          child: Image.asset(
                            "assets/images/profile.png",
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                //sorting
                const SizedBox(
                  height: 20,
                ),
                //category list

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Recent Chat",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: const Text(
                        "See All",
                        style: TextStyle(fontSize: 16, color: kblue),
                      ),
                    ),
                  ],

                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: recentChat.length,
                  itemBuilder: (context, index) {
                    final chatItem = recentChat[index];
                    return ListTile(
                      title: Text(chatItem),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChatHomeScreen(),
                        ),
                      )
                    );
                  },
                ),

                //now we create model of our images and colors which we will use in our app
              ],
            ),
          )
        ],
      ),
    );
  }
}
