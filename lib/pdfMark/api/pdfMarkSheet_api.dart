import 'dart:io';
import 'package:flutterfirebase/pdfMark/api/pdf_api.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import '../model/markSheet.dart';

class PdfInvoiceApi {
  static Future<File> generate(MarkSheet markSheet) async {
    final pdf = Document();

    pdf.addPage(MultiPage(
      build: (context) => [
        buildHeader(markSheet),
        SizedBox(height: 2 * PdfPageFormat.cm),
        buildSemTitle(markSheet),
        buildInvoice(markSheet),
        Divider(),
      ],
      footer: (context) => buildFooter(markSheet),
    ));

    return PdfApi.saveDocument(name: 'Result', pdf: pdf);
  }

  static Widget buildHeader(MarkSheet markSheet) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 1 * PdfPageFormat.cm),
          Text('Bharathiar University',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
          SizedBox(height: 1 * PdfPageFormat.mm),
          Text('Marudhamalai road Coimbatore', style: TextStyle(fontSize: 18)),
          SizedBox(height: 2 * PdfPageFormat.cm),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildStudentInfo(markSheet.info),
            ],
          ),
        ],
      );

  static Widget buildStudentInfo(StudentInfo info) {
    final titles = <String>['Regter Number:', 'NAME:'];
    final data = <String>[info.regNo, info.name];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(titles.length, (index) {
        final title = titles[index];
        final value = data[index];

        return buildText(title: title, value: value, width: 200);
      }),
    );
  }

  static Widget buildSemTitle(MarkSheet markSheet) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'RESULT',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 0.5 * PdfPageFormat.cm),
          //Text(invoice.info.semester),
          Text('Semester I'),
          SizedBox(height: 0.8 * PdfPageFormat.cm),
        ],
      );

  static Widget buildInvoice(MarkSheet markSheet) {
    final headers = [
      'Subject Code',
      'Subject Name',
      'InternalMark',
      'ExternalMark',
      'Result',
    ];

    var data1 = students.map((documents) {
      return [
        documents.subjectCode,
        documents.subjectName,
        documents.internalMark,
        documents.externalMark,
        documents.result
      ];
    }).toList();
    print(data1);
    //try end

    return Table.fromTextArray(
      headers: headers,
      data: data1,
      border: null,
      headerStyle: TextStyle(fontWeight: FontWeight.bold),
      headerDecoration: BoxDecoration(color: PdfColors.grey300),
      cellHeight: 30,
      cellAlignments: {
        0: Alignment.centerLeft,
        1: Alignment.centerLeft,
        2: Alignment.center,
        3: Alignment.center,
        4: Alignment.center,
      },
    );
  }

  static Widget buildFooter(MarkSheet markSheet) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(),
          Text(
              'Disclaimer: The University is not responsible for any inadvertent error that may have crept in the results being published on Net. The results published on Net are for immediate information to the examinees. These cannot be treated as original Mark Sheets. Original Mark Sheets will be issued by the University separately.'),
          SizedBox(height: 2 * PdfPageFormat.mm),
        ],
      );

  static buildText({
    required String title,
    required String value,
    double width = double.infinity,
    TextStyle? titleStyle,
    bool unite = false,
  }) {
    final style = titleStyle ?? TextStyle(fontWeight: FontWeight.bold);

    return Container(
      width: width,
      child: Row(
        children: [
          Expanded(child: Text(title, style: style)),
          Text(value, style: unite ? style : null),
        ],
      ),
    );
  }
}
