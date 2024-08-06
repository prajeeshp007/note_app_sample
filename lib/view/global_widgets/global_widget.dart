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
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
            color: notecolor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 0)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  children: [
                    IconButton(
                        onPressed: isEdit,
                        icon: Icon(
                          Icons.edit,
                          color: Colors.black,
                        )),
                    IconButton(
                        onPressed: ondelete,
                        icon: Icon(
                          Icons.delete,
                          color: Colors.black,
                        )),
                    IconButton(
                        onPressed: () {
                          Share.share(
                              'check out my website https://example.com');
                        },
                        icon: Icon(
                          Icons.share,
                          color: Colors.black,
                        ))
                  ],
                ),
              ],
            ),
            Text(
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              cusomtitle,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              customdescreption,
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  customdate,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
