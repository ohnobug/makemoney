import 'package:flutter/material.dart';

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
class LoRASettingsPage extends StatefulWidget {
  const LoRASettingsPage({super.key});

  @override
  State<LoRASettingsPage> createState() => _LoRASettingsPageState();
}

class _LoRASettingsPageState extends State<LoRASettingsPage> {
  // 模拟数据 (Mock data)
  List<LoRA> loras = [
    LoRA(
      id: 'LoRA_1',
      name: '日系动漫插画',
      version: 'v1.0',
      imagePath: 'assets/images/avatar/chat_2.jpg', // 占位符图片路径
      weight: 4.07,
    ),
    LoRA(
      id: 'LoRA_2',
      name: '清纯御姐脸模',
      version: 'v1.0',
      imagePath: 'assets/images/avatar/chat_2.jpg', // 占位符图片路径
      weight: 0.80,
    ),
    LoRA(
      id: 'LoRA_3',
      name: '新海诚风格动漫',
      version: 'v1.0',
      imagePath: 'assets/images/avatar/chat_2.jpg', // 占位符图片路径
      weight: 0.80,
    ),
  ];

  String promptText = '一位身穿花卉连衣裙的女孩站在蓝天白云下，她侧脸看向一旁的一只白鸽.';

  @override
  Widget build(BuildContext context) {
    const Color cardBackgroundColor = Color(0xFFF7F7F7);
    const Color primaryBlue = Color(0xFF1E88E5);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('AI 图像生成'),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- LoRA Selection Card ---
            _buildCard(
              backgroundColor: cardBackgroundColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionHeader(
                    title: '灵感库',
                    trailing: _buildAddLoRAButton(),
                  ),
                  const SizedBox(height: 10),
                  // LoRA 列表
                  ...loras.map((lora) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: LoRAItem(
                        lora: lora,
                        onDelete: () => _deleteLoRA(lora),
                        onWeightChanged: (newWeight) =>
                            _updateLoRAWeight(lora, newWeight),
                        primaryColor: primaryBlue,
                      ),
                    );
                  }),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // --- Prompt Input Card (已修改为多行输入框) ---
            _buildCard(
              backgroundColor: cardBackgroundColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '输入提示词',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 12),
                  /* const Text(
                    '提示词',
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                  const SizedBox(height: 5), */

                  // **修改点 2: 多行文本输入框**
                  TextFormField(
                    initialValue: promptText,
                    onChanged: (newValue) {
                      setState(() {
                        promptText = newValue;
                      });
                    },
                    minLines: 3,
                    maxLines: null, // 允许无限行，实现多行输入
                    keyboardType: TextInputType.multiline,
                    style: const TextStyle(fontSize: 15),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white, // 输入框内部是白色背景
                      contentPadding: const EdgeInsets.all(12),
                      hintText: '请输入提示词...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide:
                            const BorderSide(color: primaryBlue, width: 2),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      // --- 底部“一键生成”按钮 ---
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.05),
              offset: Offset(0, -2),
              blurRadius: 4,
            ),
          ],
        ),
        child: _buildGenerateButton(primaryBlue),
      ),
    );
  }

  // ... (Helper methods for _buildCard, _buildSectionHeader, _buildAddLoRAButton, _buildGenerateButton, _deleteLoRA, _updateLoRAWeight remain the same)
  Widget _buildSectionHeader({required String title, Widget? trailing}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        if (trailing != null) trailing,
      ],
    );
  }

  Widget _buildAddLoRAButton() {
    return TextButton.icon(
      onPressed: () {
        Navigator.pushNamed(context, '/resource_publisher');
      },
      icon: const Icon(Icons.add_circle_outline, size: 20),
      label: const Text('添加灵感库'),
      style: TextButton.styleFrom(
        foregroundColor: Colors.blue,
      ),
    );
  }

  Widget _buildCard({required Color backgroundColor, required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(16.0),
      child: child,
    );
  }

  Widget _buildGenerateButton(Color primaryBlue) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushNamed(context, '/publish_work');
      },
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 50),
        backgroundColor: Colors.red,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        padding: const EdgeInsets.symmetric(vertical: 12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            '一键生成',
            style: TextStyle(
                fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          /*  const SizedBox(width: 8),
          const Icon(Icons.flash_on, color: Colors.yellow, size: 20),
          const SizedBox(width: 4), */
          /*  Text(
            '11',
            style:
                TextStyle(fontSize: 16, color: Colors.white.withOpacity(0.8)),
          ), */
          /* const Text(
            ' 22',
            style: TextStyle(fontSize: 16, color: Colors.grey.shade400),
          ), */
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

  const LoRAItem({
    super.key,
    required this.lora,
    required this.onDelete,
    required this.onWeightChanged,
    required this.primaryColor,
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // LoRA 显示行 (与之前一致)
        Container(
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
          ),
          clipBehavior: Clip.antiAlias,
          child: Row(
            children: [
              // 左侧小图
              Container(
                width: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Image.asset(
                  widget.lora.imagePath,
                  fit: BoxFit.cover,
                ),
              ),

              // 右侧背景图与遮罩层
              Expanded(
                  child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(0.0), // 左上角的圆角半径
                  topRight: Radius.circular(4.0), // 右上角的圆角半径
                  bottomLeft: Radius.circular(0.0), // 左下角的圆角半径
                  bottomRight: Radius.circular(4.0), // 右下角的圆角半径
                ),
                child: Stack(
                  children: [
                    Image.asset(
                      widget.lora.imagePath,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                    Container(
                      color: Colors.black.withOpacity(0.7),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.lora.name,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14),
                              ),
                              Text(
                                'F.1 | ${widget.lora.version}',
                                style: TextStyle(
                                    color: Colors.white.withOpacity(0.8),
                                    fontSize: 12),
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: const Padding(
                              padding: EdgeInsets.symmetric(vertical: 8.0),
                              child: Icon(Icons.arrow_forward_ios,
                                  color: Colors.white, size: 18),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
              // 删除图标
              Container(
                width: 40,
                height: double.infinity,
                alignment: Alignment.center,
                child: IconButton(
                  icon: Icon(Icons.delete_outline, color: Colors.grey.shade600),
                  onPressed: widget.onDelete,
                  splashRadius: 20,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 8),

        // **修改点 1: 权重、滑块和数值在同一行**
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 4.0),
              child: Text(
                '权重',
                style: TextStyle(color: Colors.grey.shade700, fontSize: 14),
              ),
            ),
            Expanded(
              child: SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  thumbColor: widget.primaryColor,
                  activeTrackColor: widget.primaryColor,
                  inactiveTrackColor: Colors.grey.shade300,
                  overlayColor: widget.primaryColor.withOpacity(0.2),
                  trackHeight: 4.0,
                  thumbShape:
                      const RoundSliderThumbShape(enabledThumbRadius: 6.0),
                ),
                child: Slider(
                  value: _currentWeight,
                  min: 0,
                  max: 10,
                  divisions: 100,
                  onChanged: (double value) {
                    setState(() {
                      _currentWeight = double.parse(value.toStringAsFixed(2));
                    });
                    widget.onWeightChanged(_currentWeight);
                  },
                ),
              ),
            ),
            Container(
              width: 50,
              alignment: Alignment.centerRight,
              child: Text(
                _currentWeight.toStringAsFixed(2),
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
