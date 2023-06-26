import 'package:bilimlar_bellashuvi/data/local/SharedPreferencesHelper.dart';
import 'package:bilimlar_bellashuvi/data/remote/api_servise.dart';
import 'package:bilimlar_bellashuvi/presentation/utils/ProgressBarUtils.dart';
import 'package:bilimlar_bellashuvi/presentation/utils/SuccessDialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class SetPasswordScreen extends StatefulWidget {

  final String token;
  const SetPasswordScreen({required this.token, Key? key}) : super(key: key);

  @override
  State<SetPasswordScreen> createState() => _SetPasswordScreenState();
}

class _SetPasswordScreenState extends State<SetPasswordScreen> {
  final ApiService _apiService = ApiService();
  bool _obscureText = true;
  bool _obscureText2 = true;
  final _form = GlobalKey<FormState>();
  String password = '';


  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _toggleSecond() {
    setState(() {
      _obscureText2 = !_obscureText2;
    });
  }


  @override
  Widget build(BuildContext context) {

    SharedPreferencesHelper.setToken(widget.token);
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
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Form(
              key: _form,
              child: SingleChildScrollView(child: Column(
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
                            'No worries, you just need to type your email address or username and we will send the verification code.',
                            style: TextStyle(
                              color: Color(0xff78746D),
                              fontSize: 15,
                              fontFamily: 'Rubik',
                              fontWeight: FontWeight.w400,
                            )),
                      ),
                    ),
                    const SizedBox(height: 100),
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

                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                      child: TextFormField(
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return "Invalid password!";
                          }
                          if(text!=password){
                            return 'The passwords you entered do not match!';
                          }
                          return null;
                        },
                        obscureText: _obscureText2,
                        style: const TextStyle(
                            fontFamily: 'Rubik', fontWeight: FontWeight.w400),
                        decoration: InputDecoration(
                          suffixIcon: GestureDetector(
                            onTap: _toggleSecond,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 16),
                              child: SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: SvgPicture.asset(
                                    _obscureText2
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
                          hintText: 'Confirm Password',
                        ),
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
                                  .setNewPassword(password)
                                  .then((value) {
                                if (value.statusCode == 200){
                                  ProgressBarUtils(context).stopLoading();
                                  SuccessDialog(context).startSuccessDialog('Password was set up successfully', () {
                                    SuccessDialog(context).stopLoading();
                                    context.replace('/login');
                                  });
                                }
                              }).catchError((error) {
                                ProgressBarUtils(context).stopLoading();
                                var snackBar = SnackBar(content: Text(error));
                                ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
                    ),
                    Padding(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom))
                  ]))),
        ),
      ),
    );
  }
}
