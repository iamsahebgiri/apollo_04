import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class PlacesTab extends StatelessWidget {
  const PlacesTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
        items: [
          Container(
            margin: EdgeInsets.all(6.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              image: DecorationImage(
                image: NetworkImage("https://images.unsplash.com/photo-1610715936287-6c2ad208cdbf?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1074&q=80"),
                fit: BoxFit.cover,
              ),
            ),
          )
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
