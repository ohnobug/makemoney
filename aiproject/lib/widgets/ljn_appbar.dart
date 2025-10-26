import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/store/ljn_system_cubit.dart';
import 'package:vigaviga/widgets/ljn_appbar_inner.dart';
import 'package:vigaviga/tools/ljn_tools.dart';

class LJNAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String? title;
  final List<Widget>? actions;
  final Widget? leading;

  const LJNAppBar({
    super.key,
    this.title,
    this.actions,
    this.leading,
  });

  @override
  State<LJNAppBar> createState() => _LJNAppBar();

  @override
  Size get preferredSize => Size.fromHeight(90.0);
}

class _LJNAppBar extends State<LJNAppBar> {
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

    return BlocBuilder<LJNSystemCubit, SystemState>(
      builder: (context, systemState) {
        return PreferredSize(
          preferredSize: Size.fromHeight(90.0.w + systemState.statusHeight),
          child: Container(
            color: theme.appBarTheme.backgroundColor,
            padding: EdgeInsets.only(top: systemState.statusHeight),
            height: 90.0.w + systemState.statusHeight,
            child: LJNAppBarInner(
              context: context,
              title: widget.title ?? "",
              actions: widget.actions ?? [],
              leading: widget.leading,
            ),
          ),
        );
      },
    );
  }
}

class LJNAppBarActionIconButton extends StatefulWidget {
  final IconData iconData;
  final GestureTapCallback? onTap;
  const LJNAppBarActionIconButton({
    super.key,
    required this.iconData,
    required this.onTap,
  });

  @override
  State<LJNAppBarActionIconButton> createState() =>
      _LJNAppBarActionIconButton();
}

class _LJNAppBarActionIconButton extends State<LJNAppBarActionIconButton> {
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

class LJNAppBarActionTextButton extends StatefulWidget {
  final String title;
  final GestureTapCallback? onTap;
  const LJNAppBarActionTextButton({
    super.key,
    required this.title,
    required this.onTap,
  });

  @override
  State<LJNAppBarActionTextButton> createState() =>
      _LJNAppBarActionTextButton();
}

class _LJNAppBarActionTextButton extends State<LJNAppBarActionTextButton> {
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
