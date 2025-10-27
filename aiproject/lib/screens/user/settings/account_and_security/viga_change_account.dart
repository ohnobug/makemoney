import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vigaviga/widgets/viga_appbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class VigaChangeAccount extends StatefulWidget {
  const VigaChangeAccount({super.key});

  @override
  State<VigaChangeAccount> createState() => _VigaChangeAccountState();
}

class _VigaChangeAccountState extends State<VigaChangeAccount> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {});
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(_focusNode);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isInputValid =
        _controller.text.length >= 6 && _controller.text.length <= 20;
    ThemeData theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const VigaAppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 48.w),
        child: Column(
          // 主轴（垂直）居中
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                '填写新的Vigaviga号',
                style: TextStyle(fontSize: 48.w, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Vigaviga号长度限 6-20 位, 建议避免包含姓名、生日等涉及个人隐私信息。',
              style: TextStyle(color: Colors.grey[600], fontSize: 30.w),
            ),
            SizedBox(height: 40.w),
            TextField(
              controller: _controller,
              focusNode: _focusNode,
              autofocus: true,
              keyboardType: TextInputType.visiblePassword,
              inputFormatters: [
                LengthLimitingTextInputFormatter(20),
                FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9_]')),
              ],
              decoration: InputDecoration(
                labelText: 'Vigaviga号',
                labelStyle: TextStyle(color: Colors.grey[600], fontSize: 36.w),
                suffixIcon: _controller.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.cancel, color: Colors.grey),
                        onPressed: () {
                          _controller.clear();
                        },
                      )
                    : null,
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade400),
                ),
              ),
              style: TextStyle(fontSize: 36.w),
            ),
            SizedBox(height: 80.w),
            SizedBox(
              width: double.infinity,
              height: 100.0.w,
              child: ElevatedButton(
                onPressed: isInputValid
                    ? () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text('Vigaviga号 "${_controller.text}" 设置成功')),
                        );
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  // 按钮正常状态下的背景颜色
                  backgroundColor: theme.colorScheme.primary,
                  // 按钮禁用状态下的背景颜色
                  disabledBackgroundColor: theme.colorScheme.primaryContainer,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  '确定',
                  style: TextStyle(
                    fontSize: 36.w,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
