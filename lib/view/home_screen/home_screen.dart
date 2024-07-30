import 'package:flutter/material.dart';
import 'package:note_app_sample/dummy_db.dart';
import 'package:note_app_sample/view/global_widgets/global_widget.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: ListView.separated(
          itemBuilder: (context, index) => GlobalWidget(
                notecolor:
                    DummyDb.notecolor[DummyDb.items[index]['colorindex']],
                isEdit: () {
                  titlecontroller.text = DummyDb.items[index]['title'];
                  descreptioncontroller.text =
                      DummyDb.items[index]['descreption'];
                  datecontroller.text = DummyDb.items[index]['date'];
                  selectedcolorindex = DummyDb.items[index]['colorindex'];

                  _customBottomSheet(context, isEdit: true, itemindex: index);
                },
                ondelete: () {
                  DummyDb.items.removeAt(index);
                  setState(() {});
                },
                cusomtitle: DummyDb.items[index]['title'],
                customdescreption: DummyDb.items[index]['descreption'],
                customdate: DummyDb.items[index]['date'],
              ),
          separatorBuilder: (context, index) => SizedBox(
                height: 10,
              ),
          itemCount: DummyDb.items.length),
    );
  }

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
                      maxLines: 5,
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
                      controller: datecontroller,
                      decoration: InputDecoration(
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
                                    ? DummyDb.items[itemindex!] = {
                                        'title': titlecontroller.text,
                                        'descreption':
                                            descreptioncontroller.text,
                                        'date': datecontroller.text,
                                        'colorindex': selectedcolorindex,
                                      }
                                    : DummyDb.items.add({
                                        'title': titlecontroller.text,
                                        'descreption':
                                            descreptioncontroller.text,
                                        'date': datecontroller.text,
                                        'colorindex': selectedcolorindex,
                                      });
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
