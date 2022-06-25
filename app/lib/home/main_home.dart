import 'package:flutter/material.dart';
import 'package:ghumo/home/places.dart';

class MainHomePage extends StatefulWidget {
  const MainHomePage({Key? key}) : super(key: key);

  @override
  State<MainHomePage> createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage>
    with SingleTickerProviderStateMixin, RestorationMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  late TabController _tabController;

  final RestorableInt tabIndex = RestorableInt(0);

  @override
  String get restorationId => 'tab_non_scrollable_demo';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(tabIndex, 'tab_index');
    _tabController.index = tabIndex.value;
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      initialIndex: 0,
      length: 3,
      vsync: this,
    );
    _tabController.addListener(() {
      // When the tab controller's value is updated, make sure to update the
      // tab index value, which is state restorable.
      setState(() {
        tabIndex.value = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    tabIndex.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final drawerHeader = const UserAccountsDrawerHeader(
      decoration: BoxDecoration(color: Colors.deepPurple),
      accountName: Text(
        "Saheb Giri",
      ),
      accountEmail: Text(
        "iamsahebgiri@gmail.com",
      ),
      currentAccountPicture: CircleAvatar(
        child: FlutterLogo(size: 42.0),
      ),
    );

    final drawerItems = ListView(children: [
      drawerHeader,
      ListTile(
        title: const Text(
          "Wallet",
        ),
        leading: const Icon(Icons.account_balance_wallet),
        onTap: () {
          Navigator.pop(context);
        },
      ),
      ListTile(
        title: const Text("Settings"),
        leading: const Icon(Icons.comment),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    ]);

    final tabs = ["Places", "Restaurants", "Hotels"];
    return Scaffold(
        key: _scaffoldKey,
        drawer: Drawer(child: drawerItems),
        body: SafeArea(
            child: Container(
          color: Colors.blueGrey.shade50,
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              Container(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: Colors.white),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.menu,
                          color: Colors.deepPurple,
                        ),
                        onPressed: () {
                          print("your menu action here");
                          _scaffoldKey.currentState!.openDrawer();
                        },
                      ),
                      const Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                              hintText: "Search places, restaurants",
                              border: InputBorder.none,
                              hintStyle: TextStyle(color: Colors.grey)),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.account_balance_wallet_rounded,
                          color: Colors.deepPurple,
                        ),
                        onPressed: () {
                          print("your menu action here");
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: TabBar(
                  controller: _tabController,
                  isScrollable: false,
                  // give the indicator a decoration (color and border radius)
                  indicator: BoxDecoration(
                    border: Border(
                        bottom:
                            BorderSide(color: Colors.deepPurple, width: 3.0)),
                    // color: Colors.deepPurple,
                  ),
                  labelColor: Colors.deepPurple,
                  unselectedLabelColor: Colors.black,
                  tabs: [for (final tab in tabs) Tab(text: tab)],
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    // first tab bar view widget
                    Column(
                      children: <Widget>[
                        PlacesTab(),
                        SizedBox(
                          height: 20.0,
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'More places to visit',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Center(
                      child: Text(
                        'Restaurants',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),

                    // second tab bar view widget
                    Center(
                      child: Text(
                        'Hotels',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )));
  }
}
