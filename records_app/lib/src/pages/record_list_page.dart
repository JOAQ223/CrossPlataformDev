import 'package:flutter/material.dart';
import '../models/record.dart';

final List<Record> records = [
  Record(
      id: 1,
      moduleNumber: 'CS1013',
      moduleName: 'Objektorientierte Programmierung',
      crp: 6,
      grade: 73,
      halfWeighted: true,
      summerTerm: true,
      year: 2020),
  Record(
      id: 2,
      moduleNumber: 'MN1007',
      moduleName: 'Diskrete Mathematik',
      crp: 6,
      grade: 81,
      halfWeighted: true,
      summerTerm: false,
      year: 2020),
  Record(
      id: 3,
      moduleNumber: 'CS1019',
      moduleName: 'Compilerbau',
      crp: 6,
      grade: 81,
      halfWeighted: false,
      summerTerm: false,
      year: 2021),
  Record(
      id: 4,
      moduleNumber: 'CS1020',
      moduleName: 'Datenbanksysteme',
      crp: 6,
      grade: 92,
      halfWeighted: false,
      summerTerm: false,
      year: 2021),
];

class RecordListPage extends StatelessWidget {
  //const RecordListPage({Key? key}) : super(key: key);
  const RecordListPage({super.key});
  final String title = 'My Records';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
        ),
        elevation: 1,
        shadowColor: Theme.of(context).shadowColor,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.bar_chart),
            tooltip: 'Open records statistic',
            onPressed: () {
              // Call RecordListView with the list of records
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RecordListView(records: records),
                ),
              );
            },
          ),
        ],
      ),
      body: const RecordListView(records: []),
      floatingActionButton: FloatingActionButton(
        onPressed: () => throw UnimplementedError(),
        tooltip: 'Add record',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class RecordListView extends StatelessWidget {
  final List<Record> records;

  const RecordListView({Key? key, required this.records}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: records.isEmpty
          ? Center(
              // If the records list is empty, show a message
              child: Text(
                'No records',
                key: const Key(
                    'no_records_hint'), // Adding a key for the Text widget
              ),
            )
          : ListView.builder(
              itemCount: records.length,
              itemBuilder: (context, index) {
                final record = records[index];
                return ListTile(
                  title: Text(record.moduleName),
                  // You can add more widgets to display other record properties
                );
              },
            ),
    );
  }
}
