import 'package:bilimlar_bellashuvi/components/styles.dart';
import 'package:bilimlar_bellashuvi/data/models/GetUsersResponseData.dart';
import 'package:bilimlar_bellashuvi/data/remote/api_servise.dart';
import 'package:bilimlar_bellashuvi/presentation/utils/ProgressBarUtils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class SearchUserScreen extends StatefulWidget {
  const SearchUserScreen({Key? key}) : super(key: key);

  @override
  State<SearchUserScreen> createState() => _SearchUserScreenState();
}

class _SearchUserScreenState extends State<SearchUserScreen> {
  final ApiService _apiService = ApiService();
  bool isOnlyOnlineUsers = false;

  int _page = 0;
  int itemCount = 0;
  final int _limit = 10;
  String username = '';
  bool _hasNextPage = true;
  bool _isFirstLoadRunning = false;
  bool _isLoadMoreRunning = false;
  List _users = <OpponentUserData>[];

  void _firstLoad() async {
    setState(() {
      _isFirstLoadRunning = true;
    });
    try {
      _apiService
          .getUsers(20, 1, isOnlyOnlineUsers ? 1 : 0, username)
          .then((value) {
        setState(() {
          _users = value.payload!.data;
          itemCount = value.payload!.count;
        });
      });
    } catch (err) {
      if (kDebugMode) {
        print('Something went wrong');
      }
      setState(() {
        _isFirstLoadRunning = false;
      });
    }
  }

  void _loadMore() async {
    if (_hasNextPage == true &&
        _isFirstLoadRunning == false &&
        _isLoadMoreRunning == false &&
        _controller.position.extentAfter < 300) {
      setState(() {
        _isLoadMoreRunning = true; // Display a progress indicator at the bottom
      });
      _page += 1; // Increase _page by 1
      try {
        final res = await _apiService.getUsers(
            _limit, _page, isOnlyOnlineUsers ? 1 : 0, username);

        final List fetchedPosts = res.payload!.data;
        if (fetchedPosts.isNotEmpty) {
          setState(() {
            _users.addAll(fetchedPosts);
          });
        } else {
          setState(() {
            _hasNextPage = false;
          });
        }
      } catch (err) {
        if (kDebugMode) {
          print('Something went wrong!');
        }
      }

      setState(() {
        _isLoadMoreRunning = false;
      });
    }
  }

  late ScrollController _controller;

  @override
  void initState() {
    super.initState();
    _firstLoad();
    _controller = ScrollController()..addListener(_loadMore);
  }

  @override
  void dispose() {
    _controller.removeListener(_loadMore);
    super.dispose();
  }

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
              'Opponents',
            ),
            leading: GestureDetector(
              onTap: () {
                context.pop();
              },
              child: Container(
                margin: const EdgeInsets.fromLTRB(12, 12, 0, 0),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border:
                        Border.all(width: 1, color: const Color(0xffBEBAB3))),
                child: Align(
                  alignment: Alignment.center,
                  child: SvgPicture.asset('assets/Ic Back.svg'),
                ),
              ),
            )),
        body: SafeArea(
            child: Column(children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
            child: TextFormField(
              keyboardType: TextInputType.text,
              onChanged: (text) {
                username = text;
                if (text.length > 2) {
                  setState(() {
                    _users = [];
                    _page = 1;
                    _firstLoad();
                  });
                } else if (username.isEmpty) {
                  _page = 1;
                  _firstLoad();
                }
              },
              style: const TextStyle(
                  fontFamily: 'Rubik', fontWeight: FontWeight.w400),
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: Color(0xffBEBAB3), width: 1.0),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: Color(0xffBEBAB3), width: 1.0),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                hintText: 'Search by username',
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            children: [
              const SizedBox(width: 12),
              SizedBox(
                width: 128,
                child: FilledButton(
                    style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        )),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.deepOrangeAccent)),
                    onPressed: () {
                      ProgressBarUtils(context).startLoading();
                      _apiService.getRandomUser().then((value) {
                        if (value.statusCode == 200) {
                          ProgressBarUtils(context).stopLoading();
                          showRandomUserDialog(value.payload!.username ?? '',
                              value.payload!.firstName, value.payload!.id, value.payload!.avatar);
                        }
                      });
                    },
                    child: Text(
                      'Random user',
                      style: TextStyles.paragraphMediumWhite,
                    )),
              ),
              Expanded(child: Container()),
              Row(
                children: [
                  const SizedBox(width: 12),
                  GestureDetector(
                    child:
                        Text('Only online', style: TextStyles.paragraphMedium),
                    onTap: () {
                      setState(() {
                        isOnlyOnlineUsers = !isOnlyOnlineUsers;
                        _users = [];
                        _page = 1;
                        _firstLoad();
                      });
                    },
                  ),
                  Checkbox(
                    value: isOnlyOnlineUsers,
                    onChanged: (value) {
                      setState(() {
                        isOnlyOnlineUsers = !isOnlyOnlineUsers;
                        _users = [];
                        _page = 1;
                        _firstLoad();
                      });
                    },
                  )
                ],
              )
            ],
          ),
          Container(
            width: double.infinity,
            height: 1,
            color: Colors.black12,
            margin: const EdgeInsets.only(top: 4),
          ),
          Expanded(
            child: ListView.separated(
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(height: 4),
              controller: _controller,
              itemCount: _users.length,
              itemBuilder: (_, index) => SizedBox(
                width: double.infinity,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 12),
                      child: Stack(
                        children: [
                          Container(
                              width: 64,
                              height: 64,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      width: 1.5, color: Colors.deepOrange)),
                              child: Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.black12,
                                    border: Border.all(
                                        width: 2, color: Colors.white)),
                                child: ClipOval(
                                  child: Image.network(
                                    (_users[index] as OpponentUserData)
                                            .avatar ??
                                        '',
                                    errorBuilder: (context, error, stackTrace) {
                                      return const Icon(Icons.person_rounded,
                                          size: 54, color: Colors.white);
                                    },
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              )),
                          if ((_users[index] as OpponentUserData).isOnline)
                            Positioned(
                              right: 4,
                              bottom: 2,
                              child: Container(
                                width: 14,
                                height: 14,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1, color: Colors.white),
                                    color: Colors.white,
                                    shape: BoxShape.circle),
                                child: Container(
                                  width: 12,
                                  height: 12,
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.green),
                                ),
                              ),
                            )
                        ],
                      ),
                    ),
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _users.isNotEmpty
                              ? (_users[index] as OpponentUserData).firstName ??
                                  ''
                              : '',
                          style: TextStyles.paragraphLarge,
                        ),
                        Text(
                            _users.isNotEmpty
                                ? (_users[index] as OpponentUserData)
                                        .username ??
                                    ''
                                : '',
                            style: TextStyles.paragraphMedium),
                      ],
                    )),
                    SizedBox(
                      width: 128,
                      child: FilledButton(
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                              )),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.lightGreen)),
                          onPressed: () {},
                          child: const Text('PLAY')),
                    ),
                    const SizedBox(width: 12)
                  ],
                ),
              ),
            ),
          ),
          if (_isLoadMoreRunning == true)
            const Padding(
              padding: EdgeInsets.only(top: 10, bottom: 40),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          if (_hasNextPage == false)
            Container(
              padding: const EdgeInsets.only(top: 30, bottom: 40),
              color: Colors.amber,
              child: const Center(
                child: Text('You have fetched all of the content'),
              ),
            ),
        ])));
  }

  Future<void> showRandomUserDialog(
      String? username, String name, int id, String? avatar) async {
    return await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            child: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white),
                width: double.infinity,
                child: Wrap(
                  children: [
                    Column(
                      children: [
                        Align(
                          alignment: Alignment.topRight,
                          child: GestureDetector(
                            onTap: () {
                              ProgressBarUtils(context).stopLoading();
                            },
                            child: Container(
                              width: 36,
                              height: 36,
                              margin: const EdgeInsets.all(8),
                              child: const Icon(Icons.close),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Center(
                          child: Text(
                            'Your random opponent',
                            style: TextStyles.heading2,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            const SizedBox(
                              width: 12,
                            ),
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Username: ${username == '' ? '-' : username}',
                                  style: TextStyles.paragraphLarge,
                                ),
                                Text(
                                  'First name: ${name ?? '-'}',
                                  style: TextStyles.paragraphLarge,
                                ),
                              ],
                            )),
                            Container(
                                width: 64,
                                height: 64,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        width: 1.5, color: Colors.deepOrange)),
                                child: Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.black12,
                                      border: Border.all(
                                          width: 2, color: Colors.white)),
                                  child: ClipOval(
                                    child: Image.network(
                                      avatar ?? '',
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return const Icon(Icons.person_rounded,
                                            size: 54, color: Colors.white);
                                      },
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                )),
                            const SizedBox(width: 16)
                          ],
                        ),
                        Container(
                            height: 50,
                            width: double.infinity,
                            margin: const EdgeInsets.fromLTRB(16, 24, 16, 32),
                            child: FilledButton(
                                onPressed: () {},
                                style: ButtonStyle(
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                    )),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            const Color(0xFFE3562A))),
                                child: const Text('Start battle')))
                      ],
                    ),
                  ],
                )));
      },
    );
  }
}
