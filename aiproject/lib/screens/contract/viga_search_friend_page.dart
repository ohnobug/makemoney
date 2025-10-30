import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/themes.dart';
import 'package:vigaviga/l10n/app_localizations.dart';
import 'package:vigaviga/store/viga_system_cubit.dart';

class VigaSearchFriendPage extends StatefulWidget {
  const VigaSearchFriendPage({
    super.key,
  });

  @override
  State<VigaSearchFriendPage> createState() => _VigaSearchFriend();
}

class _VigaSearchFriend extends State<VigaSearchFriendPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VigaSystemCubit, SystemState>(
        builder: (context, systemState) {
      return _buildPage(systemState);
    });
  }

  // 另起一个函数方便管理
  Widget _buildPage(SystemState systemState) {
    ThemeData theme = Theme.of(context);
    AppLocalizations l10n = AppLocalizations.of(context)!;

    return Scaffold(
      primary: false,
      appBar: null,
      body: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: Container(
          color: theme.colorScheme.surfaceContainer,
          constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height -
                  90.w -
                  systemState.statusHeight),
          alignment: Alignment.topLeft,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics(),
            ),
            child: Container(
              padding: EdgeInsets.only(bottom: 20.w),
              margin: EdgeInsets.only(
                left: 15.w,
                right: 15.w,
                top: systemState.statusHeight + 10.w,
              ),
              height: 95.w,
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainer,
                border: Border(
                  bottom: BorderSide(
                    color: theme.dividerColor,
                    width: 1.w,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: TextField(
                      onTapOutside: (event) {
                        FocusScope.of(context).unfocus();
                      },
                      cursorHeight: 35.w,
                      cursorWidth: 3.w,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          const IconData(
                            0xe612,
                            fontFamily: 'Iconfont',
                          ),
                          color: theme.colorScheme.onSurface,
                          size: 40.w,
                        ),
                        prefixIconConstraints: BoxConstraints(
                          minWidth: 70.w, // 控制图标与文字的最小宽度
                          // minHeight: 36.w,
                        ),
                        hintText: l10n.searchHintAccountOrPhone,
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 30.w,
                          color: AppColors.neutralDarkGrey14,
                        ),
                        filled: true,
                        fillColor: AppColors.neutralWhite,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20).w,
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 8.0,
                          horizontal: 20.0,
                        ).w,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: 100.w,
                      child: Text(
                        l10n.cancel,
                        style: TextStyle(
                          fontSize: 30.w,
                          color: AppColors.brandBluePrimary,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
