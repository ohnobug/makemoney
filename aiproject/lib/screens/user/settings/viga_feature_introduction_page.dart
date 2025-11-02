import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vigaviga/themes.dart';
import 'package:vigaviga/l10n/app_localizations.dart';
import 'package:vigaviga/widgets/viga_appbar.dart';
import 'package:vigaviga/store/viga_system_cubit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VigaFeatureIntroductionPage extends StatefulWidget {
  const VigaFeatureIntroductionPage({super.key});

  @override
  State<VigaFeatureIntroductionPage> createState() =>
      _VigaFeatureIntroductionState();
}

class _VigaFeatureIntroductionState extends State<VigaFeatureIntroductionPage> {
  @override
  void initState() {
    super.initState();
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
              title: l10n.featureIntroduction,
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildFeatureItem(
                            title: "智能检测功能",
                            description: "利用先进的AI技术，提供精准的物体检测和识别能力",
                          ),
                          SizedBox(height: 30.w),
                          _buildFeatureItem(
                            title: "实时分析",
                            description: "支持实时视频流分析，快速响应检测需求",
                          ),
                          SizedBox(height: 30.w),
                          _buildFeatureItem(
                            title: "多场景支持",
                            description: "适用于多种应用场景，满足不同用户需求",
                          ),
                          SizedBox(height: 30.w),
                          _buildFeatureItem(
                            title: "用户友好界面",
                            description: "简洁直观的操作界面，提供良好的用户体验",
                          ),
                          SizedBox(height: 30.w),
                          _buildFeatureItem(
                            title: "数据安全",
                            description: "严格的数据保护机制，确保用户隐私安全",
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildFeatureItem({
    required String title,
    required String description,
  }) {
    ThemeData theme = Theme.of(context);

    return Container(
      width: 710.w,
      padding: EdgeInsets.all(20.w),
      margin: EdgeInsets.only(left: 20.w, right: 20.w),
      decoration: BoxDecoration(
        color: AppColors.neutralWhite,
        borderRadius: BorderRadius.circular(20.w),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(25),
            blurRadius: 10.w,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 32.w,
              fontWeight: FontWeight.bold,
              color: theme.primaryColor,
            ),
          ),
          SizedBox(height: 15.w),
          Text(
            description,
            style: TextStyle(
              fontSize: 28.w,
              color: theme.primaryColorDark,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}
