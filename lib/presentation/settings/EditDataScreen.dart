import 'dart:io';

import 'package:bilimlar_bellashuvi/components/styles.dart';
import 'package:bilimlar_bellashuvi/data/local/SharedPreferencesHelper.dart';
import 'package:bilimlar_bellashuvi/presentation/utils/ProgressBarUtils.dart';
import 'package:bilimlar_bellashuvi/presentation/utils/SuccessDialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
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

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  File? image;

  void getDataFromLocalStorage() {
    SharedPreferencesHelper.getName().then((value) {
      _nameController.text = value;
    });
    SharedPreferencesHelper.getLastName().then((value) {
      _lastNameController.text = value;
    });
    SharedPreferencesHelper.getUserName().then((value) {
      _usernameController.text = value;
    });
  }

  Future getImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemporary = File(image.path);
      setState(() {
        this.image = imageTemporary;
      });
    } on PlatformException catch (e) {
      debugPrint('Failed to pick image: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    getDataFromLocalStorage();
  }

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
              child: SingleChildScrollView(
                  reverse: true,
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Container(
                              height: 172,
                              width: 172,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      width: 4,
                                      color: const Color(0xff65AAEA))),
                              child: FutureBuilder(
                                future: SharedPreferencesHelper.getAvatar(),
                                builder: (context, snapshot) {
                                  return ClipOval(
                                      child: image != null
                                          ? Image.file(
                                              File(image!.path),
                                              fit: BoxFit.cover,
                                              errorBuilder:
                                                  (context, error, stackTrace) {
                                                return SvgPicture.asset(
                                                    'assets/Cool Kids Bust.svg');
                                              },
                                            )
                                          : snapshot.connectionState ==
                                                  ConnectionState.done
                                              ? Image.network(
                                                  snapshot.data ?? '',
                                                  fit: BoxFit.cover,
                                                  errorBuilder: (context, error,
                                                      stackTrace) {
                                                  return SvgPicture.asset(
                                                      'assets/Cool Kids Bust.svg');
                                                })
                                              : Shimmer.fromColors(
                                                  baseColor: Colors.black12,
                                                  highlightColor: Colors.white,
                                                  child: Container(
                                                    width: double.infinity,
                                                    height: double.infinity,
                                                    color: Colors.black,
                                                  )));
                                },
                              )),
                          Positioned(
                              right: 8,
                              bottom: 0,
                              child: GestureDetector(
                                onTap: () {
                                  getImage();
                                },
                                child: Container(
                                  width: 48,
                                  height: 48,
                                  decoration: const BoxDecoration(
                                      color: Colors.deepOrange,
                                      shape: BoxShape.circle),
                                  child: const Icon(
                                    Icons.edit,
                                    size: 24,
                                    color: Colors.white,
                                  ),
                                ),
                              ))
                        ],
                      ),
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.fromLTRB(16, 16, 0, 0),
                        child: Text('First Name',
                            style: TextStyles.paragraphMedium),
                      ),
                      Padding(
                          padding: const EdgeInsets.fromLTRB(16, 4, 16, 0),
                          child: TextFormField(
                            controller: _nameController,
                            validator: (text) {
                              if (text == null || text.isEmpty) {
                                return 'First Name should not be empty';
                              }
                              return null;
                            },
                            style: const TextStyle(
                                fontFamily: 'Rubik',
                                fontWeight: FontWeight.w400),
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
                          )),
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.fromLTRB(16, 16, 0, 0),
                        child: Text('Last name',
                            style: TextStyles.paragraphMedium),
                      ),
                      Padding(
                          padding: const EdgeInsets.fromLTRB(16, 4, 16, 0),
                          child: TextFormField(
                            controller: _lastNameController,
                            validator: (text) {
                              if (text == null || text.isEmpty) {
                                return 'Last Name should not be empty';
                              }
                              return null;
                            },
                            style: const TextStyle(
                                fontFamily: 'Rubik',
                                fontWeight: FontWeight.w400),
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
                          )),
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.fromLTRB(16, 16, 0, 0),
                        child:
                            Text('Username', style: TextStyles.paragraphMedium),
                      ),
                      Padding(
                          padding: const EdgeInsets.fromLTRB(16, 4, 16, 0),
                          child: TextFormField(
                            controller: _usernameController,
                            validator: (text) {
                              if (text == null || text.isEmpty) {
                                return 'Username should not be empty';
                              }
                              return null;
                            },
                            style: const TextStyle(
                                fontFamily: 'Rubik',
                                fontWeight: FontWeight.w400),
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
                          )),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(16, 100, 16, 16),
                          child: SizedBox(
                            height: 56,
                            width: double.infinity,
                            child: FilledButton(
                              onPressed: () async {
                                if (image != null) {
                                  ProgressBarUtils(context).startLoading();
                                  _apiService
                                      .uploadPhoto(image!)
                                      .then((value) async {
                                    if (value) {
                                      FocusScope.of(context).unfocus();
                                      TextEditingController().clear();
                                      await _apiService
                                          .update(
                                              _nameController.value.text,
                                              _lastNameController.value.text,
                                              _usernameController.value.text)
                                          .then((value) {
                                        if (value.statusCode == 200) {
                                          ProgressBarUtils(context)
                                              .stopLoading();
                                          SuccessDialog(context).startSuccessDialog(
                                              'You have successfully updated your profile',
                                              () {
                                            SuccessDialog(context)
                                                .stopLoading();
                                            context.pop();
                                          });
                                        }
                                      }).catchError((error) {
                                        ProgressBarUtils(context).stopLoading();
                                        var snackBar =
                                            SnackBar(content: Text(error));
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackBar);
                                      });
                                    }
                                  }).catchError((error) {
                                    ProgressBarUtils(context).stopLoading();
                                    var snackBar = SnackBar(
                                        content: Text(error.toString()));
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  });
                                } else {

                                    FocusScope.of(context).unfocus();
                                    TextEditingController().clear();
                                    ProgressBarUtils(context).startLoading();
                                    await _apiService
                                        .update(
                                            _nameController.value.text,
                                            _lastNameController.value.text,
                                            _usernameController.value.text)
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
                                      var snackBar =
                                          SnackBar(content: Text(error));
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
                              child: const Text('Save',
                                  style: TextStyle(
                                      color: Color(0xffFFFFFF),
                                      fontSize: 16,
                                      fontFamily: 'Rubik',
                                      fontWeight: FontWeight.w500)),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom))
                    ],
                  ))),
        ));
  }
}
