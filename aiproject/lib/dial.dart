import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jiaoyishuoflutter3/components/LJNAppBar.dart';
import 'package:jiaoyishuoflutter3/store.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:jiaoyishuoflutter3/tools/tools.dart';

class LJNDial extends StatefulWidget {
  const LJNDial({
    super.key,
  });

  @override
  State<LJNDial> createState() => _LJNDial();
}

class _LJNDial extends State<LJNDial> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<StoreType, StoreType>(
        converter: (store) => store.state,
        builder: (context, vm) {
          return _buildPage();
        });
  }

  // 另起一个函数方便管理
  Widget _buildPage() {
    return StoreConnector<StoreType, StoreType>(
        converter: (store) => store.state,
        builder: (context, vm) {
          return Scaffold(
              primary: false,
              appBar: null,
              body: Container(
                  width: 750.w,
                  color: const Color.fromARGB(255, 10, 11, 13),
                  // color: const Color.fromARGB(255, 76, 115, 194),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          LJNAppBar(
                            title: "",
                            bgColor: Colors.transparent,
                            leading: GestureDetector(
                              onTap: () => Navigator.of(context).pop(),
                              child: Container(
                                color: Colors.transparent,
                                child: Icon(
                                  const IconData(0xe68f,
                                      fontFamily: 'Iconfont'),
                                  color: Colors.white,
                                  size: 36.w,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 297.w,
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(
                                16.0.w), // Adjust the radius as needed
                            child: Image.asset(
                              assetPath("images/avatar_webp/chat_55.webp"),
                              width: 183.0.w,
                              height: 183.0.w,
                              cacheWidth: 360.w.toInt(),
                              cacheHeight: 360.w.toInt(),
                              fit: BoxFit.contain,
                            ),
                          ),
                          SizedBox(
                            height: 30.w,
                          ),
                          Text(
                            "罗绮娴",
                            style:
                                TextStyle(color: Colors.white, fontSize: 40.w),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            "等待对方接受邀请",
                            style: TextStyle(
                                fontSize: 30.w,
                                color:
                                    const Color.fromARGB(255, 141, 143, 142)),
                          ),
                          SizedBox(
                            height: 115.w,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 140.w,
                                height: 242.w,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 140.w,
                                      height: 140.w,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(140.w)),
                                      ),
                                      alignment: Alignment.center,
                                      child: Icon(
                                        const IconData(
                                          0xec8c,
                                          fontFamily: 'Iconfont',
                                        ),
                                        color: Colors.black,
                                        size: 64.w,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 25.w,
                                    ),
                                    Text(
                                      "麦克风已开",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 25.w),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 77.w,
                              ),
                              SizedBox(
                                width: 140.w,
                                height: 242.w,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 140.w,
                                      height: 140.w,
                                      decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                            255, 217, 79, 77),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(140.w)),
                                      ),
                                      alignment: Alignment.center,
                                      child: Icon(
                                        const IconData(
                                          0xe781,
                                          fontFamily: 'Iconfont',
                                        ),
                                        color: Colors.white,
                                        size: 64.w,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 25.w,
                                    ),
                                    Text(
                                      "取消",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 25.w),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 77.w,
                              ),
                              SizedBox(
                                width: 140.w,
                                height: 242.w,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 140.w,
                                      height: 140.w,
                                      decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                            255, 13, 13, 11),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(140.w)),
                                      ),
                                      alignment: Alignment.center,
                                      child: Icon(
                                        const IconData(
                                          0xe69c,
                                          fontFamily: 'Iconfont',
                                        ),
                                        color: Colors.white,
                                        size: 64.w,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 25.w,
                                    ),
                                    Text(
                                      "扬声器已关",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 25.w),
                                    )
                                  ],
                                ),
                              )
                            ],
                          )
                        ],
                      )
                    ],
                  )));
        });
  }
}
