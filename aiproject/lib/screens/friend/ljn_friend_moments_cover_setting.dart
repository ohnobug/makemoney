import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spicychat/colors.dart';
import 'package:spicychat/l10n/app_localizations.dart';
import 'package:spicychat/screens/components/ljn_appbar.dart';
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
          appBar: LJNAppBar(
            title: AppLocalizations.of(context)!.changeAlbumCover,
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
                    LJNFunctionItem(
                      title: AppLocalizations.of(context)!.selectFromPhoneAlbum,
                      link: '',
                      underline: true,
                    ),
                    LJNFunctionItem(
                      title: AppLocalizations.of(context)!.selectFromChannels,
                      link: '',
                      underline: true,
                    ),
                    LJNFunctionItem(
                      title: AppLocalizations.of(context)!.takeOne,
                      link: '',
                      underline: false,
                    ),
                    SizedBox(height: 62.w),
                    LJNFunctionItem(
                      title: AppLocalizations.of(context)!.photographerWorks,
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
