import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
//import 'package:records_app/test/record_test_data.dart';
import 'package:records_app/src/test/record_test_data.dart';
import 'package:records_app/src/test/record_list_view_test.dart';

import 'package:shared_preferences/shared_preferences.dart';

class RecordDAO extends ChangeNotifier {
  RecordDAO() {
    // The following is little bit dirty.
    // There is a better way to do that but at the moment okay ;)
    Future(() => _loadData());
  }

  final List<Record> _records = [];
  int _nextId = 1;

  /// Returns a flat copy of all records.
  ///
  List<Record> findAll() => _records.toList();

  /// Deletes the record object with the given record id.
  /// Return true = delete ok, false = no record object with the given id found!
  ///
  Future<bool> delete(int id) async {
    // Todo
  }

  /// Updates the record in the storage with the given record object.
  /// Return true = update ok, false = no record object with the given id found!
  ///
  Future<bool> update(Record record) async {
    // Todo
  }

  /// Persists the given record object.
  /// Return true = persist ok, false = error record object not persisted!
  /// Side effects: record.id = nextId
  ///
  Future<bool> persist(Record record) async {
    // Todo
  }

  Future<void> _loadData() async {
    final storage = await SharedPreferences.getInstance();
    //await storage.remove('records');
    final recordStrings = storage.getStringList('records');
    if (recordStrings != null && recordStrings.isNotEmpty) {
      _records.addAll(recordStrings.map((r) => Record.fromJson(jsonDecode(r))));
    } else {
      // add list with test records
      //_records.addAll(testRecords);
    }
    _nextId = _records.map((e) => e.id ?? 0).reduce(max) + 1;
    notifyListeners();
  }

  Future<void> _saveData() async {
    final storage = await SharedPreferences.getInstance();
    storage.setStringList(
        'records', _records.map((e) => json.encode(e.toJson())).toList());
  }
}
