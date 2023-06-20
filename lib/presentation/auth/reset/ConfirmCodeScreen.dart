import 'package:bilimlar_bellashuvi/data/local/SharedPreferencesHelper.dart';
import 'package:bilimlar_bellashuvi/data/remote/api_servise.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'package:go_router/go_router.dart';

import '../../utils/ProgressBarUtils.dart';

class ConfirmCodeScreen extends StatefulWidget {
  final String phone;

  const ConfirmCodeScreen({required this.phone, Key? key}) : super(key: key);

  @override
  State<ConfirmCodeScreen> createState() => _ConfirmCodeScreenState();
}

class _ConfirmCodeScreenState extends State<ConfirmCodeScreen> {
  final ApiService _apiService = ApiService();



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
                        child: Text('Verify phone number',
                            style: TextStyle(
                                color: Color(0xff3C3A36),
                                fontFamily: 'Rubik',
                                fontSize: 24,
                                fontWeight: FontWeight.w500,
                                letterSpacing: -0.5)),
                      ),
                    ),
                    const SizedBox(height: 16),
                     SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                            'Enter the 4-digit code sent to your phone \nnumber ${widget.phone}',
                            style: const TextStyle(
                              color: Color(0xff78746D),
                              fontSize: 15,
                              fontFamily: 'Rubik',
                              fontWeight: FontWeight.w400,
                            )),
                      ),
                    ),
                    const SizedBox(height: 100),
                    VerificationCode(onCompleted: (value) {
                      FocusScope.of(context).unfocus();
                      TextEditingController().clear();
                      ProgressBarUtils(context).startLoading();
                      _apiService.verifyPhoneNumber(value, widget.phone).then((value){
                        if(value.statusCode==200){
                          SharedPreferencesHelper.setPhoneNumber(widget.phone);
                          SharedPreferencesHelper.setName(value.payload!.firstName);
                          SharedPreferencesHelper.setToken(value.payload!.token);
                          SharedPreferencesHelper.setIsSignedIn(true);
                          ProgressBarUtils(context).stopLoading();
                          context.replace('/main_page');
                        }
                      }).catchError((error){
                        ProgressBarUtils(context).stopLoading();
                        var snackBar = SnackBar(content: Text(error));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      });
                    }, onEditing: (value) {},),
                    const SizedBox(height: 32),
                    const Text('Didn\'t receive the code? Resend',
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
