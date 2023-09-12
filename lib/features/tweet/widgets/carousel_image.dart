import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CarouselImage extends StatefulWidget {
  final List<String> imageLinks;
  const CarouselImage({super.key, required this.imageLinks});

  @override
  State<CarouselImage> createState() => _CarouselState();
}

class _CarouselState extends State<CarouselImage> {
  int _current = 0;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Column(
          children: [
            CarouselSlider(
                items: widget.imageLinks.map((link) {
                  return Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(25)),
                    margin: const EdgeInsets.all(10),
                    child: Image.network(
                      link,
                      fit: BoxFit.contain,
                    ),
                  );
                }).toList(),
                options: CarouselOptions(
                  viewportFraction: 1,
                  height: 300,
                  enableInfiniteScroll: false,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _current = index;
                    });
                  },
                )),
            if (widget.imageLinks.length > 1)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: widget.imageLinks.asMap().entries.map((e) {
                  return Container(
                    width: 5,
                    height: 5,
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white
                            .withOpacity(_current == e.key ? 0.9 : 0.4)),
                  );
                }).toList(),
              )
          ],
        )
      ],
    );
  }
}
