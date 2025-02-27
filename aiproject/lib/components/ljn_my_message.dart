import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:jiaoyishuoflutter3/store/ljn_system_cubit.dart';
import 'package:jiaoyishuoflutter3/store/ljn_user_cubit.dart';
import 'package:jiaoyishuoflutter3/tools/ljn_tools.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class LJNMyMessage extends StatefulWidget {
  const LJNMyMessage(
      {super.key, required this.message, required this.showName, this.name});

  final String? name;
  final bool showName;
  final String message;

  @override
  State<LJNMyMessage> createState() => _LJNMyMessage();
}

class _LJNMyMessage extends State<LJNMyMessage> {
  @override
  Widget build(BuildContext context) {
    // 对方发的消息
    return BlocBuilder<LJNSystemCubit, SystemState>(
      builder: (context, systemState) {
        return Container(
          padding: EdgeInsets.only(left: 22.w, right: 22.w, top: 22.w),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 姓名与消息
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // 姓名
                    if (widget.showName)
                      Container(
                        padding:
                            const EdgeInsets.only(right: 23, top: 0, bottom: 3)
                                .w,
                        // height: 33.w,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            BlocBuilder<LJNUserCubit, LJNUserState>(
                              builder: (context, userState) {
                                return Text(
                                  widget.name ?? userState.userinfoName!,
                                  style: TextStyle(
                                    height: 1.08,
                                    fontSize: ljnFontSizeScale(20.w),
                                    color: const Color.fromARGB(
                                        255, 130, 130, 130),
                                  ),
                                );
                              },
                            )
                          ],
                        ),
                      ),
                    // 消息
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // 消息
                        Flexible(
                          child: Container(
                            constraints: const BoxConstraints(maxWidth: 510).w,
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 158, 236, 114),
                                borderRadius: BorderRadius.circular(8).w),
                            padding: EdgeInsets.only(
                                top: 20.w,
                                bottom: 18.w,
                                left: 23.w,
                                right: 22.w),
                            child: Text(
                              softWrap: true,
                              maxLines: 1000,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.justify,
                              widget.message,
                              style: TextStyle(
                                height: 1.25,
                                fontSize: ljnFontSizeScale(31.w),
                                color: Colors.black,
                                fontFamily: "AlibabaPuHuiTi",
                              ),
                            ),
                          ),
                        ),

                        // 箭头
                        Container(
                          padding: const EdgeInsets.only(top: 32, right: 10).w,
                          child: Image.asset(
                            assetPath("images/icon/right.png"),
                            width: 10.w,
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // 头像
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/friendprofile',
                      arguments: <String, String>{
                        'name':
                            context.read<LJNUserCubit>().state.userinfoName!,
                        'avatar':
                            context.read<LJNUserCubit>().state.userinfoAvatar!,
                        'nickname':
                            context.read<LJNUserCubit>().state.userinfoName!,
                        'account':
                            context.read<LJNUserCubit>().state.userinfoAccount!,
                      });
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8).w,
                  child: Image.asset(
                    assetPath(
                        context.read<LJNUserCubit>().state.userinfoAvatar!),
                    cacheWidth: 156.w.toInt(),
                    cacheHeight: 156.w.toInt(),
                    width: 78.w,
                    height: 78.w,
                    fit: BoxFit.cover,
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
