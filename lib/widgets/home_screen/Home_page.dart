import 'package:flutter/material.dart';
import 'package:seba_admin/widgets/Hot_line_Link_add_delete/Hot_line_Link_add_delete.dart';
import 'package:seba_admin/widgets/Notice_Image_add_delete/Notice_image_add_delete.dart';
import 'package:seba_admin/widgets/Thalassemia_list/Thalassemia_list.dart';
import 'package:seba_admin/widgets/ambulance_list/ambulance_list.dart';
import 'package:seba_admin/widgets/chat_list/Chat_list.dart';
import 'package:seba_admin/widgets/donor_Page/Blood_Donor_list.dart';
import 'package:seba_admin/widgets/promotion_image_add_Delete/promotion_image_add_delete.dart';
import 'package:seba_admin/widgets/representative_list/representive_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            height: 70,
            width: double.infinity,
            color: Color(0xff008000),
            child: Center(
              child: ListView(
                children: [
                  Row(
                    children: [
                      SizedBox(width: 15),
                      SizedBox(
                        height: 28,
                        width: 33,
                        child: Image.asset(
                          'assets/right-align_10079895.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: 20),
                      Text(
                        "Home Page",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Spacer(),
                      // ignore: sized_box_for_whitespace
                      Container(
                        height: 28,
                        width: 33,
                        child: Image.asset('assets/menu_10977681.png'),
                      ),
                      SizedBox(width: 15),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      height: 147,
                      width: 140,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BloodDonorList(),
                            ),
                          );
                        },
                        child: Column(
                          children: [
                            Spacer(),
                            SizedBox(
                              height: 75,
                              width: 71,
                              child: Image.asset('assets/donor_2637695.png'),
                            ),
                            SizedBox(height: 10),
                            Text("Blood Donor List"),
                            Spacer(),
                          ],
                        ),
                      ),
                    ),
                    Spacer(),
                    Container(
                      height: 147,
                      width: 140,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ThalassemiaList(),
                            ),
                          );
                        },
                        child: Column(
                          children: [
                            Spacer(),
                            SizedBox(
                              height: 75,
                              width: 71,
                              child: Image.asset(
                                'assets/Thalassemia Patient List.png',
                              ),
                            ),
                            SizedBox(height: 10),
                            Text("Thalassemia"),
                            Text("Patient List"),
                            Spacer(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                Row(
                  children: [
                    Container(
                      height: 147,
                      width: 140,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RepresentiveList(),
                            ),
                          );
                        },
                        child: Column(
                          children: [
                            Spacer(),
                            SizedBox(
                              height: 75,
                              width: 71,
                              child: Image.asset(
                                'assets/representative List & Code Generate.png',
                              ),
                            ),
                            SizedBox(height: 10),
                            Text("Representative List"),
                            Text("& Code Generate"),
                            Spacer(),
                          ],
                        ),
                      ),
                    ),
                    Spacer(),
                    Container(
                      height: 147,
                      width: 140,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HotLineLinkAddDelete(),
                            ),
                          );
                        },
                        child: Column(
                          children: [
                            Spacer(),
                            SizedBox(
                              height: 75,
                              width: 71,
                              child: Image.asset(
                                'assets/add-link_11202916.png',
                              ),
                            ),
                            SizedBox(height: 10),
                            Text("Hot line Link"),
                            Text("Add & Delete"),
                            Spacer(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                Row(
                  children: [
                    Container(
                      height: 147,
                      width: 140,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PromotionImageAddDelete(),
                            ),
                          );
                        },
                        child: Column(
                          children: [
                            Spacer(),
                            SizedBox(
                              height: 75,
                              width: 71,
                              child: Image.asset(
                                'assets/promotion_18721792.png',
                              ),
                            ),
                            SizedBox(height: 10),
                            Text("Promotion image"),
                            Text("Add & Delete"),
                            Spacer(),
                          ],
                        ),
                      ),
                    ),
                    Spacer(),
                    Container(
                      height: 147,
                      width: 140,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NoticeImageAddDelete(),
                            ),
                          );
                        },
                        child: Column(
                          children: [
                            Spacer(),
                            SizedBox(
                              height: 75,
                              width: 71,
                              child: Image.asset('assets/notice_8003305.png'),
                            ),
                            SizedBox(height: 10),
                            Text("Notic Image"),
                            Text("Add & Delete"),
                            Spacer(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                Row(
                  children: [
                    Container(
                      height: 147,
                      width: 140,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ChatList()),
                          );
                        },
                        child: Column(
                          children: [
                            Spacer(),
                            SizedBox(
                              height: 75,
                              width: 71,
                              child: Image.asset(
                                'assets/communication_18721953.png',
                              ),
                            ),
                            SizedBox(height: 10),
                            Text("Chat"),
                            Spacer(),
                          ],
                        ),
                      ),
                    ),
                    Spacer(),
                    Container(
                      height: 147,
                      width: 140,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AmbulanceList(),
                            ),
                          );
                        },
                        child: Column(
                          children: [
                            Spacer(),
                            SizedBox(
                              height: 75,
                              width: 71,
                              child: Image.asset(
                                'assets/ambulance_6758970.png',
                              ),
                            ),
                            SizedBox(height: 10),
                            Text("Ambulance List"),
                            Spacer(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
