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
      builder: (context) => Container(
        padding: EdgeInsets.all(15),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Flex(
            direction: Axis.horizontal,
            children: [
              Text(
                key: 1,
                "Select Item",
              ),
              IconButton(onPressed: () {}, icon: Icon(Icons.close))
            ],
          )
        ]),
      ),
    );
  }
}
