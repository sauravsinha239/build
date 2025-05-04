import 'dart:convert';
import 'package:buildcontext/model/ExamItem.dart';
import 'package:http/http.dart' as http;

Future<List<ExamItem>> fetchExamItems() async {
  final response = await http.get(Uri.parse('https://exam.icsi.edu/consentform/utility/React_chatbot?guide=E124A22C-C893-4A28-AA12-98022EF9B5BB'));

  if (response.statusCode == 200) {
    final jsonData = json.decode(response.body);
    final List<dynamic> data = jsonData['data'];
    return data.map((item) => ExamItem.fromJson(item)).toList();
  } else {
    throw Exception('Failed to load data');
  }
}
