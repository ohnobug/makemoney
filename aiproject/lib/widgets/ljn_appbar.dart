import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/store/ljn_system_cubit.dart';
import 'package:vigaviga/widgets/ljn_appbar_inner.dart';

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
