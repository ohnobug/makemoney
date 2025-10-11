import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vigaviga/api_manager/api.dart';
import 'package:vigaviga/themes.dart';
import 'package:vigaviga/l10n/app_localizations.dart';
import 'package:vigaviga/widgets/ljn_alphabet.dart';
import 'package:vigaviga/widgets/ljn_appbar.dart';
import 'package:vigaviga/widgets/ljn_contact_item.dart';
import 'package:vigaviga/tools/ljn_logger.dart';
import 'package:vigaviga/store/ljn_system_cubit.dart';
import 'package:vigaviga/tools/ljn_tools.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LJNContact extends StatefulWidget {
  const LJNContact({super.key});

  @override
  State<LJNContact> createState() => _LJNContactState();
}

class _LJNContactState extends State<LJNContact> {
  // 关键改动 2: contactDataList 只存储不依赖 context 的静态数据模型
  late List<dynamic> contactDataList = [];

  @override
  void initState() {
    super.initState();
    logger.info('contact...............');

    contactDataList = getContactDataList();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<LJNSystemCubit>().updateHomescrollpixels(0);
      context.read<LJNSystemCubit>().updateShowMiniProgramDrawer(false);
      context.read<LJNSystemCubit>().updateMainpage2isload(true);
    });
  }

  // 关键改动 3: 移除整个 didChangeDependencies 方法

  // 辅助方法，用于根据 titleKey 获取本地化字符串
  String _getTitleFromKey(AppLocalizations l10n, String key) {
    switch (key) {
      case 'newFriends':
        return l10n.newFriends;
      case 'chatOnlyFriends':
        return l10n.chatOnlyFriends;
      case 'groupChats':
        return l10n.groupChats;
      case 'tags':
        return l10n.tags;
      case 'officialAccounts':
        return l10n.officialAccounts;
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations l10n = AppLocalizations.of(context)!;
    ThemeData theme = Theme.of(context);

    return BlocBuilder<LJNSystemCubit, SystemState>(
      builder: (context, systemState) {
        return Scaffold(
          primary: false,
          appBar: LJNAppBar(
            title: l10n.contacts,
          ),
          body: Stack(
            children: [
              ScrollConfiguration(
                behavior:
                    ScrollConfiguration.of(context).copyWith(scrollbars: false),
                child: Container(
                  constraints: BoxConstraints(
                      minHeight: MediaQuery.of(context).size.height),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        theme.colorScheme.surface,
                        theme.colorScheme.surfaceContainer
                      ],
                      stops: [0.3, 0.5],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: ListView.builder(
                    primary: false,
                    physics: const AlwaysScrollableScrollPhysics(
                      parent: BouncingScrollPhysics(),
                    ),
                    itemCount: contactDataList.length + 1, // +1 for the footer
                    itemBuilder: (context, index) {
                      // 关键改动 5: 在 itemBuilder 中动态构建 UI
                      if (index < contactDataList.length) {
                        final itemData = contactDataList[index];

                        if (itemData is String) {
                          return LJNAlphabet(title: itemData);
                        }

                        if (itemData is FunctionItemData) {
                          return ContactInformation(
                            icon: itemData.icon,
                            title: _getTitleFromKey(
                                l10n, itemData.titleKey), // 动态获取标题
                            link: itemData.link,
                            underline: itemData.underline,
                            onPressed: itemData.link.isEmpty
                                ? () => Navigator.pushNamed(
                                    context, '/contact/new_friends') // 特殊处理
                                : null,
                          );
                        }

                        if (itemData is ContactItemData) {
                          return ContactInformation(
                            icon: itemData.icon,
                            title: itemData.title,
                            link: '',
                            underline: itemData.underline,
                            onPressed: () {
                              Navigator.pushNamed(context, '/chat',
                                  arguments: <String, String>{
                                    'title': itemData.title,
                                    'icon': itemData.icon,
                                  });
                            },
                          );
                        }

                        return const SizedBox.shrink();
                      } else {
                        // 构建底部的统计行
                        return Container(
                          width: 750.w,
                          height: 105.0.w,
                          color: theme.colorScheme.surfaceContainer,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                l10n.friendCount(
                                  contactDataList
                                      .whereType<ContactItemData>()
                                      .length,
                                ), // 动态计算
                                style: TextStyle(
                                  height: 1.08,
                                  fontSize: fontSizeScale(30.w),
                                  color: theme.colorScheme.onSurface,
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                  ),
                ),
              ),
              Positioned(
                right: 0,
                top: ((MediaQuery.of(context).size.height - 986.w) / 2) + 40.w,
                child: SizedBox(
                  width: 40.w,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 34.w,
                        child: Icon(
                          const IconData(0xe677, fontFamily: 'Iconfont'),
                          size: 22.w,
                          color: AppColors.neutralNearBlack3,
                        ),
                      ),
                      SizedBox(
                        height: 34.w,
                        child: Icon(
                          const IconData(0xe6c8, fontFamily: 'Iconfont'),
                          size: 22.w,
                          color: AppColors.neutralNearBlack3,
                        ),
                      ),
                      for (int i = 0; i < 26; i++)
                        SizedBox(
                          height: 34.w,
                          child: Text(
                            String.fromCharCode(65 + i),
                            style: TextStyle(
                              height: 1.08,
                              fontSize: fontSizeScale(22.w),
                              color: AppColors.neutralNearBlack3,
                            ),
                          ),
                        ),
                      SizedBox(
                        height: 34.w,
                        child: Text(
                          "#",
                          style: TextStyle(
                            height: 1.08,
                            fontSize: fontSizeScale(22.w),
                            color: AppColors.neutralNearBlack3,
                          ),
                        ),
                      ),
                    ],
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
