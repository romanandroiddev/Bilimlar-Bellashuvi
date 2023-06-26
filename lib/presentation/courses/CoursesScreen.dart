import 'dart:math';

import 'package:bilimlar_bellashuvi/components/styles.dart';
import 'package:bilimlar_bellashuvi/data/local/SharedPreferencesHelper.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';
import 'package:socket_io_client/socket_io_client.dart';

class CoursesScreen extends StatefulWidget {
  const CoursesScreen({Key? key}) : super(key: key);

  @override
  State<CoursesScreen> createState() => _CoursesScreenState();

  void initSocket() async {
    String token = await SharedPreferencesHelper.getToken();
    Socket socket = io(
        'http://192.168.88.178:80',
        OptionBuilder()
            .setTransports(['websocket'])
            .disableAutoConnect()
            .setExtraHeaders({'Authorization': token})
            .build());
    socket.connect();
    socket.onConnect((_) {
      print('Connection established');
    });
    socket.onDisconnect((_) => print('Connection Disconnection'));
    socket.onError((err) => print(err));
  }
}

class _CoursesScreenState extends State<CoursesScreen> {
  @override
  Widget build(BuildContext context) {
    widget.initSocket();
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(left: 16, top: 16),
                child: Text('Hello,', style: TextStyles.paragraphLarge),
              ),
              Container(
                width: double.infinity,
                height: 42,
                margin: const EdgeInsets.only(left: 16, top: 4),
                child: FutureBuilder(
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return Text(
                            snapshot.data != null
                                ? snapshot.data ?? 'User'
                                : 'User',
                            style: TextStyles.display3);
                      } else {
                        return Container(
                          margin: const EdgeInsets.only(right: 48),
                          child: Shimmer.fromColors(
                            baseColor: Colors.black12,
                            highlightColor: Colors.white,
                            child: Text(
                              'Loading name...',
                              style: TextStyles.display3,
                            ),
                          ),
                        );
                      }
                    },
                    future: SharedPreferencesHelper.getName()),
              ),
              Container(
                width: double.infinity,
                height: 2,
                color: Colors.black12,
                margin: const EdgeInsets.only(top: 8),
              ),
              Container(
                margin: const EdgeInsets.only(left: 12, right: 12, top: 24),
                width: double.infinity,
                child: Row(
                  children: [
                    Lottie.asset('assets/Have fun.json',
                        width: 100, height: 100, repeat: true),
                    const SizedBox(width: 12),
                    Expanded(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Share the fun. Invite a friend!',
                          style: TextStyles.paragraphMedium,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        SizedBox(
                          height: 50,
                          width: double.infinity,
                          child: FilledButton(
                            onPressed: () {},
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                )),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        const Color(0xFFE3562A))),
                            child: const Text('INVITE NOW',
                                style: TextStyle(
                                    color: Color(0xffFFFFFF),
                                    fontSize: 16,
                                    fontFamily: 'Rubik',
                                    fontWeight: FontWeight.w500)),
                          ),
                        )
                      ],
                    ))
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                height: 6,
                color: Colors.black12,
                margin: const EdgeInsets.only(top: 16),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12, right: 12, top: 16),
                child: SizedBox(
                  width: double.infinity,
                  child: Text('Code challenge:', style: TextStyles.heading2),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12, right: 12, top: 4),
                child: SizedBox(
                  width: double.infinity,
                  child: Text(
                    'Choose your coding language ans select an opponent to test your might',
                    style: TextStyles.paragraphMedium,
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(top: 12, left: 12, right: 12),
                decoration: BoxDecoration(
                    image: const DecorationImage(
                        image: AssetImage('assets/Background Versus.png'),
                        fit: BoxFit.cover),
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(12)),
                child: Column(
                  children: [
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        const SizedBox(width: 32),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            FutureBuilder(
                              future: SharedPreferencesHelper.getAvatar(),
                              builder: (context, snapshot) {
                                return Container(
                                  height: 64,
                                  width: 64,
                                  margin: const EdgeInsets.only(bottom: 8),
                                  decoration: BoxDecoration(
                                      color: Colors.blue,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          width: 2, color: Colors.black26)),
                                  child: ClipOval(
                                    child: Image.network(
                                      snapshot.data ?? '',
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return const Icon(
                                          Icons.person,
                                          size: 64,
                                          color: Colors.white,
                                        );
                                      },
                                    ),
                                  ),
                                );
                              },
                            ),
                            Text('You', style: TextStyles.paragraphMediumWhite),
                            const Text('Select opponent',
                                style: TextStyle(
                                    fontFamily: 'Rubik',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    color: Colors.transparent))
                          ],
                        ),
                        Expanded(child: Container()),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(bottom: 8),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.blue,
                              ),
                              child: const ClipOval(
                                child: Icon(
                                  Icons.person,
                                  size: 64,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Text('Select opponent',
                                style: TextStyles.paragraphMediumWhite),
                            const Text('You',
                                style: TextStyle(color: Colors.transparent))
                          ],
                        ),
                        const SizedBox(width: 32),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                      child: SizedBox(
                        height: 36,
                        width: double.infinity,
                        child: FilledButton(
                          onPressed: () {
                            context.push('/searchUser');
                          },
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                              )),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  const Color(0xFFFFFFFF))),
                          child: const Text('Start a challenge',
                              style: TextStyle(
                                  color: Color(0xffE3562A),
                                  fontSize: 16,
                                  fontFamily: 'Rubik',
                                  fontWeight: FontWeight.w500)),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                height: 6,
                color: Colors.black12,
                margin: const EdgeInsets.only(top: 16),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 12, top: 16),
                        child: SizedBox(
                          width: double.infinity,
                          child:
                              Text('Active users:', style: TextStyles.heading2),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 12, top: 4),
                        child: SizedBox(
                          width: double.infinity,
                          child: Text(
                            'See active users and do new friends via our app',
                            style: TextStyles.paragraphMedium,
                          ),
                        ),
                      ),
                    ],
                  )),
                  Container(
                    width: 150,
                    height: 64,
                    margin: const EdgeInsets.only(right: 12, top: 16),
                    child: FilledButton(
                      style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          )),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.deepOrangeAccent)),
                      onPressed: () {},
                      child: const Text('See'),
                    ),
                  ),
                ],
              ),
              Container(
                width: double.infinity,
                height: 6,
                color: Colors.black12,
                margin: const EdgeInsets.only(top: 16),
              ),
              Row(
                children: [
                  Expanded(
                      child: Column(
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 12, right: 12, top: 16),
                        child: SizedBox(
                          width: double.infinity,
                          child:
                              Text('Leaderboard:', style: TextStyles.heading2),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 12, right: 0, top: 4),
                        child: SizedBox(
                          width: double.infinity,
                          child: Text(
                            'See leaders and get motivation to win your opponents',
                            style: TextStyles.paragraphMedium,
                          ),
                        ),
                      ),
                    ],
                  )),
                  const SizedBox(
                    width: 12,
                  ),
                  Lottie.asset('assets/Leadership.json',
                      height: 100, width: 100, repeat: true),
                  const SizedBox(
                    width: 12,
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 32, right: 12, left: 12),
                child: SizedBox(
                  height: 56,
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () async {},
                    style: ButtonStyle(
                        side: MaterialStateProperty.all<BorderSide>(
                            const BorderSide(
                                color: Color(0xFFE3562A), width: 2)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        )),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color(0xFFFFFFFF))),
                    child: const Text('Open leaderboard',
                        style: TextStyle(
                            color: Color(0xFFE3562A),
                            fontSize: 16,
                            fontFamily: 'Rubik',
                            fontWeight: FontWeight.w500)),
                  ),
                ),
              ),
              Container(
                  width: double.infinity,
                  height: 6,
                  color: Colors.black12,
                  margin: const EdgeInsets.only(top: 16)),
            ],
          ),
        ),
      ),
    );
  }
}
