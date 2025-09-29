import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/l10n/app_localizations.dart';
import 'package:vigaviga/store/ljn_system_cubit.dart';
import 'package:vigaviga/widgets/ljn_appbar.dart';
import 'package:vigaviga/widgets/ljn_page_loading.dart';

// [修复点 1] 将 LJNPublisher 转换为 StatefulWidget
class LJNPublisher extends StatefulWidget {
  const LJNPublisher({super.key});

  @override
  State<LJNPublisher> createState() => _LJNPublisherState();
}

// [修复点 2] 创建对应的 State 类
class _LJNPublisherState extends State<LJNPublisher> {
  @override
  void initState() {
    super.initState();

    // 在 initState 中不能直接使用 context.read，需要延迟到第一帧绘制后
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // mounted 检查是好习惯，确保 Widget 仍在树中
      if (mounted) {
        // [修复点 3] 统一使用 mainpage3isload
        context.read<LJNSystemCubit>().updateMainpage3isload(true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LJNSystemCubit, SystemState>(
      buildWhen: (previous, current) =>
          previous.mainpage3isload != current.mainpage3isload,
      builder: (context, systemState) {
        return systemState.mainpage3isload!
            ? _buildPage(context)
            : const LJNPageLoading();
      },
    );
  }

  Widget _buildPage(BuildContext context) {
    ThemeData theme = Theme.of(context);
    AppLocalizations l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: LJNAppBar(
        title: l10n.tabbar_label_publisher,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // 上半部分: AI 创作入口
                    _buildFlatOption(
                      context: context,
                      icon: Icons.auto_awesome, // 建议替换为你的 Iconfont
                      title: 'AI 创作 (花费 5 钻石)',
                      description:
                          'AI将为你生成独特的NFT艺术品。费用包含AI生成服务及链上铸造，发布后即可赚取打赏。',
                      onTap: () {
                        // print('即将进入 AI 创作流程...');
                      },
                    ),
                    SizedBox(height: 20.h),
                    // 下半部分: 用户上传入口
                    _buildFlatOption(
                      context: context,
                      icon: Icons.upload_file, // 建议替换为你的 Iconfont
                      title: '上传原创作品 (仅需 2 钻石)',
                      description: '将你的原创作品铸为NFT。仅需支付链上铸造费用，发布后即可通过社区打赏获得回报。',
                      onTap: () {
                        // print('即将打开文件选择器...');
                      },
                    ),
                  ],
                ),
              ),
              // 底部成本说明
              _buildCostDisclaimer(context),
              SizedBox(height: 50.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFlatOption({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String description,
    required VoidCallback onTap,
  }) {
    ThemeData theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(
        12.r,
      ),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 20.w,
          vertical: 24.h,
        ),
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainerHighest.withAlpha(128),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: theme.dividerColor,
            width: 1.w,
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 100.w,
              color: theme.colorScheme.primary,
            ),
            SizedBox(width: 30.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    description,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                      height: 1.6, // 使用相对行高而不是固定值
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCostDisclaimer(BuildContext context) {
    ThemeData theme = Theme.of(context);

    final regularStyle = theme.textTheme.bodySmall
        ?.copyWith(color: theme.colorScheme.onSurfaceVariant);

    final boldStyle = regularStyle?.copyWith(
      fontWeight: FontWeight.bold,
      color: theme.colorScheme.primary,
    );

    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: regularStyle,
        children: [
          const TextSpan(text: '发布作品即铸造为链上NFT，基础费用为 '),
          TextSpan(
            text: '2 钻石',
            style: boldStyle,
          ),
          const TextSpan(text: '。\n'),
          TextSpan(
            text: '（若选择AI创作，需额外支付 ',
            style: regularStyle?.copyWith(fontSize: 20.w),
          ),
          TextSpan(
            text: '3 钻石',
            style: boldStyle?.copyWith(fontSize: 20.w),
          ),
          TextSpan(
            text: ' 的AI生成服务费）',
            style: regularStyle?.copyWith(fontSize: 20.w),
          ),
        ],
      ),
    );
  }
}
