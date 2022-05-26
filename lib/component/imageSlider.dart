import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../server/api.dart';

class imageSlider extends StatefulWidget {
  int id;
  imageSlider(this.id);
  @override
  State<imageSlider> createState() => _imageSliderState();
}
class _imageSliderState extends State<imageSlider> {
  var _offers;
  final images = [
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT1g7H2Qcse7nhXqoLTx7STDxh5dPIcArxZqQ&usqp=CAU'
  ];
  @override
  void initState() {
    super.initState();
    _loadOffer();
  }
  @override
  Widget build(BuildContext context) {
    return   Center(
      child: SizedBox(height: 300,
        child: CarouselSlider.builder(
          options: CarouselOptions(
            height: 260.0,
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
          image: _offers == null
              ? NetworkImage(
              'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_640.png')
              :NetworkImage(image),
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
  _loadOffer() async {
    // setState(() {
    //   _isLoading = true;
    // });
    var response = await Api().getData('/API/products/${widget.id}/', 'JWT');
    if (response.statusCode == 200) {
      setState(() {
        // _isLoading = false;
        _offers = json.decode(response.body);
        images.clear();
        for(int i=0;i<_offers.length;i++){
          images.add(_offers['images'][i]['images'].toString());
        }
      });
    } else {
      // setState(() {
      //   _isLoading = false;
      // });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
            'Error ' + response.statusCode.toString() + ': ' + response.body),
      ));
    }
  }
}
