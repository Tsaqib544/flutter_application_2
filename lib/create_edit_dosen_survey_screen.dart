import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class CreateEditDosenSurveyScreen extends StatefulWidget {
  final String? dosenName;
  final bool isEditing;

  const CreateEditDosenSurveyScreen({Key? key, this.dosenName, this.isEditing = false}) : super(key: key);

  @override
  _CreateEditDosenSurveyScreenState createState() => _CreateEditDosenSurveyScreenState();
}

class _CreateEditDosenSurveyScreenState extends State<CreateEditDosenSurveyScreen> {
  final List<SurveyFormField> _formFields = [];
  final TextEditingController _surveyTitleController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.isEditing && widget.dosenName != null) {
      // Load existing survey data if editing
      _surveyTitleController.text = "Survey for ${widget.dosenName}";
    }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isEditing ? 'Edit Dosen Survey' : 'Create Dosen Survey'),
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
              onPressed: () {
                // Save survey logic
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
  final TextEditingController _textController;
  final TextEditingController _descriptionController = TextEditingController();

  SurveyFormField({Key? key, required this.type, required this.label, required this.onDelete})
      : _textController = TextEditingController(text: label),
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
                controller: _textController,
                decoration: InputDecoration(labelText: 'Judul Pertanyaan'),
                onChanged: (value) {
                  // Handle changes if needed
                },
              ),
              SizedBox(height: 8.0),
              _buildFormField(type),
              SizedBox(height: 8.0),
              ListTile(
                title: TextField(
                  controller: _descriptionController,
                  decoration: InputDecoration(labelText: 'Deskripsi/Jawaban Singkat'),
                ),
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
        return RadioGroup(label: label);
      case FormFieldType.checkbox:
        return CheckboxGroup(label: label);
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
}

// Define the widgets for each form field type
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
    _controllers.addAll(_options.map((option) => TextEditingController(text: option)));
  }

  void _onOptionChanged(String? value) {
    setState(() {
      _selectedOption = value;
    });
  }

  void _updateOption(int index, String value) {
    setState(() {
      _options[index] = value;
      _controllers[index].text = value;
    });
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: _options
              .asMap()
              .map((index, option) => MapEntry(
                    index,
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _controllers[index],
                            decoration: InputDecoration(labelText: 'Opsi ${index + 1}'),
                            onChanged: (value) => _updateOption(index, value),
                          ),
                        ),
                        Radio<String>(
                          value: option,
                          groupValue: _selectedOption,
                          onChanged: _onOptionChanged,
                        ),
                      ],
                    ),
                  ))
              .values
              .toList(),
        ),
        TextButton.icon(
          onPressed: () {
            setState(() {
              _options.add('Opsi ${_options.length + 1}');
              _controllers.add(TextEditingController(text: 'Opsi ${_options.length}'));
            });
          },
          icon: Icon(Icons.add),
          label: Text('Tambah Opsi'),
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
    _controllers.addAll(_options.map((option) => TextEditingController(text: option)));
  }

  void _updateOption(int index, String value) {
    setState(() {
      _options[index] = value;
      _controllers[index].text = value;
    });
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: _options
              .asMap()
              .map((index, option) => MapEntry(
                    index,
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _controllers[index],
                            decoration: InputDecoration(labelText: 'Opsi ${index + 1}'),
                            onChanged: (value) => _updateOption(index, value),
                          ),
                        ),
                        Checkbox(
                          value: _selectedOptions[index],
                          onChanged: (value) {
                            setState(() {
                              _selectedOptions[index] = value ?? false;
                            });
                          },
                        ),
                      ],
                    ),
                  ))
              .values
              .toList(),
        ),
        TextButton.icon(
          onPressed: () {
            setState(() {
              _options.add('Opsi ${_options.length + 1}');
              _selectedOptions.add(false);
              _controllers.add(TextEditingController(text: 'Opsi ${_options.length}'));
            });
          },
          icon: Icon(Icons.add),
          label: Text('Tambah Opsi'),
        ),
      ],
    );
  }
}

class DropdownField extends StatelessWidget {
  final String label;
  final List<String> _options = ['Opsi 1', 'Opsi 2', 'Opsi 3'];

  DropdownField({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(labelText: label),
      items: _options.map((String option) {
        return DropdownMenuItem<String>(
          value: option,
          child: Text(option),
        );
      }).toList(),
      onChanged: (String? newValue) {
        // Handle dropdown changes if needed
      },
    );
  }
}

class FileField extends StatelessWidget {
  final String label;

  FileField({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        SizedBox(height: 8.0),
        ElevatedButton.icon(
          onPressed: () {
            // Handle file upload logic
          },
          icon: Icon(Icons.upload_file),
          label: Text('Upload File'),
        ),
      ],
    );
  }
}

class LinearScaleField extends StatelessWidget {
  final String label;

  LinearScaleField({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        Slider(
          value: 0,
          min: 0,
          max: 10,
          divisions: 10,
          label: '0',
          onChanged: (double value) {
            // Handle slider changes
          },
        ),
      ],
    );
  }
}

class GridField extends StatelessWidget {
  final String label;

  GridField({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(label); // Implement grid field widget
  }
}

class TableField extends StatelessWidget {
  final String label;

  TableField({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(label); // Implement table field widget
  }
}

class DateField extends StatelessWidget {
  final String label;

  DateField({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(label); // Implement date field widget
  }
}

class TimeField extends StatelessWidget {
  final String label;

  TimeField({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(label); // Implement time field widget
  }
}
