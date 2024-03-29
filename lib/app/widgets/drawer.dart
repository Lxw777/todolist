import 'dart:ffi';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';
import 'package:todolist/app/const/theme.dart';
import 'package:todolist/app/data/provideData/checkinProvider.dart';
import 'package:todolist/app/data/provideData/userInfoProvider.dart';
import 'package:todolist/app/pages/darkMode.dart';
import 'package:todolist/app/pages/intro.dart';
import 'package:todolist/app/pages/userInfo.dart';
import 'package:todolist/app/pages/login.dart';
import 'package:todolist/app/pages/setting.dart';
import 'package:todolist/app/widgets/panel.dart';

import 'package:todolist/main.dart';
import 'package:todolist/model/userInfo.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserInfo user = Provider.of<UserInfoProvider>(context).readUserInfo();

    return Drawer(
      child: MediaQuery.removePadding(
        context: context,
        //移除抽屉菜单顶部默认留白
        removeTop: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 38.0),
              child: GestureDetector(
                onTap: () => Get.to(UserInfoDetail()),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Hero(
                        tag: "avatar",
                        child: ClipOval(
                          child: user.avatar == ''
                              ? Image.asset(
                                  "person.png",
                                  width: 80,
                                )
                              : Image.file(
                                  File(user.avatar!),
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.fill,
                                ),
                          // Image.network(
                          //     user.avatar!,
                          //     width: 80,
                          //     height: 80,
                          //     fit: BoxFit.fill,
                          //   ),
                        ),
                      ),
                    ),
                    Text(
                      user.id!,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView(
                children: <Widget>[
                  // ListTile(
                  //   onTap: () => Get.to(LoginPage()),
                  //   leading: const Icon(Icons.settings_outlined),
                  //   title: Text(
                  //     '测试：登录页',
                  //     style: mytheme.headline2,
                  //   ),
                  // ),
                  // ListTile(
                  //   onTap: (() {
                  //     Provider.of<CheckInProvider>(context, listen: false)
                  //         .writeMap("000001101");
                  //     print(DateTime.parse(
                  //         DateTime.now().toString().replaceRange(8, 10, "01")));

                  //     // int a = pow(2, 32).toInt();
                  //     // print(DateTime.now().year.toString() +
                  //     //     DateTime.now().month.toString());
                  //     // print(a);
                  //   }),
                  //   leading: const Icon(Icons.settings_outlined),
                  //   title: Text(
                  //     '测试：登录页',
                  //     style: mytheme.headline2,
                  //   ),
                  // ),
                  ListTile(
                    onTap: () => Get.to(SettingPage()),
                    leading: const Icon(Icons.settings_outlined),
                    title: Text('设置页面', style: mytheme.headline2),
                  ),
                  ListTile(
                    onTap: () => Get.defaultDialog(
                      title: "打卡成功",
                      content: Container(
                        height: 300,
                        width: 300,
                        color: Colors.transparent,
                        child: RiveAnimation.asset(
                          'assets/done.riv',
                          animations: ["done"],
                        ),
                      ),
                    ),
                    leading: const Icon(Icons.done_all),
                    title: Text('每日打卡', style: mytheme.headline2),
                  ),
                  ListTile(
                    onTap: () {
                      preferences!.setBool("intro", false);
                      Get.to(Intro());
                    },
                    leading: const Icon(Icons.add),
                    title: Text('设置日程', style: mytheme.headline2),
                  ),
                  ListTile(
                    title: InkWell(
                      onTap: () {
                        Get.to(DarkModePage());
                      },
                      child: Text("深色模式", style: mytheme.headline2),
                    ),
                    leading: Theme.of(context).brightness == Brightness.light
                        ? Icon(Icons.brightness_5)
                        : Icon(Icons.brightness_2),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // bool isImageUrl(String url) {
  //   RegExp exp = RegExp(
  //       r"(https?|ftp|file)://[-A-Za-z0-9+&@#/%?=~_|!:,.;]+[-A-Za-z0-9+&@#/%=~_|]");
  //   return exp.hasMatch(url);
  // }
}
