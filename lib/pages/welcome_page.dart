import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perhutaniwisata_app/cubit/app_cubit.dart';
import 'package:perhutaniwisata_app/widgets/app_large_text.dart';
import 'package:perhutaniwisata_app/widgets/app_text.dart';
import 'package:perhutaniwisata_app/widgets/responsive_button.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  List<String> images = [
    "welcome-1.jpg",
    "welcome5.jpg",
    "welcome6.jpg",
  ];

  PageController _pageController = PageController();
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      if (_pageController.page == images.length) {
        _pageController.jumpToPage(0);
      } else {
        _pageController.nextPage(
          duration: Duration(milliseconds: 400),
          curve: Curves.easeIn,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            scrollDirection: Axis.vertical,
            itemCount:
                images.length + 1, // add one more item for the dummy page
            itemBuilder: (_, index) {
              if (index == images.length) {
                return Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.grey, // dummy page color
                );
              }
              return Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("img/" + images[index]),
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
            onPageChanged: (index) {
              if (index == images.length) {
                _pageController.jumpToPage(
                    0); // jump to first page when reach the dummy page
              }
            },
          ),
          Positioned(
            top: 150,
            left: 30,
            right: 30,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppLargeText(
                  text: "Ekowisata",
                  size: 25,
                ),
                SizedBox(
                  height: 2,
                ),
                AppText(
                  text: 'PERHUTANI',
                  size: 26,
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: 300,
                  child: AppText(
                    text:
                        "Mengelola Sumberdaya Hutan Secara Lestari Peduli Kepada Kepentingan Masyarakat dan Lingkungan",
                    size: 15,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: () {
                    BlocProvider.of<AppCubits>(context).getData();
                  },
                  child: Container(
                    width: 120,
                    child: Row(children: [
                      ResponsiveButton(
                        isResponsive: false,
                      ),
                    ]),
                  ),
                )
              ],
            ),
          ),
          Positioned(
            right: 30,
            top: 150,
            child: Column(
              children: List.generate(images.length, (indexDots) {
                return AnimatedBuilder(
                  animation: _pageController,
                  builder: (context, child) {
                    double selected = 0;
                    if (_pageController.position.haveDimensions) {
                      selected = _pageController.page ??
                          _pageController.initialPage.toDouble();
                    }
                    return Container(
                      margin: const EdgeInsets.only(bottom: 2),
                      width: 8,
                      height: (selected.round() == indexDots) ? 25 : 8,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: (selected.round() == indexDots)
                            ? Colors.black
                            : Colors.black.withOpacity(0.3),
                      ),
                    );
                  },
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
