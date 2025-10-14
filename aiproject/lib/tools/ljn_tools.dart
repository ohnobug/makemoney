import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_thumbnail_video/index.dart';
import 'package:get_thumbnail_video/video_thumbnail.dart';
import 'package:http/http.dart' as http;
import 'package:image_size_getter/image_size_getter.dart' as imagegetter;
import 'package:path_provider/path_provider.dart';
import 'package:vigaviga/tools/ljn_logger.dart';

// 字体缩放
double fontSizeScale(double size) {
  return size * 1.0;
}

// 图片路径修正
String assetPath(String path) {
  if (kIsWeb) {
    return 'assets/$path';
  } else {
    return 'assets/$path';
  }
}

// 是否有效的图片
Future<bool> isValidImage(File file) async {
  if (file.lengthSync() <= 4) {
    return false;
  }

  logger.info("file length: ${file.lengthSync()}");

  final bytes = await file.openRead(0, 4).first;
  if (bytes[0] == 0x89 &&
      bytes[1] == 0x50 &&
      bytes[2] == 0x4E &&
      bytes[3] == 0x47) {
    logger.info("This is a valid PNG file.");
    return true;
  } else if (bytes[0] == 0xFF && bytes[1] == 0xD8 && bytes[2] == 0xFF) {
    logger.info("This is a valid JPG file.");
    return true;
  } else {
    logger.info("Unknown file format.");
    return false;
  }
}

// 获取视频首帧
Future<String> getFirstFrame(String url) async {
  WidgetsFlutterBinding.ensureInitialized();
  String filehash = await generateStringChunkHash(url);
  String tempFile = filehash.substring(0, 16);

  final List<Directory>? tempDir = await getExternalCacheDirectories();

  // 提取首帧并保存为图片
  final String outputImagePath = '${tempDir?[0].path}/$tempFile.png';

  var imageFile = File(outputImagePath);
  if (imageFile.existsSync() && await isValidImage(imageFile)) {
    return outputImagePath;
  } else {
    if (imageFile.existsSync()) {
      imageFile.deleteSync();
    }

    final fileName = await VideoThumbnail.thumbnailFile(
      video: url,
      thumbnailPath: outputImagePath,
      imageFormat: ImageFormat.PNG,
      quality: 100,
    );

    return fileName.path;
  }
}

Future<Size?> getLocalAssetImageSize(String assetPath) async {
  try {
    final buffer = await rootBundle.load(assetPath);

    // 使用推荐的 getSizeResult 方法
    final sizeResult = imagegetter.ImageSizeGetter.getSizeResult(
        imagegetter.MemoryInput.byteBuffer(buffer.buffer));

    final imageSize = sizeResult.size;

    // logger.info("本地图片 '$assetPath' 尺寸获取成功: $imageSize");
    // 返回 Flutter 的 Size 对象，确保尺寸是 double 类型
    return Size(imageSize.width.toDouble(), imageSize.height.toDouble());
  } catch (e) {
    // 如果 asset 路径错误或文件不存在，rootBundle.load 会抛出异常
    // logger.severe("获取本地图片 '$assetPath' 尺寸时发生异常: $e");
    return null;
  }
}

Future<Size?> getNetworkImageSize(String uri) async {
  try {
    final response = await http.get(Uri.parse(uri));

    if (response.statusCode == 200) {
      final bytes = response.bodyBytes;

      // 使用推荐的 getSizeResult 方法
      final sizeResult = imagegetter.ImageSizeGetter.getSizeResult(
          imagegetter.MemoryInput(bytes));

      final imageSize = sizeResult.size;

      // logger.info("网络图片尺寸获取成功: $imageSize");
      // 返回 Flutter 的 Size 对象，确保尺寸是 double 类型
      return Size(imageSize.width.toDouble(), imageSize.height.toDouble());
    } else {
      // logger.warning("获取网络图片失败，URL: $imageUrl, 状态码: ${response.statusCode}");
      return null;
    }
  } catch (e) {
    // 捕获任何可能发生的异常 (如网络中断、URL格式错误)
    // logger.severe("获取网络图片 '$imageUrl' 尺寸时发生异常: $e");
    return null;
  }
}

// 正则表达式匹配所有 emoji
// 解析推文内容，将emoji和文本分开处理
final RegExp emojiRegex = RegExp(
  r'[\u{1F600}-\u{1F64F}]|' // 表情符号
  r'[\u{1F300}-\u{1F5FF}]|' // 符号和图形
  r'[\u{1F680}-\u{1F6FF}]|' // 交通工具和符号
  r'[\u{1F700}-\u{1F77F}]|' // 箭头、符号
  r'[\u{1F780}-\u{1F7FF}]|' // 符号
  r'[\u{1F800}-\u{1F8FF}]|' // 符号
  r'[\u{2600}-\u{26FF}]|' // 各类符号
  r'[\u{2700}-\u{27BF}]|' // 各类符号
  r'[\u{1F900}-\u{1F9FF}]|' // 各类符号
  r'[\u{1FA70}-\u{1FAFF}]|' // emoji v12.0
  r'[\u{200D}]|' // 零宽字符
  r'[\u{2640}\u{2642}]', // 性别符号
  unicode: true,
);

// 随机人名
String mockName() {
  List<String> names = [
    "星愿",
    "雨含思念",
    "沧海带不走蝴蝶",
    "池浅",
    "梦之",
    "云落羽",
    "我以为是你",
    "仗剑走天涯",
    "余厌",
    "执笔画倾颜",
    "樱花蜜桃酥",
    "汤十三✌️",
    "浮夸了年华",
    "傲世冷颜",
    "纵横、芯卟死",
    "与孤独合葬",
    "北折",
    "最初呢",
    "嫣花笑、倾城美",
    "林枫听雨",
    "顾辞",
    "孤身浪子",
    "敦睦情谊",
    "夙只希望",
    "柚子伴酒c",
    "演痕、墨轩",
    "别把玩笑当诺言",
    "清河星梦坠落",
    "北街浊酒",
    "筱糖豆﹥ε﹤",
    "孤王戏",
    "堇年",
    "乱世浮生❤️",
    "满身英雄梦",
    "花落人断肠",
    "姐抽的是寂寞",
    "骑驴自拍",
    "亂丗ゐ小苮囡",
    "村头的小怂包儿啊",
    "换胃思考",
    "枕边旧宠",
    "烈火中挣扎",
    "薄凉依稀",
    "夜玉",
    "柚子猫七",
    "黎明前",
    "蓬勃野心😘",
    "吥想苌大",
    "鶴慕",
    "烟雨墨冷竹离殇",
    "灵韵",
    "时光荏苒等谁归",
    "吞了仙女粉",
    "清河星梦坠落",
    "若初见终不悔",
    "彼岸櫻花開得淒美",
    "奴庸",
    "小嘴儿欠啵",
    "含笑拥刀锋",
    "余年寄山水",
    "囚苼🤞",
    "清酒孤欢",
    "那年、那事儿",
    "半度微凉",
    "战帝天",
    "时光如酒你如狗",
    "悲伤逆流成河",
    "果绿森裙",
    "春风乍起",
    "殇。月夜",
    "墨锦倾城染青衣",
    "紅唇",
    "抹平你的忧愁",
    "咕咕奈子鸽",
    "冷月飘霜",
    "吃鸡只用平底锅",
    "美人兮",
    "算了我认输",
    "断缘间",
    "走成熟路线",
    "花事未了",
    "冷瞳少女",
    "笙南",
    "静秋",
    "山川情诗",
    "梦想天空分外蓝",
    "心里无人自有人",
    "云寒",
    "泪倾城-",
    "半度",
    "只对你心动",
    "世界之巅",
    "椛开椛落",
    "酒与心事",
    "傲气与我同生",
    "我趴在云边",
    "踮脚亲你",
    "依稀故人在"
  ];

  Random random = Random();
  return names[random.nextInt(names.length)];
}

Future<String> generateBytesChunkHash(List<int> bytes) async {
  // 使用 SHA-256 哈希算法
  final hash = sha256.convert(bytes);

  // 返回文件内容的哈希值（十六进制表示）
  return hash.toString();
}

Future<String> generateStringChunkHash(String str) async {
  // 使用 SHA-256 哈希算法
  final hash = sha256.convert(
    utf8.encode(str),
  );

  // 返回文件内容的哈希值（十六进制表示）
  return hash.toString();
}

// 提亮颜色
Color lightenColor(Color color, double percentage) {
  double r = color.r + ((255 - color.r) * percentage);
  double g = color.g + ((255 - color.g) * percentage);
  double b = color.b + ((255 - color.b) * percentage);

  return Color.from(alpha: color.a, red: r, green: g, blue: b);
}

Color darkenColor(Color color, double percentage) {
  // 将每个通道的值减少，避免低于0
  double r = color.r - color.r * percentage;
  double g = color.g - color.g * percentage;
  double b = color.b - color.b * percentage;

  return Color.from(alpha: color.a, red: r, green: g, blue: b);
}

String formatDuration(Duration duration) {
  int hours = duration.inHours;
  int minutes = duration.inMinutes % 60;
  int seconds = duration.inSeconds % 60;

  if (hours > 0) {
    return '$hours:$minutes:$seconds';
  } else if (minutes > 0) {
    return '$minutes:$seconds';
  } else {
    return '$seconds';
  }
}
