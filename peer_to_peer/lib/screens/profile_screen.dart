import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:peer_to_peer/api_config.dart';
import 'dart:convert';

import 'package:peer_to_peer/utils.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String name = 'Gourav';
  String email = 'gourav@gmail.com';
  String bio = 'I am software developer';
  List<String> skills = ["java","python"];
  String profession = 'Software Developer';
  String profileImage = ''; // Store the URL of the profile image
  String defaultImage = 'assets/images/default_profile_image.jpg';

  // Function to fetch profile data from the API
  Future<void> fetchProfileData() async {
    print("calling fetch profile data");
    // Retrieve the access token from SharedPreferences
    // Replace 'accessToken' with the actual key used in SharedPreferences
    String accessToken = await Utils.getAccessToken();
    print("access token is");
    print(accessToken);
    // Make the API call to fetch the profile data
    final response = await http.get(
      Uri.parse('${ApiConfig.baseUrl}/profile'),
      headers: {'Authorization': 'Bearer $accessToken'},
    );
    print(response.body);

    // Check if the API call was successful
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(data);
      setState(() {
        // Update the profile data with the received values, providing default values for null or missing fields
        name = data['name'] ?? '';
        email = data['email'] ?? '';
        bio = data['bio'] ?? '';
        skills = List<String>.from(data['skills'] ?? []);
        profession = data['profession'] ?? '';
        profileImage = data['profileImage'] ?? '';
      });
    }
  }

  @override
  void initState() {
    super.initState();
    // Fetch profile data when the screen is initialized
    fetchProfileData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: profileImage.isNotEmpty
                    ? NetworkImage(profileImage)
                    : AssetImage(defaultImage) as ImageProvider,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Name: $name',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Email: $email',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Bio: $bio',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Skills:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: skills.length,
              itemBuilder: (context, index) {
                return Text(
                  '- ${skills[index]}',
                  style: TextStyle(fontSize: 16),
                );
              },
            ),
            SizedBox(height: 10),
            if (profession.isNotEmpty)
              Text(
                'Profession: $profession',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // TODO: Implement edit profile functionality
              },
              child: Text('Edit Profile'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // TODO: Implement update profile functionality
              },
              child: Text('Update Profile'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // TODO: Implement logout functionality
              },
              child: Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
