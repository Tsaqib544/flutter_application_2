import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CreateEditDosenSurveyScreen extends StatefulWidget {
  final String? dosenName;
  final bool isEditing;

  const CreateEditDosenSurveyScreen(
      {Key? key, this.dosenName, this.isEditing = false})
      : super(key: key);

  @override
  _CreateEditDosenSurveyScreenState createState() =>
      _CreateEditDosenSurveyScreenState();
}

class _CreateEditDosenSurveyScreenState
    extends State<CreateEditDosenSurveyScreen> {
  final List<SurveyFormField> _formFields = [];
  final TextEditingController _surveyTitleController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    if (widget.isEditing && widget.dosenName != null) {
      _surveyTitleController.text = "Survey for ${widget.dosenName}";
      _loadSurveyData();
    }
  }

  void _loadSurveyData() async {
    // Logic to load existing survey data from Firebase
  }

  void _addFormField(FormFieldType fieldType) {
    setState(() {
      _formFields.add(SurveyFormField(
        type: fieldType,
        label: 'Pertanyaan Tanpa Judul',
        onDelete: (formField) {
          setState(() {
            _formFields.remove(formField);
          });
        },
      ));
    });
  }

  Future<void> _saveSurvey() async {
    List<Map<String, dynamic>> questions = _formFields.map((field) {
      return {
        'type': field.type.toString(),
        'label': field.textController.text,
        'description': field.descriptionController.text,
        'options': field.getOptions(),
      };
    }).toList();

    await _firestore.collection('surveys').add({
      'title': _surveyTitleController.text,
      'questions': questions,
      'dosenName': widget.dosenName,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            widget.isEditing ? 'Edit Dosen Survey' : 'Create Dosen Survey'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _surveyTitleController,
              decoration: InputDecoration(labelText: 'Survey Title'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton.icon(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          leading: Icon(Icons.radio_button_checked),
                          title: Text('Pilihan Ganda'),
                          onTap: () {
                            _addFormField(FormFieldType.radio);
                            Navigator.pop(context);
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.check_box),
                          title: Text('Kotak Centang'),
                          onTap: () {
                            _addFormField(FormFieldType.checkbox);
                            Navigator.pop(context);
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.arrow_drop_down),
                          title: Text('Drop-down'),
                          onTap: () {
                            _addFormField(FormFieldType.dropdown);
                            Navigator.pop(context);
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.cloud_upload),
                          title: Text('Upload File'),
                          onTap: () {
                            _addFormField(FormFieldType.file);
                            Navigator.pop(context);
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.linear_scale),
                          title: Text('Skala Linier'),
                          onTap: () {
                            _addFormField(FormFieldType.linearScale);
                            Navigator.pop(context);
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.grid_view),
                          title: Text('Kisi Pilihan Ganda'),
                          onTap: () {
                            _addFormField(FormFieldType.grid);
                            Navigator.pop(context);
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.table_chart),
                          title: Text('Petak Kotak Centang'),
                          onTap: () {
                            _addFormField(FormFieldType.table);
                            Navigator.pop(context);
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.calendar_today),
                          title: Text('Tanggal'),
                          onTap: () {
                            _addFormField(FormFieldType.date);
                            Navigator.pop(context);
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.access_time),
                          title: Text('Waktu'),
                          onTap: () {
                            _addFormField(FormFieldType.time);
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              icon: Icon(Icons.add),
              label: Text('Tambahkan Pertanyaan'),
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: ReorderableListView(
                onReorder: (oldIndex, newIndex) {
                  setState(() {
                    if (newIndex > oldIndex) {
                      newIndex -= 1;
                    }
                    final item = _formFields.removeAt(oldIndex);
                    _formFields.insert(newIndex, item);
                  });
                },
                children: _formFields
                    .map((formField) => ListTile(
                          key: ValueKey(formField),
                          title: formField,
                        ))
                    .toList(),
              ),
            ),
            ElevatedButton.icon(
              onPressed: () async {
                await _saveSurvey();
                Navigator.pop(context);
              },
              icon: Icon(Icons.save),
              label: Text('Simpan Survei'),
            ),
          ],
        ),
      ),
    );
  }
}

enum FormFieldType {
  radio,
  checkbox,
  dropdown,
  file,
  linearScale,
  grid,
  table,
  date,
  time,
}

class SurveyFormField extends StatelessWidget {
  final FormFieldType type;
  final String label;
  final ValueChanged<SurveyFormField> onDelete;
  final TextEditingController textController;
  final TextEditingController descriptionController = TextEditingController();
  final GlobalKey<_RadioGroupState> _radioGroupKey =
      GlobalKey<_RadioGroupState>();
  final GlobalKey<_CheckboxGroupState> _checkboxGroupKey =
      GlobalKey<_CheckboxGroupState>();

  SurveyFormField(
      {Key? key,
      required this.type,
      required this.label,
      required this.onDelete})
      : textController = TextEditingController(text: label),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: ValueKey(this),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) => onDelete(this),
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Hapus',
          ),
        ],
      ),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: textController,
                decoration: InputDecoration(labelText: 'Judul Pertanyaan'),
                onChanged: (value) {
                  // Handle changes if needed
                },
              ),
              SizedBox(height: 8.0),
              _buildFormField(type),
              SizedBox(height: 8.0),
              TextField(
                controller: descriptionController,
                decoration:
                    InputDecoration(labelText: 'Deskripsi/Jawaban Singkat'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFormField(FormFieldType type) {
    switch (type) {
      case FormFieldType.radio:
        return RadioGroup(key: _radioGroupKey, label: label);
      case FormFieldType.checkbox:
        return CheckboxGroup(key: _checkboxGroupKey, label: label);
      case FormFieldType.dropdown:
        return DropdownField(label: label);
      case FormFieldType.file:
        return FileField(label: label);
      case FormFieldType.linearScale:
        return LinearScaleField(label: label);
      case FormFieldType.grid:
        return GridField(label: label);
      case FormFieldType.table:
        return TableField(label: label);
      case FormFieldType.date:
        return DateField(label: label);
      case FormFieldType.time:
        return TimeField(label: label);
      default:
        return Container();
    }
  }

  List<String> getOptions() {
    switch (type) {
      case FormFieldType.radio:
        return _radioGroupKey.currentState?._options ?? [];
      case FormFieldType.checkbox:
        return _checkboxGroupKey.currentState?._options ?? [];
      default:
        return [];
    }
  }
}

class RadioGroup extends StatefulWidget {
  final String label;

  const RadioGroup({Key? key, required this.label}) : super(key: key);

  @override
  _RadioGroupState createState() => _RadioGroupState();
}

class _RadioGroupState extends State<RadioGroup> {
  final List<String> _options = ['Opsi 1', 'Opsi 2', 'Opsi 3'];
  String? _selectedOption;
  final List<TextEditingController> _controllers = [];

  @override
  void initState() {
    super.initState();
    _controllers
        .addAll(_options.map((option) => TextEditingController(text: option)));
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var i = 0; i < _options.length; i++)
          Row(
            children: [
              Radio<String>(
                value: _options[i],
                groupValue: _selectedOption,
                onChanged: (value) {
                  setState(() {
                    _selectedOption = value;
                  });
                },
              ),
              Expanded(
                child: TextField(
                  controller: _controllers[i],
                  onChanged: (value) {
                    _options[i] = value;
                  },
                ),
              ),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  setState(() {
                    _options.removeAt(i);
                    _controllers.removeAt(i).dispose();
                  });
                },
              ),
            ],
          ),
        TextButton(
          onPressed: () {
            setState(() {
              _options.add('Opsi ${_options.length + 1}');
              _controllers
                  .add(TextEditingController(text: 'Opsi ${_options.length}'));
            });
          },
          child: Text('Tambahkan Opsi'),
        ),
      ],
    );
  }
}

class CheckboxGroup extends StatefulWidget {
  final String label;

  const CheckboxGroup({Key? key, required this.label}) : super(key: key);

  @override
  _CheckboxGroupState createState() => _CheckboxGroupState();
}

class _CheckboxGroupState extends State<CheckboxGroup> {
  final List<String> _options = ['Opsi 1', 'Opsi 2', 'Opsi 3'];
  final List<bool> _selectedOptions = [false, false, false];
  final List<TextEditingController> _controllers = [];

  @override
  void initState() {
    super.initState();
    _controllers
        .addAll(_options.map((option) => TextEditingController(text: option)));
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var i = 0; i < _options.length; i++)
          Row(
            children: [
              Checkbox(
                value: _selectedOptions[i],
                onChanged: (value) {
                  setState(() {
                    _selectedOptions[i] = value!;
                  });
                },
              ),
              Expanded(
                child: TextField(
                  controller: _controllers[i],
                  onChanged: (value) {
                    _options[i] = value;
                  },
                ),
              ),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  setState(() {
                    _options.removeAt(i);
                    _selectedOptions.removeAt(i);
                    _controllers.removeAt(i).dispose();
                  });
                },
              ),
            ],
          ),
        TextButton(
          onPressed: () {
            setState(() {
              _options.add('Opsi ${_options.length + 1}');
              _selectedOptions.add(false);
              _controllers
                  .add(TextEditingController(text: 'Opsi ${_options.length}'));
            });
          },
          child: Text('Tambahkan Opsi'),
        ),
      ],
    );
  }
}

class DropdownField extends StatelessWidget {
  final String label;

  const DropdownField({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class FileField extends StatelessWidget {
  final String label;

  const FileField({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class LinearScaleField extends StatelessWidget {
  final String label;

  const LinearScaleField({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class GridField extends StatelessWidget {
  final String label;

  const GridField({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class TableField extends StatelessWidget {
  final String label;

  const TableField({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class DateField extends StatelessWidget {
  final String label;

  const DateField({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class TimeField extends StatelessWidget {
  final String label;

  const TimeField({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
