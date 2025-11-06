import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vigaviga/themes.dart';
import 'package:vigaviga/l10n/app_localizations.dart';
import 'package:vigaviga/widgets/viga_alphabet.dart';
import 'package:vigaviga/widgets/viga_appbar.dart';
import 'package:vigaviga/widgets/viga_function_list.dart';
import 'package:vigaviga/widgets/viga_special_function_item.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/store/viga_system_cubit.dart';

// 数据模型
class Device {
  final String name;
  final String? subtitle;
  final bool isCurrent;

  Device({required this.name, this.subtitle, this.isCurrent = false});
}

class VigaLoggedDevicesPage extends StatefulWidget {
  const VigaLoggedDevicesPage({super.key});

  @override
  State<VigaLoggedDevicesPage> createState() => _VigaLoggedDevicesPageState();
}

class _VigaLoggedDevicesPageState extends State<VigaLoggedDevicesPage> {
  bool _isEditing = false;

  // 模拟数据
  List<Device> loggedInDevices = [
    Device(name: '少年郎他爸爸', isCurrent: true),
    Device(name: 'admin的iMac'),
  ];

  List<Device> loggedOutDevices = [
    Device(name: 'IT-PD000472', subtitle: '9月17日 02:10'),
    Device(name: 'admin的iMac', subtitle: '2024年9月16日 14:36'),
    Device(name: '黄智杰的iPhone', subtitle: '2023年5月27日 10:54'),
    Device(name: 'Windows 10 x64', subtitle: '2023年1月4日 18:54'),
    Device(name: 'Android 设备', subtitle: '2019年6月11日 17:10'),
    Device(name: 'vivo-vivo X7', subtitle: '2018年9月9日 00:58'),
    Device(name: 'Android 设备', subtitle: '2017年4月8日 14:32'),
  ];

  void _toggleEditMode() {
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  void _deleteDevice(List<Device> list, int index) {
    setState(() {
      list.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    AppLocalizations l10n = AppLocalizations.of(context)!;

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
              title: l10n.loggedInDevices,
              actions: [
                GestureDetector(
                  onTap: _toggleEditMode,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 40.w),
                    alignment: Alignment.center,
                    child: Text(
                      _isEditing ? l10n.done : l10n.edit,
                      style: TextStyle(
                        color: _isEditing
                            ? theme.colorScheme.primary
                            : theme.colorScheme.onSurface,
                        fontSize: 32.w,
                        fontWeight:
                            _isEditing ? FontWeight.bold : FontWeight.w100,
                      ),
                    ),
                  ),
                )
              ],
            ),
            body: ScrollConfiguration(
              behavior:
                  ScrollConfiguration.of(context).copyWith(scrollbars: false),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics(),
                ),
                child: Container(
                  constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height -
                        systemState.appbarHeight -
                        systemState.statusHeight,
                  ),
                  color: theme.colorScheme.surfaceContainer,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 30.w,
                          vertical: 20.w,
                        ),
                        child: Text(
                          l10n.manageLoginDevicesDescriptionFull,
                          style: TextStyle(
                            fontSize: 27.w,
                            color: AppColors.neutralGrey60,
                          ),
                        ),
                      ),
                      // 当前设备
                      VigaFunctionList(
                        title:
                            VigaAlphabet(title: l10n.currentlyLoggedInDevices),
                        children:
                            List.generate(loggedInDevices.length, (index) {
                          final device = loggedInDevices[index];
                          return _buildDeviceItem(
                            device,
                            () => _deleteDevice(loggedInDevices, index),
                            cdnBase,
                            l10n,
                          );
                        }),
                      ),
                      // 登出设备
                      VigaFunctionList(
                        title: VigaAlphabet(title: l10n.loggedOutDevices),
                        children:
                            List.generate(loggedOutDevices.length, (index) {
                          final device = loggedOutDevices[index];
                          return _buildDeviceItem(
                            device,
                            () => _deleteDevice(loggedOutDevices, index),
                            cdnBase,
                            l10n,
                          );
                        }),
                      ),
                      SizedBox(height: 100.w)
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildDeviceItem(Device device, VoidCallback onDelete, String cdnBase,
      AppLocalizations l10n) {
    return Row(
      children: [
        if (_isEditing && !device.isCurrent)
          GestureDetector(
            onTap: onDelete,
            child: Padding(
              padding: EdgeInsets.only(left: 30.w, right: 0.w),
              child: Icon(
                Icons.remove_circle,
                color: Colors.red,
                size: 40.w,
              ),
            ),
          ),
        Expanded(
          child: VigaSpecialFunctionItem(
            // height: 130.w,
            title: device.name,
            link: _isEditing ? null : '/settings/device_detail',
            underline: true,
            subTitle: device.subtitle != null
                ? Text(
                    device.subtitle!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: AppColors.neutralGrey37,
                      fontSize: 28.w,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                : null,
            showStyle: device.isCurrent
                ? Expanded(
                    flex: 0,
                    child: Container(
                      constraints: BoxConstraints(maxWidth: 375.w),
                      child: Text(
                        l10n.currentDevice,
                        textAlign: TextAlign.end,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: AppColors.neutralGrey37,
                          fontSize: 28.w,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  )
                : null,
          ),
        ),
      ],
    );
  }
}
