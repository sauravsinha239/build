import 'package:buildcontext/model/ExamItem.dart';
import 'package:flutter/material.dart';

import '../model/api.dart';

class data extends StatefulWidget{
  const data({super.key});

  @override
  State<data> createState() => _dataState();
}

class _dataState extends State<data> {
  late Future<List<ExamItem>> futureItems;
  String selectedSection = "Pre Exam";

  @override
  void initState() {
    super.initState();
    futureItems = fetchExamItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Exam Menu Sections")),
      body: Column(
        children: [
          // Section Selector Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: ["Pre Exam", "During Exam", "Post Exam"].map((section) {
              return ElevatedButton(
                onPressed: () {
                  setState(() {
                    selectedSection = section;
                  });
                },
                child: Text(section),
              );
            }).toList(),
          ),
          Expanded(
            child: FutureBuilder<List<ExamItem>>(
              future: futureItems,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting)
                  return Center(child: CircularProgressIndicator());
                else if (snapshot.hasError)
                  return Center(child: Text('Error: ${snapshot.error}'));
                else if (!snapshot.hasData || snapshot.data!.isEmpty)
                  return Center(child: Text('No data available'));

                // Group data
                final grouped = groupBySection(snapshot.data!);
                final sectionItems = grouped[selectedSection] ?? [];

                return ListView.builder(
                  itemCount: sectionItems.length,
                  itemBuilder: (context, index) {
                    final item = sectionItems[index];
                    return ExpansionTile(
                      title: Text(item.label),
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(item.description),
                        )
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );

  }

}