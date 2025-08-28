import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spicychat/colors.dart';
import 'package:spicychat/screens/components/ljn_appbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spicychat/store/ljn_system_cubit.dart';
import '../components/ljn_function_item.dart';

class LJNMoreSecureSetting extends StatefulWidget {
  const LJNMoreSecureSetting({super.key});

  @override
  State<LJNMoreSecureSetting> createState() => _LJNAaccountAndSecure();
}

class _LJNAaccountAndSecure extends State<LJNMoreSecureSetting> {
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
            title: "更多安全设置",
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
                      title: "QQ号",
                      link: '/',
                      showStyle: "2281551151",
                      underline: true,
                    ),
                    const LJNFunctionItem(
                      title: "邮箱地址",
                      link: '/',
                      showStyle: "未绑定",
                      underline: false,
                    ),
                    SizedBox(height: 16.w),
                    const LJNFunctionItem(
                      title: "手机安全防护",
                      link: '/',
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
