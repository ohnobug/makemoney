import 'package:flutter/material.dart';

class HelpAndFeedbackPage extends StatefulWidget {
  const HelpAndFeedbackPage({Key? key}) : super(key: key);

  @override
  _HelpAndFeedbackPageState createState() => _HelpAndFeedbackPageState();
}

class _HelpAndFeedbackPageState extends State<HelpAndFeedbackPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<String> hotQuestions = [
    '笔记审核时效是多久',
    '视频互动栏怎么切换到底部？',
    '如何开通直播权限？',
    '笔记被判定违反社区规范第四条是什么意思？',
    '如何变更或解绑小红书的实名认证？',
    '如何找回小红书账号？',
    '如何开通买手权限为他人带货？',
    '小红书开店的费用是多少？',
    '商家一直不发货怎么办？',
    '如何修改、新增、删除收货地址？',
  ];

  final List<String> accountQuestions = [
    '如何修改密码？',
    '账号被盗了怎么办？',
    '怎么注销账号？',
    '如何绑定手机号？',
  ];

  final List<String> profileQuestions = [
    '个人主页可以设置什么？',
    '如何更换头像？',
    '怎么修改昵称？',
  ];

  final List<String> trafficQuestions = [
    '如何增加笔记曝光？',
    '为什么我的笔记没有流量？',
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    // 添加监听器，以便在标签页切换时重建UI
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _tabController.removeListener(() {});
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8), // 设置页面背景色为更接近图片的浅灰色
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          '帮助与客服',
          style: TextStyle(
              color: Colors.black, fontSize: 17, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFF8F8F8), // AppBar背景色与页面统一
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black, size: 24),
            onPressed: () {
              // Handle search button press
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        // 使用SingleChildScrollView确保整个页面内容可滚动
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            children: [
              const SizedBox(height: 12.0),
              // 自助工具卡片
              _buildWhiteCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
                      child: Text(
                        '自助工具',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87),
                      ),
                    ),
                    GridView.count(
                        shrinkWrap: true,
                        physics:
                            const NeverScrollableScrollPhysics(), // GridView不滚动，由外层SingleChildScrollView控制
                        crossAxisCount: 4,
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        mainAxisSpacing: 16.0,
                        crossAxisSpacing: 0,
                        childAspectRatio: 0.9,
                        children: [
                          _buildToolItem(Icons.account_circle_outlined, '账号检测'),
                          _buildToolItem(Icons.description_outlined, '笔记申诉'),
                          _buildToolItem(Icons.store_outlined, '开通店铺'),
                          _buildToolItem(Icons.currency_exchange, '售后退款'),
                          _buildToolItem(
                              Icons.confirmation_number_outlined, '券和福利'),
                          _buildToolItem(Icons.person_search_outlined, '找回账号'),
                          _buildToolItem(Icons.security_outlined, '账号与安全'),
                          _buildToolItem(Icons.local_shipping_outlined, '查看物流'),
                        ]),
                    const SizedBox(height: 16.0),
                  ],
                ),
              ),
              const SizedBox(height: 12.0),

              // 猜你想问卡片
              _buildWhiteCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
                      child: Text(
                        '猜你想问',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      child: TabBar(
                        controller: _tabController,
                        tabAlignment: TabAlignment.start,
                        isScrollable: true,
                        // 1. 修改选中标签的文字颜色为黑色
                        labelColor: Colors.black,
                        // 2. 修改未选中标签的文字颜色为灰色
                        unselectedLabelColor: Colors.grey,
                        labelStyle: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                        unselectedLabelStyle: const TextStyle(fontSize: 14),
                        // 3. 设置指示器的尺寸为与标签文字同宽
                        indicatorSize: TabBarIndicatorSize.label,
                        tabs: const [
                          Tab(text: '热门问题'),
                          Tab(text: '帐号问题'),
                          Tab(text: '个人主页问题'),
                          Tab(text: '流量问题'),
                        ],
                      ),
                    ),
                    // **关键改动**: 直接构建当前选中的问题列表，而不是使用固定高度的TabBarView
                    _buildCurrentQuestionList(),
                  ],
                ),
              ),
              const SizedBox(height: 12.0),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  // **新增方法**: 根据当前TabController的索引来构建对应的问题列表Column
  Widget _buildCurrentQuestionList() {
    List<String> currentQuestions;
    switch (_tabController.index) {
      case 0:
        currentQuestions = hotQuestions;
        break;
      case 1:
        currentQuestions = accountQuestions;
        break;
      case 2:
        currentQuestions = profileQuestions;
        break;
      case 3:
        currentQuestions = trafficQuestions;
        break;
      default:
        currentQuestions = [];
    }
    // 返回一个Column，它会占据所需的高度，由外部的SingleChildScrollView处理滚动
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Column(
        children: currentQuestions.map((question) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                title: Text(question,
                    style:
                        const TextStyle(fontSize: 14, color: Colors.black87)),
                trailing: Icon(Icons.arrow_forward_ios,
                    size: 14, color: Colors.grey[400]),
                onTap: () {
                  // Handle question tap
                },
              ),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildWhiteCard({required Widget child}) {
    return Container(
      padding: EdgeInsets.only(
        bottom: 6, // 下边距
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: child,
    );
  }

  Widget _buildToolItem(IconData icon, String label) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 28, color: Colors.black87),
        const SizedBox(height: 8),
        Text(label,
            style: const TextStyle(fontSize: 12, color: Colors.black87)),
      ],
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey[200]!, width: 0.5)),
      ),
      padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).padding.bottom), // 适配底部安全区域
      height: 60 + MediaQuery.of(context).padding.bottom,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                // Handle feedback tap
              },
              child: const Center(
                child: Text('意见反馈',
                    style: TextStyle(fontSize: 14, color: Colors.black87)),
              ),
            ),
          ),
          Container(
            width: 0.5,
            height: 24,
            color: Colors.grey[300],
          ),
          Expanded(
            child: InkWell(
              onTap: () {
                // Handle contact customer service tap
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.headset_mic_outlined,
                      color: Colors.black87, size: 20),
                  SizedBox(width: 6),
                  Text('联系官方客服',
                      style: TextStyle(fontSize: 14, color: Colors.black87)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
