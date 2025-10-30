import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vigaviga/themes.dart';
import 'package:vigaviga/l10n/app_localizations.dart';
import 'package:vigaviga/widgets/viga_appbar.dart';
import 'package:vigaviga/store/viga_system_cubit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/widgets/viga_function_list.dart';
import 'package:vigaviga/widgets/viga_max_width_button.dart';

class VigaComplainPage extends StatefulWidget {
  const VigaComplainPage({super.key});

  @override
  State<VigaComplainPage> createState() => _VigaComplainState();
}

class _VigaComplainState extends State<VigaComplainPage> {
  final TextEditingController _complainController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _complainController.dispose();
    _contactController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    AppLocalizations l10n = AppLocalizations.of(context)!;

    return BlocBuilder<VigaSystemCubit, SystemState>(
      builder: (context, systemState) {
        return Theme(
          data: theme.copyWith(
            appBarTheme: theme.appBarTheme.copyWith(
              backgroundColor: Colors.transparent,
            ),
          ),
          child: Scaffold(
            primary: false,
            appBar: VigaAppBar(
              title: l10n.complain,
            ),
            body: ScrollConfiguration(
              behavior:
                  ScrollConfiguration.of(context).copyWith(scrollbars: false),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics(),
                ),
                child: Container(
                  width: 750.w,
                  constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height -
                        (systemState.statusHeight + 90.w),
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20.w),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "问题描述",
                                style: TextStyle(
                                  fontSize: 32.w,
                                  fontWeight: FontWeight.w600,
                                  color: theme.primaryColorDark,
                                ),
                              ),
                              SizedBox(height: 20.w),
                              Container(
                                height: 300.w,
                                decoration: BoxDecoration(
                                  color: AppColors.neutralWhite,
                                  borderRadius: BorderRadius.circular(20.w),
                                  border: Border.all(
                                    color: AppColors.neutralGrey13,
                                    width: 2.w,
                                  ),
                                ),
                                child: TextFormField(
                                  controller: _complainController,
                                  maxLines: null,
                                  maxLength: 500,
                                  decoration: InputDecoration(
                                    hintText: "请详细描述您遇到的问题或建议...",
                                    hintStyle: TextStyle(
                                      fontSize: 28.w,
                                      color: AppColors.neutralGrey13,
                                    ),
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.all(30.w),
                                    counterText: "",
                                  ),
                                  style: TextStyle(
                                    fontSize: 28.w,
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return '请输入问题描述';
                                    }
                                    if (value.length < 10) {
                                      return '问题描述至少需要10个字符';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              SizedBox(height: 20.w),
                              Text(
                                "联系方式（选填）",
                                style: TextStyle(
                                  fontSize: 32.w,
                                  fontWeight: FontWeight.w600,
                                  color: theme.primaryColorDark,
                                ),
                              ),
                              SizedBox(height: 20.w),
                              Container(
                                height: 120.w,
                                decoration: BoxDecoration(
                                  color: AppColors.neutralWhite,
                                  borderRadius: BorderRadius.circular(20.w),
                                  border: Border.all(
                                    color: AppColors.neutralGrey13,
                                    width: 2.w,
                                  ),
                                ),
                                child: TextFormField(
                                  controller: _contactController,
                                  decoration: InputDecoration(
                                    hintText: "邮箱/电话/微信等（方便我们联系您）",
                                    hintStyle: TextStyle(
                                      fontSize: 28.w,
                                      color: AppColors.neutralGrey13,
                                    ),
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.all(30.w),
                                  ),
                                  style: TextStyle(
                                    fontSize: 28.w,
                                  ),
                                ),
                              ),
                              SizedBox(height: 60.w),
                            ],
                          ),
                        ),
                        VigaFunctionList(children: [
                          VigaMaxWidthButton(
                            title: "提交反馈",
                            link: null,
                            onPressed: _submitComplain,
                            underline: false,
                          ),
                        ]),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _submitComplain() {
    if (_formKey.currentState!.validate()) {
      // 显示提交成功的提示
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            '反馈提交成功，感谢您的宝贵意见！',
            style: TextStyle(fontSize: 28.w),
          ),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 3),
        ),
      );

      // 清空表单
      _complainController.clear();
      _contactController.clear();

      // 延迟返回上一页
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          Navigator.of(context).pop();
        }
      });
    }
  }
}
