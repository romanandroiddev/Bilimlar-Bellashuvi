import 'package:bilimlar_bellashuvi/data/local/SharedPreferencesHelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class ConfirmVerificationScreen extends StatefulWidget {
  final String token;

  const ConfirmVerificationScreen({required this.token, Key? key})
      : super(key: key);

  @override
  State<ConfirmVerificationScreen> createState() =>
      _ConfirmVerificationScreenState();
}

class _ConfirmVerificationScreenState extends State<ConfirmVerificationScreen> {
  @override
  Widget build(BuildContext context){
    SharedPreferencesHelper.setIsSignedIn(true);
    SharedPreferencesHelper.setToken(widget.token);

    Future.delayed(const Duration(milliseconds: 300), (){
      context.replace('/main_page');
    });

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            context.pop();
            // Navigator.maybePop(context);
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
      body: const Scaffold(
        body: SafeArea(
          child: SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 48),
                    SizedBox(
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
                    SizedBox(height: 16),
                    SizedBox(
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
                    SizedBox(height: 100),
                    Align(
                        alignment: Alignment.center,
                        child:Text('--:--',
                              style: TextStyle(
                                  color: Color(0xff3C3A36),
                                  fontFamily: 'Rubik',
                                  fontSize: 48,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: -0.5)),
                        ),
                    SizedBox(height: 32),
                    Text('Seconds remained to verify your email address',
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
