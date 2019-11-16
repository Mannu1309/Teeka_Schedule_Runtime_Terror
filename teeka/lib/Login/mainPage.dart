import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:teeka/Parents/signUp.dart' as startup;
import 'package:teeka/Widgets/styles.dart';
import 'package:teeka/Widgets/widgets.dart';
import 'package:teeka/Doctor/signUp.dart' as govt;

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {
  TabController controller;
  @override
  void initState() {
    super.initState();
    controller = new TabController(
      length: 2,
      vsync: this,
    );
  }

  Widget tabCard(Widget widget) {
    return Card(
      margin: EdgeInsets.symmetric(
        horizontal: 15.0,
        vertical: MediaQuery.of(context).size.height * 0.1,
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: widget,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: stackBg(
        widget: TabBarView(
          controller: controller,
          children: <Widget>[
            tabCard(
              startup.SignUp(),
            ),
            tabCard(
              govt.SignUp(),
            ),
          ],
        ),
        context: context,
      ),
      bottomNavigationBar: TabBar(
        indicatorSize: TabBarIndicatorSize.label,
        indicatorWeight: 3.0,
        controller: controller,
        unselectedLabelStyle: Styles(context).title().merge(
              TextStyle(
                fontSize: 14.0,
              ),
            ),
        labelStyle: Styles(context).title().merge(
              TextStyle(
                fontSize: 14.0,
              ),
            ),
        labelColor: Theme.of(context).primaryColor,
        tabs: <Widget>[
          Tab(
            child: Text("Parents"),
            icon: Icon(
              Icons.people,
            ),
          ),
          Tab(
            child: Text("Doctors"),
            icon: Icon(
              FontAwesomeIcons.ambulance,
            ),
          ),
        ],
      ),
    );
  }
}
