import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vigaviga/themes.dart';
import 'package:vigaviga/l10n/app_localizations.dart';
import 'package:vigaviga/widgets/viga_appbar.dart';
import 'package:vigaviga/widgets/viga_change_detail_item.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/store/viga_system_cubit.dart';

class VigaBillDetailsPage extends StatefulWidget {
  const VigaBillDetailsPage({super.key});

  @override
  State<VigaBillDetailsPage> createState() => _VigaBillDetailsPage();
}

class _VigaBillDetailsPage extends State<VigaBillDetailsPage>
    with SingleTickerProviderStateMixin {
  bool _showFilterOverlay = false;
  late AnimationController _animationController;
  late Animation<double> _slideAnimation;

  // State for filters
  String _incomeAndExpenditureType = "all";
  String _transactionType = "all";

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
      reverseDuration: const Duration(milliseconds: 200),
    );

    // Animate from off-screen (1.0) to on-screen (0.0)
    _slideAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _openFilter() {
    setState(() => _showFilterOverlay = true);
    _animationController.forward();
  }

  void _closeFilter() {
    _animationController.reverse().then((_) {
      if (mounted) {
        setState(() => _showFilterOverlay = false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Get theme and l10n at the top for easy access
    ThemeData theme = Theme.of(context);

    AppLocalizations l10n = AppLocalizations.of(context)!;
    final colorScheme = theme.colorScheme;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: BlocBuilder<VigaSystemCubit, SystemState>(
        builder: (context, systemState) {
          String cdnBase = systemState.cdnBase;

          return Scaffold(
            primary: false,
            appBar: VigaAppBar(
              title: l10n.bill,
              actions: [
                VigaAppBarActionTextButton(
                  onTap: () {
                    context.push(
                      '/webview',
                      extra: {
                        'url': 'https://help.vigaviga.com', // Vue开发服务器地址
                        'title': l10n.helpAndFeedback,
                      },
                    );
                  },
                  title: l10n.faq,
                ),
              ],
            ),
            body: Stack(
              children: [
                // Main content
                Container(
                  height: double.infinity,
                  color: colorScheme.surfaceContainer,
                  child: Column(
                    children: [
                      _buildFilterBar(theme, l10n),
                      _buildDateSelector(theme, l10n),
                      Expanded(
                        child: ScrollConfiguration(
                          behavior: ScrollConfiguration.of(context)
                              .copyWith(scrollbars: false),
                          child: SingleChildScrollView(
                            physics: AlwaysScrollableScrollPhysics(
                              parent: BouncingScrollPhysics(),
                            ),
                            child: Column(
                              // Your list of VigaChangeDetailItem
                              children: [
                                VigaChangeDetailItem(
                                  title: "原乡智选",
                                  change: -32,
                                  icon: "$cdnBase/avatar/01.png",
                                  link: '',
                                  underline: true,
                                ),
                                VigaChangeDetailItem(
                                  title: "原乡智选",
                                  change: -56,
                                  icon: "$cdnBase/avatar/01.png",
                                  link: '',
                                  underline: true,
                                ),
                                VigaChangeDetailItem(
                                  title: "原乡智选",
                                  change: -14,
                                  icon: "$cdnBase/avatar/01.png",
                                  link: '',
                                  underline: true,
                                ),
                                VigaChangeDetailItem(
                                  title: "原乡智选",
                                  change: 200,
                                  icon: "$cdnBase/avatar/01.png",
                                  link: '',
                                  underline: true,
                                ),
                                VigaChangeDetailItem(
                                  title: "原乡智选",
                                  change: -49,
                                  icon: "$cdnBase/avatar/01.png",
                                  link: '',
                                  underline: true,
                                ),
                                VigaChangeDetailItem(
                                  title: "原乡智选",
                                  change: -18,
                                  icon: "$cdnBase/avatar/01.png",
                                  link: '',
                                  underline: true,
                                ),
                                VigaChangeDetailItem(
                                  title: "原乡智选",
                                  change: -21,
                                  icon: "$cdnBase/avatar/01.png",
                                  link: '',
                                  underline: true,
                                ),
                                VigaChangeDetailItem(
                                  title: "原乡智选",
                                  change: -29,
                                  icon: "$cdnBase/avatar/01.png",
                                  link: '',
                                  underline: true,
                                ),
                                VigaChangeDetailItem(
                                  title: "原乡智选",
                                  change: -91,
                                  icon: "$cdnBase/avatar/01.png",
                                  link: '',
                                  underline: true,
                                ),
                                VigaChangeDetailItem(
                                  title: "原乡智选",
                                  change: -5,
                                  icon: "$cdnBase/avatar/01.png",
                                  link: '',
                                  underline: true,
                                ),
                                VigaChangeDetailItem(
                                  title: "原乡智选",
                                  change: -73,
                                  icon: "$cdnBase/avatar/01.png",
                                  link: '',
                                  underline: true,
                                ),
                                VigaChangeDetailItem(
                                  title: "原乡智选",
                                  change: -47,
                                  icon: "$cdnBase/avatar/01.png",
                                  link: '',
                                  underline: true,
                                ),
                                VigaChangeDetailItem(
                                  title: "原乡智选",
                                  change: -15,
                                  icon: "$cdnBase/avatar/01.png",
                                  link: '',
                                  underline: true,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Filter Overlay and Panel
                if (_showFilterOverlay) ...[
                  GestureDetector(
                    onTap: _closeFilter,
                    child: Container(
                      color: AppColors
                          .blackTransparent45, // This can stay hardcoded
                    ),
                  ),
                  AnimatedBuilder(
                    animation: _animationController,
                    builder: (context, child) {
                      return Transform.translate(
                        offset: Offset(0, _slideAnimation.value * 1030.w),
                        child: child,
                      );
                    },
                    child: _buildFilterPanel(theme, l10n),
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }

  // Helper widget for the filter bar at the top
  Widget _buildFilterBar(ThemeData theme, AppLocalizations l10n) {
    return Container(
      height: 130.w,
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      decoration: BoxDecoration(
        color: theme.cardColor, // Use cardColor for a slight elevation feel
        border: Border(
          top: BorderSide(
            color: theme.dividerColor,
            width: 2.w,
          ),
          bottom: BorderSide(
            color: theme.dividerColor,
            width: 2.w,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: _openFilter,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 25.w),
              height: 70.w,
              decoration: BoxDecoration(
                color: theme.colorScheme
                    .surfaceContainerHighest, // Theme-aware background
                borderRadius: BorderRadius.circular(70.w),
              ),
              child: Row(
                children: [
                  Text(
                    l10n.allBills,
                    style: TextStyle(
                      fontSize: 30.w,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Icon(
                    Icons.arrow_drop_down,
                    size: 25.w,
                  ),
                ],
              ),
            ),
          ),
          Row(
            children: [
              Text(
                l10n.statistics,
                style: TextStyle(
                  fontSize: 30.w,
                ),
              ),
              SizedBox(width: 8.w),
              Icon(
                Icons.arrow_forward_ios,
                size: 30.w,
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Helper widget for the date selector
  Widget _buildDateSelector(ThemeData theme, AppLocalizations l10n) {
    return Container(
      height: 107.w,
      padding: EdgeInsets.only(
        left: 42.w,
      ),
      alignment: Alignment.centerLeft,
      color: theme.colorScheme.surface,
      child: Row(
        children: [
          Text(
            l10n.yearAndMonth(
              DateTime(
                2023,
                12,
              ),
            ),
            style: TextStyle(
              fontSize: 30.w,
              color: theme.colorScheme.onSurface,
            ),
          ),
          SizedBox(width: 8.w),
          Icon(
            Icons.calendar_today,
            size: 30.w,
            color: theme.colorScheme.onSurface,
          ),
        ],
      ),
    );
  }

  // Helper widget for the filter panel
  Widget _buildFilterPanel(ThemeData theme, AppLocalizations l10n) {
    ThemeData theme = Theme.of(context);

    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 1030.w,
        padding: EdgeInsets.symmetric(
          horizontal: 45.w,
        ),
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(
              18.w,
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 47.w,
              child: Center(
                child: Text(
                  l10n.selectFilter,
                  style: theme.textTheme.titleMedium,
                ),
              ),
            ),
            SizedBox(height: 50.w),
            Text(
              l10n.incomeExpenseType,
              style: theme.textTheme.titleSmall,
            ),
            SizedBox(height: 20.w),
            Wrap(
              spacing: 22.w,
              runSpacing: 20.w,
              children: [
                VigaFilterButton(
                  title: l10n.all,
                  selected: _incomeAndExpenditureType == "all",
                  onTap: () => setState(
                    () => _incomeAndExpenditureType = "all",
                  ),
                ),
                VigaFilterButton(
                  title: l10n.expense,
                  selected: _incomeAndExpenditureType == "expenditure",
                  onTap: () => setState(
                    () => _incomeAndExpenditureType = "expenditure",
                  ),
                ),
                VigaFilterButton(
                  title: l10n.income,
                  selected: _incomeAndExpenditureType == "income",
                  onTap: () => setState(
                    () => _incomeAndExpenditureType = "income",
                  ),
                ),
              ],
            ),
            SizedBox(height: 52.w),
            Text(
              l10n.transactionType,
              style: theme.textTheme.titleSmall,
            ),
            SizedBox(height: 20.w),
            Wrap(
              spacing: 22.w,
              runSpacing: 20.w,
              children: [
                VigaFilterButton(
                  title: l10n.all,
                  selected: _transactionType == "all",
                  onTap: () => setState(
                    () => _transactionType = "all",
                  ),
                ),
                VigaFilterButton(
                  title: l10n.redPacket,
                  selected: _transactionType == "redpack",
                  onTap: () => setState(
                    () => _transactionType = "redpack",
                  ),
                ),
                VigaFilterButton(
                  title: l10n.transfer,
                  selected: _transactionType == "transaction",
                  onTap: () => setState(
                    () => _transactionType = "transaction",
                  ),
                ),
                VigaFilterButton(
                  title: l10n.groupSplitBill,
                  selected: _transactionType == "group_collection",
                  onTap: () => setState(
                    () => _transactionType = "group_collection",
                  ),
                ),
                VigaFilterButton(
                  title: l10n.qrCodePayment,
                  selected: _transactionType == "qr_code_payment_and_receipt",
                  onTap: () => setState(
                    () => _transactionType = "qr_code_payment_and_receipt",
                  ),
                ),
                VigaFilterButton(
                  title: l10n.merchantPayment,
                  selected: _transactionType == "merchant_consumption",
                  onTap: () => setState(
                    () => _transactionType = "merchant_consumption",
                  ),
                ),
                VigaFilterButton(
                  title: l10n.topUpAndWithdrawal,
                  selected: _transactionType == "recharge_and_withdrawal",
                  onTap: () => setState(
                    () => _transactionType = "recharge_and_withdrawal",
                  ),
                ),
                VigaFilterButton(
                  title: l10n.creditCardRepayment,
                  selected: _transactionType == "credit_card_payment",
                  onTap: () => setState(
                    () => _transactionType = "credit_card_payment",
                  ),
                ),
                VigaFilterButton(
                  title: l10n.withRefund,
                  selected: _transactionType == "there_is_a_refund_available",
                  onTap: () => setState(
                    () => _transactionType = "there_is_a_refund_available",
                  ),
                ),
              ],
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: _closeFilter,
                    style: TextButton.styleFrom(
                      backgroundColor:
                          theme.colorScheme.surfaceContainerHighest,
                      foregroundColor: theme.colorScheme.onSurfaceVariant,
                      padding: EdgeInsets.symmetric(vertical: 25.w),
                    ),
                    child: Text(
                      l10n.cancel,
                      style: TextStyle(
                        fontSize: 30.w,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 30.w),
                Expanded(
                  child: TextButton(
                    onPressed: _closeFilter,
                    style: TextButton.styleFrom(
                      backgroundColor: theme.colorScheme.primary,
                      foregroundColor: theme.colorScheme.onPrimary,
                      padding: EdgeInsets.symmetric(vertical: 25.w),
                    ),
                    child: Text(
                      l10n.confirm,
                      style: TextStyle(
                        fontSize: 30.w,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 50.w), // Bottom padding
          ],
        ),
      ),
    );
  }
}

// --- Filter Button (Corrected) ---
class VigaFilterButton extends StatelessWidget {
  final String title;
  final bool selected;
  final VoidCallback? onTap;

  const VigaFilterButton({
    super.key,
    required this.title,
    required this.selected,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    final chipTheme = theme.chipTheme;

    // Determine colors based on selection state and theme
    final Color backgroundColor = selected
        ? (chipTheme.selectedColor ?? theme.colorScheme.primaryContainer)
        : (chipTheme.backgroundColor ??
            theme.colorScheme.surfaceContainerHighest);
    final Color textColor = selected
        ? (chipTheme.secondaryLabelStyle?.color ??
            theme.colorScheme.onPrimaryContainer)
        : (chipTheme.labelStyle?.color ?? theme.colorScheme.onSurfaceVariant);
    final BorderSide border = selected
        ? BorderSide(color: theme.colorScheme.primary, width: 2.w)
        : BorderSide.none;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 205.w,
        height: 85.w,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.fromBorderSide(border),
          borderRadius: BorderRadius.all(
            Radius.circular(
              10.w,
            ),
          ),
        ),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 26.w,
            color: textColor,
            height: 2.2.w,
          ),
        ),
      ),
    );
  }
}
