import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VigaCustomNumpad extends StatelessWidget {
  final Function(String) onKeyPressed;

  const VigaCustomNumpad({
    super.key,
    required this.onKeyPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          _buildNumpadRow(['1', '2', '3']),
          _buildDivider(),
          _buildNumpadRow(['4', '5', '6']),
          _buildDivider(),
          _buildNumpadRow(['7', '8', '9']),
          _buildDivider(),
          _buildNumpadRow(['', '0', 'del']),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Container(height: 1.h, color: Colors.grey.shade200);
  }

  Widget _buildNumpadRow(List<String> keys) {
    return Row(
      children: keys.map((key) {
        return Expanded(
          child: _buildNumpadKey(key),
        );
      }).toList(),
    );
  }

  Widget _buildNumpadKey(String key) {
    return InkWell(
      onTap: () => onKeyPressed(key),
      child: Container(
        height: 120.h,
        decoration: BoxDecoration(
          border: Border(
            right: BorderSide(color: Colors.grey.shade200, width: 1.w),
          ),
        ),
        child: Center(
          child: key.isEmpty
              ? const SizedBox.shrink()
              : key == 'del'
                  ? Icon(Icons.backspace_outlined, size: 48.w, color: Colors.grey.shade600)
                  : Text(
                      key,
                      style: TextStyle(
                        fontSize: 48.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
        ),
      ),
    );
  }
}