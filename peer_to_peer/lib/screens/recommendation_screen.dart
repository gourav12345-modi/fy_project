import 'package:flutter/material.dart';

class Recommendation {
  final String name;
  final String occupation;

  Recommendation(this.name, this.occupation);
}

class RecommendationScreen extends StatelessWidget {
  final List<Recommendation> recommendations = [
    Recommendation('John Doe', 'Software Engineer'),
    Recommendation('Jane Smith', 'Graphic Designer'),
    Recommendation('Mark Johnson', 'Marketing Specialist'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recommendations'),
      ),
      body: ListView.builder(
        itemCount: recommendations.length,
        itemBuilder: (context, index) {
          final recommendation = recommendations[index];
          return ListTile(
            title: Text(recommendation.name),
            subtitle: Text(recommendation.occupation),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Accept button logic
                    print('Accepted ${recommendation.name}');
                  },
                  child: Text('Accept'),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    // Decline button logic
                    print('Declined ${recommendation.name}');
                  },
                  child: Text('Decline'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: RecommendationScreen(),
  ));
}