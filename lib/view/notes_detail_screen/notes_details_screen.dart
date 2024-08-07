import 'package:flutter/material.dart';

class NotesDetailsScreen extends StatefulWidget {
  const NotesDetailsScreen(
      {super.key,
      required this.title,
      required this.descreption,
      required this.date,
      required this.colors,
      this.isedit});
  final String title;
  final String descreption;
  final String date;
  final Color colors;
  final void Function()? isedit;

  @override
  State<NotesDetailsScreen> createState() => _NotesDetailsScreenState();
}

class _NotesDetailsScreenState extends State<NotesDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.edit),
          onPressed: widget.isedit,
        ),
        appBar: AppBar(),
        body: Center(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            decoration: BoxDecoration(
              color: widget.colors,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'TITLE :-',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      widget.title,
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  textAlign: TextAlign.start,
                  'DESCREPTION',
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                      decorationThickness: 2),
                ),
                Text(
                  widget.descreption,
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Text(
                      'DATE :-',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      widget.date,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ],
            ),
          ),
        )));
  }
}
