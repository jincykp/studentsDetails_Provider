import 'package:hive/hive.dart';
part 'student_model.g.dart';

@HiveType(typeId: 0)
class StudentsModel extends HiveObject {
  @HiveField(0)
  String? studentName;
  @HiveField(1)
  String? studentAge;
  @HiveField(2)
  String? studentRegNo;
  @HiveField(3)
  String? studentContactNo;
  @HiveField(4)
  String? studentPhoto;
  StudentsModel(
      {required this.studentName,
      required this.studentAge,
      required this.studentRegNo,
      required this.studentContactNo,
      this.studentPhoto});
}
