import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/store/viga_system_cubit.dart';
import 'package:vigaviga/widgets/viga_appbar_inner.dart';
import 'package:vigaviga/tools/viga_tools.dart';

class VigaAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String? title;
  final List<Widget>? actions;
  final Widget? leading;
  final SystemUiOverlayStyle? systemOverlayStyle;

  const VigaAppBar({
    super.key,
    this.title,
    this.actions,
    this.leading,
    this.systemOverlayStyle,
  });

  @override
  State<VigaAppBar> createState() => _VigaAppBar();

  @override
  Size get preferredSize => Size.fromHeight(90.0);
}

class _VigaAppBar extends State<VigaAppBar> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return BlocBuilder<VigaSystemCubit, SystemState>(
      builder: (context, systemState) {
        return PreferredSize(
          preferredSize: Size.fromHeight(90.0.w + systemState.statusHeight),
          child: Container(
            color: theme.appBarTheme.backgroundColor,
            padding: EdgeInsets.only(top: systemState.statusHeight),
            height: 90.0.w + systemState.statusHeight,
            child: VigaAppBarInner(
              context: context,
              title: widget.title ?? "",
              actions: widget.actions ?? [],
              leading: widget.leading,
              systemOverlayStyle: widget.systemOverlayStyle,
            ),
          ),
        );
      },
    );
  }
}

class VigaAppBarActionIconButton extends StatefulWidget {
  final IconData iconData;
  final GestureTapCallback? onTap;
  const VigaAppBarActionIconButton({
    super.key,
    required this.iconData,
    required this.onTap,
  });

  @override
  State<VigaAppBarActionIconButton> createState() =>
      _VigaAppBarActionIconButton();
}

class _VigaAppBarActionIconButton extends State<VigaAppBarActionIconButton> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        color: Colors.transparent,
        height: 90.w,
        padding: EdgeInsets.only(right: 33.w),
        alignment: Alignment.center,
        child: Icon(
          color: theme.appBarTheme.titleTextStyle!.color,
          widget.iconData,
          size: 42.w,
        ),
      ),
    );
  }
}

class VigaAppBarActionTextButton extends StatefulWidget {
  final String title;
  final GestureTapCallback? onTap;
  const VigaAppBarActionTextButton({
    super.key,
    required this.title,
    required this.onTap,
  });

  @override
  State<VigaAppBarActionTextButton> createState() =>
      _VigaAppBarActionTextButton();
}

class _VigaAppBarActionTextButton extends State<VigaAppBarActionTextButton> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        height: 90.w,
        color: Colors.transparent,
        alignment: Alignment.center,
        padding: EdgeInsets.only(right: 33.w),
        child: Text(
          widget.title,
          style: TextStyle(
            color: theme.colorScheme.onSurface,
            fontSize: fontSizeScale(32.w),
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
