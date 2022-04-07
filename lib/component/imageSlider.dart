import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class imageSlider extends StatelessWidget {
  final images = [
    'assets/images/S1.jpg',
    'assets/images/home.jpg',
    'assets/images/vanta.jpg',
    'assets/images/S.jpg',
  ];
  @override
  Widget build(BuildContext context) {
    return   Center(
      child: SizedBox(height: 300,
        child: CarouselSlider.builder(
          options: CarouselOptions(
            height: 200.0,
            enlargeCenterPage: true,
            autoPlay: true,
            aspectRatio: 16 / 9,
            autoPlayCurve: Curves.fastOutSlowIn,
            enableInfiniteScroll: true,
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            viewportFraction: 0.8,
          ),
          itemCount: images.length,
          itemBuilder: (BuildContext context, int index, int realIndex) {
            final image = images[index];
            return imageBuilder(image,index);
          },
        ),
      ),
    );
  }

  Widget imageBuilder(String image, int index) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        image: DecorationImage(
          image: AssetImage(image),
          fit: BoxFit.cover,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF605F5F).withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
    );
  }
}
