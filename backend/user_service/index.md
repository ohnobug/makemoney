<!--
 * @description:
 * @author chenchangfu
 * Copyright (c) 2019, AUTHOR. All rights reserved.
 * AUTHOR PROPRIETARY/CONFIDENTIAL. Use is subject to license terms.
-->

1、依赖安装
pip install -r requirements.txt
2、启动
py ./main.py

异常解决
1、windos install 中依赖包 asyncmy 报错，有可能是 c++编译环境，暂时注释
requirements.txt 中 asyncmy 重新安装启动

开发指引：
一、常用目录说明
1、​​db(数据模型)​：
职责 ​​：定义数据库表和 ORM 映射
2、​schemas(数据结构)​​：
职责 ​​：定义数据库表和 ORM 映射
3、 ​​services(业务逻辑)​​
​ ​ 职责 ​​：实现核心业务规则和流程
