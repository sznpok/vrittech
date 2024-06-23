import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vrititech/constants/image_constant.dart';
import 'package:vrititech/services/google_sign_in.dart';

import '../constants/color_constant.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Platform.isAndroid
                ? GestureDetector(
                    onTap: () async {
                      AuthMethods authMethod = AuthMethods();
                      await authMethod.signInWithGoogle();
                    },
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 8.0,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset(
                              ImageConstant.googleImage,
                              width: 30,
                              height: 30,
                            ),
                            const SizedBox(
                              width: 8.0,
                            ),
                            Text(
                              "Sign in with Google",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                    color: textColor,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : Card(
                    color: primaryColor,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 8.0,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset(
                            ImageConstant.appleImage,
                            width: 30,
                            height: 30,
                            color: Colors.white,
                          ),
                          const SizedBox(
                            width: 8.0,
                          ),
                          Text(
                            "Sign in with Google",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                  color: Colors.white,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
