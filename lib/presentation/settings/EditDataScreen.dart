import 'package:bilimlar_bellashuvi/components/styles.dart';
import 'package:bilimlar_bellashuvi/data/local/SharedPreferencesHelper.dart';
import 'package:bilimlar_bellashuvi/presentation/utils/ProgressBarUtils.dart';
import 'package:bilimlar_bellashuvi/presentation/utils/SuccessDialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';

import '../../data/remote/api_servise.dart';

class EditScreen extends StatefulWidget {
  const EditScreen({Key? key}) : super(key: key);

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final ApiService _apiService = ApiService();
  final _form = GlobalKey<FormState>();

  String name = '';
  String lastName = '';
  String userName = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            'Edit Profile',
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
          child: Form(
            key: _form,
            child: Column(
              children: [
                SizedBox(
                    height: 172,
                    width: 172,
                    child: Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                width: 4, color: const Color(0xff65AAEA))),
                        child: FutureBuilder(
                          future: SharedPreferencesHelper.getAvatar(),
                          builder: (context, snapshot) {
                            return ClipOval(
                                child: snapshot.connectionState ==
                                        ConnectionState.done
                                    ? CachedNetworkImage(
                                        fit: BoxFit.fitHeight,
                                        imageUrl: (snapshot.data ?? '') ?? '',
                                        progressIndicatorBuilder:
                                            (context, url, progress) =>
                                                Shimmer.fromColors(
                                          baseColor: Colors.black12,
                                          highlightColor: Colors.white,
                                          child: const SizedBox(
                                              width: double.infinity,
                                              height: double.infinity),
                                        ),
                                        errorWidget: (context, url, error) {
                                          return SvgPicture.asset(
                                              'assets/Cool Kids Bust.svg');
                                        },
                                      )
                                    : Shimmer.fromColors(
                                        baseColor: Colors.black12,
                                        highlightColor: Colors.white,
                                        child: Container(
                                          width: double.infinity,
                                          height: double.infinity,
                                          color: Colors.black,
                                        )));
                          },
                        ))),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.fromLTRB(16, 16, 0, 0),
                  child: Text('First Name', style: TextStyles.paragraphMedium),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 4, 16, 0),
                  child: FutureBuilder(
                    future: SharedPreferencesHelper.getName(),
                    builder: (context, snapshot) {
                      return TextFormField(
                        initialValue:
                            snapshot.data != '' ? snapshot.data : 'e.g Roman',
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return 'First Name should not be empty';
                          }
                          return null;
                        },
                        onChanged: (text) {
                          name = text;
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
                          hintText: 'First name',
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.fromLTRB(16, 16, 0, 0),
                  child: Text('Last name', style: TextStyles.paragraphMedium),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 4, 16, 0),
                  child: FutureBuilder(
                    future: SharedPreferencesHelper.getLastName(),
                    builder: (context, snapshot) {
                      return TextFormField(
                        initialValue: snapshot.data != ''
                            ? snapshot.data
                            : 'e.g Sarichev',
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return 'Last Name should not be empty';
                          }
                          return null;
                        },
                        onChanged: (text) {
                          lastName = text;
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
                          hintText: 'Last name',
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.fromLTRB(16, 16, 0, 0),
                  child: Text('Username', style: TextStyles.paragraphMedium),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 4, 16, 0),
                  child: FutureBuilder(
                    future: SharedPreferencesHelper.getName(),
                    builder: (context, snapshot) {
                      return TextFormField(
                        initialValue: snapshot.data != ''
                            ? snapshot.data
                            : 'e.g roman_sarichev',
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return 'Username should not be empty';
                          }
                          return null;
                        },
                        onChanged: (text) {
                          userName = text;
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
                          hintText: 'Username',
                        ),
                      );
                    },
                  ),
                ),
                Expanded(child: Container()),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
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
                              .update(name, lastName, userName)
                              .then((value) {
                            if (value.statusCode == 200) {
                              ProgressBarUtils(context).stopLoading();

                              SuccessDialog(context).startSuccessDialog(
                                  'You have successfully updated your profile',
                                  () {
                                SuccessDialog(context).stopLoading();
                                context.pop();
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
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
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
          ),
        ));
  }
}
