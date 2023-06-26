import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: const TextStyle(
            fontFamily: 'Rubik',
            fontWeight: FontWeight.w500,
            letterSpacing: -0.5,
            fontSize: 24,
            color: Color(0xff3C3A36),
          ),
          title: const Text(
            'Opponents',
          ),
          leading: GestureDetector(
            onTap: () {
              Navigator.maybePop(context);
            },
            child: Container(
              margin: const EdgeInsets.fromLTRB(12, 12, 0, 0),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(width: 1, color: const Color(0xffBEBAB3))),
              child: Align(
                alignment: Alignment.center,
                child: SvgPicture.asset('assets/Ic Back.svg'),
              ),
            ),
          )),
    );
  }
}
