import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jiaoyishuoflutter3/store/system/cubit/system_cubit.dart';

class LJNChatFunctionSelector extends StatefulWidget {
  const LJNChatFunctionSelector({super.key});

  @override
  State<LJNChatFunctionSelector> createState() => _LJNChatFunctionSelector();
}

class _LJNChatFunctionSelector extends State<LJNChatFunctionSelector> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SystemCubit, SystemState>(
        builder: (context, systemState) {
      return ColoredBox(
          color: const Color.fromARGB(255, 237, 237, 237),
          child: Wrap(
            spacing: 63.w,
            children: List.generate(8, (index) {
              return Container(
                  width: (systemState.screenSize.width) / 8,
                  height: 90.0.w,
                  alignment: Alignment.center,
                  color: Colors.red,
                  child: null);
            }),
          ));
    });
  }
}
