import 'package:cached_network_image/cached_network_image.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:vigaviga/themes.dart';
import 'package:vigaviga/l10n/app_localizations.dart';
import 'package:vigaviga/tools/ljn_logger.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vigaviga/tools/ljn_tools.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vigaviga/store/ljn_system_cubit.dart';

class LJNMiniProgram extends StatefulWidget {
  final String link;
  const LJNMiniProgram({
    super.key,
    required this.link,
  });

  @override
  State<LJNMiniProgram> createState() => _LJNMiniProgramState();
}

class _LJNMiniProgramState extends State<LJNMiniProgram>
    with SingleTickerProviderStateMixin {
  late WebViewController webViewController;
  // late WebviewController _windowsWebViewController;

  late final AnimationController _lottieController;

  bool pageVisible = false;

  @override
  void initState() {
    super.initState();

    logger.info("bbbbbbbbbbbb link:${widget.link}");

    _initLotties();

    _initWebViewController();
  }

  void _initLotties() {
    _lottieController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _lottieController.addListener(() {
      if (_lottieController.isCompleted) {
        setState(() {
          pageVisible = true;
        });
      }
    });
  }

  void _initWebViewController() {
    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            logger.info("qqqqqqqqqqqqq onProgress");

            _lottieController.value = (progress / 100) * 0.5;
          },
          onPageStarted: (String url) {
            logger.info("qqqqqqqqqqqqq onPageStarted");
          },
          onPageFinished: (String url) {
            logger.info("qqqqqqqqqqqqq onPageFinished: $url");

            // _lottieController.value = 1;

            // 页面加载完, 需要有个动画的过程
            _lottieController
              ..duration = const Duration(milliseconds: 1000)
              ..forward();
          },
          onUrlChange: (UrlChange change) {
            logger.info("qqqqqqqqqqqqq onUrlChange ${change.url}");
          },
          onHttpError: (HttpResponseError error) {
            logger.info("qqqqqqqqqqqqq onHttpError");
          },
          onWebResourceError: (WebResourceError error) async {
            // 清空错误的信息
            // webViewController.loadHtmlString("");
            // _lottieController.reset();
          },
          // 跳转劫持
          onNavigationRequest: (NavigationRequest request) async {
            logger.info("qqqqqqqqqqqqq onNavigationRequest");

            if (request.url.startsWith('http://helloworld.com')) {
              webViewController.loadHtmlString(
                  "<h1 style='margin-top: 100px'>你来到了被劫持的页面，哈哈哈</h1>");

              return NavigationDecision.prevent;
            }

            return NavigationDecision.navigate;
          },
        ),
      );

    if (widget.link == "") {
      webViewController
          .loadHtmlString("<h1 style='margin-top: 100px'>404 Not Found</h1>");
    } else {
      logger.info("当前打开的link: ${widget.link}");
      loadPage(widget.link);
    }
  }

  void loadPage(String requestUrl) async {
    logger.info("bbbbbbbbbbbbbbbbbbbbbbbbbbbb::: $requestUrl");

    if (requestUrl.startsWith('http://inner')) {
      Uri uri = Uri.parse(requestUrl);

      uri = uri.replace(host: '127.0.0.1', port: 9413);

      // 请求页面
      final response = await http.get(uri,
          headers: {'Host': '127.0.0.1', 'Content-Type': 'text/html'});
      if (response.statusCode == 200) {
        webViewController.loadHtmlString(
          response.body,
          baseUrl: requestUrl,
        );
      } else {
        webViewController.loadHtmlString(
          "<h1 style='margin-top: 100px'>页面挂了</h1><a href='/qq'>qqq</a>",
          baseUrl: requestUrl,
        );
      }
    } else {
      webViewController.loadRequest(
        Uri.parse(requestUrl),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LJNSystemCubit, SystemState>(
      builder: (context, systemState) {
        return Scaffold(
          appBar: null,
          body: Stack(
            children: [
              // 页面本身
              WebViewWidget(controller: webViewController),

              // 加载动画
              Visibility(
                visible: !pageVisible,
                child: Container(
                  color: AppColors.neutralGrey40,
                  width: 750.w,
                  height: MediaQuery.of(context).size.height,
                  child: Center(
                    child: Lottie.asset(
                      assetPath('lotties/miniprogramloading.json'),
                      width: 750.w * 0.4,
                      // height: MediaQuery.of(context).size.height,
                      fit: BoxFit.contain,
                      renderCache: RenderCache.drawingCommands,
                      controller: _lottieController,
                      onLoaded: (composition) {
                        // _lottieController
                        //   ..duration = const Duration(milliseconds: 600)
                        //   ..forward();
                      },
                    ),
                  ),
                ),
              ),

              // 关闭按钮
              Positioned(
                right: 17.w,
                top: 90.w,
                child: Container(
                  width: 192.w,
                  height: 64.w,
                  decoration: BoxDecoration(
                    color: AppColors.whiteTransparent93, // 背景颜色
                    borderRadius: BorderRadius.circular(35.w), // 圆角
                    border: Border.all(
                      color: AppColors.neutralGrey28, // 边框颜色
                      width: 1.w, // 边框宽度
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            _showPopup(context, systemState);
                          },
                          child: Container(
                            // 加盒子是为了扩大点击区域
                            color: Colors.transparent,
                            child: Icon(
                              const IconData(
                                0xe620,
                                fontFamily: 'Iconfont',
                              ), // 使用的图标
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurface, // 图标颜色
                              size: 36.w, // 图标大小
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 2.w,
                        height: 40.w,
                        color: AppColors.neutralGrey22,
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => Navigator.of(context).pop(), // 点击事件
                          child: Container(
                            // 加盒子是为了扩大点击区域
                            color: Colors.transparent,
                            child: Icon(
                              const IconData(
                                0xe617,
                                fontFamily: 'Iconfont',
                              ), // 使用的图标
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurface, // 图标颜色
                              size: 36.w, // 图标大小
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Container(
              //   width: MediaQuery.of(context).size.height,
              //   height: 750.w,
              //   color: AppColors.blackTransparent40,
              // ),
            ],
          ),
        );
      },
    );
  }
}

void _showPopup(BuildContext context, SystemState systemState) {
  AppLocalizations l10n = AppLocalizations.of(context)!;
  ThemeData theme = Theme.of(context);
  double widthHeightRatio = 750.w / MediaQuery.of(context).size.height;

  // [改动] 提取CDN基础路径，方便复用
  final cdnBase = systemState.cdnBase;

  Widget popupWidget = Column(
    children: [
      // 小程序信息
      Container(
        // color: Colors.amber,
        height: 125.w,
        padding: EdgeInsets.only(
          left: 24.w,
          right: 24.w,
          top: 35.w,
          // bottom: 25.w,
        ),
        child: Row(
          children: [
            CachedNetworkImage(
              imageUrl: "$cdnBase/miniprogram_icon/chengzixiaoshuodaziban.jpg",
              width: 90.0.w,
              height: 90.0.w,
              fit: BoxFit.fill,
              placeholder: (context, url) => Container(color: Colors.grey[300]),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
            SizedBox(
              width: 10.w,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "积贝生活",
                  style: TextStyle(
                    height: 1.08,
                    color: Theme.of(context).colorScheme.onSurface,
                    fontSize: 32.w,
                    fontFamily: 'AlibabaPuHuiTi-Medium',
                  ),
                ),
                // SizedBox(
                //   height: 10.w,
                // ),
                Text(
                  '东城共赢(南海)信息科技有限公司',
                  style: TextStyle(
                    height: 1.08,
                    color: AppColors.neutralGrey35,
                    fontSize: 24.w,
                  ),
                )
              ],
            )
          ],
        ),
      ),

      // 评论
      Container(
        width: 750.w,
        padding: EdgeInsets.only(
          left: 24.w,
          right: 24.w,
          top: 16.w,
          bottom: 16.w,
        ),
        height: 100.w,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.noTransactionRating,
              style: TextStyle(
                fontSize: 26.w,
                color: Theme.of(context).colorScheme.onSurface,
                height: 1.08,
              ),
            ),
            Text(
              l10n.commentCount(1),
              style: TextStyle(
                fontSize: 26.w,
                color: Theme.of(context).colorScheme.onSurface,
                height: 1.08,
              ),
            ),
            Text(
              l10n.featuredCommentDisplay("very good"),
              style: TextStyle(
                fontSize: 24.w,
                color: AppColors.neutralGrey70,
                height: 1.08,
              ),
            )
          ],
        ),
      ),

      // 转发
      Container(
        color: AppColors.neutralGrey2,
        width: 750.w,
        height: 300.w,
        padding: EdgeInsets.only(
          top: 40.w,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(left: 24.w),
              child: Text(
                l10n.forwardTo,
                style: TextStyle(
                  fontSize: 25.w,
                  // fontWeight: FontWeight.bold,
                  fontFamily: 'AlibabaPuHuiTi-Medium',
                ),
              ),
            ),
            SizedBox(
              height: 25.w,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 24.w,
                  ),
                  LJNPopupFunctionButton(
                    icon: Container(
                      width: 112.w,
                      height: 112.w,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        color: AppColors.neutralWhite,
                        borderRadius: BorderRadius.circular(18.w),
                      ),
                      alignment: Alignment.center,
                      child: CachedNetworkImage(
                        imageUrl: "$cdnBase/miniprogram_icon/uitartuna.jpg",
                        width: 112.w,
                        height: 112.w,
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            Container(color: Colors.grey[300]),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                    title: "随身尺子",
                    onPressed: () {},
                  ),
                  LJNPopupFunctionButton(
                    icon: Container(
                      width: 112.w,
                      height: 112.w,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        color: AppColors.neutralWhite,
                        borderRadius: BorderRadius.circular(18.w),
                      ),
                      alignment: Alignment.center,
                      child: CachedNetworkImage(
                        imageUrl: "$cdnBase/miniprogram_icon/chuangzuomao.jpg",
                        width: 112.w,
                        height: 112.w,
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            Container(color: Colors.grey[300]),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                    title: "文件传输助手",
                    onPressed: () {},
                  ),
                  LJNPopupFunctionButton(
                    icon: Container(
                      width: 112.w,
                      height: 112.w,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        color: AppColors.neutralWhite,
                        borderRadius: BorderRadius.circular(18.w),
                      ),
                      alignment: Alignment.center,
                      child: CachedNetworkImage(
                        imageUrl: "$cdnBase/miniprogram_icon/upaotui.jpg",
                        width: 112.w,
                        height: 112.w,
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            Container(color: Colors.grey[300]),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                    title: "飞常准查航班",
                    onPressed: () {},
                  ),
                  LJNPopupFunctionButton(
                    icon: Container(
                      width: 112.w,
                      height: 112.w,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        color: AppColors.neutralWhite,
                        borderRadius: BorderRadius.circular(18.w),
                      ),
                      alignment: Alignment.center,
                      child: CachedNetworkImage(
                        imageUrl:
                            "$cdnBase/miniprogram_icon/wangwangshangliao.jpg",
                        width: 112.w,
                        height: 112.w,
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            Container(color: Colors.grey[300]),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                    title: "花式昵称",
                    onPressed: () {},
                  ),
                  LJNPopupFunctionButton(
                    icon: Container(
                      width: 112.w,
                      height: 112.w,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        color: AppColors.neutralWhite,
                        borderRadius: BorderRadius.circular(18.w),
                      ),
                      alignment: Alignment.center,
                      child: CachedNetworkImage(
                        imageUrl:
                            "$cdnBase/miniprogram_icon/wangwangshangliao.jpg",
                        width: 112.w,
                        height: 112.w,
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            Container(color: Colors.grey[300]),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                    title: "腾讯体育+",
                    onPressed: () {},
                  ),
                  LJNPopupFunctionButton(
                    icon: Container(
                      width: 112.w,
                      height: 112.w,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        color: AppColors.neutralWhite,
                        borderRadius: BorderRadius.circular(18.w),
                      ),
                      alignment: Alignment.center,
                      child: CachedNetworkImage(
                        imageUrl:
                            "$cdnBase/miniprogram_icon/daimengPS2moniqi.jpg",
                        width: 112.w,
                        height: 112.w,
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            Container(color: Colors.grey[300]),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                    title: "邮政信使",
                    onPressed: () {},
                  ),
                  LJNPopupFunctionButton(
                    icon: Container(
                      width: 112.w,
                      height: 112.w,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        color: AppColors.neutralWhite,
                        borderRadius: BorderRadius.circular(18.w),
                      ),
                      alignment: Alignment.center,
                      child: CachedNetworkImage(
                        imageUrl:
                            "$cdnBase/miniprogram_icon/wangyiyunyinyue.jpg",
                        width: 112.w,
                        height: 112.w,
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            Container(color: Colors.grey[300]),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                    title: "壁纸精选",
                    onPressed: () {},
                  ),
                ],
              ),
            )
          ],
        ),
      ),

      // 功能按钮
      Container(
        height: 465.w,
        width: 750.w,
        decoration: BoxDecoration(
          color: AppColors.neutralGrey2,
          border: Border(
            top: BorderSide(
              color: theme.dividerColor,
              width: 1.0.w,
              style: BorderStyle.solid,
            ),
          ),
        ),
        // height: 478.w,
        padding: EdgeInsets.only(top: 45.w),
        child: Column(
          children: [
            SizedBox(
              width: 750.w,
              height: 200.w,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: BouncingScrollPhysics(),
                child: Row(
                  children: [
                    SizedBox(width: 24.w),
                    LJNPopupFunctionButton(
                      icon: Container(
                        width: 112.w,
                        height: 112.w,
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          color: AppColors.neutralWhite,
                          borderRadius: BorderRadius.circular(18.w),
                        ),
                        alignment: Alignment.center,
                        child: CachedNetworkImage(
                          imageUrl: "$cdnBase/icon/popup_forward.png",
                          width: 55.w,
                          height: 55.w,
                          fit: BoxFit.cover,
                          placeholder: (context, url) =>
                              Container(color: Colors.grey[300]),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ),
                      title: l10n.forwardToFriend,
                      onPressed: () {},
                    ),
                    LJNPopupFunctionButton(
                      icon: Container(
                        width: 112.w,
                        height: 112.w,
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          color: AppColors.neutralWhite,
                          borderRadius: BorderRadius.circular(18.w),
                        ),
                        alignment: Alignment.center,
                        child: CachedNetworkImage(
                          imageUrl: "$cdnBase/icon/popup_circle_of_friends.png",
                          width: 55.w,
                          height: 55.w,
                          fit: BoxFit.cover,
                          placeholder: (context, url) =>
                              Container(color: Colors.grey[300]),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ),
                      title: l10n.shareToMoments,
                      onPressed: () {},
                    ),
                    LJNPopupFunctionButton(
                      icon: Container(
                        width: 112.w,
                        height: 112.w,
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          color: AppColors.neutralWhite,
                          borderRadius: BorderRadius.circular(18.w),
                        ),
                        alignment: Alignment.center,
                        child: CachedNetworkImage(
                          imageUrl: "$cdnBase/icon/popup_collection.png",
                          width: 55.w,
                          height: 55.w,
                          fit: BoxFit.cover,
                          placeholder: (context, url) =>
                              Container(color: Colors.grey[300]),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ),
                      title: l10n.favorite,
                      onPressed: () {},
                    ),
                    LJNPopupFunctionButton(
                      icon: Container(
                        width: 112.w,
                        height: 112.w,
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          color: AppColors.neutralWhite,
                          borderRadius: BorderRadius.circular(18.w),
                        ),
                        alignment: Alignment.center,
                        child: CachedNetworkImage(
                          imageUrl:
                              "$cdnBase/icon/popup_add_to_mini_Program.png",
                          width: 55.w,
                          height: 55.w,
                          fit: BoxFit.cover,
                          placeholder: (context, url) =>
                              Container(color: Colors.grey[300]),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ),
                      title: l10n.addToMyMiniPrograms,
                      onPressed: () {},
                    ),
                    LJNPopupFunctionButton(
                      icon: Container(
                        width: 112.w,
                        height: 112.w,
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          color: AppColors.neutralWhite,
                          borderRadius: BorderRadius.circular(18.w),
                        ),
                        alignment: Alignment.center,
                        child: CachedNetworkImage(
                          imageUrl: "$cdnBase/icon/popup_add_to_desktop.png",
                          width: 55.w,
                          height: 55.w,
                          fit: BoxFit.cover,
                          placeholder: (context, url) =>
                              Container(color: Colors.grey[300]),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ),
                      title: l10n.addToDesktop,
                      onPressed: () {},
                    ),
                    LJNPopupFunctionButton(
                      icon: Container(
                        width: 112.w,
                        height: 112.w,
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          color: AppColors.neutralWhite,
                          borderRadius: BorderRadius.circular(18.w),
                        ),
                        alignment: Alignment.center,
                        child: CachedNetworkImage(
                          imageUrl: "$cdnBase/icon/popup_open_on_computer.png",
                          width: 55.w,
                          height: 55.w,
                          fit: BoxFit.cover,
                          placeholder: (context, url) =>
                              Container(color: Colors.grey[300]),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ),
                      title: l10n.openOnComputer,
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10.w,
            ),
            SizedBox(
              width: 750.w,
              height: 200.w,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: BouncingScrollPhysics(),
                child: Row(
                  children: [
                    SizedBox(width: 24.w),
                    LJNPopupFunctionButton(
                      icon: Container(
                        width: 112.w,
                        height: 112.w,
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          color: AppColors.neutralWhite,
                          borderRadius: BorderRadius.circular(18.w),
                        ),
                        alignment: Alignment.center,
                        child: Icon(
                          const IconData(
                            0xe667,
                            fontFamily: 'Iconfont',
                          ),
                          color: AppColors.neutralGrey75,
                          size: 55.w,
                        ),
                      ),
                      title: l10n.floatingWindow,
                      onPressed: () {},
                    ),
                    LJNPopupFunctionButton(
                      icon: Container(
                        width: 112.w,
                        height: 112.w,
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          color: AppColors.neutralWhite,
                          borderRadius: BorderRadius.circular(18.w),
                        ),
                        alignment: Alignment.center,
                        child: Icon(
                          const IconData(
                            0xe684,
                            fontFamily: 'Iconfont',
                          ),
                          color: AppColors.neutralGrey75,
                          size: 45.w,
                        ),
                      ),
                      title: l10n.settings,
                      onPressed: () {},
                    ),
                    LJNPopupFunctionButton(
                      icon: Container(
                        width: 112.w,
                        height: 112.w,
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          color: AppColors.neutralWhite,
                          borderRadius: BorderRadius.circular(18.w),
                        ),
                        alignment: Alignment.center,
                        child: Icon(
                          const IconData(
                            0xe6b5,
                            fontFamily: 'Iconfont',
                          ),
                          color: AppColors.neutralGrey75,
                          size: 45.w,
                        ),
                      ),
                      title: l10n.feedbackAndComplaints,
                      onPressed: () {},
                    ),
                    LJNPopupFunctionButton(
                      icon: Container(
                        width: 112.w,
                        height: 112.w,
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          color: AppColors.neutralWhite,
                          borderRadius: BorderRadius.circular(18.w),
                        ),
                        alignment: Alignment.center,
                        child: Icon(
                          const IconData(
                            0xe63e,
                            fontFamily: 'Iconfont',
                          ),
                          color: AppColors.neutralGrey75,
                          size: 45.w,
                        ),
                      ),
                      title: l10n.reEnterMiniProgram,
                      onPressed: () {},
                    ),
                    LJNPopupFunctionButton(
                      icon: Container(
                        width: 112.w,
                        height: 112.w,
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          color: AppColors.neutralWhite,
                          borderRadius: BorderRadius.circular(18.w),
                        ),
                        alignment: Alignment.center,
                        child: Icon(
                          const IconData(
                            0xe66e,
                            fontFamily: 'Iconfont',
                          ),
                          color: AppColors.neutralGrey75,
                          size: 45.w,
                        ),
                      ),
                      title: l10n.copyLink,
                      onPressed: () {},
                    ),
                    LJNPopupFunctionButton(
                      icon: Container(
                        width: 112.w,
                        height: 112.w,
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          color: AppColors.neutralWhite,
                          borderRadius: BorderRadius.circular(18.w),
                        ),
                        alignment: Alignment.center,
                        child: Icon(
                          const IconData(
                            0xe639,
                            fontFamily: 'Iconfont',
                          ),
                          color: AppColors.neutralGrey75,
                          size: 45.w,
                        ),
                      ),
                      title: l10n.translate,
                      onPressed: () {},
                    ),
                    LJNPopupFunctionButton(
                      icon: Container(
                        width: 112.w,
                        height: 112.w,
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          color: AppColors.neutralWhite,
                          borderRadius: BorderRadius.circular(18.w),
                        ),
                        alignment: Alignment.center,
                        child: Icon(
                          const IconData(
                            0xe63a,
                            fontFamily: 'Iconfont',
                          ),
                          color: AppColors.neutralGrey75,
                          size: 45.w,
                        ),
                      ),
                      title: l10n.growthGuardianAntiAddiction,
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      // 取消
      LJNPopupButtonMaxWidthButton(
        color: AppColors.brandBlueDark3,
        title: l10n.cancel,
        underline: false,
        onPressed: () {
          Navigator.pop(context);
        },
      )
    ],
  );

  showModalBottomSheet(
      context: context,
      barrierColor: AppColors.blackTransparent47,
      // backgroundColor: AppColors.accentRedPure,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: widthHeightRatio > 1 ||
                  MediaQuery.of(context).size.height < 1102.w
              ? Radius.zero
              : Radius.circular(13.w),
        ),
      ),
      isScrollControlled: true,
      builder: (BuildContext context) {
        return widthHeightRatio > 1 ||
                MediaQuery.of(context).size.height < 1102.w
            ? SizedBox(
                height: MediaQuery.of(context).size.height,
                width: 750.w,
                child: ScrollConfiguration(
                  behavior: ScrollConfiguration.of(context)
                      .copyWith(scrollbars: false),
                  child: SingleChildScrollView(
                    primary: false,
                    physics: const AlwaysScrollableScrollPhysics(
                      parent: BouncingScrollPhysics(),
                    ),
                    child: popupWidget,
                  ),
                ),
              )
            : SizedBox(
                height: 1102.w,
                width: 750.w,
                child: popupWidget,
              );
      });
}

// 底部弹出取消按钮
class LJNPopupButtonMaxWidthButton extends StatefulWidget {
  final double? height;
  final Object? title;
  final Color? color;
  final String? link;
  final bool underline;
  final Function? onPressed;

  const LJNPopupButtonMaxWidthButton({
    super.key,
    this.height,
    required this.title,
    this.color,
    this.link,
    required this.underline,
    this.onPressed,
  });

  @override
  State<LJNPopupButtonMaxWidthButton> createState() =>
      _LJNPopupButtonMaxWidthButtonState();
}

class _LJNPopupButtonMaxWidthButtonState
    extends State<LJNPopupButtonMaxWidthButton> {
  // bool isClicked = false;
  late Color containerColor = Theme.of(context).listTileTheme.tileColor!;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return BlocBuilder<LJNSystemCubit, SystemState>(
      builder: (context, systemState) {
        return GestureDetector(
          onTapDown: (tapDownDetails) {
            setState(() {
              containerColor =
                  Theme.of(context).listTileTheme.selectedTileColor!;
            });
          },
          onTapCancel: () {
            setState(() {
              containerColor = Theme.of(context).listTileTheme.tileColor!;
            });

            logger.info("取消点击");
          },
          onTapUp: (tapDownDetails) {
            Future.delayed(
              const Duration(milliseconds: 50),
              () {
                setState(() {
                  containerColor = Theme.of(context).listTileTheme.tileColor!;
                });

                if (context.mounted) {
                  if (widget.link != null) {
                    Navigator.pushNamed(context, widget.link!);
                  }

                  if (widget.onPressed != null) {
                    widget.onPressed!();
                  }
                }
              },
            );

            logger.info("弹起");
          },
          child: Container(
            height: 112.w,
            width: 750.w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: containerColor,
              border: Border(
                top: BorderSide(
                  width: 1.0.w,
                  color: theme.dividerColor,
                ),
              ),
            ),
            child: widget.title is String
                ? Text(
                    widget.title as String,
                    style: TextStyle(
                      color: widget.color ??
                          Theme.of(context).colorScheme.onSurface,
                      height: 1.08,
                      fontSize: fontSizeScale(32.0.w),
                      decoration: TextDecoration.none,
                      fontFamily: "AlibabaPuHuiTi",
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  )
                : widget.title as Widget,
          ),
        );
      },
    );
  }
}

// 小程序按钮
class LJNPopupFunctionButton extends StatefulWidget {
  final Object icon;
  final String title;
  final VoidCallback onPressed;

  const LJNPopupFunctionButton({
    super.key,
    required this.icon,
    required this.title,
    required this.onPressed,
  });

  @override
  LJNPopupFunctionButtonState createState() => LJNPopupFunctionButtonState();
}

class LJNPopupFunctionButtonState extends State<LJNPopupFunctionButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      onTapDown: (_) {
        setState(() {
          _isPressed = true;
        });
      },
      onTapUp: (_) {
        Future.delayed(const Duration(milliseconds: 50), () {
          setState(() {
            _isPressed = false;
          });
        });
      },
      onTapCancel: () {
        Future.delayed(const Duration(milliseconds: 50), () {
          setState(() {
            _isPressed = false;
          });
        });
      },
      child: Container(
        width: 110.w,
        // height: 225.w,
        margin: EdgeInsets.only(right: 25.w),
        decoration: BoxDecoration(
          // color: Colors.orange,
          color: _isPressed ? Colors.grey[200] : Colors.transparent, // 按下时背景色
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            widget.icon as Widget,

            SizedBox(height: 10.w), // 图标和标题之间的间距
            Text(
              widget.title,
              maxLines: 2,
              textAlign: TextAlign.center,
              style: TextStyle(
                height: 1.08,
                decoration: TextDecoration.none,
                color: AppColors.neutralGrey73,
                fontSize: fontSizeScale(20.0.w),
                overflow: TextOverflow.ellipsis,
              ), // 标题颜色
            ),
          ],
        ),
      ),
    );
  }
}
