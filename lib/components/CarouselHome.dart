import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CarouselHome extends StatelessWidget {
  const CarouselHome({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String , String>> imgList = [
      {'image': 'assets/images/cake.jpg', 'text': 'Cake Category'},
      {'image': 'assets/images/photography.png', 'text': 'Photography and Videography'},
      {'image': 'assets/images/catoring.jpg', 'text': 'Catering and Menu'},
      {'image': 'assets/images/WeddingAttire.png', 'text': 'Wedding Attire'},
      {'image': 'assets/images/Entertainment.jpg', 'text': 'Entertainment and Music'},
      {'image': 'assets/images/image02.png', 'text': 'Decorations and Design'},
      {'image': 'assets/images/Transportation.jpg', 'text': 'Transportation'},
      {'image': 'assets/images/Beauty.jpg', 'text': 'Beauty and Wellness'},
      {'image': 'assets/images/EventCoordinator.jpg', 'text': 'Event Coordination'},
    ];

    return CarouselSlider(
      options: CarouselOptions(
        height: 250.0,
        autoPlay: true,
        enlargeCenterPage: true,
        aspectRatio: 16 / 9,
        autoPlayCurve: Curves.fastOutSlowIn,
        enableInfiniteScroll: true,
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        viewportFraction: 0.8,
      ),
      items: imgList.map((item) => Container(
        margin: const EdgeInsets.all(5.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 5.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                ),
                child: Image.asset(
                  item['image']!,
                  fit: BoxFit.cover,
                  height: 160.0, // Adjust the image height
                  width: double.infinity,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Text(
                  item['text']!,
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      )).toList(),
    );
  }
}
