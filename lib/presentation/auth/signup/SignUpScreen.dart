import 'package:bilimlar_bellashuvi/data/local/SharedPreferencesHelper.dart';
import 'package:bilimlar_bellashuvi/data/remote/api_servise.dart';
import 'package:bilimlar_bellashuvi/presentation/auth/confirm/ConfirmScreen.dart';
import 'package:bilimlar_bellashuvi/presentation/main/MainScreen.dart';
import 'package:bilimlar_bellashuvi/presentation/utils/ProgressBarUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final ApiService _apiService = ApiService();
  bool _obscureText = true;
  String firstName = '';
  String _value = '';
  String password = '';

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  final _form = GlobalKey<FormState>(); //for storing form state.

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
      body: SafeArea(
        child: SingleChildScrollView(
          reverse: true,
          child: Form(
              key: _form,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Wrap(
                    children: [
                      SvgPicture.asset('assets/Cool Kids Standing.svg')
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text('Sign up',
                      style: TextStyle(
                          color: Color(0xff3C3A36),
                          fontFamily: 'Rubik',
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                          letterSpacing: -0.5)),
                  const SizedBox(height: 8),
                  const Text('Create your account',
                      style: TextStyle(
                        color: Color(0xff78746D),
                        fontSize: 14,
                        fontFamily: 'Rubik',
                        fontWeight: FontWeight.w400,
                      )),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                    child: TextFormField(
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return 'Name should not be empty';
                        }
                        return null;
                      },
                      onChanged: (String text) {
                        firstName = text;
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
                        hintText: 'Name',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                    child: TextFormField(
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return 'Field should not be empty';
                        }
                        if(!text.contains('@gmail.com') || !text.startsWith('998')){
                          return 'Invalid value was entered';
                        }
                        return null;
                      },
                      onChanged: (String text) {
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
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                    child: TextFormField(
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return "Invalid password!";
                        }
                        if (text.length < 8) {
                          return "Password must has 8 characters";
                        }
                        return null;
                      },
                      obscureText: _obscureText,
                      onChanged: (String text) {
                        password = text;
                      },
                      style: const TextStyle(
                          fontFamily: 'Rubik', fontWeight: FontWeight.w400),
                      decoration: InputDecoration(
                        suffixIcon: GestureDetector(
                          onTap: _toggle,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 16),
                            child: SizedBox(
                                width: 24,
                                height: 24,
                                child: SvgPicture.asset(
                                  _obscureText
                                      ? 'assets/Icon Visible.svg'
                                      : 'assets/Icon Hidden.svg',
                                  width: 24,
                                  height: 24,
                                )),
                          ),
                        ),
                        suffixIconConstraints:
                            const BoxConstraints(maxWidth: 48, maxHeight: 48),
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
                        hintText: 'Password',
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
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
                            if (_value.contains('@gmail.com')) {
                              await _apiService
                                  .sendCodeToEmail(firstName, _value, password)
                                  .then((value) {
                                if (value.statusCode == 200 &&
                                    value.payload != null) {
                                  SharedPreferencesHelper.setName(firstName);
                                  SharedPreferencesHelper.setEmailAddress(
                                      _value);
                                  context.push('/confirm',
                                      extra: {"timer": value.payload!.timer});
                                }
                                ProgressBarUtils(context).stopLoading();
                              }).catchError((error) {
                                ProgressBarUtils(context).stopLoading();
                                var snackBar = SnackBar(content: Text(error));
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              });
                            } else {
                              await _apiService
                                  .sendCodeToPhone(firstName, _value, password)
                                  .then((value) {
                                if (value.statusCode == 200 &&
                                    value.payload != null) {
                                  SharedPreferencesHelper.setName(firstName);
                                  SharedPreferencesHelper.setPhoneNumber(
                                      _value);
                                  context.push('/confirm_code',
                                      extra: {"phone": _value});
                                }
                                ProgressBarUtils(context).stopLoading();
                              }).catchError((error) {
                                ProgressBarUtils(context).stopLoading();
                                var snackBar = SnackBar(content: Text(error));
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              });
                            }
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
                        child: const Text('Sign up',
                            style: TextStyle(
                                color: Color(0xffFFFFFF),
                                fontSize: 16,
                                fontFamily: 'Rubik',
                                fontWeight: FontWeight.w500)),
                      ),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom)),
                  const SizedBox(height: 16),
                  GestureDetector(
                    onTap: () {
                      context.pop();
                      // Navigator.pop(context);
                    },
                    child: const Text(
                      'Log in',
                      style: TextStyle(
                          fontFamily: 'Rubik',
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: Color(0xff78746D)),
                    ),
                  )
                ],
              )),
        ),
      ),
    );
  }
}
