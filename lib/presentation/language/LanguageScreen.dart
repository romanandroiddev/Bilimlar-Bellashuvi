import 'package:bilimlar_bellashuvi/components/styles.dart';
import 'package:bilimlar_bellashuvi/data/local/SharedPreferencesHelper.dart';
import 'package:bilimlar_bellashuvi/data/models/LanguageData.dart';
import 'package:bilimlar_bellashuvi/data/remote/api_servise.dart';
import 'package:bilimlar_bellashuvi/presentation/utils/SuccessDialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({Key? key}) : super(key: key);

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  final ApiService _apiService = ApiService();
  String selectedLanguage='';

  setSelectedUser(String code) {
    setState(() {
      selectedLanguage = code;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
              color: const Color(0xfff0f0f0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 48),
                  SizedBox(
                    height: 130,
                    width: 150,
                    child: SvgPicture.asset('assets/Cool Kids Bust.svg'),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  const SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text('Select Language',
                          style: TextStyle(
                              color: Color(0xff3C3A36),
                              fontFamily: 'Rubik',
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                              letterSpacing: -0.5)),
                    ),
                  ),
                  const SizedBox(height: 16),
                  FutureBuilder<LanguageData>(
                    future: _apiService.getLanguages(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.separated(
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    const Divider(height: 2),
                            shrinkWrap: true,
                            itemCount: snapshot.data!.payload!.length,
                            itemBuilder: (BuildContext context, int index) {
                              return RadioListTile(
                                value: snapshot.data!.payload![index].code,
                                groupValue: selectedLanguage,
                                title:
                                    Text(snapshot.data!.payload![index].name),
                                onChanged: (language) {
                                  setSelectedUser(language!);
                                },
                                selected: selectedLanguage != ''
                                    ? selectedLanguage ==
                                        snapshot.data!.payload![index].code
                                    : false,
                                activeColor: Colors.green,
                              );
                            });
                      } else if (snapshot.hasError) {
                        return Text(snapshot.error.toString());
                      }
                      return const CircularProgressIndicator();
                    },
                  ),
                  Expanded(child: Container()),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                      child: SizedBox(
                        height: 56,
                        width: double.infinity,
                        child: FilledButton(
                          onPressed: () {
                            // _apiService.updateLanguage()
                            SharedPreferencesHelper.setLanguageCode(
                                selectedLanguage);
                            context.replace('/intro');
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
                          child: const Text('Confirm',
                              style: TextStyle(
                                  color: Color(0xffFFFFFF),
                                  fontSize: 16,
                                  fontFamily: 'Rubik',
                                  fontWeight: FontWeight.w500)),
                        ),
                      ),
                    ),
                  )
                ],
              ))),
    );
  }
}
