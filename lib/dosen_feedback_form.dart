import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DosenFeedbackForm extends StatefulWidget {
  final String dosenName;

  const DosenFeedbackForm({Key? key, required this.dosenName}) : super(key: key);

  @override
  _DosenFeedbackFormState createState() => _DosenFeedbackFormState();
}

class _DosenFeedbackFormState extends State<DosenFeedbackForm> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> _questions = [];
  final Map<String, dynamic> _answers = {};

  @override
  void initState() {
    super.initState();
    _loadQuestions();
  }

  void _loadQuestions() async {
    final survey = await _firestore
        .collection('surveys')
        .where('dosenName', isEqualTo: widget.dosenName)
        .get();
    
    if (survey.docs.isNotEmpty) {
      setState(() {
        _questions = List<Map<String, dynamic>>.from(survey.docs.first['questions']);
      });
    }
  }

  Future<void> _submitFeedback() async {
    await _firestore.collection('feedback').add({
      'dosenName': widget.dosenName,
      'answers': _answers,
    });
    Navigator.pop(context);
  }

  Widget _buildQuestion(Map<String, dynamic> question) {
    switch (question['type']) {
      case 'FormFieldType.radio':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(question['label'], style: TextStyle(fontWeight: FontWeight.bold)),
            ...List<Widget>.from(question['options'].map((option) => RadioListTile(
                  title: Text(option),
                  value: option,
                  groupValue: _answers[question['label']],
                  onChanged: (value) {
                    setState(() {
                      _answers[question['label']] = value;
                    });
                  },
                ))),
          ],
        );
      case 'FormFieldType.checkbox':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(question['label'], style: TextStyle(fontWeight: FontWeight.bold)),
            ...List<Widget>.from(question['options'].map((option) => CheckboxListTile(
                  title: Text(option),
                  value: _answers[question['label']]?.contains(option) ?? false,
                  onChanged: (value) {
                    setState(() {
                      if (value == true) {
                        _answers[question['label']] = [...?_answers[question['label']], option];
                      } else {
                        _answers[question['label']] = List<String>.from(_answers[question['label']] ?? [])
                          ..remove(option);
                      }
                    });
                  },
                ))),
          ],
        );
      case 'FormFieldType.dropdown':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(question['label'], style: TextStyle(fontWeight: FontWeight.bold)),
            DropdownButton<String>(
              value: _answers[question['label']],
              items: question['options'].map<DropdownMenuItem<String>>((option) {
                return DropdownMenuItem<String>(
                  value: option,
                  child: Text(option),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _answers[question['label']] = value;
                });
              },
            ),
          ],
        );
      case 'FormFieldType.date':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(question['label'], style: TextStyle(fontWeight: FontWeight.bold)),
            TextField(
              controller: TextEditingController(text: _answers[question['label']]),
              decoration: InputDecoration(
                hintText: 'Select Date',
              ),
              readOnly: true,
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2101),
                );
                if (pickedDate != null) {
                  setState(() {
                    _answers[question['label']] = "${pickedDate.toLocal()}".split(' ')[0];
                  });
                }
              },
            ),
          ],
        );
      case 'FormFieldType.time':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(question['label'], style: TextStyle(fontWeight: FontWeight.bold)),
            TextField(
              controller: TextEditingController(text: _answers[question['label']]),
              decoration: InputDecoration(
                hintText: 'Select Time',
              ),
              readOnly: true,
              onTap: () async {
                TimeOfDay? pickedTime = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                if (pickedTime != null) {
                  setState(() {
                    _answers[question['label']] = pickedTime.format(context);
                  });
                }
              },
            ),
          ],
        );
      default:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(question['label'], style: TextStyle(fontWeight: FontWeight.bold)),
            TextField(
              onChanged: (value) {
                _answers[question['label']] = value;
              },
            ),
          ],
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Survei Penilaian Dosen'),
      ),
      body: _questions.isEmpty
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  ..._questions.map(_buildQuestion).toList(),
                  SizedBox(height: 16.0),
                  ElevatedButton.icon(
                    onPressed: _submitFeedback,
                    icon: Icon(Icons.send),
                    label: Text('Submit Feedback'),
                  ),
                ],
              ),
            ),
    );
  }
}
