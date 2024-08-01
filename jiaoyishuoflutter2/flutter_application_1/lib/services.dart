import 'package:flutter/material.dart';
import 'userfunctions.dart';
import 'logger.dart';

class Services extends StatefulWidget {
  const Services({super.key});

  @override
  ServicesState createState() => ServicesState();
}

class ServicesState extends State<Services> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // 金融理财
          FunctionButtonsSection(
            title: '金融理财',
            buttons: [
              FunctionButton(
                icon: Icons.settings,
                title: '信用卡还款',
                onPressed: () {
                  logger.info('点击了信用卡还款按钮~~');
                },
              ),
              FunctionButton(
                icon: Icons.help,
                title: '微粒贷借钱',
                onPressed: () {
                  logger.info('点击了微粒贷借钱按钮~~');
                },
              ),
              FunctionButton(
                icon: Icons.feedback,
                title: '理财通',
                onPressed: () {
                  logger.info('点击了理财通按钮~~');
                },
              ),
              FunctionButton(
                icon: Icons.share,
                title: '保险服务',
                onPressed: () {
                  logger.info('点击了保险服务按钮~~');
                },
              ),
            ],
          ),

          // 生活服务
          FunctionButtonsSection(
            title: '生活服务',
            buttons: [
              FunctionButton(
                icon: Icons.settings,
                title: '手机充值',
                onPressed: () {
                  logger.info('点击了手机充值按钮~~');
                },
              ),
              FunctionButton(
                icon: Icons.help,
                title: '生活缴费',
                onPressed: () {
                  logger.info('点击了生活缴费按钮~~');
                },
              ),
              FunctionButton(
                icon: Icons.feedback,
                title: 'Q币充值',
                onPressed: () {
                  logger.info('点击了Q币充值按钮~~');
                },
              ),
              FunctionButton(
                icon: Icons.share,
                title: '城市服务',
                onPressed: () {
                  logger.info('点击了城市服务按钮~~');
                },
              ),
              FunctionButton(
                icon: Icons.settings,
                title: '腾讯公益',
                onPressed: () {
                  logger.info('点击了腾讯公益按钮~~');
                },
              ),
              FunctionButton(
                icon: Icons.help,
                title: '医疗健康',
                onPressed: () {
                  logger.info('点击了医疗健康按钮~~');
                },
              ),
            ],
          ),

          // 交通出行
          FunctionButtonsSection(
            title: '交通出行',
            buttons: [
              FunctionButton(
                icon: Icons.settings,
                title: '出行服务',
                onPressed: () {
                  logger.info('点击了出行服务按钮~~');
                },
              ),
              FunctionButton(
                icon: Icons.help,
                title: '火车票机票',
                onPressed: () {
                  logger.info('点击了火车票机票按钮~~');
                },
              ),
              FunctionButton(
                icon: Icons.feedback,
                title: '滴滴出行',
                onPressed: () {
                  logger.info('点击了滴滴出行按钮~~');
                },
              ),
              FunctionButton(
                icon: Icons.share,
                title: '酒店',
                onPressed: () {
                  logger.info('点击了酒店按钮~~');
                },
              ),
            ],
          ),

          // 购物消费
          FunctionButtonsSection(
            title: '购物消费',
            buttons: [
              FunctionButton(
                icon: Icons.settings,
                title: '品牌发现',
                onPressed: () {
                  logger.info('点击了品牌发现按钮~~');
                },
              ),
              FunctionButton(
                icon: Icons.help,
                title: '京东购物',
                onPressed: () {
                  logger.info('点击了京东购物按钮~~');
                },
              ),
              FunctionButton(
                icon: Icons.feedback,
                title: '美团外卖',
                onPressed: () {
                  logger.info('点击了美团外卖按钮~~');
                },
              ),
              FunctionButton(
                icon: Icons.share,
                title: '电影演出玩乐',
                onPressed: () {
                  logger.info('点击了电影演出玩乐按钮~~');
                },
              ),
              FunctionButton(
                icon: Icons.settings,
                title: '美团特价',
                onPressed: () {
                  logger.info('点击了美团特价按钮~~');
                },
              ),
              FunctionButton(
                icon: Icons.help,
                title: '拼多多',
                onPressed: () {
                  logger.info('点击了拼多多按钮~~');
                },
              ),
              FunctionButton(
                icon: Icons.feedback,
                title: '唯品会特卖',
                onPressed: () {
                  logger.info('点击了唯品会特卖按钮~~');
                },
              ),
              FunctionButton(
                icon: Icons.share,
                title: '转转二手',
                onPressed: () {
                  logger.info('点击了转转二手按钮~~');
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class LJNIcon extends StatelessWidget {
  final String title;
  final double size;
  final Color color;

  const LJNIcon({
    super.key,
    required this.title,
    required this.size,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.ac_unit, // Replace with appropriate icon logic
      size: size,
      color: color,
    );
  }
}
