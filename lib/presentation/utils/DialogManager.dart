import 'package:bilimlar_bellashuvi/components/styles.dart';
import 'package:bilimlar_bellashuvi/data/remote/api_servise.dart';
import 'package:bilimlar_bellashuvi/presentation/utils/SuccessDialog.dart';
import 'package:flutter/material.dart';

class DialogManager {
  late BuildContext context;

  DialogManager(this.context);

  Future<void> openDialogToChangeUserName(ApiService api, String hint, String paramName) async {
    final _form = GlobalKey<FormState>();
    String value = '';
    return await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
            backgroundColor: Colors.transparent,
            child: Form(
              key: _form,
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(12.0)),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Wrap(
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: TextFormField(
                            validator: (text) {
                              if (text == null || text.isEmpty) {
                                return 'Field should not be empty';
                              }
                              return null;
                            },
                            onChanged: (text) {
                              value = text;
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
                              hintText: hint,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
                          child: SizedBox(
                            height: 56,
                            width: double.infinity,
                            child: FilledButton(
                              onPressed: () {
                                stopDialog();
                                if (_form.currentState!.validate()) {
                                  FocusScope.of(context).unfocus();
                                  TextEditingController().clear();
                                  api.update(value, paramName).then((value) {
                                    SuccessDialog(context).startSuccessDialog(
                                        '$hint was successfully updated', () {
                                      stopDialog();
                                    });
                                  }).catchError((onError) {});
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
                              child: const Text('Save',
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
              ),
            ));
      },
    );
  }

  Future<void> openDialogToChangeFullName(ApiService api) async {
    String name = '';
    String lastName = '';
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
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Wrap(
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: TextFormField(
                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return 'First name should not be empty';
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
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: TextFormField(
                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return 'Last name should not be empty';
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
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
                        child: SizedBox(
                          height: 56,
                          width: double.infinity,
                          child: FilledButton(
                            onPressed: () {
                              api.updateFullName(name, lastName).then((value) {
                                stopDialog();
                                SuccessDialog(context).startSuccessDialog(
                                    'Full name was successfully updated', () {
                                  stopDialog();
                                });
                              }).catchError((onError) {});
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
                            child: const Text('Save',
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

  Future<void> stopDialog() async {
    Navigator.of(context).pop();
  }
}
