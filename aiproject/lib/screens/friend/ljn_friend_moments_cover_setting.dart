import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vigaviga/l10n/app_localizations.dart';
import 'package:vigaviga/widgets/ljn_appbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/store/ljn_system_cubit.dart';
import 'package:vigaviga/widgets/ljn_function_list.dart';
import '../../widgets/ljn_function_item.dart';

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
    ThemeData theme = Theme.of(context);
    AppLocalizations l10n = AppLocalizations.of(context)!;

    return BlocBuilder<LJNSystemCubit, SystemState>(
      builder: (context, systemState) {
        return Scaffold(
          primary: false,
          appBar: LJNAppBar(
            title: l10n.changeAlbumCover,
          ),
          body: ScrollConfiguration(
            behavior:
                ScrollConfiguration.of(context).copyWith(scrollbars: false),
            child: Container(
              constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height -
                      90.w -
                      systemState.statusHeight),
              color: theme.colorScheme.surfaceContainer,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics(),
                ),
                child: Column(
                  children: [
                    // 功能列表
                    LJNFunctionList(
                      children: [
                        LJNFunctionItem(
                          icon: "images/avatar/02.png",
                          title: l10n.selectFromPhoneAlbum,
                          link: '',
                          underline: true,
                        ),
                        LJNFunctionItem(
                          icon: "images/avatar/02.png",
                          title: l10n.selectFromChannels,
                          link: '',
                          underline: true,
                        ),
                        LJNFunctionItem(
                          icon: "images/avatar/02.png",
                          title: l10n.takeOne,
                          link: '',
                          underline: false,
                        ),
                        SizedBox(height: 62.w),
                        LJNFunctionItem(
                          icon: "images/avatar/02.png",
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
