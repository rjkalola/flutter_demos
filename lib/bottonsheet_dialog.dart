import 'package:flutter/material.dart';

class BottomSheetDialogDemo extends StatefulWidget {
  const BottomSheetDialogDemo({Key? key}) : super(key: key);

  @override
  _BottomSheetDialogDemoState createState() => _BottomSheetDialogDemoState();
}

class _BottomSheetDialogDemoState extends State<BottomSheetDialogDemo> {
  final allItems = List<String>.generate(50, (i) => "State $i");
  var items = <String>[];
  TextEditingController editingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bottom Sheet Dialog"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            MaterialButton(
              onPressed: () {
                showSimpleDialog();
              },
              color: Colors.green,
              child: Text(
                "Simple",
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
            ),
            MaterialButton(
              onPressed: () {},
              color: Colors.green,
              child: Text(
                "Fulll Screen",
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
            ),
            MaterialButton(
              onPressed: () {},
              color: Colors.green,
              child: Text(
                "Scrollable",
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
            )
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void showSimpleDialog() {
    items.clear();
    items.addAll(allItems);
    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      /* shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),*/
      context: context,
      builder: (context) => StatefulBuilder(
          builder: (BuildContext context,
                  StateSetter setModalState /*You can rename this!*/) =>
              DraggableScrollableSheet(
                initialChildSize: 0.9,
                maxChildSize: 0.9,
                minChildSize: 0.5,
                builder:
                    (BuildContext context, ScrollController scrollController) =>
                        Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(10))),
                  child: Column(mainAxisSize: MainAxisSize.max, children: [
                    Container(
                      color: Colors.blueGrey.withAlpha(100),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          const Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Select State",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 15),
                            ),
                          ),
                          Align(
                              alignment: Alignment.centerRight,
                              child: IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: Icon(Icons.close, size: 20),
                              ))
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
                      child: TextField(
                        controller: editingController,
                        onChanged: (value) {
                          setModalState(() {
                            filterSearchResults(value);
                          });
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(0, 2, 14, 0),
                          prefixIcon: Icon(Icons.search, color: Colors.black26),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          hintText: 'Search',
                        ),
                      ),
                    ),
                    Expanded(
                      child: setStateList(),
                    )
                  ]),
                ),
              )),
    );
  }

  Widget setStateList() => ListView.builder(
        itemCount: items.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, i) {
          return ListTile(
            title: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 9, 0, 9),
                    child: Text(
                      '${items[i]}',
                      style: TextStyle(fontSize: 18, color: Colors.blue),
                    ),
                  ),
                  Divider()
                ],
              ),
            ),
            onTap: (){
              print(items[i]);
            },
          );
        },
      );

  void filterSearchResults(String value) {
    print(value);
    List<String> dummySearchList = <String>[];
    dummySearchList.addAll(allItems);

    if (value.isNotEmpty) {
      List<String> dummyListData = <String>[];
      for (var item in dummySearchList) {
        if (item.toLowerCase().contains(value.toLowerCase())) {
          dummyListData.add(item);
        }
      }
      setState(() {
        items.clear();
        items.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        items.clear();
        items.addAll(allItems);
      });
    }
  }
}
