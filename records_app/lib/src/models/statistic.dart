import 'record.dart';

class Statistic {
  Statistic(List<Record> records) {
    recordCount = records.length;
    hwCount = records.where((record) => record.halfWeighted).length;
    sumCrp = records.map((record) => record.crp).fold(0, (a, b) => a + b);
    crpToEnd = crpEnd - sumCrp;
    averageGrade = calculateRecordsAverage(records);
  }
  int calculateRecordsAverage(List<Record> records) {
    int sumWeightedGrades = 0;
    int sumWeightedCrp = 0;

    for (var record in records) {
      if (record.halfWeighted) {
        // For half-weighted records, the crp is counted as half
        sumWeightedGrades += (record.grade * (record.crp ~/ 2));
        sumWeightedCrp += (record.crp ~/ 2);
      } else {
        sumWeightedGrades += (record.grade * record.crp);
        sumWeightedCrp += record.crp;
      }
    }

    if (sumWeightedCrp == 0) {
      return 0; // To prevent division by zero
    }

    return (sumWeightedGrades / sumWeightedCrp).floor();
  }

  static const crpEnd = 180;

  late final int recordCount;
  late final int hwCount;
  late final int sumCrp;
  late final int crpToEnd;
  late final int averageGrade;
}
