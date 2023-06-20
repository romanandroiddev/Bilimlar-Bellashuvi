import 'package:bilimlar_bellashuvi/components/styles.dart';
import 'package:bilimlar_bellashuvi/data/local/SharedPreferencesHelper.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CoursesScreen extends StatefulWidget {
  const CoursesScreen({Key? key}) : super(key: key);

  @override
  State<CoursesScreen> createState() => _CoursesScreenState();
}

class _CoursesScreenState extends State<CoursesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
          ],
        ),
      ),
    );
  }
}
