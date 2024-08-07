import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:note_app_sample/dummy_db.dart';
import 'package:note_app_sample/utils/app_sessions.dart';
import 'package:note_app_sample/view/global_widgets/global_widget.dart';
import 'package:note_app_sample/view/notes_detail_screen/notes_details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedcolorindex = 0;
  TextEditingController titlecontroller = TextEditingController();

  TextEditingController descreptioncontroller = TextEditingController();
  TextEditingController datecontroller = TextEditingController();

  ///step 2 reference adding
  var notebox = Hive.box(AppSessions.NOTEBOX);
  List notkeys = [];
  @override

  /// initial value et cheyyan vendi hann initstate set chythh
  void initState() {
    ///to upadte the keys list
    notkeys = notebox.keys.toList();
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            titlecontroller.clear();
            datecontroller.clear();
            descreptioncontroller.clear();
            selectedcolorindex = 0;
            _customBottomSheet(context);
          },
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: Text(
                  "MY NOTES",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 35),
                ),
              ),
              GridView.builder(
                physics: ScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  var CurrentNote = notebox.get(notkeys[index]);
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            /// notesdetails screen navigation section

                            builder: (context) => NotesDetailsScreen(
                              isedit: () {
                                _customBottomSheet(context,
                                    isEdit: true, itemindex: index);
                                titlecontroller.text = CurrentNote['title'];
                                descreptioncontroller.text =
                                    CurrentNote['descreption'];
                                datecontroller.text = CurrentNote['date'];
                                selectedcolorindex = CurrentNote['colorindex'];
                                notkeys = notebox.keys.toList();
                                setState(() {});
                              },
                              date: datecontroller.text = CurrentNote['date'],
                              descreption: descreptioncontroller.text =
                                  CurrentNote['descreption'],
                              title: titlecontroller.text =
                                  CurrentNote['title'],
                              colors:
                                  DummyDb.notecolor[CurrentNote['colorindex']],
                            ),
                          ));
                    },
                    child: GlobalWidget(
                      /// is edit true ayyaaa custom bottom sheet
                      notecolor: DummyDb.notecolor[CurrentNote['colorindex']],
                      // isEdit: () {
                      //   titlecontroller.text = CurrentNote['title'];
                      //   descreptioncontroller.text = CurrentNote['descreption'];
                      //   datecontroller.text = CurrentNote['date'];
                      //   selectedcolorindex = CurrentNote['colorindex'];

                      //   _customBottomSheet(context,
                      //       isEdit: true, itemindex: index);
                      // },

                      ///delete icon section
                      ondelete: () {
                        notebox.delete(notkeys[index]);
                        notkeys = notebox.keys.toList();
                        setState(() {});
                      },
                      cusomtitle: CurrentNote['title'],
                      customdescreption: CurrentNote['descreption'],
                      customdate: CurrentNote['date'],
                    ),
                  );
                },
                itemCount: notkeys.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 10,
                    mainAxisExtent: 250),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// is edit false custom bottom sheet

  Future<dynamic> _customBottomSheet(BuildContext context,
      {bool isEdit = false, int? itemindex}) {
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) => Padding(
              padding: const EdgeInsets.all(20),
              child: Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      controller: titlecontroller,
                      decoration: InputDecoration(
                          labelText: 'Title',
                          filled: true,
                          fillColor: Colors.grey,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: descreptioncontroller,
                      decoration: InputDecoration(
                          labelText: 'Descreption',
                          filled: true,
                          fillColor: Colors.grey,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      readOnly: true,
                      controller: datecontroller,
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: () async {
                              var selectedDate = await showDatePicker(
                                  context: context,
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime.now());
                              if (selectedDate != null) {
                                datecontroller.text =
                                    DateFormat('dd/MMM/y').format(selectedDate);
                              }
                            },
                            icon: Icon(Icons.calendar_month_outlined),
                          ),
                          labelText: 'Date',
                          filled: true,
                          fillColor: Colors.grey,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    StatefulBuilder(
                      builder: (context, setState) => Row(
                        children: List.generate(
                          DummyDb.notecolor.length,
                          (index) => Expanded(
                            child: InkWell(
                              onTap: () {
                                selectedcolorindex = index;
                                setState(() {});
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 5),
                                height: 50,
                                decoration: BoxDecoration(
                                    border: selectedcolorindex == index
                                        ? Border.all(width: 2)
                                        : null,
                                    color: DummyDb.notecolor[index],
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(width: 1)),
                          child: TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                'Cancel',
                                style: TextStyle(
                                    fontSize: 25, color: Colors.white),
                              )),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(width: 1)),
                          child: TextButton(
                              onPressed: () {
                                isEdit
                                    ? notebox.put(notkeys[itemindex!], {
                                        'title': titlecontroller.text,
                                        'descreption':
                                            descreptioncontroller.text,
                                        'date': datecontroller.text,
                                        'colorindex': selectedcolorindex,
                                      })

                                    ///step 3 data adding
                                    : notebox.add({
                                        'title': titlecontroller.text,
                                        'descreption':
                                            descreptioncontroller.text,
                                        'date': datecontroller.text,
                                        'colorindex': selectedcolorindex,
                                      });
                                notkeys = notebox.keys.toList();

                                ///this is used to update the keys list after adding to textcontroller
                                setState(() {});

                                Navigator.pop(context);
                              },
                              child: Text(
                                isEdit ? 'edit' : 'Save',
                                style: TextStyle(
                                    fontSize: 25, color: Colors.white),
                              )),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ));
  }
}
