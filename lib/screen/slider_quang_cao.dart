import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class SliderQuangCao extends StatefulWidget {
  @override
  _SliderQuangCaoState createState() => _SliderQuangCaoState();
}

final List<String> _imageUrls = [
  "https://cdn.cellphones.com.vn/media/ltsoft/promotion/T_T-SAMSUNG-GALAXY-S10_-_-ACTIVE-1---1600x600.png",
  "https://cdn.cellphones.com.vn/media/ltsoft/promotion/iphone_xs_max_gia_soc.png",
  "https://cdn.cellphones.com.vn/media/ltsoft/promotion/T_T-LAPTOP---1600x600.png",
  "https://cdn.cellphones.com.vn/media/ltsoft/promotion/T_T-LOA-_-TAI-NGHE---1600x600.png"
];

class _SliderQuangCaoState extends State<SliderQuangCao> {
  @override
  Widget build(BuildContext context) {
    final CarouselSlider autoPlayDemo = CarouselSlider(
      options: CarouselOptions(
        viewportFraction: 0.8,
        aspectRatio: 2.5,
        autoPlay: true,
        enlargeCenterPage: true,
        autoPlayAnimationDuration: Duration(milliseconds: 800),
      ),
      items: _imageUrls.map(
        (url) {
          return Container(
            margin: EdgeInsets.all(5.0),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              child: Image.network(
                url,
                fit: BoxFit.cover,
                width: 1000.0,
              ),
            ),
          );
        },
      ).toList(),
    );
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5.0),
      child: Column(
        children: <Widget>[
          autoPlayDemo,
        ],
      ),
    );
  }
}
