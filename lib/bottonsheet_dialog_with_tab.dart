import 'dart:convert';

import 'package:azlistview/azlistview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lpinyin/lpinyin.dart';

import 'models.dart';

class BottomSheetDialogTabDemo extends StatefulWidget {
  const BottomSheetDialogTabDemo({Key? key}) : super(key: key);

  @override
  BottomSheetDialogTabDemoState createState() =>
      BottomSheetDialogTabDemoState();
}

class BottomSheetDialogTabDemoState extends State<BottomSheetDialogTabDemo> {
  int selectedTabIndex = 0;
  List<ContactInfo> allUsersData = [];
  List<ContactInfo> allItems = [];
  List<ContactInfo> displayItems = [];
  double susItemHeight = 40;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    rootBundle.loadString('assets/data/contacts.json').then((value) {
      List list = json.decode(value);
      for (var v in list) {
        allUsersData.add(ContactInfo.fromJson(v));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bottom Sheet Dialog"),
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
              child: const Text(
                "Simple",
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
            ),
            MaterialButton(
              onPressed: () {},
              color: Colors.green,
              child: const Text(
                "Fulll Screen",
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
            ),
            MaterialButton(
              onPressed: () {},
              color: Colors.green,
              child: const Text(
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
    selectedTabIndex = 0;
    setCustomerItems();
    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      /* shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),*/
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (BuildContext context, StateSetter setModalState) =>
            DraggableScrollableSheet(
          initialChildSize: 0.9,
          maxChildSize: 0.9,
          minChildSize: 0.5,
          builder: (BuildContext context, ScrollController scrollController) =>
              Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
            child: Column(mainAxisSize: MainAxisSize.max, children: [
              Container(
                decoration: BoxDecoration(
                    color: Color(0xffECF2FE),
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20))),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Text(
                          "Select Customer",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              fontFamily: 'PlusJakartaSans'),
                        ),
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
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                child: TextField(
                  onChanged: (value) {
                    setModalState(() {
                      filterSearchResults(value);
                    });
                  },
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(0, 2, 14, 0),
                    prefixIcon: Icon(Icons.search, color: Colors.black26),
                    border: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xffbab8b8), width: 1.3),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xffbab8b8), width: 1.3),
                    ),
                    hintText: 'Search',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          flex: 4,
                          child: Container(
                            decoration: (selectedTabIndex == 0)
                                ? const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(6)),
                                  )
                                : null,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 9, 0, 9),
                              child: GestureDetector(
                                onTap: () {
                                  print("All click");
                                  selectedTabIndex = 0;
                                  setCustomerItems();
                                  setModalState(() {});
                                },
                                child: const Text("All",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14)),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: Container(
                            decoration: (selectedTabIndex == 1)
                                ? const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(6)),
                                  )
                                : null,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 9, 0, 9),
                              child: GestureDetector(
                                onTap: () {
                                  print("Individuals click");
                                  selectedTabIndex = 1;
                                  setCustomerItems();
                                  setModalState(() {});
                                },
                                child: const Text("Individuals",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14)),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Container(
                            decoration: (selectedTabIndex == 2)
                                ? const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(6)),
                                  )
                                : null,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 9, 0, 9),
                              child: GestureDetector(
                                onTap: () {
                                  selectedTabIndex = 2;
                                  setCustomerItems();
                                  setModalState(() {});
                                },
                                child: const Text("Fleets",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14)),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 12,),
              Expanded(
                flex: 1,
                child: AzListView(
                  data: displayItems,
                  itemCount: displayItems.length,
                  itemBuilder: (BuildContext context, int index) {
                    // if (index == 0) return _buildHeader();
                    ContactInfo model = displayItems[index];
                    return _buildListItem(model);
                  },
                  physics: const BouncingScrollPhysics(),
                  indexBarData: SuspensionUtil.getTagIndexList(displayItems),
                  indexHintBuilder: (context, hint) {
                    return Container(
                      alignment: Alignment.center,
                      width: 60.0,
                      height: 60.0,
                      decoration: BoxDecoration(
                        color: Colors.blue[700]!.withAlpha(200),
                        shape: BoxShape.circle,
                      ),
                      child: Text(hint,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 30.0)),
                    );
                  },
                  indexBarMargin: const EdgeInsets.all(10),
                  indexBarOptions: IndexBarOptions(
                    needRebuild: true,
                    decoration: getIndexBarDecoration(Colors.grey[50]!),
                    downDecoration: getIndexBarDecoration(Colors.grey[200]!),
                  ),
                ),
              ),
              Visibility(
                visible: (selectedTabIndex == 0 || selectedTabIndex == 1),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: MaterialButton(
                      onPressed: () {

                      },
                      color: Color(0xff1D67F1),
                      elevation: 0,
                      height: 48,
                      splashColor: Colors.white.withAlpha(30),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4)),
                      child: Text("ADD NEW CUSTOMER",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'PlusJakartaSans',
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          )),
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: (selectedTabIndex == 2),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: MaterialButton(
                      onPressed: () {

                      },
                      color: Color(0xff1D67F1),
                      elevation: 0,
                      height: 48,
                      splashColor: Colors.white.withAlpha(30),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4)),
                      child: Text("ADD NEW FLEETS",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'PlusJakartaSans',
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          )),
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }

  void setCustomerItems() {
    allItems.clear();
    displayItems.clear();
    if (selectedTabIndex == 0) {
      for (var info in allUsersData) {
        allItems.add(info);
      }
    } else if (selectedTabIndex == 1) {
      for (var info in allUsersData) {
        if (!info.isFleets!) {
          allItems.add(info);
        }
      }
    } else if (selectedTabIndex == 2) {
      for (var info in allUsersData) {
        if (info.isFleets!) {
          allItems.add(info);
        }
      }
    }
    displayItems.addAll(allItems);
    _handleList(displayItems);
  }

  void _handleList(List<ContactInfo> list) {
    if (list.isEmpty) return;
    for (int i = 0, length = list.length; i < length; i++) {
      String pinyin = PinyinHelper.getPinyinE(list[i].name);
      String tag = pinyin.substring(0, 1).toUpperCase();
      list[i].namePinyin = pinyin;
      if (RegExp("[A-Z]").hasMatch(tag)) {
        list[i].tagIndex = tag;
      } else {
        list[i].tagIndex = "#";
      }
    }
    // A-Z sort.
    SuspensionUtil.sortListBySuspensionTag(displayItems);

    // show sus tag.
    SuspensionUtil.setShowSuspensionStatus(displayItems);

    // add header.
    // _contacts.insert(0, ContactInfo(name: 'header', tagIndex: '↑'));

    setState(() {});
  }

  Widget _buildSusWidget(String susTag) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      height: susItemHeight,
      width: double.infinity,
      alignment: Alignment.centerLeft,
      child: Row(
        children: <Widget>[
          Text(
            '$susTag',
            textScaleFactor: 1.2,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const Expanded(
              child: Divider(
            height: .0,
            indent: 10.0,
          ))
        ],
      ),
    );
  }

  Widget _buildListItem(ContactInfo model) {
    String susTag = model.getSuspensionTag();
    return Column(
      children: <Widget>[
        Offstage(
          offstage: model.isShowSuspension != true,
          child: _buildSusWidget(susTag),
        ),
        ListTile(
          dense: true,
          contentPadding:
              const EdgeInsets.only(left: 16, right: 16, top: 0, bottom: 0),
          // leading: CircleAvatar(
          //   backgroundColor: Colors.blue[700],
          //   child: Text(
          //     model.name[0],
          //     style: TextStyle(color: Colors.white),
          //   ),
          // ),
          title: Text(
            model.name,
            style: const TextStyle(color: Color(0xff828282)),
          ),
          onTap: () {
            print("OnItemClick: $model");
            // Navigator.pop(context, model);
          },
        )
      ],
    );
  }

  Decoration getIndexBarDecoration(Color color) {
    return BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(color: Colors.grey[300]!, width: .5));
  }

  void filterSearchResults(String query) {
    List<ContactInfo> dummySearchList = <ContactInfo>[];
    dummySearchList.addAll(allItems);
    if (query.isNotEmpty) {
      List<ContactInfo> dummyListData = <ContactInfo>[];
      for (var item in dummySearchList) {
        if (item.name.toLowerCase().contains(query.toLowerCase())) {
          dummyListData.add(item);
        }
      }
      setState(() {
        displayItems.clear();
        displayItems.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        displayItems.clear();
        displayItems.addAll(allItems);
      });
    }
    _handleList(displayItems);
    print(displayItems.length);
  }
}
