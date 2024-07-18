import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perhutaniwisata_app/cubit/app_cubit.dart';
import 'package:perhutaniwisata_app/cubit/app_cubit_states.dart';
import 'package:perhutaniwisata_app/pages/detail_pages/cubit/store_page_info_cubits.dart';
import 'package:perhutaniwisata_app/widgets/app_buttons.dart';
import 'package:perhutaniwisata_app/widgets/app_large_text.dart';
import 'package:perhutaniwisata_app/widgets/app_text.dart';
import 'package:perhutaniwisata_app/widgets/responsive_button.dart';
import 'package:perhutaniwisata_app/model/data_model.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  int gottenStars = 4;
  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubits, CubitStates>(builder: (context, state) {
      if (state is DetailState) {
        DataModel place = state.place;

        return Scaffold(
          body: Stack(
            children: [
              Container(
                width: double.infinity,
                height: 300,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(place.img),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                left: 20,
                top: 40,
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        BlocProvider.of<AppCubits>(context).goHome();
                      },
                      icon: Icon(Icons.arrow_back),
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
              DraggableScrollableSheet(
                initialChildSize: 0.6,
                minChildSize: 0.6,
                maxChildSize: 0.9,
                expand: true,
                builder:
                    (BuildContext context, ScrollController scrollController) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 30),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(30)),
                    ),
                    child: SingleChildScrollView(
                      controller: scrollController,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AppLargeText(
                                text: place.name,
                                size: 25,
                                color: Colors.black.withOpacity(0.8),
                              ),
                              AppLargeText(
                                text: "Rp ${place.price},00",
                                size: 20,
                                color: Colors.green,
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                color: Colors.red,
                                size: 18,
                              ),
                              SizedBox(width: 5),
                              AppText(
                                text: place.location,
                                size: 16,
                                color: Colors.black54,
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Row(
                            children: [
                              Wrap(
                                children: List.generate(5, (index) {
                                  return Icon(
                                    Icons.star,
                                    color: index < place.stars
                                        ? Colors.orange
                                        : Colors.black,
                                    size: 22,
                                  );
                                }),
                              ),
                              AppText(
                                text: "(${place.stars}.0)",
                                color: Colors.black54,
                                size: 18,
                              ),
                            ],
                          ),
                          SizedBox(height: 25),
                          AppLargeText(
                            text: "People",
                            color: Colors.black.withOpacity(0.8),
                            size: 20,
                          ),
                          SizedBox(height: 5),
                          AppText(
                            text: "Number of people in your group",
                            color: Colors.black54,
                            size: 18,
                          ),
                          SizedBox(height: 10),
                          Wrap(
                            children: List.generate(place.people, (index) {
                              return InkWell(
                                onTap: () {
                                  BlocProvider.of<StorePageInfoCubits>(context)
                                      .addPageInfo(place.name, index);
                                  setState(() {
                                    selectedIndex = index;
                                  });
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(right: 10),
                                  child: AppButtons(
                                    size: 50,
                                    color: selectedIndex == index
                                        ? Colors.white
                                        : Colors.black,
                                    backgroundColor: selectedIndex == index
                                        ? Colors.black87
                                        : Colors.black12,
                                    borderColor: selectedIndex == index
                                        ? Colors.black
                                        : Colors.black12,
                                    text: (index + 1).toString(),
                                    isIcon: false,
                                  ),
                                ),
                              );
                            }),
                          ),
                          SizedBox(height: 20),
                          AppLargeText(
                            text: "Description",
                            color: Colors.black.withOpacity(0.8),
                            size: 20,
                          ),
                          AppText(
                            text: place.description,
                            color: Colors.black54,
                            size: 18,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              Positioned(
                bottom: 5,
                left: 20,
                right: 20,
                child: Container(
                  height: 70,
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      AppButtons(
                        size: 60,
                        color: Colors.blueGrey,
                        backgroundColor: Colors.white,
                        borderColor: Colors.blueGrey,
                        isIcon: true,
                        icon: Icons.favorite_border,
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            BlocProvider.of<AppCubits>(context).goHome();
                          },
                          child: ResponsiveButton(isResponsive: true),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      } else {
        return Center(
            child: CircularProgressIndicator()); // Fallback for other states
      }
    });
  }
}
