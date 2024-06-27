import 'package:flutter/material.dart';

class CreateEditDosenSurveyScreen extends StatefulWidget {
  final String? dosenName;
  final bool isEditing;

  const CreateEditDosenSurveyScreen({Key? key, this.dosenName, this.isEditing = false}) : super(key: key);

  @override
  _CreateEditDosenSurveyScreenState createState() => _CreateEditDosenSurveyScreenState();
}

class _CreateEditDosenSurveyScreenState extends State<CreateEditDosenSurveyScreen> {
  final TextEditingController _surveyTitleController = TextEditingController();
  final List<Question> _questions = [];

  @override
  void initState() {
    super.initState();
    if (widget.isEditing && widget.dosenName != null) {
      // Load existing survey data if editing
      _surveyTitleController.text = "Survey for ${widget.dosenName}";
    }
  }

  void _addQuestion() {
    showDialog(
      context: context,
      builder: (context) {
        return AddQuestionDialog(
          onAdd: (question) {
            setState(() {
              _questions.add(question);
            });
          },
        );
      },
    );
  }

  void _editQuestion(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AddQuestionDialog(
          question: _questions[index],
          onAdd: (question) {
            setState(() {
              _questions[index] = question);
            });
          },
        );
      },
    );
  }

  void _deleteQuestion(int index) {
    setState(() {
      _questions.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isEditing ? 'Edit Dosen Survey' : 'Create Dosen Survey'),
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
            ElevatedButton(
              onPressed: _addQuestion,
              child: Text('Add Question'),
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                itemCount: _questions.length,
                itemBuilder: (context, index) {
                  final question = _questions[index];
                  return ListTile(
                    title: Text(question.title),
                    subtitle: Text(question.type.toString().split('.').last),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () => _editQuestion(index),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () => _deleteQuestion(index),
                        ),
                      ],
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

class AddQuestionDialog extends StatefulWidget {
  final Question? question;
  final ValueChanged<Question> onAdd;

  const AddQuestionDialog({Key? key, this.question, required this.onAdd}) : super(key: key);

  @override
  _AddQuestionDialogState createState() => _AddQuestionDialogState();
}

class _AddQuestionDialogState extends State<AddQuestionDialog> {
  final TextEditingController _titleController = TextEditingController();
  QuestionType _selectedType = QuestionType.text;

  @override
  void initState() {
    super.initState();
    if (widget.question != null) {
      _titleController.text = widget.question!.title;
      _selectedType = widget.question!.type;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.question == null ? 'Add Question' : 'Edit Question'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _titleController,
            decoration: InputDecoration(labelText: 'Question Title'),
          ),
          SizedBox(height: 16.0),
          DropdownButton<QuestionType>(
            value: _selectedType,
            items: QuestionType.values.map((QuestionType type) {
              return DropdownMenuItem<QuestionType>(
                value: type,
                child: Text(type.toString().split('.').last),
              );
            }).toList(),
            onChanged: (QuestionType? newType) {
              setState(() {
                _selectedType = newType!;
              });
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            final question = Question(
              title: _titleController.text,
              type: _selectedType,
            );
            widget.onAdd(question);
            Navigator.of(context).pop();
          },
          child: Text(widget.question == null ? 'Add' : 'Save'),
        ),
      ],
    );
  }
}

class Question {
  final String title;
  final QuestionType type;

  Question({required this.title, required this.type});
}

enum QuestionType { text, multipleChoice, checkbox }
