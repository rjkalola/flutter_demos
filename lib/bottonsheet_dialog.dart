import 'package:flutter/material.dart';

class BottomSheetDialogDemo extends StatefulWidget {
  const BottomSheetDialogDemo({Key? key}) : super(key: key);

  @override
  _BottomSheetDialogDemoState createState() => _BottomSheetDialogDemoState();
}

class _BottomSheetDialogDemoState extends State<BottomSheetDialogDemo> {
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
    showModalBottomSheet(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      context: context,
      builder: (context) => Column(mainAxisSize: MainAxisSize.min, children: [
        Container(
          color: Colors.blueGrey.withAlpha(100),
          child: Stack(
            alignment: Alignment.center,
            children: [
              const Align(
                alignment: Alignment.center,
                child: Text(
                  "Select Item",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                ),
              ),
              Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.close, size: 20),
                  ))
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(16, 12, 16, 12),
          child: TextField(
            decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(0, 2, 14, 0),
              prefixIcon: Icon(Icons.search, color: Colors.black26),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              hintText: ' Search',
            ),
          ),
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: Container(child: Text("Babe")),
              flex: 2,
            ),
            Expanded(
              child: Container(child: Text("I don't miss you")),
              flex: 2,
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(1.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child:  Expanded(
                      flex: 1,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(0, 6, 0, 6),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(0, 6, 0, 6),
                          child: Text("All",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 14)),
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(0, 6, 0, 6),
                    child: Text("Individuals",
                        style:
                            TextStyle(fontWeight: FontWeight.w500, fontSize: 14)),
                  ),
                  Text("Fleets",
                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14))
                ],
              ),
            ),
          ),
        )
      ]),
    );
  }
}
