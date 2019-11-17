import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:teeka/Widgets/styles.dart';
import 'package:teeka/Widgets/title.dart';

import '../Widgets/widgets.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard>
    with SingleTickerProviderStateMixin {
  TabBar tabBar;
  TabController controller;
  @override
  void initState() {
    super.initState();
    controller = new TabController(length: 2, vsync: this);
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
          icon: Icon(Icons.people),
          text: "Profile",
        ),
      ],
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Image.asset(
                'assets/dashboard.jpg',
                alignment: Alignment.center,
                height: MediaQuery.of(context).size.height * 0.20,
              ),
            ),
          ),
          Text(
            "Children Age : 10",
            style: Styles(context).title().copyWith(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                Text(
                  "Pending Vacinations:",
                  style: Styles(context).title().copyWith(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                      ),
                ),
                buttonV(),
                buttonV(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget schemeCard() {

  // }

  Widget vaccines() {
    return Container();
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
          profile(),
        ],
        physics: BouncingScrollPhysics(),
      );
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Parents Dashboard",
          style: Styles(context).title().copyWith(
            fontSize: 18.0
          ),

        ),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
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
  Widget detailsTile(String prop, String value){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(prop, style: Styles(context).title(),),
        ), 
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(value,style: Styles(context).title(),),
        )
      ],
    );
  }
  @override
  Widget build(BuildContext context) {
    return ListView(
     children: <Widget>[
       ListTile(
         title: Text("Add child details"),
         trailing: Icon(Icons.add),
         onTap: (){
           Navigator.push(context, MaterialPageRoute(
            builder: (context)=>StudentForm() 
           ));
         },
       ),
       detailsTile("Name :", "Aman"),
       detailsTile("Age :", "20"),
       detailsTile("Gender :", "Male"),
       detailsTile("Date Of Birth :", "18-01-1999"),
       detailsTile("Profession :", "Student"),
       detailsTile("Income :", "Income"),
       detailsTile("Address :", "City, State"),

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
      appBar:AppBar(title: Text(
        "Add Child Details",
        style: Styles(context).title().copyWith(
            fontSize: 18.0
          ),
      ),
      elevation: 0.0,backgroundColor: Colors.transparent,
      iconTheme: IconThemeData(color: Colors.black),),
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
                        controller: new  TextEditingController(),
                        hintText: "Name",
                        validator: (String ) {return null;}
                      ),
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
                        controller: new  TextEditingController(),
                        hintText: "Birth Weight",
                        validator: (String ) {return null;}
                        
                      ),
                    ),
                    padding(
                      formFields(
                        context: context,
                        controller: new  TextEditingController(),
                        hintText: "Deliver Type",
                        validator: (String ) {return null;}
                        
                      ),
                    ),
                    padding(
                      formFields(
                        context: context,
                        controller: new  TextEditingController(),
                        hintText: "Vaccines Already Done",
                        validator: (String ) {return null;}
                        
                      ),
                    ),
                    padding(
                      button(
                        context: context,
                        function: (){},
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