import 'package:bilimlar_bellashuvi/components/styles.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SuccessDialog {
  late BuildContext context;

  SuccessDialog(this.context);

  Future<void> startSuccessDialog(String body, VoidCallback onTapFinish) async {
    return await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
            backgroundColor: Colors.transparent,
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                shape: BoxShape.rectangle,
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(12.0)),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 48),
              child: Wrap(
                children: [
                  Column(
                    children: [
                      Lottie.asset('assets/success.json',
                          width: 200, height: 200, repeat: false),
                      Text(
                        body,
                        style: TextStyles.paragraphMedium,
                        textAlign: TextAlign.center,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
                        child: SizedBox(
                          height: 56,
                          width: double.infinity,
                          child: FilledButton(
                            onPressed: onTapFinish,
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                    const RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(16)),
                                    )),
                                backgroundColor: MaterialStateProperty.all<Color>(
                                    const Color(0xFFE3562A))),
                            child: const Text('Ok, Understand',
                                style: TextStyle(
                                    color: Color(0xffFFFFFF),
                                    fontSize: 16,
                                    fontFamily: 'Rubik',
                                    fontWeight: FontWeight.w500)),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ));
      },
    );
  }

  Future<void> stopLoading() async {
    Navigator.of(context).pop();
  }
}
