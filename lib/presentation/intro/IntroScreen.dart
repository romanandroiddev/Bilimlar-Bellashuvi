import 'package:bilimlar_bellashuvi/presentation/auth/login/LoginScreen.dart';
import 'package:bilimlar_bellashuvi/presentation/intro/IntroItem.dart';
import 'package:bilimlar_bellashuvi/presentation/intro/models/IntroData.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final pageController = PageController();
  int _activePage = 0;

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                  onTap: () {
                    context.replace('/login');
                  },
                  child: const Padding(
                      padding: EdgeInsets.fromLTRB(0, 16, 16, 0),
                      child: Text(
                        'Skip',
                        style: TextStyle(
                            color: Color(0xff78746D),
                            fontFamily: 'Rubik',
                            fontWeight: FontWeight.w500),
                      )))),
          const SizedBox(
            height: 100,
          ),
          Expanded(
              child: PageView.builder(
            onPageChanged: (int index) {
              setState(() {
                _activePage = index;
              });
            },
            controller: pageController,
            itemCount: introList.length,
            itemBuilder: (context, index) =>
                IntroItem(introList.elementAt(index), key: ValueKey(index),),
          )),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List<Widget>.generate(
              introList.length,
              (index) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  child: _activePage == index
                      ? Container(
                          width: 16,
                          height: 6,
                          decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4)),
                              color: Color(0xFF65AAEA)))
                      : GestureDetector(
                          onTap: () {
                            pageController.animateToPage(index,
                                duration: const Duration(milliseconds: 200),
                                curve: Curves.linear);
                          },
                          child: Container(
                            width: 6,
                            height: 6,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xFFBEBAB3)),
                          ),
                        )),
            ),
          ),
          const SizedBox(
            height: 64,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: SizedBox(
              height: 56,
              width: double.infinity,
              child: FilledButton(
                onPressed: () {
                  if (_activePage < 2) {
                    pageController.animateToPage(_activePage + 1,
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.easeIn);
                  } else {
                    context.replace('/login');
                  }
                },
                style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    )),
                    backgroundColor: MaterialStateProperty.all<Color>(
                        const Color(0xFFE3562A))),
                child: const Text('Next',
                    style: TextStyle(
                        color: Color(0xffFFFFFF),
                        fontSize: 16,
                        fontFamily: 'Rubik',
                        fontWeight: FontWeight.w500)),
              ),
            ),
          )
        ],
      ),
    ));
  }
}
