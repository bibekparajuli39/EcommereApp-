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
  final List<String> adImage = [
    AppAdimage.imageOne,
    AppAdimage.imageTwo,
    AppAdimage.imageThree,
  ];

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _imageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      children: [
        SizedBox(
          height: 150,
          width: 150,
          child: PageView.builder(
            itemCount: adImage.length,
            controller: _imageController,
            onPageChanged: (index) {
              setState(() {
                currentImage = index;
              });
            },

            itemBuilder: (context, index) {
              return Image.network(
                adImage[index],
                height: 250,
                width: 200,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(
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
          mainAxisAlignment: .center,
          spacing: 5,
          children: [
            Container(
              height: 10,
              width: 10,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: currentImage == 0 ? Colors.white : Colors.white38,
              ),
            ),
            Container(
              height: 10,
              width: 10,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: currentImage == 1 ? Colors.white : Colors.white38,
              ),
            ),
            Container(
              height: 10,
              width: 10,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: currentImage == 2 ? Colors.white : Colors.white38,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
