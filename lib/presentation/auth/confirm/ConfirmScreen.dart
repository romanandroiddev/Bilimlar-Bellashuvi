import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class ConfirmScreen extends StatefulWidget {
  final int timer;
  const ConfirmScreen({required this.timer, Key? key}) : super(key: key);

  @override
  State<ConfirmScreen> createState() => _ConfirmScreenState();
}

class _ConfirmScreenState extends State<ConfirmScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            context.pop();
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
        ),
      ),
      body: Scaffold(
        body: SafeArea(
          child: SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 48),
                    const SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text('Confirm your email',
                            style: TextStyle(
                                color: Color(0xff3C3A36),
                                fontFamily: 'Rubik',
                                fontSize: 24,
                                fontWeight: FontWeight.w500,
                                letterSpacing: -0.5)),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                            'No worries, we just sent to your email address a verification link and after you have to press the link and get verification code.',
                            style: TextStyle(
                              color: Color(0xff78746D),
                              fontSize: 15,
                              fontFamily: 'Rubik',
                              fontWeight: FontWeight.w400,
                            )),
                      ),
                    ),
                    const SizedBox(height: 100),
                    TweenAnimationBuilder<Duration>(
                        duration: Duration(seconds: widget.timer),
                        tween: Tween(
                            begin: Duration(seconds: widget.timer),
                            end: Duration.zero),
                        onEnd: () {
                          context.pop();
                        },
                        builder: (BuildContext context, Duration value,
                            Widget? child) {
                         final minutes = value.inMinutes.toString().padLeft(2, '0');
                          final seconds =(value.inSeconds % 60).toString().padLeft(2, '0');

                          return Align(
                          alignment: Alignment.center,
                          child: Text(
                          '$minutes:$seconds',
                          style: const TextStyle(
                          color: Color(0xff3C3A36),
                          fontFamily: 'Rubik',
                          fontSize: 48,
                          fontWeight: FontWeight.w500,
                          letterSpacing: -0.5),
                          )
                          );
                        }),
                    const SizedBox(height: 32),
                    const Text('Seconds remained to verify your email address',
                        style: TextStyle(
                          color: Color(0xff78746D),
                          fontSize: 15,
                          fontFamily: 'Rubik',
                          fontWeight: FontWeight.w400,
                        )),
                  ])),
        ),
      ),
    );
  }
}
