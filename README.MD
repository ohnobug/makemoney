启动app方式：
进入/home/vigaviga/jiaoyisuo/aiproject目录后
bash ./build.sh可以编译安卓app。
bash ./build_web.sh可以编译web端，在dist/web下面。


Docker启动服务方式：

docker编译艺术品服务
docker compose build art_service

docker编译用户服务
docker compose build user_service

docker编译奖励模式服务
docker compose build reward_mode_service


一般情况下，哪些服务代码有变更，重新编译该项服务、重启该项服务即可。

docker启动过程
docker compose up db -d
docker compose up rabbitmq -d
docker compose up redis -d

确保以上三个服务启动后，再启动以下服务：
docker compose up user_service -d
docker compose up reward_mode_service -d
docker compose up art_service -d

最后启动：
docker compose up nginx -d




在vscode安装Docker插件，即可在docker插件查看当前启动的docker容器。
右击可以：
View logs 查看日志
Attach Shell 进入容器的shell
Stop 停止容器
Restart 重启容器