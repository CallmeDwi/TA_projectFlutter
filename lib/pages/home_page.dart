import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perhutaniwisata_app/cubit/app_cubit.dart';
import 'package:perhutaniwisata_app/cubit/app_cubit_states.dart';
import 'package:perhutaniwisata_app/pages/drawer_pages/drawer.dart';
import 'package:perhutaniwisata_app/widgets/app_large_text.dart';
import 'package:perhutaniwisata_app/widgets/app_text.dart';

import 'profile_pages/profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late TabController _tabController;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  var images = {
    "bukit.jpeg": "Bukit",
    "danau.jpg": "Danau",
    "welcome-3.jpg": "Air Terjun",
    "hutan_wisata.jpeg": "Hutan Wisata"
  };

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  void goToProfilePage() {
    Navigator.pop(context);
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ProfilePage(),
        ));
  }

  void signOut() {
    // Define your sign-out logic here.
    // For example, if you're using Firebase Authentication, you can do:
    // FirebaseAuth.instance.signOut();

    // For now, let's just print a message.
    print("User signed out");
    // You might want to navigate to a login screen after signing out
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: MyDrawer(
        onProfileTap: goToProfilePage,
        onSignOut: signOut,
      ),
      body: BlocBuilder<AppCubits, CubitStates>(
        builder: (context, state) {
          if (state is LoadedState) {
            var info = state.places;
            return SafeArea(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(top: 70, left: 20),
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {
                              _scaffoldKey.currentState?.openDrawer();
                            },
                            child: Icon(
                              Icons.menu,
                              size: 30,
                              color: Colors.black54,
                            ),
                          ),
                          Expanded(
                              child: Container(
                                  // child: Icon(Icons.verified_user),
                                  )),
                          Container(
                            margin: const EdgeInsets.only(right: 20),
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey.withOpacity(0.5),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 30),
                    Container(
                      margin: const EdgeInsets.only(left: 20),
                      child: AppLargeText(text: "Discover"),
                    ),
                    SizedBox(height: 30),
                    Container(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: TabBar(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          controller: _tabController,
                          labelColor: Colors.black,
                          unselectedLabelColor: Colors.grey,
                          isScrollable: true,
                          indicatorSize: TabBarIndicatorSize.label,
                          indicator: CircleTabIndicator(
                              color: Colors.black, radius: 4),
                          tabs: [
                            Tab(text: "Places"),
                            Tab(text: "Inspiration"),
                            Tab(text: "Emotions"),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 20),
                      height: 300,
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          ListView.builder(
                            physics: BouncingScrollPhysics(),
                            itemCount: info.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () {
                                  BlocProvider.of<AppCubits>(context)
                                      .detailPage(info[index]);
                                },
                                child: Container(
                                  margin:
                                      const EdgeInsets.only(right: 15, top: 10),
                                  width: 200,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white,
                                    image: DecorationImage(
                                      image: NetworkImage(info[index].img),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                          ListView.builder(
                            physics: BouncingScrollPhysics(),
                            itemCount: info.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () {
                                  BlocProvider.of<AppCubits>(context)
                                      .detailPage(info[index]);
                                },
                                child: Container(
                                  margin:
                                      const EdgeInsets.only(right: 15, top: 10),
                                  width: 200,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white,
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          "https://cdn.antaranews.com/cache/1200x800/2014/05/20140504Hujan-Abu-Vulkanik-040514-ol-2.jpg.webp"),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                          ListView.builder(
                            physics: BouncingScrollPhysics(),
                            itemCount: info.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () {
                                  BlocProvider.of<AppCubits>(context)
                                      .detailPage(info[index]);
                                },
                                child: Container(
                                  margin:
                                      const EdgeInsets.only(right: 15, top: 10),
                                  width: 200,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white,
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          "https://static.promediateknologi.id/crop/0x0:0x0/750x500/webp/photo/p1/43/2024/04/18/indrasutantoo_171341025972364-1-2407333488.jpg"),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 30),
                    Container(
                      margin: const EdgeInsets.only(left: 20, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppLargeText(
                            text: "Explore More",
                            size: 22,
                          ),
                          AppText(
                            text: "See all",
                            size: 16,
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Container(
                        width: MediaQuery.sizeOf(context).width,
                        height: 100,
                        margin: const EdgeInsets.only(left: 20),
                        child: ListView.builder(
                          physics: BouncingScrollPhysics(),
                          itemCount: 4,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (_, index) {
                            return Container(
                              margin: const EdgeInsets.only(right: 30),
                              child: Column(
                                children: [
                                  Container(
                                    width: 80,
                                    height: 80,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.black,
                                      image: DecorationImage(
                                        image: AssetImage("img/" +
                                            images.keys.elementAt(index)),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    child: AppText(
                                      text: images.values.elementAt(index),
                                      size: 13,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

class CircleTabIndicator extends Decoration {
  final Color color;
  final double radius;
  CircleTabIndicator({required this.color, required this.radius});

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _CirclePainter(color: color, radius: radius);
  }
}

class _CirclePainter extends BoxPainter {
  final Color color;
  final double radius;
  _CirclePainter({required this.color, required this.radius});

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    Paint _paint = Paint();
    _paint.color = color;
    _paint.isAntiAlias = true;

    // Perform a null check on configuration.size
    final double? width = configuration.size?.width;
    final double? height = configuration.size?.height;

    if (width != null && height != null) {
      final Offset circleOffset =
          Offset(width / 2 - radius / 2, height - radius);
      canvas.drawCircle(offset + circleOffset, radius, _paint);
    }
  }
}
