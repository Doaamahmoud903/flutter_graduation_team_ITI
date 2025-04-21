import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:electro_app_team/utils/app_colors.dart';
import 'package:flutter/material.dart';

class CarouselWidget extends StatefulWidget {
  final List<Widget> items;

  const CarouselWidget({super.key, required this.items});

  @override
  State<CarouselWidget> createState() => _CarouselWidgetState();
}

class _CarouselWidgetState extends State<CarouselWidget> {
  int _currentIndex = 0;
  final CarouselSliderController _controller = CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CarouselSlider.builder(
          controller: _controller,
          itemCount: widget.items.length,
          itemBuilder: (context, index, realIndex) {
            return SizedBox(
              width: MediaQuery.of(context).size.width,
              child: widget.items[index],
            );
          },
          options: CarouselOptions(
            height: 200,
            viewportFraction: 1.0,
            autoPlay: true,
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
        ),
        Positioned(
          bottom: 10,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: widget.items.asMap().entries.map((entry) {
              return Container(
                width: 8.0,
                height: 8.0,
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentIndex == entry.key
                      ? AppColors.darkBlueColor
                      : AppColors.whiteColor
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
