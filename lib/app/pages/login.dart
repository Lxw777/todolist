import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:rive/rive.dart';
import 'package:todolist/app/const/colors.dart';
import 'package:todolist/app/widgets/gradientButton.dart';
import 'package:todolist/app/widgets/myApplication.dart';
import 'package:todolist/dio/DioUtil.dart';
import 'package:todolist/util/loadingUtil.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).brightness == Brightness.dark
        ? darkcolor
        : lightcolor;
    TextEditingController userController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            width: MediaQuery.of(context).size.width * 1.7,
            left: 100,
            bottom: 100,
            child: Image.asset(
              "assets/Spline.png",
            ),
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
              child: const SizedBox(),
            ),
          ),
          const RiveAnimation.asset(
            "assets/shapes.riv",
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
              child: const SizedBox(),
            ),
          ),
          Positioned(
            right: 0,
            left: 0,
            bottom: 100,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, bottom: 170),
                  child: Text(
                    "Keep & \tGoing On",
                    style: TextStyle(
                      fontSize: 60,
                      fontWeight: FontWeight.w700,
                      color: color,
                      fontFamily: "MiSans",
                      height: 1.2,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 24.0),
                      TextFormField(
                        controller: userController,
                        decoration: InputDecoration(
                          labelText: '账号',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                      SizedBox(height: 16.0),
                      TextFormField(
                        controller: passwordController,
                        decoration: InputDecoration(
                          labelText: '密码',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        obscureText: true,
                      ),
                      SizedBox(height: 16.0),
                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () async {},
                          child: Text(
                            '修改密码',
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 16.0),
                      GradientButton(
                        child: Text('登录'),
                        tapCallback: () async {
                          print(1);
                          // HubUtil.show(msg: "登录中", dismissOnTap: false);
                          Map<String, String> params = {
                            "phoneNum": "${userController.text}",
                            "password": "${passwordController.text}"
                          };

                          var result = await DioUtil().request('login/login',
                              params: params, method: DioMethod.post);
                          // print(result.runtimeType);
                          // print(result);

                          // if (result["msg"] == "") Get.to(MyApplication());
                          // HubUtil.dismiss;
                          print(result);
                        },
                        borderRadius: BorderRadius.circular(10),
                        colors: [color.withOpacity(0.5), color],
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
