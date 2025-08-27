import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spicychat/colors.dart';
import 'package:spicychat/components/ljn_appbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spicychat/store/ljn_system_cubit.dart';
import '../components/ljn_function_item.dart';

class LJNFriendMomentsCoverSetting extends StatefulWidget {
  const LJNFriendMomentsCoverSetting({super.key});

  @override
  State<LJNFriendMomentsCoverSetting> createState() =>
      _LJNFriendMomentsCoverSetting();
}

class _LJNFriendMomentsCoverSetting
    extends State<LJNFriendMomentsCoverSetting> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LJNSystemCubit, SystemState>(
      builder: (context, systemState) {
        return Scaffold(
          primary: false,
          appBar: const LJNAppBar(
            title: "更换相册封面",
          ),
          body: ScrollConfiguration(
            behavior:
                ScrollConfiguration.of(context).copyWith(scrollbars: false),
            child: Container(
              constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height -
                      90.w -
                      systemState.statusHeight),
              color: AppColors.neutralGrey11,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics(),
                ),
                child: Column(
                  children: [
                    const LJNFunctionItem(
                      title: "从手机相册选择",
                      link: '',
                      underline: true,
                    ),
                    const LJNFunctionItem(
                      title: "从视频号选择",
                      link: '',
                      underline: true,
                    ),
                    const LJNFunctionItem(
                      title: "拍一个",
                      link: '',
                      underline: false,
                    ),
                    SizedBox(height: 62.w),
                    const LJNFunctionItem(
                      title: "摄影师作品",
                      link: '',
                      underline: false,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
