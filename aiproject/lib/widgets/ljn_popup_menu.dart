import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/l10n/app_localizations.dart';
import 'package:vigaviga/widgets/ljn_popup_menu_item.dart';

class LJNPopupMenu extends StatefulWidget {
  final bool showPopup;
  final Function(bool value)? setShowPopup;

  const LJNPopupMenu({
    super.key,
    required this.showPopup,
    required this.setShowPopup,
  });

  @override
  State<LJNPopupMenu> createState() => _LJNPopupMenuState();
}

class _LJNPopupMenuState extends State<LJNPopupMenu> {
  @override
  Widget build(BuildContext context) {
    // Core Refactor: Get theme and l10n instance once at the top.
    ThemeData theme = Theme.of(context);

    AppLocalizations l10n = AppLocalizations.of(context)!;

    // Define theme-aware colors to ensure consistency.
    final Color popupBackgroundColor = theme.colorScheme.surfaceContainer;
    // Corrected: Use the theme's dividerColor for borders. This is semantically correct.
    final Color popupBorderColor = theme.dividerColor;

    return SizedBox(
      width: 320.w,
      height: 500.w,
      child: Stack(
        children: [
          // Popup Menu Body
          Positioned(
            left: 0,
            top: 28.w,
            child: Container(
              decoration: BoxDecoration(
                // Use the defined theme-aware background color.
                color: popupBackgroundColor,
                borderRadius: BorderRadius.circular(10.0).w,
                border: Border.all(
                  width: 3.w,
                  // Use the defined theme-aware border color.
                  color: popupBorderColor,
                ),
              ),
              width: 320.w,
              child: Column(
                children: [
                  // Start Group Chat
                  LJNPopupMenuItem(
                    title: l10n.startGroupChat,
                    icon: const IconData(0xe676, fontFamily: "iconfont"),
                    // Corrected: Removed unnecessary local setState.
                    // The parent widget is responsible for hiding the popup.
                    onTap: () => widget.setShowPopup?.call(false),
                  ),
                  // Add Friend
                  LJNPopupMenuItem(
                    title: l10n.addFriend,
                    icon: const IconData(0xe61f, fontFamily: "iconfont"),
                    onTap: () {
                      widget.setShowPopup?.call(false);
                      Navigator.pushNamed(context, '/add_friends');
                    },
                  ),
                  // Scan QR Code
                  LJNPopupMenuItem(
                    title: l10n.scan,
                    icon: const IconData(0xe69a, fontFamily: "iconfont"),
                    onTap: () {
                      widget.setShowPopup?.call(false);
                      Navigator.pushNamed(context, '/qrcode_scanner');
                    },
                  ),
                  // Payment
                  LJNPopupMenuItem(
                    title: l10n.payment,
                    icon: const IconData(0xe611, fontFamily: "iconfont"),
                    onTap: () {
                      widget.setShowPopup?.call(false);
                      Navigator.pushNamed(context, '/collection_and_payment');
                    },
                  ),
                ],
              ),
            ),
          ),
          // Top Arrow Icon
          Positioned(
            top: 0.w,
            right: 28.w,
            child: SizedBox(
              width: 36.w,
              height: 30.w,
              child: Icon(
                const IconData(0xe62c, fontFamily: 'Iconfont'),
                // The arrow color should match the popup's background to create the illusion
                // of a single shape. Using the variable ensures they are always in sync.
                color: popupBackgroundColor,
                size: 42.0.w,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
