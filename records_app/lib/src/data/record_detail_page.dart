import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:records_app/src/data/record_dao.dart';
import '/home/dors/Documents/wise23/testcodes/records_app/lib/src/models/record.dart';

class RecordDetailPage extends StatelessWidget {
  RecordDetailPage({super.key, Record? record})
      : _title = record == null ? 'Create Record' : 'Edit Record',
        _record = record ?? Record();

  final Record _record;
  final String _title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _title,
        ),
        elevation: 1,
        shadowColor: Theme.of(context).shadowColor,
        actions: <Widget>[
          if (_record.id != null)
            IconButton(
              icon: const Icon(Icons.delete),
              tooltip: 'Delete Record',
              onPressed: () { // Todo },
            )
        ],
      ),
      body: SingleChildScrollView(child: RecordForm(record: _record)),
    );
  }
}

class RecordForm extends StatefulWidget {
  const RecordForm({super.key, required Record record}) : _record = record;
  final Record _record;

  @override
  RecordFormState createState() => RecordFormState();
}

class RecordFormState extends State<RecordForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  final _formKey = GlobalKey<FormState>();
  final _years = []; // Todo

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            initialValue: widget._record.moduleNumber,
            keyboardType: TextInputType.text,
            inputFormatters: <TextInputFormatter>[
              LengthLimitingTextInputFormatter(10),
            ],
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Modul number*',
            ),
            autofocus: widget._record.id == null ? true : false,
            validator: (value) {
              // Todo
              return null;
            },
          ),
          TextFormField(
            initialValue: widget._record.moduleName,
            keyboardType: TextInputType.text,
            inputFormatters: <TextInputFormatter>[
              LengthLimitingTextInputFormatter(100),
            ],
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Modul name*',
            ),
            validator: (value) {
              // Todo
              return null;
            },
          ),
          CheckboxListTile(
            contentPadding: const EdgeInsets.all(0),
            title: const Text('Summer term'),
            value: widget._record.isSummerTerm,
            onChanged: (value) => setState(() {
              widget._record.isSummerTerm = value ?? false;
            }),
          ),
          const Divider(
            height: 0,
            thickness: 2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                textAlign: TextAlign.start,
                '*mandatory',
                style: TextStyle(color: Colors.grey),
              ),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    // Todo
                  }
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ]
            .map((widget) => Padding(
                  padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
                  child: widget,
                ))
            .toList(),
      ),
    );
  }
}
