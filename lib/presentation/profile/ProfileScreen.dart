import 'dart:io';

import 'package:bilimlar_bellashuvi/components/styles.dart';
import 'package:bilimlar_bellashuvi/data/local/SharedPreferencesHelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
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
            'Profile',
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
          ),
        ),
        body: SafeArea(
            child: SizedBox(
          width: double.infinity,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            const SizedBox(height: 32),
            Container(
              height: 190,
              margin: const EdgeInsets.only(top: 24),
              child: SvgPicture.asset('assets/Cool Kids On Wheels.svg'),
            ),
            Container(
                height: 80,
                width: double.infinity,
                margin: const EdgeInsets.fromLTRB(16, 32, 16, 0),
                child: OutlinedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    )),
                  ),
                  child: Text('History', style: TextStyles.heading1),
                )),
            Container(
                height: 80,
                width: double.infinity,
                margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: OutlinedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    )),
                  ),
                  child: Text('Saved', style: TextStyles.heading1),
                )),
            Container(
                height: 80,
                width: double.infinity,
                margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: OutlinedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    )),
                  ),
                  child: Text('Notifications', style: TextStyles.heading1),
                )),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.center,
              child: TextButton(
                child: Text('Log out', style: TextStyles.paragraphLarge),
                onPressed: () {
                  context.replace('/');
                  SharedPreferencesHelper.clearSharedPreferences();
                },
              ),
            )
          ]),
        )));
  }
}
