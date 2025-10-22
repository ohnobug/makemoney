import Navigation from "@/components/Navigation";
import Footer from "@/components/Footer";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Target, Users, Zap, Shield, Globe, Heart, Star } from "lucide-react";
import logo from "@/assets/logo.webp";

const About = () => {
  const values = [
    {
      icon: <Heart className="w-8 h-8" />,
      title: "用户至上",
      description: "始终将用户体验和需求放在首位，打造最友好的NFT平台",
      color: "from-red-500 to-pink-500",
    },
    {
      icon: <Zap className="w-8 h-8" />,
      title: "技术创新",
      description: "持续推进区块链技术创新，降低NFT创作和交易门槛",
      color: "from-yellow-500 to-orange-500",
    },
    {
      icon: <Globe className="w-8 h-8" />,
      title: "开放包容",
      description: "建设全球化的创作者社区，欢迎不同文化背景的艺术家",
      color: "from-green-500 to-blue-500",
    },
    {
      icon: <Shield className="w-8 h-8" />,
      title: "安全可靠",
      description: "采用最高安全标准，保护用户资产和隐私安全",
      color: "from-blue-500 to-purple-500",
    },
  ];

  const team = [
    {
      name: "Alex Chen",
      role: "创始人 & CEO",
      avatar: "👨‍💼",
      bio: "前Meta区块链技术专家，10年Web3经验",
    },
    {
      name: "Sarah Liu",
      role: "首席技术官",
      avatar: "👩‍💻",
      bio: "前以太坊核心开发者，智能合约专家",
    },
    {
      name: "Mike Zhang",
      role: "产品总监",
      avatar: "👨‍🎨",
      bio: "前Adobe产品经理，UX设计专家",
    },
    {
      name: "Emma Wang",
      role: "社区负责人",
      avatar: "👩‍🤝‍👩",
      bio: "Web3社区建设专家，KOL运营达人",
    },
  ];

  const milestones = [
    { year: "2023 Q1", title: "项目启动", desc: "Vigaviga概念诞生，团队组建" },
    { year: "2023 Q2", title: "种子轮融资", desc: "完成500万美元种子轮融资" },
    { year: "2023 Q3", title: "MVP发布", desc: "发布最小可行产品，开启测试" },
    { year: "2023 Q4", title: "公开测试", desc: "向社区开放，收集用户反馈" },
    { year: "2024 Q1", title: "正式上线", desc: "平台正式上线，开启NFT新时代" },
  ];

  return (
    <div className="min-h-screen bg-background">
      <Navigation />

      {/* Hero Section */}
      <section className="pt-16 pb-12">
        <div className="container mx-auto px-4 py-16">
          <div className="text-center max-w-4xl mx-auto">
            <div className="flex items-center justify-center mb-8">
              {/* <Sparkles className="w-16 h-16 text-brand-primary mr-4 animate-pulse-glow" /> */}
              <img
                src={logo}
                style={{ width: "70px", height: "70px" }}
                alt="Vigaviga logo"
              />

              <h1 className="text-5xl md:text-7xl font-bold bg-gradient-to-r from-brand-primary via-brand-secondary to-brand-accent bg-clip-text text-transparent">
                Vigaviga
              </h1>
            </div>
            <h2 className="text-2xl md:text-3xl font-light text-foreground/90 mb-6">
              重新定义NFT创作与社交的
              <span className="bg-gradient-to-r from-brand-secondary to-brand-accent bg-clip-text text-transparent font-semibold">
                下一代平台
              </span>
            </h2>
            <p className="text-lg text-muted-foreground max-w-3xl mx-auto leading-relaxed">
              我们相信每个人都应该能够轻松创作NFT，通过社区互动获得真实收益。Vigaviga致力于打破技术壁垒，让数字创作变得简单有趣，让创意真正产生价值。
            </p>
          </div>
        </div>
      </section>

      {/* Vision & Mission */}
      <section className="py-16 bg-card/20">
        <div className="container mx-auto px-4">
          <div className="grid grid-cols-1 lg:grid-cols-2 gap-12">
            <Card className="gradient-card border-white/10 p-8">
              <CardHeader>
                <Target className="w-12 h-12 text-brand-primary mb-4" />
                <CardTitle className="text-2xl">我们的使命</CardTitle>
              </CardHeader>
              <CardContent>
                <p className="text-muted-foreground text-lg leading-relaxed">
                  让NFT创作变得简单易用，让每个创作者都能通过自己的才华获得公平回报。我们要建设一个真正属于创作者的去中心化平台。
                </p>
              </CardContent>
            </Card>

            <Card className="gradient-card border-white/10 p-8">
              <CardHeader>
                <Star className="w-12 h-12 text-brand-secondary mb-4" />
                <CardTitle className="text-2xl">我们的愿景</CardTitle>
              </CardHeader>
              <CardContent>
                <p className="text-muted-foreground text-lg leading-relaxed">
                  成为全球最大的NFT社交平台，构建一个充满活力的创作者经济生态系统，让创意与科技完美融合。
                </p>
              </CardContent>
            </Card>
          </div>
        </div>
      </section>

      {/* Core Values */}
      <section className="py-16">
        <div className="container mx-auto px-4">
          <div className="text-center mb-16">
            <h2 className="text-3xl md:text-4xl font-bold mb-4">
              <span className="bg-gradient-to-r from-brand-primary to-brand-secondary bg-clip-text text-transparent">
                核心价值观
              </span>
            </h2>
            <p className="text-lg text-muted-foreground">
              指导我们前进的核心理念
            </p>
          </div>

          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-8">
            {values.map((value, index) => (
              <Card
                key={index}
                className="gradient-card border-white/10 hover:border-white/20 transition-smooth group hover:scale-105 shadow-elevated text-center"
              >
                <CardHeader>
                  <div
                    className={`w-16 h-16 rounded-2xl bg-gradient-to-br ${value.color} p-4 mx-auto mb-4 group-hover:scale-110 transition-bounce`}
                  >
                    <div className="text-white">{value.icon}</div>
                  </div>
                  <CardTitle className="text-xl">{value.title}</CardTitle>
                </CardHeader>
                <CardContent>
                  <p className="text-muted-foreground leading-relaxed">
                    {value.description}
                  </p>
                </CardContent>
              </Card>
            ))}
          </div>
        </div>
      </section>

      {/* Team */}
      <section className="py-16 bg-card/20">
        <div className="container mx-auto px-4">
          <div className="text-center mb-16">
            <h2 className="text-3xl md:text-4xl font-bold mb-4">
              <span className="bg-gradient-to-r from-brand-secondary to-brand-accent bg-clip-text text-transparent">
                核心团队
              </span>
            </h2>
            <p className="text-lg text-muted-foreground">
              来自全球顶级科技公司的精英团队
            </p>
          </div>

          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-8">
            {team.map((member, index) => (
              <Card
                key={index}
                className="gradient-card border-white/10 hover:border-white/20 transition-smooth group hover:scale-105 text-center"
              >
                <CardContent className="p-8">
                  <div className="text-6xl mb-4">{member.avatar}</div>
                  <h3 className="text-xl font-semibold mb-2">{member.name}</h3>
                  <div className="text-brand-primary font-medium mb-4">
                    {member.role}
                  </div>
                  <p className="text-muted-foreground text-sm leading-relaxed">
                    {member.bio}
                  </p>
                </CardContent>
              </Card>
            ))}
          </div>
        </div>
      </section>

      {/* Timeline */}
      <section className="py-16">
        <div className="container mx-auto px-4">
          <div className="text-center mb-16">
            <h2 className="text-3xl md:text-4xl font-bold mb-4">
              <span className="bg-gradient-to-r from-brand-accent to-brand-primary bg-clip-text text-transparent">
                发展历程
              </span>
            </h2>
            <p className="text-lg text-muted-foreground">
              从概念到现实的成长之路
            </p>
          </div>

          <div className="max-w-4xl mx-auto">
            {milestones.map((milestone, index) => (
              <div key={index} className="flex gap-6 pb-8 last:pb-0">
                <div className="flex-shrink-0">
                  <div className="w-4 h-4 bg-gradient-to-br from-brand-primary to-brand-secondary rounded-full"></div>
                  {index !== milestones.length - 1 && (
                    <div className="w-0.5 h-16 bg-gradient-to-b from-brand-primary/50 to-transparent mx-auto mt-2"></div>
                  )}
                </div>
                <div className="flex-1">
                  <div className="flex flex-col sm:flex-row sm:items-center gap-2 mb-2">
                    <div className="text-sm font-medium text-brand-primary">
                      {milestone.year}
                    </div>
                    <div className="hidden sm:block w-2 h-2 bg-brand-primary/30 rounded-full"></div>
                    <h3 className="text-xl font-semibold">{milestone.title}</h3>
                  </div>
                  <p className="text-muted-foreground">{milestone.desc}</p>
                </div>
              </div>
            ))}
          </div>
        </div>
      </section>

      {/* Contact CTA */}
      <section className="py-16 bg-card/20">
        <div className="container mx-auto px-4">
          <div className="gradient-card rounded-3xl p-12 border border-white/10 max-w-4xl mx-auto text-center">
            <Users className="w-16 h-16 text-brand-primary mx-auto mb-6" />
            <h3 className="text-3xl font-bold mb-4 bg-gradient-to-r from-brand-primary to-brand-secondary bg-clip-text text-transparent">
              加入我们的使命
            </h3>
            <p className="text-muted-foreground mb-8 text-lg max-w-2xl mx-auto">
              无论您是创作者、投资者还是技术专家，都欢迎加入Vigaviga的革命性旅程
            </p>
            <div className="flex flex-col sm:flex-row gap-4 justify-center">
              <Button variant="hero" size="lg">
                联系我们
              </Button>
              <Button variant="glass" size="lg">
                查看招聘
              </Button>
            </div>
          </div>
        </div>
      </section>

      <Footer />
    </div>
  );
};

export default About;
