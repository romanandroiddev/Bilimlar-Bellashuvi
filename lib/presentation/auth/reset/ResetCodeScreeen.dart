import 'package:bilimlar_bellashuvi/presentation/utils/ProgressBarUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../data/remote/api_servise.dart';

class ResetCodeScreen extends StatefulWidget {
  const ResetCodeScreen({Key? key}) : super(key: key);

  @override
  State<ResetCodeScreen> createState() => _ResetCodeScreenState();
}

class _ResetCodeScreenState extends State<ResetCodeScreen> {
  final ApiService _apiService = ApiService();
  final _form = GlobalKey<FormState>();

  String _value = '';

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
      body: Scaffold(
        body: SafeArea(
          child: Form(
              key: _form,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 48),
                    const SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text('Forgot Your Password?',
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
                            'No worries, you just need to type your email address or phone (e.g 998990000000) and we will send the verification code.',
                            style: TextStyle(
                              color: Color(0xff78746D),
                              fontSize: 15,
                              fontFamily: 'Rubik',
                              fontWeight: FontWeight.w400,
                            )),
                      ),
                    ),
                    const SizedBox(height: 84),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                        child: TextFormField(
                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return 'Field  should not be empty';
                            }
                            return null;
                          },
                          onChanged: (text) {
                            _value = text;
                          },
                          style: const TextStyle(
                              fontFamily: 'Rubik', fontWeight: FontWeight.w400),
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Color(0xffBEBAB3), width: 1.0),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Color(0xffBEBAB3), width: 1.0),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            hintText: 'Umail/Phone number',
                          ),
                        )),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                      child: SizedBox(
                        height: 56,
                        width: double.infinity,
                        child: FilledButton(
                          onPressed: () async {
                            if (_form.currentState!.validate()) {
                              FocusScope.of(context).unfocus();
                              TextEditingController().clear();
                              ProgressBarUtils(context).startLoading();
                              await _apiService
                                  .resetCode(
                                      _value.contains('@gmail.com')
                                          ? 'email'
                                          : 'phone_number',
                                      _value)
                                  .then((value) {
                                if (value.statusCode == 200 &&
                                    value.payload != null) {
                                  if (_value.contains('@gmail.com')) {
                                    context.push('/confirm',
                                        extra: {"timer": value.payload!.timer});
                                  } else if (_value.length == 12 &&
                                      _value.startsWith('998')) {
                                    context.push('/confirm_code',
                                        extra: {"phone": _value});
                                  }
                                }
                                ProgressBarUtils(context).stopLoading();
                              }).catchError((error) {
                                ProgressBarUtils(context).stopLoading();
                                var snackBar = SnackBar(content: Text(error));
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              });
                            }
                          },
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16)),
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
                  ])),
        ),
      ),
    );
  }
}
