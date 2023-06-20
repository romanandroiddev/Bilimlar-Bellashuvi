import 'package:bilimlar_bellashuvi/data/local/SharedPreferencesHelper.dart';
import 'package:bilimlar_bellashuvi/data/models/GetMeData.dart';
import 'package:bilimlar_bellashuvi/presentation/utils/DialogManager.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shimmer/shimmer.dart';

import '../../components/styles.dart';
import '../../data/remote/api_servise.dart';

class SettingsScreen extends StatelessWidget {
  final ApiService _apiService = ApiService();

  SettingsScreen({Key? key}) : super(key: key);

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
          'Settings',
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
        child: SingleChildScrollView(
          child: FutureBuilder<GetMeData>(
              future: _apiService.getMe(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.data != null) {
                  SharedPreferencesHelper.setName(
                      snapshot.data!.payload!.firstName);
                  SharedPreferencesHelper.setEmailAddress(
                      snapshot.data!.payload!.email);
                  SharedPreferencesHelper.setPhoneNumber(
                      snapshot.data!.payload!.phoneNumber);
                  SharedPreferencesHelper.setUserName(
                      snapshot.data!.payload!.username);
                  SharedPreferencesHelper.setAvatar(
                      snapshot.data!.payload!.avatar);
                }
                return Column(
                  children: [
                    SizedBox(
                        height: 172,
                        width: 172,
                        child: Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    width: 4, color: const Color(0xff65AAEA))),
                            child: ClipOval(
                                child: snapshot.connectionState ==
                                        ConnectionState.done
                                    ? CachedNetworkImage(
                                        fit: BoxFit.fitHeight,
                                        imageUrl: (snapshot.data != null
                                                ? snapshot.data!.payload!.avatar
                                                : '') ??
                                            '',
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
                                        ))))),
                    Container(
                      height: 80,
                      width: double.infinity,
                      margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                      child: OutlinedButton(
                          onPressed: () {
                            DialogManager(context).openDialogToChangeUserName(
                                _apiService, 'Username', 'username');
                          },
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0),
                            )),
                          ),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                  height: 32,
                                  width: 32,
                                  'assets/Profile Circle.svg'),
                              const SizedBox(width: 12),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Username', style: TextStyles.heading1),
                                  Text(
                                    (snapshot.data != null
                                            ? snapshot.data!.payload!.username
                                            : 'e.g username') ??
                                        'e.g username',
                                    style: TextStyles.paragraphMedium,
                                  )
                                ],
                              )
                            ],
                          )),
                    ),
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.fromLTRB(16, 16, 0, 0),
                      child: Text('Account information',
                          style: TextStyles.heading2),
                    ),
                    Container(
                        height: 80,
                        width: double.infinity,
                        margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                        child: OutlinedButton(
                          onPressed: () {
                            DialogManager(context)
                                .openDialogToChangeFullName(_apiService);
                          },
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0),
                            )),
                          ),
                          child: Container(
                            width: double.infinity,
                            height: double.infinity,
                            alignment: Alignment.centerLeft,
                            child: Row(
                              children: [
                                SizedBox(
                                    width: 32,
                                    height: 32,
                                    child: SvgPicture.asset(
                                        'assets/Profile Circle.svg',
                                        width: 32,
                                        height: 32)),
                                const SizedBox(width: 12),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('Full name',
                                        style: TextStyles.heading1),
                                    Text(
                                      (snapshot.data != null
                                              ? '${snapshot.data!.payload!.firstName} ${snapshot.data!.payload!.lastName ?? ''}'
                                              : '') ??
                                          '',
                                      style: TextStyles.paragraphMedium,
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        )),
                    Container(
                        height: 80,
                        width: double.infinity,
                        margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                        child: OutlinedButton(
                          onPressed: () {},
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0),
                            )),
                          ),
                          child: Container(
                            width: double.infinity,
                            height: double.infinity,
                            alignment: Alignment.centerLeft,
                            child: Row(
                              children: [
                                SizedBox(
                                    width: 32,
                                    height: 32,
                                    child: SvgPicture.asset(
                                        'assets/Email Circle.svg')),
                                const SizedBox(width: 12),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('Umail', style: TextStyles.heading1),
                                    Text(
                                      (snapshot.data != null
                                              ? snapshot.data!.payload!.email
                                              : 'e.g test@umail.com') ??
                                          'e.g test@umail.com',
                                      style: TextStyles.paragraphMedium,
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        )),
                    Container(
                        height: 80,
                        width: double.infinity,
                        margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                        child: OutlinedButton(
                          onPressed: () {},
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0),
                            )),
                          ),
                          child: Container(
                            width: double.infinity,
                            height: double.infinity,
                            alignment: Alignment.centerLeft,
                            child: Row(
                              children: [
                                SizedBox(
                                    width: 32,
                                    height: 32,
                                    child: SvgPicture.asset(
                                        'assets/Email Circle.svg')),
                                const SizedBox(width: 12),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('Phone', style: TextStyles.heading1),
                                    Text(
                                      (snapshot.data != null
                                              ? snapshot
                                                  .data!.payload!.phoneNumber
                                              : 'e.g 998000000000') ??
                                          'e.g 998000000000',
                                      style: TextStyles.paragraphMedium,
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        )),
                    Container(
                        height: 80,
                        width: double.infinity,
                        margin: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                        child: OutlinedButton(
                          onPressed: () {},
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0),
                            )),
                          ),
                          child: Row(
                            children: [
                              SizedBox(
                                  width: 32,
                                  height: 32,
                                  child: SvgPicture.asset(
                                      'assets/Password Circle.svg',
                                      width: 32,
                                      height: 32)),
                              const SizedBox(width: 12),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Password', style: TextStyles.heading1),
                                  Text(
                                    'changed 2 weeks ago',
                                    style: TextStyles.paragraphMedium,
                                  )
                                ],
                              )
                            ],
                          ),
                        )),
                  ],
                );
              }),
        ),
      ),
    );
  }
}
