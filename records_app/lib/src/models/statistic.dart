import 'record.dart';

class Statistic {
  Statistic(List<Record> records) {
    recordCount = records.length;
    hwCount = records.where((record) => record.halfWeighted).length;
    sumCrp = records.map((record) => record.crp).fold(0, (a, b) => a + b);
    crpToEnd = crpEnd - sumCrp;

    if (recordCount == 0) {
      averageGrade = 0;
    } else {
      final totalGrade =
          records.map((record) => record.grade).fold(0, (a, b) => a + b);
      averageGrade = (totalGrade / recordCount).ceil();
    }
  }

  static const crpEnd = 180;

  late final int recordCount;
  late final int hwCount;
  late final int sumCrp;
  late final int crpToEnd;
  late final int averageGrade;
}
