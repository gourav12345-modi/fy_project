import 'package:flutter/material.dart';

class Skill {
  String name;


  Skill({required this.name});
}

class SkillUIPage extends StatefulWidget {
  @override
  _SkillUIPageState createState() => _SkillUIPageState();
}

class _SkillUIPageState extends State<SkillUIPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  List<Skill> _skills = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Skills'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Skill Name',
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a skill name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      _skills.add(Skill(
                        name: _nameController.text,
                      ));
                      _nameController.clear();
                    });
                  }
                },
                child: Text('Add Skill'),
              ),
              const SizedBox(height: 16.0),
              Text(
                'Skills:',
                style: Theme.of(context).textTheme.headline6,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: _skills.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text(_skills[index].name),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
