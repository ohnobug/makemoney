import 'package:vigaviga/widgets/viga_app_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vigaviga/themes.dart';

import 'package:vigaviga/store/viga_system_cubit.dart';
import 'package:vigaviga/store/viga_user_cubit.dart';
import 'package:vigaviga/tools/viga_tools.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class VigaMyMessage extends StatefulWidget {
  const VigaMyMessage(
      {super.key, required this.message, required this.showName, this.name});

  final String? name;
  final bool showName;
  final String message;

  @override
  State<VigaMyMessage> createState() => _VigaMyMessage();
}

class _VigaMyMessage extends State<VigaMyMessage> {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    // 对方发的消息
    return BlocBuilder<VigaSystemCubit, SystemState>(
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
                            BlocBuilder<VigaUserCubit, UserState>(
                              builder: (context, userState) {
                                return Text(
                                  widget.name ?? userState.userinfoName!,
                                  style: TextStyle(
                                    height: 1.08,
                                    fontSize: fontSizeScale(20.w),
                                    color: AppColors.neutralGrey66,
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
                                color: AppColors.brandGreenLighter,
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
                                fontSize: fontSizeScale(31.w),
                                color: theme.colorScheme.onSurface,
                              ),
                            ),
                          ),
                        ),

                        // 箭头
                        Container(
                          padding: const EdgeInsets.only(top: 32, right: 10).w,
                          child: Image.asset(
                            assetPath("images/right.png"),
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
                  Navigator.pushNamed(context, '/chat/friend_profile',
                      arguments: <String, String>{
                        'name':
                            context.read<VigaUserCubit>().state.userinfoName!,
                        'avatar':
                            context.read<VigaUserCubit>().state.userinfoAvatar!,
                        'nickname':
                            context.read<VigaUserCubit>().state.userinfoName!,
                        'account':
                            context.read<VigaUserCubit>().state.userinfoAccount!,
                      });
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8).w,
                  child: VigaAppNetworkImage(
                    imageUrl:
                        context.read<VigaUserCubit>().state.userinfoAvatar!,
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
