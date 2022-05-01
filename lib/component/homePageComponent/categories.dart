import 'package:flutter/material.dart';

class categories extends StatelessWidget {
  List <String>_list=['appartement', 'house', 'industrial', 'commercial' ,'land'];
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SizedBox(
        height: 70,
        child: ListView.builder(
          padding: const EdgeInsets.fromLTRB(12, 0,20 , 0),
          physics: const BouncingScrollPhysics(parent: null),
          shrinkWrap: true,
          itemCount: 10,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                child:const Center(child: Text("category",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(13.0),
                  color: const Color(0xFFFFFFFF),
                  shape: BoxShape.rectangle,
                    boxShadow: [
                    BoxShadow(
                    color: const Color(0xFF605F5F).withOpacity(0.2),
                spreadRadius: 4,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),],
                ),
                width: 120,

              ),
            );
          },
        ));
  }
}
