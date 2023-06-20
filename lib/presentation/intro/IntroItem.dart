import 'package:bilimlar_bellashuvi/presentation/intro/models/IntroData.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class IntroItem extends StatelessWidget {
  final IntroData introData;

  const IntroItem(this.introData, {super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              SvgPicture.asset('assets/${introData.imagePath}',
                  fit: BoxFit.fill),
              const SizedBox(height: 16),
              Text(
                introData.title,
                style: const TextStyle(
                    color: Color(0xff3C3A36),
                    fontFamily: 'Rubik',
                    fontWeight: FontWeight.w500,
                    fontSize: 24,
                    letterSpacing: (-0.5)),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                introData.paragraph,
                style: const TextStyle(
                    color: Color(0xff78746D),
                    fontFamily: 'Rubik',
                    fontWeight: FontWeight.w400,
                    fontSize: 14),
                textAlign: TextAlign.center,
              )
            ],
          ),
        )
      ],
    );
  }
}
