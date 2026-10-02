import 'dart:async';

import 'package:nana/core/constants/app_adimage.dart';
import 'package:flutter/material.dart';

class ImageAd extends StatefulWidget {
  const ImageAd({super.key});

  @override
  State<ImageAd> createState() => _ImageAdState();
}

class _ImageAdState extends State<ImageAd> {
  final PageController _imageController = PageController();

  int currentImage = 0;
  Timer? _timer;

  final List<String> adImage = [
    AppAdimage.imageOne,
    AppAdimage.imageTwo,
    AppAdimage.imageThree,
  ];

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      if (_imageController.hasClients) {
        int nextPage = currentImage + 1;

        if (nextPage >= adImage.length) {
          nextPage = 0;
        }

        _imageController.animateToPage(
          nextPage,
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _imageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      children: [
        Expanded(
          child: PageView.builder(
            itemCount: adImage.length,
            controller: _imageController,
            onPageChanged: (index) {
              setState(() {
                currentImage = index;
              });
            },
            itemBuilder: (context, index) {
              return Image.asset(
                adImage[index],
                width: double.infinity,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(
                    Icons.image_not_supported_outlined,
                    color: Colors.white54,
                    size: 50,
                  );
                },
              );
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 5,
          children: [
            Container(
              height: 6,
              width: currentImage == 0 ? 20 : 6,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            Container(
              height: 6,
              width: currentImage == 1 ? 20 : 6,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            Container(
              height: 6,
              width: currentImage == 2 ? 20 : 6,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
