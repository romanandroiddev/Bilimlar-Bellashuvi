import 'package:bilimlar_bellashuvi/data/local/SharedPreferencesHelper.dart';
import 'package:bilimlar_bellashuvi/data/remote/api_servise.dart';
import 'package:bilimlar_bellashuvi/presentation/auth/signup/SignUpScreen.dart';
import 'package:bilimlar_bellashuvi/presentation/main/MainScreen.dart';
import 'package:bilimlar_bellashuvi/presentation/utils/ProgressBarUtils.dart';
import 'package:bilimlar_bellashuvi/presentation/utils/SuccessDialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final ApiService _apiService = ApiService();
  bool _obscureText = true;
  final _form = GlobalKey<FormState>();
  String email = '';
  String password = '';

  bool isPhoneRegimeSelected = false;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: SafeArea(
              child: Form(
                key: _form,
                child: SingleChildScrollView(
                  reverse: true,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child:
                        GestureDetector(
                          onTap: () {
                            FocusScope.of(context).unfocus();
                            TextEditingController().clear();
                            context.push('/signup');
                          },
                          child:  const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            child: Text(
                              'Sign up',
                              style: TextStyle(
                                  fontFamily: 'Rubik',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: Color(0xff78746D)),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Wrap(
                        children: [
                          SvgPicture.asset('assets/Cool Kids Sitting.svg')
                        ],
                      ),
                      const SizedBox(height: 16),
                      const Text('Log in',
                          style: TextStyle(
                              color: Color(0xff3C3A36),
                              fontFamily: 'Rubik',
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                              letterSpacing: -0.5)),
                      const SizedBox(height: 8),
                      const Text('Login with umail',
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
                              return 'Umail should not be empty';
                            }
                            if (!text.contains('@gmail.com')) {
                              return 'Invalid Umail was entered';
                            }
                            return null;
                          },
                          onChanged: (text) {
                            email = text;
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
                            hintText: 'Umail',
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
                          onChanged: (String text) {
                            password = text;
                          },
                          obscureText: _obscureText,
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
                            suffixIconConstraints: const BoxConstraints(
                                maxWidth: 48, maxHeight: 48),
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
                      const SizedBox(height: 48),
                      GestureDetector(
                        onTap: () {
                          context.push('/reset');
                        },
                        child: const Text(
                          'Forgot Password?',
                          style: TextStyle(
                              fontFamily: 'Rubik',
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: Color(0xff78746D)),
                        ),
                      ),
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
                                    .login(email, password)
                                    .then((value) {
                                  if (value.statusCode == 200 &&
                                      value.payload != null) {
                                    SharedPreferencesHelper.setName(
                                        value.payload!.firstName);
                                    SharedPreferencesHelper.setUserName(
                                        value.payload!.username);
                                    SharedPreferencesHelper.setToken(
                                        value.payload!.token);
                                    SharedPreferencesHelper.setEmailAddress(
                                        value.payload!.email);
                                    SharedPreferencesHelper.setAvatar(
                                        value.payload!.avatar);
                                    SharedPreferencesHelper.setIsSignedIn(true);
                                    ProgressBarUtils(context).stopLoading();

                                    SuccessDialog(context).startSuccessDialog('You have successfully signed in to your profile', () {
                                      SuccessDialog(context).stopLoading();
                                      context.replace('/main_page');
                                    });
                                  }
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
                                backgroundColor:
                                MaterialStateProperty.all<Color>(
                                    const Color(0xFFE3562A))),
                            child: const Text('Next',
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
                              bottom:
                              MediaQuery
                                  .of(context)
                                  .viewInsets
                                  .bottom)),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                        child: SizedBox(
                          height: 56,
                          width: double.infinity,
                          child: OutlinedButton(
                            onPressed: () async {
                              context.replace('/login_phone');
                            },
                            style: ButtonStyle(
                              side: MaterialStateProperty.all<BorderSide>(
                                  const BorderSide(
                                      color: Color(0xFFE3562A), width: 2)),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                  const RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(16)),
                                  )),
                            ),
                            child: const Text('Login via phone',
                                style: TextStyle(
                                    color: Color(0xFFE3562A),
                                    fontSize: 16,
                                    fontFamily: 'Rubik',
                                    fontWeight: FontWeight.w500)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )),
        onTap: () => FocusScope.of(context).unfocus());
  }
}
