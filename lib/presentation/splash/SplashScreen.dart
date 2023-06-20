import 'dart:async';

import 'package:bilimlar_bellashuvi/components/styles.dart';
import 'package:bilimlar_bellashuvi/data/local/SharedPreferencesHelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      SharedPreferencesHelper.getIsSignedIn().then((value){
        if(value){
          context.replace('/main_page') ;
        }else{
          context.replace('/language') ;
        }
      });
    },);

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Align(
          alignment: Alignment.center,
          child: Wrap(children: [
            Column(
              children: [
                SizedBox(
                  height: 260,
                  child: SvgPicture.asset('assets/Cool Kids On Wheels.svg'),
                ),
                SizedBox(
                  width: double.infinity,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Bilimlar Bellashuvi',
                      style: TextStyles.display3,
                    ),
                  ),
                )
              ],
            )
          ]),
        ),
      ),
    ));
  }
}
