class MarkSheet {
  final StudentInfo info;

  const MarkSheet({
    required this.info,
  });
}

List<Student> students = [];

class StudentInfo {
  final String regNo;
  final String name;

  const StudentInfo({
    required this.regNo,
    required this.name,
  });
}

class Student {
  String subjectName;
  String internalMark;
  String externalMark;
  String subjectCode;
  String totalMark;
  String result;

  Student(
      {required this.subjectCode,
      required this.subjectName,
      required this.internalMark,
      required this.externalMark,
      required this.totalMark,
      required this.result});
}
