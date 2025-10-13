import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/themes.dart';
import 'package:vigaviga/l10n/app_localizations.dart';
import 'package:vigaviga/widgets/ljn_appbar.dart';
import 'package:vigaviga/store/ljn_system_cubit.dart';
import 'package:vigaviga/tools/ljn_tools.dart';

class LJNSetNotesAndLabelsPage extends StatefulWidget {
  const LJNSetNotesAndLabelsPage({super.key});

  @override
  State<LJNSetNotesAndLabelsPage> createState() => _LJNSetNotesAndLabelsState();
}

class _LJNSetNotesAndLabelsState extends State<LJNSetNotesAndLabelsPage> {
  TextEditingController inputController1 = TextEditingController();
  FocusNode inputFocusNode1 = FocusNode();

  TextEditingController inputController2 = TextEditingController();
  FocusNode inputFocusNode2 = FocusNode();

  List<String> phoneNumberList = ["+8618825130917", "+8618718988850"];

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
            title: "",
            leading: GestureDetector(
              onTap: () {
                // 点击事件
                Navigator.of(context).pop();
              },
              child: Container(
                // color: Colors.transparent,
                height: 90.w,
                color: Colors.transparent,
                // color: Colors.amber,
                alignment: Alignment.center,
                padding: EdgeInsets.only(left: 0.w),
                child: Text(
                  l10n.cancel,
                  style: TextStyle(
                    // height: 1.08,
                    color: theme.colorScheme.onSurface,
                    fontSize: fontSizeScale(32.w),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            actions: [
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/settings/security/bind_phone');
                },
                child: Container(
                  height: 60.w,
                  constraints: BoxConstraints(minWidth: 98.w),
                  margin: EdgeInsets.only(right: 30.w),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.brandGreenVibrant3,
                    borderRadius: BorderRadius.all(
                      Radius.circular(8.w),
                    ),
                  ),
                  child: Text(
                    l10n.done,
                    // textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.neutralWhite,
                      fontSize: 25.w,
                      fontWeight: FontWeight.w100,
                    ),
                  ),
                ),
              )
            ],
          ),
          body: ColoredBox(
            color: AppColors.neutralWhite,
            child: ScrollConfiguration(
              behavior:
                  ScrollConfiguration.of(context).copyWith(scrollbars: false),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics(),
                ),
                child: Container(
                  constraints: BoxConstraints(
                      minHeight: MediaQuery.of(context).size.height - 205.w),
                  color: AppColors.neutralWhite,
                  padding: EdgeInsets.only(left: 45.w, right: 45.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 70.w, bottom: 95.w),
                        alignment: Alignment.center,
                        child: Text(
                          l10n.setAliasAndTags,
                          style: TextStyle(
                            fontSize: 40.w,
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.onSurface,
                          ),
                        ),
                      ),

                      Container(
                        padding: EdgeInsets.only(left: 30.w),
                        margin: EdgeInsets.only(
                          bottom: 15.w,
                        ),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          l10n.remark,
                          style: TextStyle(
                            fontSize: 25.w,
                            color: AppColors.neutralGrey78,
                            height: 1.08,
                          ),
                        ),
                      ),

                      // 输入框
                      Container(
                        height: 105.w,
                        margin: EdgeInsets.only(bottom: 15.w),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppColors.neutralGrey2,
                          borderRadius: BorderRadius.all(
                            Radius.circular(12.w),
                          ),
                        ),
                        child: TextField(
                          readOnly: false,
                          autofocus: false,
                          showCursor: true,
                          controller: inputController1,
                          focusNode: inputFocusNode1,
                          onTap: () {},
                          cursorColor: AppColors.brandGreenDarker4,
                          // cursorHeight: 44.w,
                          cursorWidth: 3.w,
                          style: TextStyle(
                            // height: 1.08,
                            fontSize: fontSizeScale(30.w),
                            color: theme.colorScheme.onSurface,
                          ),
                          // strutStyle: StrutStyle(fontSize: fontSizeScale(20.w),),
                          maxLines: 5,
                          minLines: 1,
                          onChanged: (newText) {
                            inputController1.value =
                                inputController1.value.copyWith(
                              text: newText,
                              selection: TextSelection.fromPosition(
                                TextPosition(offset: newText.length),
                              ),
                            );
                          },
                          decoration: InputDecoration(
                            // fillColor:
                            //     AppColors.accentRedVibrant2,
                            // filled: true,
                            // focusColor: AppColors.accentRedPure,
                            // hoverColor:
                            //     AppColors.neutralGrey2,
                            isCollapsed: true,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 32.w,
                              vertical: 30.w,
                            ),
                            border: const OutlineInputBorder(
                              gapPadding: 0,
                              borderSide: BorderSide.none,
                            ),
                            // focusedBorder: OutlineInputBorder(gapPadding: 0, borderSide: BorderSide.none),
                            // enabledBorder: OutlineInputBorder(gapPadding: 0, borderSide: BorderSide.none),
                            // disabledBorder: OutlineInputBorder(gapPadding: 0, borderSide: BorderSide.none),
                            // focusedErrorBorder: OutlineInputBorder(gapPadding: 0, borderSide: BorderSide.none),
                            // errorBorder: OutlineInputBorder(gapPadding: 0, borderSide: BorderSide.none),
                          ),
                        ),
                      ),

                      Container(
                        padding: EdgeInsets.only(left: 30.w),
                        margin: EdgeInsets.only(bottom: 75.w),
                        // alignment: Alignment.centerLeft,
                        // color: AppColors.accentRedPure,
                        child: Text.rich(
                          textAlign: TextAlign.left,
                          TextSpan(
                            children: [
                              TextSpan(
                                text: l10n.info_name_in_phone_contacts("邓桥香"),
                                style: TextStyle(
                                  fontSize: 25.w,
                                  color: AppColors.neutralGrey78,
                                  height: 1.08, // 统一行高
                                ),
                              ),
                              WidgetSpan(
                                child: SizedBox(
                                  width: 10.w,
                                ),
                              ),
                              WidgetSpan(
                                alignment: ui.PlaceholderAlignment.middle,
                                // baseline: TextBaseline.alphabetic,
                                child: GestureDetector(
                                  onTap: () {
                                    inputController1.text = "邓桥香";
                                  },
                                  child: Text(
                                    l10n.fillIn,
                                    style: TextStyle(
                                      fontSize: 25.w,
                                      color: AppColors.brandBlueDark1,
                                      height: 1.08, // 统一行高
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      Container(
                        padding: EdgeInsets.only(left: 30.w),
                        margin: EdgeInsets.only(bottom: 15.w),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          l10n.remark,
                          style: TextStyle(
                            fontSize: 25.w,
                            color: AppColors.neutralGrey78,
                            height: 1.08,
                          ),
                        ),
                      ),

                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/chat/set_friend_tags');
                        },
                        child: Container(
                          height: 105.w,
                          margin: EdgeInsets.only(bottom: 50.w),
                          padding: EdgeInsets.symmetric(horizontal: 30.w),
                          decoration: BoxDecoration(
                            color: AppColors.neutralGrey2,
                            borderRadius: BorderRadius.all(
                              Radius.circular(12.w),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "同学，ajj",
                                style: TextStyle(
                                    fontSize: 32.w,
                                    color: theme.colorScheme.onSurface),
                              ),
                              SizedBox(
                                width: 30.w,
                                child: Icon(
                                  const IconData(
                                    0xed9d,
                                    fontFamily: 'Iconfont',
                                  ),
                                  size: 30.0.w,
                                  color: theme.colorScheme.onSurface
                                      .withAlpha(100),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),

                      Container(
                        padding: EdgeInsets.only(left: 30.w),
                        margin: EdgeInsets.only(
                          bottom: 15.w,
                        ),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          l10n.phone,
                          style: TextStyle(
                            fontSize: 25.w,
                            color: AppColors.neutralGrey78,
                            height: 1.08,
                          ),
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.only(bottom: 55.w),
                        padding: EdgeInsets.symmetric(horizontal: 25.w),
                        decoration: BoxDecoration(
                          color: AppColors.neutralGrey2,
                          borderRadius: BorderRadius.all(
                            Radius.circular(12.w),
                          ),
                        ),
                        child: Column(
                          children: [
                            ...phoneNumberList.asMap().map(
                              (key, value) {
                                return MapEntry(
                                  key,
                                  Container(
                                    height: 105.w,
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                          width: 1.w,
                                          color: theme.dividerColor,
                                        ),
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          const IconData(
                                            0xe656,
                                            fontFamily: 'Iconfont',
                                          ),
                                          color: AppColors.accentRedPure,
                                          size: 40.w,
                                        ),
                                        SizedBox(width: 25.w),
                                        Text(
                                          value,
                                          style: TextStyle(
                                            fontSize: 27.w,
                                            height: 1.08,
                                            color: theme.colorScheme.onSurface,
                                          ),
                                        ),
                                        Expanded(
                                          child: Align(
                                            alignment: Alignment.centerRight,
                                            child: GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  phoneNumberList.removeAt(key);
                                                });
                                              },
                                              child: Container(
                                                width: 50.w,
                                                height: 50.w,
                                                color: Colors.transparent,
                                                alignment: Alignment.center,
                                                child: Icon(
                                                  const IconData(
                                                    0xe627,
                                                    fontFamily: 'Iconfont',
                                                  ),
                                                  color:
                                                      AppColors.neutralGrey41,
                                                  size: 35.w,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ).values,
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  phoneNumberList.add("+8618825130917");
                                });
                              },
                              child: SizedBox(
                                height: 105.w,
                                width: systemState.screenSize.width - 50.w,
                                child: Row(
                                  children: [
                                    Icon(
                                      const IconData(
                                        0xe673,
                                        fontFamily: 'Iconfont',
                                      ),
                                      color: AppColors.brandBlueDark5,
                                      size: 40.w,
                                    ),
                                    SizedBox(
                                      width: 25.w,
                                    ),
                                    Text(
                                      l10n.addPhoneNumber,
                                      style: TextStyle(
                                        fontSize: 30.w,
                                        height: 1.08,
                                        color: AppColors.brandBlueDark6,
                                      ),
                                    ),
                                    const Spacer(), // 这个 Spacer 会把第二个图标推到最右边

                                    Container(
                                      width: 50.w,
                                      height: 50.w,
                                      color: Colors.transparent,
                                      alignment: Alignment.center,
                                      child: Icon(
                                        const IconData(
                                          0xe655,
                                          fontFamily: 'Iconfont',
                                        ),
                                        color: AppColors.neutralGrey41,
                                        size: 35.w,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      Container(
                        padding: EdgeInsets.only(left: 30.w),
                        margin: EdgeInsets.only(
                          bottom: 15.w,
                        ),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          l10n.description,
                          style: TextStyle(
                            fontSize: 25.w,
                            color: AppColors.neutralGrey78,
                            height: 1.08,
                          ),
                        ),
                      ),
                      // 输入框输入框
                      Container(
                        height: 105.w,
                        margin: EdgeInsets.only(
                          bottom: 15.w,
                        ),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppColors.neutralGrey2,
                          borderRadius: BorderRadius.all(
                            Radius.circular(12.w),
                          ),
                        ),
                        child: TextField(
                          readOnly: false,
                          autofocus: false,
                          showCursor: true,
                          controller: inputController2,
                          focusNode: inputFocusNode2,
                          onTap: () {},
                          cursorColor: AppColors.brandGreenDarker4,
                          // cursorHeight: 44.w,
                          cursorWidth: 3.w,
                          style: TextStyle(
                              // height: 1.08,
                              fontSize: fontSizeScale(30.w),
                              color: theme.colorScheme.onSurface),
                          // strutStyle: StrutStyle(fontSize: fontSizeScale(20.w),),
                          maxLines: 5,
                          minLines: 1,
                          onChanged: (newText) {
                            inputController2.value =
                                inputController2.value.copyWith(
                              text: newText,
                              selection: TextSelection.fromPosition(
                                TextPosition(offset: newText.length),
                              ),
                            );
                          },
                          decoration: InputDecoration(
                            // fillColor:
                            //     AppColors.accentRedVibrant2,
                            // filled: true,
                            // focusColor: AppColors.accentRedPure,
                            // hoverColor:
                            //     AppColors.neutralGrey2,
                            isCollapsed: true,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 32.w, vertical: 30.w),
                            border: const OutlineInputBorder(
                                gapPadding: 0, borderSide: BorderSide.none),
                            // focusedBorder: OutlineInputBorder(gapPadding: 0, borderSide: BorderSide.none),
                            // enabledBorder: OutlineInputBorder(gapPadding: 0, borderSide: BorderSide.none),
                            // disabledBorder: OutlineInputBorder(gapPadding: 0, borderSide: BorderSide.none),
                            // focusedErrorBorder: OutlineInputBorder(gapPadding: 0, borderSide: BorderSide.none),
                            // errorBorder: OutlineInputBorder(gapPadding: 0, borderSide: BorderSide.none),
                          ),
                        ),
                      ),

                      Container(
                        width: 210.w,
                        height: 210.w,
                        decoration: BoxDecoration(
                          color: AppColors.neutralGrey2,
                          borderRadius: BorderRadius.all(
                            Radius.circular(12.w),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              const IconData(
                                0xe673,
                                fontFamily: 'Iconfont',
                              ),
                              color: AppColors.brandPurpleDark2,
                              size: 42.w,
                            ),
                            SizedBox(
                              height: 25.w,
                            ),
                            Text(
                              l10n.addImage,
                              style: TextStyle(
                                fontSize: 25.w,
                                color: AppColors.brandPurpleDark2,
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 100.w,
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
}
