import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:teeka/Parents/child.dart';
import 'package:teeka/Widgets/styles.dart';
import 'package:teeka/Widgets/title.dart';
import 'package:teeka/Widgets/title.dart' as prefix0;

import '../Widgets/widgets.dart';

List<Month> allMonths = [];
List<String> questions = [];

class Month {
  String number, doses;
  List vaccines = [];

  Month(this.number, this.doses, this.vaccines);
}

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard>
    with SingleTickerProviderStateMixin {
  TabBar tabBar;
  TabController controller;
  List<TableRow> tableRow = [];

  var json;
  @override
  void initState() {
    super.initState();
    controller = new TabController(length: 3, vsync: this);
    initJson();
    allMonths = [];
    tabBar = new TabBar(
      controller: controller,
      unselectedLabelColor: Colors.grey.shade400,
      labelColor: Colors.deepPurple,
      indicatorColor: Colors.deepOrange,
      indicatorSize: TabBarIndicatorSize.label,
      tabs: <Widget>[
        Tab(
          icon: Icon(
            FontAwesomeIcons.home,
          ),
          text: "Home",
        ),
        Tab(
          child: Column(
            children: <Widget>[
              Image.asset(
                'assets/symbol.png',
                alignment: Alignment.center,
                height: 42.0,
              ),
            ],
          ),
        ),
        Tab(
          icon: Icon(Icons.people),
          text: "Profile",
        ),
      ],
    );
  }

  initJson() async {
    json = await DefaultAssetBundle.of(context).loadString('assets/vacc.json');
    var decodedJson = jsonDecode(json);

    // var mainData = decodedJson['months'];
    decodedJson['months'].forEach((var v) {
      // print(v['month']);
      // print(v);
      allMonths.add(new Month(
          v['month'].toString(), v['doseNo'].toString(), v['vacName']));
    });
    print(allMonths.length);
    allMonths.forEach((Month m) {
      tableRow.add(TableRow(decoration: BoxDecoration(), children: [
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          // verticalAlignment: TableCellVerticalAlignment.fill,
          child: Center(
            child: Text(
              (int.parse(m.number) > 12)
                  ? (int.parse(m.number) / 12).toString() + " Years"
                  : m.number + " Months",
              textAlign: TextAlign.center,
              style: Styles(context).title().copyWith(
                    color: Colors.grey.shade400,
                  ),
            ),
          ),
        ),
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          // verticalAlignment: TableCellVerticalAlignment.fill,
          child: Center(
              child: Text(
            m.vaccines
                .toString()
                .split('|')
                .toList()
                .toString()
                .replaceAll("[", "")
                .replaceAll("]", ""),
            textAlign: TextAlign.center,
            style: Styles(context).title().copyWith(
                  color: Colors.grey.shade400,
                ),
          )),
        ),
      ]));
    });
    setState(() {});
  }

  Widget ques() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        gradient: LinearGradient(
          colors: [
            Theme.of(context).primaryColor,
            Theme.of(context).accentColor,
          ],
        ),
      ),
      child: Column(
        children: <Widget>[
          Card(
            child: padding(
              formFields(
                  context: context,
                  controller: TextEditingController(),
                  hintText: "Please ask your query here",
                  validator: (String) {
                    return null;
                  }),
            ),
          ),
          padding(
            FlatButton(
              child: Text(
                "Post your query",
                style: TextStyle(color: Theme.of(context).cardColor),
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }

  Widget table() {
    return Table(
      border: TableBorder.all(color: Colors.grey.shade200),
      children: <TableRow>[
            TableRow(children: [
              TableCell(
                  verticalAlignment: TableCellVerticalAlignment.middle,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.05,
                    child: Center(
                      child: Text(
                        "Age (Months/Years)",
                        textAlign: TextAlign.center,
                        style: Styles(context).title().copyWith(
                              color: Colors.grey.shade900,
                            ),
                      ),
                    ),
                  )),
              TableCell(
                  verticalAlignment: TableCellVerticalAlignment.middle,
                  child: Center(
                    child: Text(
                      "Vaccines",
                      textAlign: TextAlign.center,
                      style: Styles(context).title().copyWith(
                            color: Colors.grey.shade900,
                          ),
                    ),
                  )),
              // TableCell(
              //     verticalAlignment: TableCellVerticalAlignment.middle,
              //     child: Center(
              //       child: Text(
              //         "Months/Years at which the vaccine is to be given",
              //         textAlign: TextAlign.center,
              //         style: Styles(context).title().copyWith(
              //               color: Colors.grey.shade800,
              //             ),
              //       ),
              //     )),
            ]),
          ] +
          (tableRow),
    );
  }

  Widget buttonV() {
    return FlatButton(
      onPressed: () {
        showDialog(
            context: context,
            builder: (context) {
              return SimpleDialog(
                title: title(
                  text: "Vaccine1",
                  context: context,
                ),
                children: <Widget>[],
              );
            });
      },
      child: Card(
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.1,
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                "Vaccine 1",
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget schemes() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Card(
              elevation: 10.0,
              child: Center(
                child: Image.network(
                  // 'assets/dashboard.jpg',
                  "https://pbs.twimg.com/media/CVGC3qeUwAARSb0.jpg",
                  alignment: Alignment.center,
                  // height: MediaQuery.of(context).size.height * 0.30,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ques(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30.0),
            child: table(),
          )
          // Text(
          //   "Children Age : 10",
          //   style: Styles(context).title().copyWith(
          //         fontSize: 16.0,
          //         fontWeight: FontWeight.w500,
          //       ),
          // ),
          // Padding(
          //   padding: const EdgeInsets.all(10.0),
          //   child: Column(
          //     children: <Widget>[
          //       Text(
          //         "Pending Vacinations:",
          //         style: Styles(context).title().copyWith(
          //               fontSize: 14.0,
          //               fontWeight: FontWeight.w500,
          //             ),
          //       ),
          //       buttonV(),
          //       buttonV(),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget vaccines() {
    return MaintainVaccines();
  }

  Widget profile() {
    return Profile();
  }

  @override
  Widget build(BuildContext context) {
    Widget parentsBody() {
      return TabBarView(
        controller: controller,
        children: <Widget>[
          schemes(),
          vaccines(),
          profile(),
        ],
        physics: BouncingScrollPhysics(),
      );
    }

    return Scaffold(
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   title: Text(
      //     "Parents Dashboard",
      //     style: Styles(context).title().copyWith(fontSize: 18.0),
      //   ),
      //   elevation: 0.0,
      //   backgroundColor: Colors.transparent,
      // ),
      body: parentsBody(),
      bottomNavigationBar: tabBar,
    );
  }
}

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Widget detailsTile(String prop, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            prop,
            style: Styles(context).title().copyWith(
                  color: Colors.grey.shade400,
                ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            value,
            style:
                Styles(context).title().copyWith(color: Colors.grey.shade600),
          ),
        )
      ],
    );
  }

  Widget card() {
    return Card(
      margin: EdgeInsets.all(20.0).add(EdgeInsets.only(top: 20)),
      child: Column(
        children: <Widget>[
          detailsTile("Name :", "Simarjeet Kaur"),
          detailsTile("Age :", "35"),
          detailsTile("Gender :", "Female"),
          detailsTile("Profession :", "IT Professor"),
          detailsTile("Income :", "6 lpa"),
          detailsTile("Address :", "Patiala, Punjab"),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        card(),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              title: Text(
                "Add child details",
                style: Styles(context).title().copyWith(fontSize: 15.0),
              ),
              trailing: Icon(
                Icons.add,
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => StudentForm()));
              },
            ),
          ),
        ),
      ],
    );
  }
}

class StudentForm extends StatefulWidget {
  @override
  _StudentFormState createState() => _StudentFormState();
}

class _StudentFormState extends State<StudentForm> {
  String selectedG;
  DateTime date;

  TextEditingController sname,
      cname,
      age,
      dob,
      city,
      state,
      birthweight,
      vaccines,
      deliverytype,
      sector;

  @override
  void initState() {
    super.initState();
    cname = new TextEditingController();
    dob = new TextEditingController();
    state = new TextEditingController();
    city = new TextEditingController();
    birthweight = new TextEditingController();
    vaccines = new TextEditingController();
    sector = new TextEditingController();
  }

  Widget gender() {
    return new DropdownButton<String>(
      hint: Text(
        "Gender *",
        style: Styles(context).subTitle().copyWith(
              color: Colors.grey.shade600,
            ),
      ),
      value: selectedG,
      style: Styles(context).subTitle().copyWith(
            color: Colors.grey.shade700,
          ),
      items: <String>[
        'Male',
        'Female',
      ].map((String value) {
        return new DropdownMenuItem<String>(
          value: value,
          child: Padding(
            padding: const EdgeInsets.all(
              8.0,
            ),
            child: new Text(
              value,
            ),
          ),
        );
      }).toList(),
      onChanged: (String str) {
        selectedG = str;
        setState(() {});
      },
    );
  }

  onDateClick() {
    showDatePicker(
      context: context,
      initialDate: date != null ? date : DateTime(DateTime.now().year),
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year),
    ).then((DateTime date) {
      print(date);
      date = date;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      appBar: AppBar(
        title: Text(
          "Add Child Details",
          style: Styles(context).title().copyWith(fontSize: 18.0),
        ),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Center(
        child: Card(
          elevation: 10.0,
          margin: EdgeInsets.all(10.0),
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              padding(
                formFields(
                    context: context,
                    controller: cname,
                    hintText: "Name",
                    validator: (String) {
                      return null;
                    }),
              ),
              padding(
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    padding(
                      gender(),
                    ),
                    padding(
                      FlatButton(
                        child: Text(
                          date == null
                              ? "Date of Birth *"
                              : (date.day.toString() +
                                  "/" +
                                  date.month.toString() +
                                  "/" +
                                  date.year.toString()),
                          textAlign: TextAlign.left,
                          style: Styles(context).subTitle().copyWith(
                                color: Colors.grey.shade600,
                              ),
                        ),
                        onPressed: () {
                          onDateClick();
                        },
                      ),
                    ),
                  ],
                ),
              ),
              padding(
                formFields(
                    context: context,
                    controller: birthweight,
                    hintText: "Birth Weight",
                    validator: (String) {
                      return null;
                    }),
              ),
              padding(
                formFields(
                    context: context,
                    controller: deliverytype,
                    hintText: "Deliver Type",
                    validator: (String) {
                      return null;
                    }),
              ),
              padding(
                formFields(
                    context: context,
                    controller: vaccines,
                    hintText: "Vaccines Already Done",
                    validator: (String) {
                      return null;
                    }),
              ),
              padding(
                button(
                  context: context,
                  function: () {},
                  text: "Add Child Details",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MaintainVaccines extends StatefulWidget {
  @override
  _MaintainVaccinesState createState() => _MaintainVaccinesState();
}

class _MaintainVaccinesState extends State<MaintainVaccines> {
  List<int> truefalse = [];
  var dict = {};
  @override
  void initState() {
    truefalse = [];
    allMonths = [];
    super.initState();
    loadJson();
  }

  loadJson() async {
    var json;
    json = await DefaultAssetBundle.of(context).loadString('assets/vacc.json');
    var decodedJson = jsonDecode(json);
    decodedJson['months'].forEach((var v) {
      // truefalse.add(false);
      allMonths.add(new Month(
          v['month'].toString(), v['doseNo'].toString(), v['vacName']));
    });

    print(allMonths.length);
    setState(() {});
  }

  int count = 0;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        Month m = allMonths[index];
        List<Widget> tiles = [];
        m.vaccines.forEach((var v) {
          count++;
          tiles.add(
            CheckboxListTile(
              title: prefix0.title(text: v, context: context),
              onChanged: (bool b) {
                if (b) {
                  print("Added");
                  truefalse.add(count);
                } else {
                  print("REmoved");
                  truefalse.remove(count);
                }
                print(truefalse.contains(count));
                setState(() {});
              },
              value: truefalse.contains(count),
              
            ),
          );
        });
        return ExpansionTile(
          title: Text(
            (int.parse(m.number) > 12)
                ? (int.parse(m.number) / 12).toString() + " Years"
                : m.number + " Months",
            textAlign: TextAlign.center,
            style: Styles(context).title().copyWith(
                  color: Colors.grey.shade400,
                ),
          ),
          onExpansionChanged: (bool b) {
            // truefalse[index] = b;
            if (b) {}
            setState(() {});
          },
          children: tiles,
        );
      },
      itemCount: allMonths.length,
    );
  }
}
