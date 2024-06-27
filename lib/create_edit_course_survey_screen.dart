import 'package:flutter/material.dart';

class CreateEditCourseSurveyScreen extends StatefulWidget {
  final String? courseName;
  final bool isEditing;

  const CreateEditCourseSurveyScreen({Key? key, this.courseName, this.isEditing = false}) : super(key: key);

  @override
  _CreateEditCourseSurveyScreenState createState() => _CreateEditCourseSurveyScreenState();
}

class _CreateEditCourseSurveyScreenState extends State<CreateEditCourseSurveyScreen> {
  final TextEditingController _surveyTitleController = TextEditingController();
  final TextEditingController _questionController = TextEditingController();
  final List<String> _questions = [];

  @override
  void initState() {
    super.initState();
    if (widget.isEditing && widget.courseName != null) {
      // Load existing survey data if editing
      _surveyTitleController.text = "Survey for ${widget.courseName}";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isEditing ? 'Edit Course Survey' : 'Create Course Survey'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _surveyTitleController,
              decoration: InputDecoration(labelText: 'Survey Title'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _questionController,
              decoration: InputDecoration(labelText: 'Add Question'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _questions.add(_questionController.text);
                  _questionController.clear();
                });
              },
              child: Text('Add Question'),
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                itemCount: _questions.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_questions[index]),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        setState(() {
                          _questions.removeAt(index);
                        });
                      },
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Save survey logic
              },
              child: Text('Save Survey'),
            ),
          ],
        ),
      ),
    );
  }
}
