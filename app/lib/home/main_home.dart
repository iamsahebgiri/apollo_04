import 'package:flutter/material.dart';
import 'package:ghumo/home/places.dart';

import '../global/global.dart';
import '../splash/splash.dart';

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
    final size = MediaQuery.of(context).size;
    const drawerHeader = UserAccountsDrawerHeader(
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

    final drawerItems = ListView(
      children: [
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
        ListTile(
          title: const Text("Log out"),
          leading: const Icon(Icons.logout),
          onTap: () async {
            await sharedPreferences!.setBool("user", false);
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const SplashScreen()),
              (route) => false,
            );
          },
        ),
      ],
    );

    final tabs = [
      "Places",
      "Restaurants",
      "Hotels",
    ];

    Widget PlaceVertical(title, image) {
      return AspectRatio(
        aspectRatio: 4 / 6,
        child: Container(
          margin: const EdgeInsets.only(right: 8.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            image:
                DecorationImage(fit: BoxFit.cover, image: NetworkImage(image)),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              gradient: LinearGradient(
                begin: Alignment.bottomRight,
                stops: const [0.1, 0.9],
                colors: [
                  Colors.black.withOpacity(.8),
                  Colors.black.withOpacity(.1)
                ],
              ),
            ),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  title,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ),
        ),
      );
    }

    return Scaffold(
        key: _scaffoldKey,
        drawer: Drawer(child: drawerItems),
        body: SafeArea(
            child: Container(
          color: Colors.blueGrey.shade50,
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              SizedBox(
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
                      color: Colors.deepPurple.shade100,
                      border: Border.all(width: 2.0, color: Colors.deepPurple),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(99.0))),
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
                        const PlacesTab(),
                        const SizedBox(
                          height: 20.0,
                        ),
                        const Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'More places to visit',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Expanded(
                          child: GridView.count(
                            crossAxisCount: 2,
                            children: List.generate(10, (index) {
                              return PlaceVertical("Test ",
                                  "https://images.unsplash.com/photo-1554121347-0f1f876bad19?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80");
                            }),
                          ),
                        ),
                      ],
                    ),
                    const Center(
                      child: Text(
                        'Restaurants',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),

                    // second tab bar view widget
                    const Center(
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
