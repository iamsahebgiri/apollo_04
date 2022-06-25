import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ghumo/home/places.dart';
import 'package:permission_handler/permission_handler.dart';

import '../global/global.dart';

class MainHomePage extends StatefulWidget {
  const MainHomePage({Key? key}) : super(key: key);

  @override
  State<MainHomePage> createState() => _MainHomePageState();
}

//await sharedPreferences!.setBool("user", false);
// // Navigator.pushAndRemoveUntil(
// //   context,
// //   MaterialPageRoute(builder: (context) => const SplashScreen()),
// //   (route) => false,
// // );

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
    requestPermission();
  }

  requestPermission() async {
    // ignore: avoid_print
    print("Asking Permission");
    await [
      Permission.location,
    ].request();
    checkForPermission();
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
      ],
    );

    final tabs = [
      "Places",
      "Restaurants",
      "Hotels",
    ];
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
                  indicator: const BoxDecoration(
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
                        Expanded(
                          child: GridView.count(
                            crossAxisCount: 2,
                            children: List.generate(10, (index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 50.0,
                                  width: 50.0,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20.0),
                                    ),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20.0),
                                    child: Image.asset(
                                      "assets/images/a.jpg",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),
                        )
                        // ListView.builder(
                        //   shrinkWrap: true,
                        //     itemCount: 5,
                        //     itemBuilder: (BuildContext context, int index) {
                        //       return ListView(
                        //         children: const [
                        //           Card(
                        //               child: ListTile(
                        //             title: Text("List Item 1"),
                        //           )),
                        //           Card(
                        //             child: ListTile(
                        //               title: Text("List Item 2"),
                        //             ),
                        //           ),
                        //           Card(
                        //               child: ListTile(
                        //             title: Text("List Item 3"),
                        //           )),
                        //         ],
                        //       );
                        //     })
                        // ListView.builder(
                        //   itemBuilder: ((context, index) {
                        //     return Container(
                        //       height: 50,
                        //       width: double.infinity,
                        //       decoration: const BoxDecoration(
                        //         color: Colors.red,
                        //       ),
                        //     );
                        //   }),
                        //   itemCount: 10,
                        // ),
                        // )
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

  var currentLocation;

  void checkForPermission() {
    Geolocator.getCurrentPosition().then((currrloc) async {
      currentLocation = currrloc;
      print(currentLocation.latitude);
      print(currentLocation.longitude);
      await sharedPreferences!.setDouble("lat", currentLocation.latitude);
      await sharedPreferences!.setDouble("long", currentLocation.longitude);
    });
  }
}
