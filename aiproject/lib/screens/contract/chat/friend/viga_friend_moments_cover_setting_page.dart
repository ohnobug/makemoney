import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vigaviga/l10n/app_localizations.dart';
import 'package:vigaviga/widgets/viga_appbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/store/viga_system_cubit.dart';
import 'package:vigaviga/widgets/viga_function_list.dart';
import 'package:vigaviga/widgets/viga_function_item.dart';

class VigaFriendMomentsCoverSettingPage extends StatefulWidget {
  const VigaFriendMomentsCoverSettingPage({super.key});

  @override
  State<VigaFriendMomentsCoverSettingPage> createState() =>
      _VigaFriendMomentsCoverSetting();
}

class _VigaFriendMomentsCoverSetting
    extends State<VigaFriendMomentsCoverSettingPage> {
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
        String cdnBase = systemState.cdnBase;

        return Scaffold(
          primary: false,
          appBar: VigaAppBar(
            title: l10n.changeAlbumCover,
          ),
          body: ScrollConfiguration(
            behavior:
                ScrollConfiguration.of(context).copyWith(scrollbars: false),
            child: Container(
              constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height -
                      systemState.appbarHeight -
                      systemState.statusHeight),
              color: theme.colorScheme.surfaceContainer,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics(),
                ),
                child: Column(
                  children: [
                    // 功能列表
                    VigaFunctionList(
                      children: [
                        VigaFunctionItem(
                          icon: "$cdnBase/avatar/02.png",
                          title: l10n.selectFromPhoneAlbum,
                          link: '',
                          underline: true,
                        ),
                        VigaFunctionItem(
                          icon: "$cdnBase/avatar/02.png",
                          title: l10n.selectFromChannels,
                          link: '',
                          underline: true,
                        ),
                        VigaFunctionItem(
                          icon: "$cdnBase/avatar/02.png",
                          title: l10n.takeOne,
                          link: '',
                          underline: false,
                        ),
                        SizedBox(height: 62.w),
                        VigaFunctionItem(
                          icon: "$cdnBase/avatar/02.png",
                          title: l10n.photographerWorks,
                          link: '',
                          underline: false,
                        ),
                      ],
                    ),
                    SizedBox(height: 100.w)
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
