import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:teeka/Widgets/styles.dart';
import 'package:teeka/Widgets/title.dart';

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
                  fontSize: 20.0,
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
                        fontSize: 20.0,
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
    return Container();
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
          style: Styles(context).title(),
        ),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: parentsBody(),
      bottomNavigationBar: tabBar,
    );
  }
}
