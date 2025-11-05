import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:vigaviga/l10n/app_localizations.dart';
import 'package:vigaviga/store/viga_system_cubit.dart';
import 'package:vigaviga/tools/viga_dialog_service.dart';
import 'package:vigaviga/widgets/viga_appbar.dart';
import 'package:vigaviga/widgets/viga_page_loading.dart';
import 'package:image_picker/image_picker.dart';

class VigaPublisherPage extends StatefulWidget {
  const VigaPublisherPage({super.key});

  @override
  State<VigaPublisherPage> createState() => _VigaPublisherState();
}

class _VigaPublisherState extends State<VigaPublisherPage>
    with AutomaticKeepAliveClientMixin<VigaPublisherPage> {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<VigaSystemCubit>().updateMainpage3isload(true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<VigaSystemCubit, SystemState>(
      buildWhen: (previous, current) =>
          previous.mainpage3isload != current.mainpage3isload,
      builder: (context, systemState) {
        return systemState.mainpage3isload!
            ? _buildPage(context)
            : const VigaPageLoading();
      },
    );
  }

  Widget _buildPage(BuildContext context) {
    ThemeData theme = Theme.of(context);
    AppLocalizations l10n = AppLocalizations.of(context)!;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: theme.colorScheme.surface,
        appBar: VigaAppBar(
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: Brightness.dark,
            ),
            title: l10n.tabbar_label_publisher,
            leading: const SizedBox(),
            actions: [
              // 点击出来弹窗
              VigaAppBarActionIconButton(
                iconData: const IconData(0xe726, fontFamily: 'Iconfont'),
                onTap: () {
                  showPopupMenu(context);
                },
              ),
            ]),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 48.w), // 24 * 2
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
                          context.push('/ai_publisher');
                        },
                      ),
                      SizedBox(height: 20.w), // 20 * 2
                      // 下半部分: 用户上传入口
                      _buildFlatOption(
                        context: context,
                        icon: Icons.upload_file, // 建议替换为你的 Iconfont
                        title: '上传原创作品 (仅需 2 钻石)',
                        description: '将你的原创作品铸为NFT。仅需支付链上铸造费用，发布后即可通过社区打赏获得回报。',
                        onTap: () async {
                          final ImagePicker picker = ImagePicker();
                          final XFile? image = await picker.pickImage(
                              source: ImageSource.gallery);
                          if (image != null) {
                            if (context.mounted) {
                              context.push('/publish_work');
                            }
                          }
                        },
                      ),
                    ],
                  ),
                ),
                // 底部成本说明
                _buildCostDisclaimer(context),
                SizedBox(height: 100.w), // 50 * 2
              ],
            ),
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
      borderRadius: BorderRadius.circular(24.w),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(32.w),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(24.w),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha((0.05 * 255).toInt()),
              blurRadius: 15.w,
              offset: Offset(0, 4.w),
            ),
          ],
          border: Border.all(
            color: theme.dividerColor.withAlpha((0.3 * 255).toInt()),
            width: 1.w,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 图标区域
            Container(
              width: 120.w,
              height: 120.w,
              decoration: BoxDecoration(
                color: theme.colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(24.w),
              ),
              child: Icon(
                icon,
                size: 60.w,
                color: theme.colorScheme.primary,
              ),
            ),
            SizedBox(height: 24.w),

            // 标题和描述
            Text(
              title,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
                color: theme.colorScheme.onSurface,
                fontSize: 34.w,
                height: 1.2,
              ),
            ),
            SizedBox(height: 16.w),
            Text(
              description,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                height: 1.5,
                fontSize: 26.w,
              ),
            ),

            // 底部箭头
            SizedBox(height: 16.w),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.w),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primaryContainer
                        .withAlpha((0.3 * 255).toInt()),
                    borderRadius: BorderRadius.circular(20.w),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '开始创作',
                        style: TextStyle(
                          color: theme.colorScheme.primary,
                          fontSize: 24.w,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Icon(
                        Icons.arrow_forward,
                        color: theme.colorScheme.primary,
                        size: 20.w,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCostDisclaimer(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(32.w),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest
            .withAlpha((0.5 * 255).toInt()),
        borderRadius: BorderRadius.circular(20.w),
        border: Border.all(
          color: theme.dividerColor.withAlpha((0.3 * 255).toInt()),
          width: 1.w,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.info_outline,
                color: theme.colorScheme.primary,
                size: 28.w,
              ),
              SizedBox(width: 12.w),
              Text(
                '费用说明',
                style: TextStyle(
                  color: theme.colorScheme.onSurface,
                  fontSize: 28.w,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.w),
          RichText(
            textAlign: TextAlign.left,
            text: TextSpan(
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                fontSize: 24.w,
                height: 1.4,
              ),
              children: [
                const TextSpan(text: '• 发布作品即铸造为链上NFT，基础费用为 '),
                TextSpan(
                  text: '2 钻石',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.primary,
                  ),
                ),
                const TextSpan(text: '\n• 若选择AI创作，需额外支付 '),
                TextSpan(
                  text: '3 钻石',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.primary,
                  ),
                ),
                const TextSpan(text: ' 的AI生成服务费'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
