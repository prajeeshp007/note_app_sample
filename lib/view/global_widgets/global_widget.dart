import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class GlobalWidget extends StatelessWidget {
  const GlobalWidget(
      {super.key,
      this.ondelete,
      final String,
      required this.cusomtitle,
      required this.customdescreption,
      required this.customdate,
      this.isEdit,
      required this.notecolor});
  final void Function()? ondelete;
  final void Function()? isEdit;
  final String cusomtitle, customdescreption, customdate;
  final Color notecolor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
            color: notecolor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 0)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(cusomtitle),
                Spacer(),
                IconButton(onPressed: isEdit, icon: Icon(Icons.edit)),
                IconButton(onPressed: ondelete, icon: Icon(Icons.delete))
              ],
            ),
            Text(customdescreption),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(customdate),
                IconButton(
                    onPressed: () {
                      Share.share('check out my website https://example.com');
                    },
                    icon: Icon(Icons.share))
              ],
            )
          ],
        ),
      ),
    );
  }
}
