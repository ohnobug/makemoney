import 'package:flutter/material.dart';
import 'package:jiaoyishuoflutter3/components/LJNAddButton.dart';
import 'package:jiaoyishuoflutter3/components/LJNAppBar.dart';
import 'package:jiaoyishuoflutter3/store.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LJNBindNewPhoneNumber extends StatefulWidget {
  const LJNBindNewPhoneNumber({super.key});

  @override
  State<LJNBindNewPhoneNumber> createState() => _LJNBindNewPhoneNumber();
}

class _LJNBindNewPhoneNumber extends State<LJNBindNewPhoneNumber> {
  bool isHide = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<StoreType, StoreType>(
        converter: (store) => store.state,
        builder: (context, vm) {
          return _buildPage(context, vm);
        });
  }

  // 另起一个函数方便管理
  Widget _buildPage(BuildContext context, StoreType vm) {
    Size screenSize = MediaQuery.of(context).size;

    String phone = vm.userinfoPhone is String ? vm.userinfoPhone! : "";

    if (isHide) {
      phone =
          '${phone.substring(0, 6)}${'*' * (phone.length - 10)}${phone.substring(phone.length - 4, phone.length)}';
    }

    return Scaffold(
        primary: false,
        resizeToAvoidBottomInset: false,
        appBar: const LJNAppBar(
          title: "填写验证码",
        ),
        body: ScrollConfiguration(
            behavior:
                ScrollConfiguration.of(context).copyWith(scrollbars: false),
            child: Container(
                constraints: BoxConstraints(
                    minHeight: screenSize.height - 90.w - vm.statusHeight!),
                color: const Color.fromARGB(255, 237, 237, 237),
                child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(
                        parent: BouncingScrollPhysics()),
                    child: Container(
                      padding: EdgeInsets.only(left: 30.w, right: 30.w),
                      height: 100.w,
                      width: screenSize.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                              flex: 1,
                              child: TextField(
                                style: TextStyle(
                                  fontSize: 30.w,
                                ),
                                autofocus: true,
                                cursorColor:
                                    const Color.fromRGBO(62, 174, 86, 1.0),
                                cursorWidth: 1.w,
                                onTapOutside: (event) {
                                  FocusScope.of(context).unfocus();
                                },
                                decoration: InputDecoration(
                                  hintText: '请输入验证码',
                                  hintStyle: TextStyle(
                                      fontSize: 30.w,
                                      color: const Color.fromARGB(
                                          255, 147, 147, 147)),
                                  labelText: '',
                                  isDense: true,
                                  border: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1.5.w,
                                        color: const Color.fromARGB(
                                            255, 104, 199, 145)),
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1.5.w,
                                        color: const Color.fromARGB(
                                            255, 104, 199, 145)),
                                  ),
                                  // 获取焦点时的底线样式
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1.5.w,
                                        color: const Color.fromARGB(
                                            255, 104, 199, 145)),
                                  ),
                                  contentPadding:
                                      EdgeInsets.only(bottom: 20.w), // 也可调小内边距
                                ),
                              )),
                          SizedBox(
                            width: 20.w,
                          ),
                          LJNAddButton(
                              title: "下一步",
                              backgroundColor:
                                  const Color.fromARGB(255, 74, 193, 99),
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('提示'),
                                      content: const Text('请正确输入验证码'),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('确定'),
                                        )
                                      ],
                                    );
                                  },
                                );
                              })
                        ],
                      ),
                    )))));
  }
}
