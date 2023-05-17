import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:peer_to_peer/api_config.dart';
import 'package:peer_to_peer/utils.dart';
import 'package:peer_to_peer/screens/tab_screen.dart';

class SkillSelectionPage extends StatefulWidget {
  const SkillSelectionPage({Key? key}) : super(key: key);

  @override
  _SkillSelectionPageState createState() => _SkillSelectionPageState();
}

class _SkillSelectionPageState extends State<SkillSelectionPage> {
  final TextEditingController _searchController = TextEditingController();
  List<String> _selectedSkills = [];
  List<String> _availableSkills = [];

  Future<List<String>> _fetchSkills(String word) async {
    var url = Uri.parse('${ApiConfig.baseUrl}/getskills?word=$word');
    var headers = {'Content-Type': 'application/json'};

    // Add access token to headers
    String accessToken = await Utils.getAccessToken();
    headers['Authorization'] = 'Bearer $accessToken';

    try {
      var response = await http.get(url, headers: headers);
      print("resposne is");
      print(response.body);
      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        return List<String>.from(responseData['skills']);
      } else {
        throw Exception('Failed to fetch skills');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  void _addSelectedSkill(String skill) {
    setState(() {
      if (_selectedSkills.contains(skill)) {
        _selectedSkills.remove(skill);
      } else {
        _selectedSkills.add(skill);
      }
    });
  }

  void _updateProfile() async {
    var url = Uri.parse('${ApiConfig.baseUrl}/profile');
    var headers = {'Content-Type': 'application/json'};

    // Add access token to headers
    String accessToken = await Utils.getAccessToken();
    headers['Authorization'] = 'Bearer $accessToken';

    var body = jsonEncode({
      'skills': _selectedSkills,
    });

    try {
      var response = await http.put(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        // Profile updated successfully
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => TabScreen()),
        );
        // Handle the response as needed
      } else {
        throw Exception('Failed to update profile');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Skill Selection'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              onChanged: (value) async {
                if (value.isNotEmpty) {
                  List<String> skills = await _fetchSkills(value);
                  setState(() {
                    _availableSkills = skills;
                  });
                } else {
                  setState(() {
                    _availableSkills = [];
                  });
                }
              },
              decoration: const InputDecoration(
                labelText: 'Search Skills',
              ),
            ),
            const SizedBox(height: 16.0),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: _availableSkills.map((skill) {
                bool isSelected = _selectedSkills.contains(skill);
                return GestureDetector(
                  onTap: () => _addSelectedSkill(skill),
                  child: Chip(
                    label: Text(skill),
                    backgroundColor: isSelected ? Colors.blue : Colors.grey,
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 16.0),
            Text(
              'Selected Skills: ${_selectedSkills.join(", ")}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _updateProfile,
              child: const Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}
