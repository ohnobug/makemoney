import Navigation from "@/components/Navigation";
import Footer from "@/components/Footer";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import communityHero from "@/assets/community-hero.jpg";
import { Users, Heart, Trophy, TrendingUp, MessageCircle, Star, Calendar, Gift } from "lucide-react";

const Community = () => {
  const stats = [
    { icon: <Users className="w-8 h-8" />, value: "50K+", label: "活跃创作者", color: "from-brand-primary to-brand-secondary" },
    { icon: <Heart className="w-8 h-8" />, value: "2M+", label: "点赞奖励", color: "from-brand-secondary to-brand-accent" },
    { icon: <Trophy className="w-8 h-8" />, value: "100K+", label: "NFT作品", color: "from-brand-accent to-brand-primary" },
    { icon: <TrendingUp className="w-8 h-8" />, value: "15K ETH", label: "总交易额", color: "from-brand-primary to-brand-accent" }
  ];

  const topCreators = [
    { rank: 1, name: "数字艺术家", avatar: "🎨", works: 156, likes: 12450, earnings: "45.6 ETH" },
    { rank: 2, name: "像素大师", avatar: "🖼️", works: 234, likes: 10890, earnings: "38.2 ETH" },
    { rank: 3, name: "3D创作者", avatar: "🎭", works: 89, likes: 9876, earnings: "32.1 ETH" },
    { rank: 4, name: "音乐制作人", avatar: "🎵", works: 67, likes: 8765, earnings: "28.9 ETH" },
    { rank: 5, name: "摄影师", avatar: "📸", works: 145, likes: 7654, earnings: "25.3 ETH" }
  ];

  const activities = [
    { type: "新作品", user: "创作者A", action: "发布了新NFT", item: "《星空梦境》", time: "2小时前", icon: <Star className="w-4 h-4" /> },
    { type: "点赞", user: "用户B", action: "点赞了", item: "《数字风景》", time: "3小时前", icon: <Heart className="w-4 h-4" /> },
    { type: "交易", user: "收藏家C", action: "购买了", item: "《抽象艺术》", time: "5小时前", icon: <TrendingUp className="w-4 h-4" /> },
    { type: "评论", user: "用户D", action: "评论了", item: "《未来城市》", time: "6小时前", icon: <MessageCircle className="w-4 h-4" /> }
  ];

  const events = [
    { title: "NFT创作大赛", date: "2024年1月15日", prize: "50 ETH奖池", status: "进行中" },
    { title: "社区AMA活动", date: "2024年1月20日", prize: "与顶级创作者对话", status: "即将开始" },
    { title: "新年狂欢节", date: "2024年2月1日", prize: "限定NFT空投", status: "预告" }
  ];

  return (
    <div className="min-h-screen bg-background">
      <Navigation />
      
      {/* Hero Section */}
      <section className="relative pt-16 pb-12 overflow-hidden">
        <div 
          className="absolute inset-0 z-0"
          style={{
            backgroundImage: `url(${communityHero})`,
            backgroundSize: 'cover',
            backgroundPosition: 'center',
          }}
        >
          <div className="absolute inset-0 bg-background/70 backdrop-blur-sm" />
        </div>
        
        <div className="relative z-10 container mx-auto px-4 py-16">
          <div className="text-center max-w-4xl mx-auto">
            <h1 className="text-4xl md:text-6xl font-bold mb-6">
              <span className="bg-gradient-to-r from-brand-primary via-brand-secondary to-brand-accent bg-clip-text text-transparent">
                Vigaviga社区
              </span>
            </h1>
            <p className="text-xl text-muted-foreground mb-8">
              加入全球最活跃的NFT创作者社区，分享创意，互动赚取，共同成长
            </p>
            
            <div className="flex flex-col sm:flex-row gap-4 justify-center">
              <Button variant="hero" size="hero">
                加入社区
              </Button>
              <Button variant="glass" size="hero">
                社区指南
              </Button>
            </div>
          </div>
        </div>
      </section>

      {/* Community Stats */}
      <section className="py-16 border-b border-white/10">
        <div className="container mx-auto px-4">
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-8">
            {stats.map((stat, index) => (
              <Card key={index} className="gradient-card border-white/10 text-center group hover:scale-105 transition-smooth">
                <CardContent className="p-8">
                  <div className={`w-16 h-16 rounded-2xl bg-gradient-to-br ${stat.color} p-4 mx-auto mb-4 group-hover:scale-110 transition-bounce`}>
                    <div className="text-white">
                      {stat.icon}
                    </div>
                  </div>
                  <div className="text-3xl font-bold text-brand-primary mb-2">{stat.value}</div>
                  <div className="text-muted-foreground">{stat.label}</div>
                </CardContent>
              </Card>
            ))}
          </div>
        </div>
      </section>

      <div className="container mx-auto px-4 py-16">
        <div className="grid grid-cols-1 lg:grid-cols-3 gap-8">
          {/* Top Creators */}
          <div className="lg:col-span-2">
            <Card className="gradient-card border-white/10 h-fit">
              <CardHeader>
                <CardTitle className="flex items-center gap-2">
                  <Trophy className="w-6 h-6 text-brand-primary" />
                  顶级创作者排行榜
                </CardTitle>
              </CardHeader>
              <CardContent>
                <div className="space-y-4">
                  {topCreators.map((creator) => (
                    <div key={creator.rank} className="flex items-center justify-between p-4 rounded-lg bg-background/50 hover:bg-background/70 transition-smooth">
                      <div className="flex items-center gap-4">
                        <div className="flex items-center justify-center w-10 h-10 bg-gradient-to-br from-brand-primary to-brand-secondary rounded-full text-white font-bold">
                          #{creator.rank}
                        </div>
                        <div className="text-2xl">{creator.avatar}</div>
                        <div>
                          <div className="font-semibold">{creator.name}</div>
                          <div className="text-sm text-muted-foreground">{creator.works} 作品</div>
                        </div>
                      </div>
                      <div className="text-right">
                        <div className="font-bold text-brand-primary">{creator.earnings}</div>
                        <div className="text-sm text-muted-foreground">{creator.likes} 点赞</div>
                      </div>
                    </div>
                  ))}
                </div>
              </CardContent>
            </Card>
          </div>

          {/* Recent Activities */}
          <div>
            <Card className="gradient-card border-white/10 mb-8">
              <CardHeader>
                <CardTitle className="flex items-center gap-2">
                  <TrendingUp className="w-6 h-6 text-brand-secondary" />
                  最新动态
                </CardTitle>
              </CardHeader>
              <CardContent>
                <div className="space-y-4">
                  {activities.map((activity, index) => (
                    <div key={index} className="flex gap-3">
                      <div className="flex-shrink-0 w-8 h-8 bg-gradient-to-br from-brand-secondary/20 to-brand-accent/20 rounded-full flex items-center justify-center">
                        {activity.icon}
                      </div>
                      <div className="flex-1 min-w-0">
                        <div className="text-sm">
                          <span className="font-semibold">{activity.user}</span>{" "}
                          <span className="text-muted-foreground">{activity.action}</span>{" "}
                          <span className="text-brand-primary">{activity.item}</span>
                        </div>
                        <div className="text-xs text-muted-foreground">{activity.time}</div>
                      </div>
                    </div>
                  ))}
                </div>
              </CardContent>
            </Card>

            {/* Community Events */}
            <Card className="gradient-card border-white/10">
              <CardHeader>
                <CardTitle className="flex items-center gap-2">
                  <Calendar className="w-6 h-6 text-brand-accent" />
                  社区活动
                </CardTitle>
              </CardHeader>
              <CardContent>
                <div className="space-y-4">
                  {events.map((event, index) => (
                    <div key={index} className="p-4 rounded-lg bg-background/50 hover:bg-background/70 transition-smooth">
                      <div className="flex items-center justify-between mb-2">
                        <div className="font-semibold">{event.title}</div>
                        <Badge variant={event.status === "进行中" ? "default" : "secondary"}>
                          {event.status}
                        </Badge>
                      </div>
                      <div className="text-sm text-muted-foreground mb-1">{event.date}</div>
                      <div className="text-sm text-brand-primary">{event.prize}</div>
                    </div>
                  ))}
                </div>
              </CardContent>
            </Card>
          </div>
        </div>
      </div>

      {/* Join Community CTA */}
      <section className="py-16 bg-card/20">
        <div className="container mx-auto px-4">
          <div className="gradient-card rounded-3xl p-12 border border-white/10 max-w-4xl mx-auto text-center">
            <Gift className="w-16 h-16 text-brand-primary mx-auto mb-6" />
            <h3 className="text-3xl font-bold mb-4 bg-gradient-to-r from-brand-primary to-brand-secondary bg-clip-text text-transparent">
              成为Vigaviga社区一员
            </h3>
            <p className="text-muted-foreground mb-8 text-lg max-w-2xl mx-auto">
              与全球创作者连接，分享您的作品，参与社区治理，获得丰富奖励
            </p>
            <div className="flex flex-col sm:flex-row gap-4 justify-center">
              <Button variant="hero" size="lg">
                立即加入
              </Button>
              <Button variant="glass" size="lg">
                了解权益
              </Button>
            </div>
          </div>
        </div>
      </section>
      
      <Footer />
    </div>
  );
};

export default Community;