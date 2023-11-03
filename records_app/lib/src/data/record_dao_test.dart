import 'package:flutter_test/flutter_test.dart';
import 'package:records_app/src/data/record_dao.dart';
import 'dart:convert';
import 'package:records_app/src/models/record.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'record_test_data.dart';

void main() {
  group('RecordDAO', () {
    RecordDAO? recordDAO;
    setUp(() async {
      // Load test records into mock shared pref singleton instance.
      SharedPreferences.setMockInitialValues({
        'records': testRecords.map((e) => json.encode(e.toJson())).toList()
      });
      recordDAO = RecordDAO();
      // Wait 500ms to load data in recordDAO.
      // Little bit dirty but at the moment okay ;)
      await Future.delayed(const Duration(milliseconds: 500));
    });
    tearDown(() => SharedPreferences.resetStatic());
    test('findAll()', () {
      final records = recordDAO?.findAll();
      expect(records?.length, 4);
    });

    test('persist()', () async {
      final record = Record(
          moduleNumber: '4711',
          moduleName: 'TEST MODULE NAME',
          crp: 6,
          grade: 99,
          halfWeighted: true,
          summerTerm: true,
          year: 2018);
      final result = await recordDAO?.persist(record);
      expect(result, true);
      expect(record.id, 5);
      expect(recordDAO?.findAll().length, 5);
    });

    test('update()', () async {
      var record = recordDAO?.findAll().first;
      expect(record != null, true);
      expect(record?.id, 1);
      record?.moduleNumber = 'TEST NUMBER';
      record?.moduleName = 'TEST NAME';
      final result = await recordDAO?.update(record as Record);
      expect(result, true);
      record = recordDAO?.findAll().first;
      expect(record != null, true);
      expect(record?.id, 1);
      expect(record?.moduleNumber, 'TEST NUMBER');
      expect(record?.moduleName, 'TEST NAME');
    });
  });
}
