import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:todolist/app/const/colors.dart';
import 'package:todolist/app/const/extensions.dart';
import 'package:todolist/app/widgets/doingList.dart';
import 'package:todolist/app/widgets/doneList.dart';
import 'package:todolist/controller/homeController.dart';

//具体添加
class DetailPage extends StatelessWidget {
  DetailPage({Key? key}) : super(key: key);
  final control = Get.find<Homecontroller>();
  @override
  Widget build(BuildContext context) {
    var task = control.task.value;
    var color = HexColor.fromHex(task!.color);
    return WillPopScope(
      onWillPop: () async {
        Get.back();
        control.updateTodos();
        control.changeTask(null);
        control.titlecontroller.clear();
        return true;
      },
      child: Scaffold(
        body: SafeArea(
            child: Form(
          key: control.formkey,
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.all(3.0.wp),
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Get.back();
                          control.updateTodos();
                          control.changeTask(null);
                          control.titlecontroller.clear();
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                          color: lightcolor,
                        ))
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0.wp),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 2.0.wp),
                      child: Icon(
                          IconData(
                            task.icon,
                            fontFamily: 'MyFlutterApp',
                          ),
                          color: color,
                          size: 35),
                    ),
                    SizedBox(
                      width: 3.0.wp,
                    ),
                    Expanded(
                      child: Text(
                        task.title,
                        style: Theme.of(context).textTheme.headline4,
                        softWrap: true,
                        maxLines: 2,
                      ),
                    )
                  ],
                ),
              ),
              Obx(() {
                var totalTodos =
                    control.doingTodos.length + control.doneTodos.length;
                return Padding(
                  padding: EdgeInsets.only(
                      left: 16.0.wp,
                      top: 6.0.wp,
                      bottom: 6.0.wp,
                      right: 16.0.wp),
                  child: Row(
                    children: [
                      Text(
                        "$totalTodos 个任务",
                        style: Theme.of(context).textTheme.headline2,
                      ),
                      SizedBox(
                        width: 3.0.wp,
                      ),
                      Expanded(
                          child: StepProgressIndicator(
                        totalSteps: totalTodos == 0 ? 1 : totalTodos,
                        currentStep: control.doneTodos.length,
                        size: 5,
                        roundedEdges: Radius.circular(10),
                        padding: 0,
                        selectedGradientColor: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [color.withOpacity(0.4), color]),
                        unselectedGradientColor: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [Colors.grey[300]!, Colors.grey[300]!]),
                      ))
                    ],
                  ),
                );
              }),
              Padding(
                padding:
                    EdgeInsets.symmetric(vertical: 2.0.wp, horizontal: 5.0.wp),
                child: TextFormField(
                  controller: control.titlecontroller,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                      labelText: '添加 To-Do',
                      suffixIcon: IconButton(
                          onPressed: () {
                            if (control.formkey.currentState!.validate()) {
                              var success =
                                  control.addTodo(control.titlecontroller.text);
                              if (success)
                                EasyLoading.showSuccess('To-Do 添加成功');
                              else
                                EasyLoading.showError('To-Do 已存在');

                              control.titlecontroller.clear();
                            }
                          },
                          icon: Icon(
                            Icons.done,
                            color: lightcolor,
                          ))),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return '请确认你的To-Do';
                    }
                    return null;
                  },
                ),
              ),
              DoingList(),
              DoneList(),
            ],
          ),
        )),
      ),
    );
  }
}
