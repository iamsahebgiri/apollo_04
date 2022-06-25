import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

Widget Place(title, image) {
  return AspectRatio(
    aspectRatio: 16 / 9,
    child: Container(
      margin: EdgeInsets.only(right: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        image: DecorationImage(fit: BoxFit.cover, image: NetworkImage(image)),
      ),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            gradient: LinearGradient(begin: Alignment.bottomRight, stops: [
              0.1,
              0.9
            ], colors: [
              Colors.black.withOpacity(.8),
              Colors.black.withOpacity(.1)
            ])),
        child: Align(
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              title,
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ),
      ),
    ),
  );
}

class PlacesTab extends StatelessWidget {
  const PlacesTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
        items: [
          Place("Puri",
              "https://images.unsplash.com/photo-1610715936287-6c2ad208cdbf?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1074&q=80"),
              Place("Khandagiri",
              "https://images.unsplash.com/photo-1454496522488-7a8e488e8606?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1776&q=80")
        ],
        options: CarouselOptions(
          height: 180.0,
          enlargeCenterPage: false,
          autoPlay: true,
          aspectRatio: 16 / 9,
          autoPlayCurve: Curves.fastOutSlowIn,
          enableInfiniteScroll: true,
          autoPlayAnimationDuration: Duration(milliseconds: 800),
          viewportFraction: 0.8,
        ));
  }
}
