import 'package:flutter/material.dart';

import 'package:shimmer/shimmer.dart';

import '../../decorations/home_screen_style.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Shimmer.fromColors(
          baseColor: const Color.fromRGBO(47, 48, 51, 1),
          highlightColor: const Color.fromRGBO(68, 71, 79, 1),
          child: ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) {
              return ListTile(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                      top: 18.0, left: 0.0, bottom: 10.0),
                      child: Container(
                        width: 100,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(21),
                            ),
                            color: Color.fromRGBO(149, 165, 166, 1),
                          ),
                          child: Text(" ", style: kDateTextStyle,
                          )
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 0.0,
                        vertical: 4.0,
                      ),
                      child: Container(
                        height: 96.0,
                        width: MediaQuery.of(context).size.width,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(21),
                          ),
                          color: Color.fromRGBO(149, 165, 166, 1),
                        ),
                      ),
                    ),
                  ],
                )
              );
            },
          ),
        ),
    );
  }
}
