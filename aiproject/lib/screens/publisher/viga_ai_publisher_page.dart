import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:vigaviga/widgets/viga_app_network_image.dart'; // 确保这个路径是正确的

// --- Data Model for LoRA ---
class LoRA {
  final String id;
  final String name;
  final String version;
  final String imagePath;
  double weight;

  LoRA({
    required this.id,
    required this.name,
    required this.version,
    required this.imagePath,
    this.weight = 1.0,
  });
}

// --- Main Page Widget ---
class VigaAiPublisherPage extends StatefulWidget {
  const VigaAiPublisherPage({super.key});

  @override
  State<VigaAiPublisherPage> createState() => _VigaAiPublisherPageState();
}

class _VigaAiPublisherPageState extends State<VigaAiPublisherPage> {
  // 模拟数据 (Mock data)
  List<LoRA> loras = [
    LoRA(
      id: 'LoRA_1',
      name: '日系动漫插画',
      version: 'v1.0',
      imagePath: 'assets/images/avatar/chat_2.jpg',
      weight: 4.07,
    ),
    LoRA(
      id: 'LoRA_2',
      name: '清纯御姐脸模',
      version: 'v1.0',
      imagePath: 'assets/images/avatar/chat_2.jpg',
      weight: 0.80,
    ),
    LoRA(
      id: 'LoRA_3',
      name: '新海诚风格动漫',
      version: 'v1.0',
      imagePath: 'assets/images/avatar/chat_2.jpg',
      weight: 0.80,
    ),
  ];

  String promptText = '一位身穿花卉连衣裙的女孩站在蓝天白云下，她侧脸看向一旁的一只白鸽.';

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surfaceContainer,
      appBar: AppBar(
        title: Text(
          'AI 图像生成',
          style: TextStyle(
            color: theme.colorScheme.onSurface,
            fontSize: 36.w,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: theme.colorScheme.surfaceContainer,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: theme.colorScheme.onSurface,
            size: 40.w,
          ),
          onPressed: () => context.pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(32.0.w), // 16 * 2
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- LoRA Selection Card ---
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(24.w),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha((0.05 * 255).toInt()),
                    blurRadius: 10.w,
                    offset: Offset(0, 2.w),
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.all(32.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionHeader(
                      theme: theme,
                      title: '灵感库',
                      trailing: _buildAddLoRAButton(theme),
                    ),
                    SizedBox(height: 24.0.w), // 12 * 2
                    // LoRA 列表
                    ...loras.map((lora) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: 24.0.w), // 12 * 2
                        child: LoRAItem(
                          lora: lora,
                          onDelete: () => _deleteLoRA(lora),
                          onWeightChanged: (newWeight) =>
                              _updateLoRAWeight(lora, newWeight),
                          primaryColor: theme.colorScheme.primary,
                          theme: theme,
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
            SizedBox(height: 32.0.w), // 16 * 2

            // --- Prompt Input Card ---
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(24.w),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha((0.05 * 255).toInt()),
                    blurRadius: 10.w,
                    offset: Offset(0, 2.w),
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.all(32.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.edit_outlined,
                          color: theme.colorScheme.primary,
                          size: 32.w,
                        ),
                        SizedBox(width: 12.w),
                        Text(
                          '输入提示词',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 32.0.w,
                            color: theme.colorScheme.onSurface,
                          ), // 16 * 2
                        ),
                      ],
                    ),
                    SizedBox(height: 24.0.w), // 12 * 2
                    TextFormField(
                      initialValue: promptText,
                      onChanged: (newValue) {
                        setState(() {
                          promptText = newValue;
                        });
                      },
                      minLines: 4,
                      maxLines: 6,
                      keyboardType: TextInputType.multiline,
                      style: TextStyle(
                        fontSize: 30.0.w,
                        color: theme.colorScheme.onSurface,
                      ), // 15 * 2
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: theme.colorScheme.surfaceContainerHighest,
                        contentPadding: EdgeInsets.all(24.0.w), // 12 * 2
                        hintText: '描述你想要生成的图像，例如：一位身穿花卉连衣裙的女孩站在蓝天白云下...',
                        hintStyle: TextStyle(
                          color: theme.colorScheme.onSurfaceVariant,
                          fontSize: 28.w,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.0.w), // 8 * 2
                          borderSide: BorderSide(color: theme.dividerColor),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.0.w), // 8 * 2
                          borderSide: BorderSide(color: theme.dividerColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.0.w), // 8 * 2
                          borderSide: BorderSide(
                              color: theme.colorScheme.primary,
                              width: 2.0.w), // 1 * 2
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      // --- 底部"一键生成"按钮 ---
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(32.0.w), // 16 * 2
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha((0.1 * 255).toInt()),
              offset: Offset(0, -4.0.w), // -2 * 2
              blurRadius: 20.0.w, // 10 * 2
            ),
          ],
        ),
        child: SafeArea(
          child: _buildGenerateButton(theme),
        ),
      ),
    );
  }

  Widget _buildSectionHeader({
    required ThemeData theme,
    required String title,
    Widget? trailing,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 32.0.w,
            color: theme.colorScheme.onSurface,
          ), // 16 * 2
        ),
        if (trailing != null) trailing,
      ],
    );
  }

  Widget _buildAddLoRAButton(ThemeData theme) {
    return TextButton.icon(
      onPressed: () {
        context.push('/resource_publisher');
      },
      icon: Icon(Icons.add_circle_outline, size: 36.0.w), // 18 * 2
      label: Text('添加灵感库'),
      style: TextButton.styleFrom(
        foregroundColor: theme.colorScheme.primary,
        textStyle: TextStyle(
          fontSize: 26.w,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildGenerateButton(ThemeData theme) {
    return ElevatedButton(
      onPressed: () {
        context.push('/publish_work');
      },
      style: ElevatedButton.styleFrom(
        minimumSize: Size(double.infinity, 100.0.w), // 50 * 2
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: theme.colorScheme.onPrimary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0.w), // 25 * 2
        ),
        padding: EdgeInsets.symmetric(vertical: 24.0.w), // 12 * 2
        elevation: 0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.auto_awesome_outlined,
            size: 36.w,
          ),
          SizedBox(width: 12.w),
          Text(
            '一键生成',
            style: TextStyle(
              fontSize: 36.0.w, // 18 * 2
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  void _deleteLoRA(LoRA lora) {
    setState(() {
      loras.removeWhere((item) => item.id == lora.id);
    });
  }

  void _updateLoRAWeight(LoRA lora, double newWeight) {
    setState(() {
      lora.weight = newWeight;
    });
  }
}

// --- Custom Widget for a Single LoRA Item ---
class LoRAItem extends StatefulWidget {
  final LoRA lora;
  final VoidCallback onDelete;
  final ValueChanged<double> onWeightChanged;
  final Color primaryColor;
  final ThemeData theme;

  const LoRAItem({
    super.key,
    required this.lora,
    required this.onDelete,
    required this.onWeightChanged,
    required this.primaryColor,
    required this.theme,
  });

  @override
  State<LoRAItem> createState() => _LoRAItemState();
}

class _LoRAItemState extends State<LoRAItem> {
  late double _currentWeight;

  @override
  void initState() {
    super.initState();
    _currentWeight = widget.lora.weight;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget.theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(16.w),
        border: Border.all(
          color: widget.theme.dividerColor.withAlpha((0.3 * 255).toInt()),
          width: 1.w,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // LoRA 显示行
          Container(
            height: 100.0.w, // 50 * 2
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.0.w), // 8 * 2
            ),
            clipBehavior: Clip.antiAlias,
            child: Row(
              children: [
                // 左侧小图
                Container(
                  width: 160.0.w, // 80 * 2
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0.w), // 8 * 2
                  ),
                  child: VigaAppNetworkImage(
                    imageUrl: widget.lora.imagePath,
                    fit: BoxFit.cover,
                  ),
                ),

                // 右侧背景图与遮罩层
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(0.0.w),
                      topRight: Radius.circular(16.0.w), // 8 * 2
                      bottomLeft: Radius.circular(0.0.w),
                      bottomRight: Radius.circular(16.0.w), // 8 * 2
                    ),
                    child: Stack(
                      children: [
                        VigaAppNetworkImage(
                          imageUrl: widget.lora.imagePath,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                Colors.black.withAlpha((0.7 * 255).toInt()),
                                Colors.black.withAlpha((0.3 * 255).toInt()),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 32.0.w), // 16 * 2
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.lora.name,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 28.0.w,
                                    ), // 14 * 2
                                  ),
                                  SizedBox(height: 4.w),
                                  Text(
                                    'F.1 | ${widget.lora.version}',
                                    style: TextStyle(
                                      color: Colors.white.withAlpha(204),
                                      fontSize: 22.0.w,
                                    ), // 11 * 2
                                  ),
                                ],
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 16.0.w), // 8 * 2
                                  child: Icon(Icons.arrow_forward_ios,
                                      color: Colors.white,
                                      size: 32.0.w), // 16 * 2
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // 删除图标
                Container(
                  width: 80.0.w, // 40 * 2
                  height: double.infinity,
                  alignment: Alignment.center,
                  child: IconButton(
                    icon: Icon(Icons.delete_outline,
                        color: widget.theme.colorScheme.onSurfaceVariant),
                    onPressed: widget.onDelete,
                    splashRadius: 40.0.w, // 20 * 2
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 16.0.w), // 8 * 2

          // 权重滑块区域
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '权重',
                  style: TextStyle(
                    color: widget.theme.colorScheme.onSurfaceVariant,
                    fontSize: 26.0.w,
                    fontWeight: FontWeight.w500,
                  ), // 13 * 2
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      thumbColor: widget.primaryColor,
                      activeTrackColor: widget.primaryColor,
                      inactiveTrackColor: widget.theme.dividerColor,
                      overlayColor: widget.primaryColor.withAlpha(51),
                      trackHeight: 6.0.w, // 3 * 2
                      thumbShape: RoundSliderThumbShape(
                        enabledThumbRadius: 10.0.w,
                      ), // 5 * 2
                    ),
                    child: Slider(
                      value: _currentWeight,
                      min: 0,
                      max: 10,
                      divisions: 100,
                      onChanged: (double value) {
                        setState(() {
                          _currentWeight =
                              double.parse(value.toStringAsFixed(2));
                        });
                        widget.onWeightChanged(_currentWeight);
                      },
                    ),
                  ),
                ),
                SizedBox(width: 16.w),
                Container(
                  width: 80.0.w, // 40 * 2
                  alignment: Alignment.center,
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.w),
                  decoration: BoxDecoration(
                    color: widget.theme.colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(12.w),
                  ),
                  child: Text(
                    _currentWeight.toStringAsFixed(1),
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 24.0.w,
                      color: widget.theme.colorScheme.onPrimaryContainer,
                    ), // 12 * 2
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.w),
        ],
      ),
    );
  }
}
