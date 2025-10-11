import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vigaviga/l10n/app_localizations.dart';
import 'package:vigaviga/widgets/ljn_appbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/store/ljn_system_cubit.dart';
import 'package:vigaviga/tools/ljn_tools.dart';

class LJNSetFriendTagsPage extends StatefulWidget {
  const LJNSetFriendTagsPage({
    super.key,
  });

  @override
  State<LJNSetFriendTagsPage> createState() => _LJNSetFriendTags();
}

class _LJNSetFriendTags extends State<LJNSetFriendTagsPage> {
  // Data for tags - this part is fine
  List<String> selectedTag = [];
  List<String> unselectTags = [
    "同学",
    "老婆",
    "情人",
    "矮冬瓜",
    "肥猪",
    "瘦猴",
    "歪嘴怪",
    "斗鸡眼",
    "龅牙妹",
    "邋遢鬼",
    "臭乞丐",
    "油腻男",
    "卑鄙小人",
    "阴险狡诈之徒",
    "虚伪者",
    "两面派",
    "势利眼",
    "笑面虎",
    "暴躁狂",
    "神经质",
    "小心眼",
    "醋坛子",
    "杠精",
    "喷子",
    "孤立者",
    "马屁精",
    "墙头草",
    "懒汉",
    "废物",
    "草包",
    "饭桶",
    "笨蛋",
    "傻瓜",
    "白痴",
    "脑残",
    "黑心商人",
    "无良医生",
    "贪腐官员"
  ];

  final TextEditingController inputController = TextEditingController();
  final FocusNode focusNode = FocusNode();
  int willBeRemoveTagofLast = 3;

  @override
  void dispose() {
    inputController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LJNSystemCubit, SystemState>(
        builder: (context, systemState) {
      // Pass both context and systemState to the build method
      return _buildPage(context, systemState);
    });
  }

  Widget _buildPage(BuildContext context, SystemState systemState) {
    // Core Refactor: Get theme and l10n instance once at the top of the build method
    ThemeData theme = Theme.of(context);
    AppLocalizations l10n = AppLocalizations.of(context)!;
    final colorScheme = theme.colorScheme;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      primary: false,
      appBar: LJNAppBar(
        title: l10n.addFromAllTags,
        actions: [
          // "Save" button
          GestureDetector(
            onTap: () {
              // Your save logic here
            },
            child: Container(
              height: 60.w,
              constraints: BoxConstraints(minWidth: 98.w),
              margin: EdgeInsets.only(right: 30.w),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                // Corrected: Use primary color from theme
                color: colorScheme.primary,
                borderRadius: BorderRadius.all(Radius.circular(8.w)),
              ),
              child: Text(
                l10n.save,
                style: TextStyle(
                  // Corrected: Use onPrimary color for text on primary background
                  color: colorScheme.onPrimary,
                  fontSize: 25.w,
                  fontWeight: FontWeight.w100,
                ),
              ),
            ),
          )
        ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        // Corrected: Use a theme-aware background color
        color: theme.colorScheme.surfaceContainer,
        child: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics(),
            ),
            child: Column(
              children: [
                // "Selected Tags" section
                Container(
                  width: 750.w,
                  padding: EdgeInsets.fromLTRB(30.w, 35.w, 10.w, 35.w),
                  // Corrected: Use cardColor or surface for white backgrounds
                  color: theme.cardColor,
                  constraints: BoxConstraints(minHeight: 102.w),
                  child: Wrap(
                    spacing: 17.w,
                    runSpacing: 10.w,
                    children: [
                      ..._buildSelectedTags(theme),
                      _buildTagInputField(theme, l10n),
                    ],
                  ),
                ),
                // "All Tags" title section
                Container(
                  height: 73.w,
                  width: 750.w,
                  padding: EdgeInsets.symmetric(horizontal: 30.w),
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        l10n.allTags,
                        style: TextStyle(
                          fontSize: 27.w,
                          // Corrected: Use a theme color for subtitles
                          color: theme.textTheme.bodySmall?.color,
                        ),
                      ),
                      Text(
                        l10n.edit,
                        style: TextStyle(
                          fontSize: 27.w,
                          color: theme.textTheme.bodySmall?.color,
                        ),
                      ),
                    ],
                  ),
                ),
                // "Unselected Tags" section
                Container(
                  width: 750.w,
                  padding:
                      EdgeInsets.only(left: 30.w, right: 10.w, bottom: 200.w),
                  constraints: BoxConstraints(minHeight: 102.w),
                  child: Wrap(
                    spacing: 17.w,
                    runSpacing: 10.w,
                    children: [
                      ..._buildUnselectedTags(theme),
                      _buildNewTagButton(context, systemState, theme, l10n),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper method to build the list of selected tags
  List<Widget> _buildSelectedTags(ThemeData theme) {
    return selectedTag.asMap().entries.map((entry) {
      int key = entry.key;
      String value = entry.value;

      bool isLast = key == selectedTag.length - 1;
      bool isMarkedForDelete = isLast && willBeRemoveTagofLast == 2;

      // Define theme-aware colors
      final Color tagColor = isMarkedForDelete
          ? theme.colorScheme.error // Use error color for deletion warning
          : theme.colorScheme.primaryContainer;
      final Color textColor = isMarkedForDelete
          ? theme.colorScheme.onError
          : theme.colorScheme.onPrimaryContainer;

      if (isMarkedForDelete) {
        return GestureDetector(
          onTap: () => setState(() => willBeRemoveTagofLast = 3),
          child: _buildTag(
            text: value,
            tagColor: tagColor,
            textColor: textColor,
            hasDeleteIcon: true,
            onDelete: () => setState(() {
              selectedTag.removeAt(key);
              willBeRemoveTagofLast = 3; // Reset state after deletion
            }),
          ),
        );
      }

      return GestureDetector(
        onTap: () => setState(() => selectedTag.remove(value)),
        child: _buildTag(text: value, tagColor: tagColor, textColor: textColor),
      );
    }).toList();
  }

  // Helper method to build the list of unselected tags
  List<Widget> _buildUnselectedTags(ThemeData theme) {
    return unselectTags.map((value) {
      bool isSelected = selectedTag.contains(value);
      final Color tagColor = isSelected
          ? theme.colorScheme.primaryContainer
          : theme.chipTheme.backgroundColor ??
              theme.colorScheme.surfaceContainerHighest;
      final Color textColor = isSelected
          ? theme.colorScheme.onPrimaryContainer
          : theme.chipTheme.labelStyle?.color ??
              theme.colorScheme.onSurfaceVariant;

      return GestureDetector(
        onTap: () {
          setState(() {
            if (isSelected) {
              selectedTag.remove(value);
            } else {
              selectedTag.add(value);
            }
          });
        },
        child: _buildTag(text: value, tagColor: tagColor, textColor: textColor),
      );
    }).toList();
  }

  // A generic tag widget to reduce code duplication
  Widget _buildTag({
    required String text,
    required Color tagColor,
    required Color textColor,
    bool hasDeleteIcon = false,
    VoidCallback? onDelete,
  }) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Container(
        height: 60.w,
        padding: EdgeInsets.only(left: 25.w, right: hasDeleteIcon ? 0 : 25.w),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: tagColor,
          borderRadius: BorderRadius.all(Radius.circular(30.w)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              text,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 28.w, color: textColor),
            ),
            if (hasDeleteIcon)
              GestureDetector(
                onTap: onDelete,
                child: Container(
                  width: 50.w,
                  height: 50.w,
                  color: Colors.transparent,
                  alignment: Alignment.center,
                  child: Icon(Icons.cancel, color: textColor, size: 35.w),
                ),
              ),
          ],
        ),
      ),
    );
  }

  // Input field for new tags
  Widget _buildTagInputField(ThemeData theme, AppLocalizations l10n) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Container(
        height: 60.w,
        width: 310.w,
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        decoration: BoxDecoration(
          color: theme.chipTheme.backgroundColor ??
              theme.colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.all(Radius.circular(30.w)),
        ),
        child: Row(
          children: [
            Expanded(
              child: KeyboardListener(
                focusNode:
                    FocusNode(), // Use a local focus node for the listener
                onKeyEvent: (KeyEvent event) {
                  if (event is KeyDownEvent &&
                      event.logicalKey == LogicalKeyboardKey.backspace &&
                      inputController.text.isEmpty &&
                      selectedTag.isNotEmpty) {
                    setState(() {
                      willBeRemoveTagofLast--;
                      if (willBeRemoveTagofLast == 1) {
                        selectedTag.removeLast();
                        willBeRemoveTagofLast = 3;
                      }
                    });
                  }
                },
                child: TextField(
                  controller: inputController,
                  focusNode: focusNode,
                  onSubmitted: (value) {
                    if (value.trim().isNotEmpty) {
                      setState(() {
                        selectedTag.add(value.trim());
                        if (!unselectTags.contains(value.trim())) {
                          unselectTags.add(value.trim());
                        }
                        inputController.clear();
                      });
                    }
                  },
                  cursorColor: theme.primaryColor,
                  style: TextStyle(
                    fontSize: fontSizeScale(28.w),
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  decoration: InputDecoration(
                    isCollapsed: true,
                    contentPadding: EdgeInsets.symmetric(horizontal: 5.w),
                    hintText: l10n.createOrSearchTags,
                    hintStyle: TextStyle(
                      fontSize: fontSizeScale(28.w),
                      color: theme.hintColor,
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                final text = inputController.text.trim();
                if (text.isNotEmpty) {
                  setState(() {
                    selectedTag.add(text);
                    if (!unselectTags.contains(text)) {
                      unselectTags.add(text);
                    }
                    inputController.clear();
                  });
                }
              },
              child: Icon(
                Icons.add_circle,
                color: theme.primaryColor,
                size: 35.w,
              ),
            )
          ],
        ),
      ),
    );
  }

  // "New Tag" button
  Widget _buildNewTagButton(BuildContext context, SystemState systemState,
      ThemeData theme, AppLocalizations l10n) {
    return GestureDetector(
      onTap: () {
        _showNewTagPopup(context, systemState, (String text) {
          if (unselectTags.contains(text)) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  l10n.tagExistsError,
                  textAlign: TextAlign.center,
                ),
              ),
            );
            return;
          }
          setState(() => unselectTags.add(text));
        });
      },
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Container(
          height: 60.w,
          padding: EdgeInsets.symmetric(horizontal: 25.w),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.all(Radius.circular(30.w)),
            border: Border.all(
              width: 1.0.w,
              color: theme.dividerColor,
            ),
          ),
          child: Text(
            l10n.newTag,
            style: TextStyle(
              fontSize: 28.w,
              color: theme.textTheme.bodyMedium?.color,
            ),
          ),
        ),
      ),
    );
  }
}

// Popup for creating a new tag
void _showNewTagPopup(
    BuildContext context, SystemState systemState, Function(String) callback) {
  final TextEditingController inputController2 = TextEditingController();
  AppLocalizations l10n = AppLocalizations.of(context)!;
  ThemeData theme = Theme.of(context);
  final colorScheme = theme.colorScheme;

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent, // Make sheet background transparent
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
          bool isInputEmpty = inputController2.text.trim().isEmpty;
          final Color confirmButtonColor =
              isInputEmpty ? theme.disabledColor : colorScheme.primary;
          final Color confirmTextColor = isInputEmpty
              ? colorScheme.onSurface.withAlpha(97)
              : colorScheme.onPrimary;

          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              decoration: BoxDecoration(
                color: theme.cardColor,
                borderRadius: BorderRadius.vertical(top: Radius.circular(13.w)),
              ),
              height: 600.w,
              child: Column(
                children: [
                  SizedBox(height: 70.w),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(Icons.close, color: colorScheme.onSurface),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      Text(
                        l10n.enterTag,
                        style: theme.textTheme.titleLarge,
                      ),
                      SizedBox(width: 90.w), // To balance the close button
                    ],
                  ),
                  SizedBox(height: 95.w),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 90.w),
                    child: TextField(
                      controller: inputController2,
                      autofocus: true,
                      cursorColor: colorScheme.primary,
                      style: TextStyle(color: colorScheme.onSurface),
                      onChanged: (_) => setState(() {}),
                      decoration: InputDecoration(
                        hintText: l10n.tagName,
                        hintStyle: TextStyle(color: theme.hintColor),
                        // Using theme's default input border
                      ),
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: isInputEmpty
                        ? null
                        : () {
                            callback(inputController2.text.trim());
                            Navigator.of(context).pop();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  l10n.create_success_message,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            );
                          },
                    child: Container(
                      width: 345.w,
                      height: 90.w,
                      decoration: BoxDecoration(
                        color: confirmButtonColor,
                        borderRadius: BorderRadius.circular(10.w),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        l10n.confirm,
                        style: TextStyle(
                          color: confirmTextColor,
                          fontSize: 32.w,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 50.w), // Bottom padding
                ],
              ),
            ),
          );
        },
      );
    },
  );
}
