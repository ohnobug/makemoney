import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import createNftIcon from "@/assets/create-nft-icon.jpg";
import earnLikesIcon from "@/assets/earn-likes-icon.jpg";
import { Palette, Heart, Coins, Users, Zap, Shield } from "lucide-react";

const Features = () => {
  const features = [
    {
      icon: <Palette className="w-8 h-8" />,
      title: "一键发布NFT",
      description: "无需复杂的技术知识，任何人都可以轻松创建和发布独特的NFT作品",
      image: createNftIcon,
      color: "from-brand-primary to-brand-secondary"
    },
    {
      icon: <Heart className="w-8 h-8" />,
      title: "点赞即赚取",
      description: "通过社区互动获得点赞，每个赞都能转化为真实的Token奖励",
      image: earnLikesIcon,
      color: "from-brand-secondary to-brand-accent"
    },
    {
      icon: <Users className="w-8 h-8" />,
      title: "社区驱动",
      description: "加入充满活力的创作者社区，发现优质内容，建立有价值的连接",
      color: "from-brand-accent to-brand-primary"
    },
    {
      icon: <Zap className="w-8 h-8" />,
      title: "即时交易",
      description: "基于高效区块链技术，实现快速、低成本的NFT交易体验",
      color: "from-brand-primary to-brand-accent"
    },
    {
      icon: <Shield className="w-8 h-8" />,
      title: "安全可靠",
      description: "采用先进的区块链安全机制，确保您的数字资产和收益安全",
      color: "from-brand-secondary to-brand-primary"
    },
    {
      icon: <Coins className="w-8 h-8" />,
      title: "多元收益",
      description: "通过创作、点赞、分享等多种方式获得收益，让创意变现更简单",
      color: "from-brand-accent to-brand-secondary"
    }
  ];

  return (
    <section className="py-24 px-4">
      <div className="container mx-auto">
        {/* Header */}
        <div className="text-center mb-16">
          <h2 className="text-4xl md:text-5xl font-bold mb-6">
            <span className="bg-gradient-to-r from-brand-primary via-brand-secondary to-brand-accent bg-clip-text text-transparent">
              为什么选择Vigaviga?
            </span>
          </h2>
          <p className="text-xl text-muted-foreground max-w-3xl mx-auto">
            我们重新定义了NFT的创作和交易体验，让每个人都能参与到数字经济中来
          </p>
        </div>

        {/* Features Grid */}
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8 mb-16">
          {features.map((feature, index) => (
            <Card 
              key={index} 
              className="gradient-card border-white/10 hover:border-white/20 transition-smooth group hover:scale-105 shadow-elevated"
            >
              <CardHeader className="pb-4">
                <div className={`w-16 h-16 rounded-2xl bg-gradient-to-br ${feature.color} p-4 mb-4 group-hover:scale-110 transition-bounce`}>
                  <div className="text-white">
                    {feature.icon}
                  </div>
                </div>
                <CardTitle className="text-xl font-semibold text-foreground">
                  {feature.title}
                </CardTitle>
              </CardHeader>
              <CardContent>
                {feature.image && (
                  <div className="mb-4 overflow-hidden rounded-lg">
                    <img 
                      src={feature.image} 
                      alt={feature.title}
                      className="w-full h-32 object-cover group-hover:scale-105 transition-smooth"
                    />
                  </div>
                )}
                <CardDescription className="text-muted-foreground leading-relaxed">
                  {feature.description}
                </CardDescription>
              </CardContent>
            </Card>
          ))}
        </div>

        {/* CTA Section */}
        <div className="text-center">
          <div className="gradient-card rounded-3xl p-12 border border-white/10 max-w-2xl mx-auto">
            <h3 className="text-3xl font-bold mb-4 bg-gradient-to-r from-brand-primary to-brand-secondary bg-clip-text text-transparent">
              准备开始您的NFT之旅？
            </h3>
            <p className="text-muted-foreground mb-8 text-lg">
              加入Vigaviga社区，开启创作赚取的新纪元
            </p>
            <div className="flex flex-col sm:flex-row gap-4 justify-center">
              <Button variant="hero" size="lg">
                立即注册
              </Button>
              <Button variant="glass" size="lg">
                查看演示
              </Button>
            </div>
          </div>
        </div>
      </div>
    </section>
  );
};

export default Features;