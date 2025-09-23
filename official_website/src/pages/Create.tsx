import Navigation from "@/components/Navigation";
import Footer from "@/components/Footer";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import createHero from "@/assets/create-hero.jpg";
import { Upload, Palette, Zap, Globe, ArrowRight, CheckCircle } from "lucide-react";

const Create = () => {
  const steps = [
    {
      icon: <Upload className="w-8 h-8" />,
      title: "上传作品",
      description: "支持图片、视频、音频等多种格式",
      color: "from-brand-primary to-brand-secondary"
    },
    {
      icon: <Palette className="w-8 h-8" />,
      title: "设置属性",
      description: "添加标题、描述和稀有度属性",
      color: "from-brand-secondary to-brand-accent"
    },
    {
      icon: <Zap className="w-8 h-8" />,
      title: "铸造NFT",
      description: "一键生成区块链上的唯一数字资产",
      color: "from-brand-accent to-brand-primary"
    },
    {
      icon: <Globe className="w-8 h-8" />,
      title: "发布分享",
      description: "在Vigaviga社区展示您的作品",
      color: "from-brand-primary to-brand-accent"
    }
  ];

  const features = [
    { icon: "🎨", title: "多格式支持", desc: "图片、视频、3D模型、音频" },
    { icon: "⚡", title: "快速铸造", desc: "几分钟内完成NFT创建" },
    { icon: "💰", title: "低成本", desc: "享受优惠的gas费用" },
    { icon: "🔒", title: "安全可靠", desc: "区块链技术保障" },
    { icon: "🌍", title: "全球市场", desc: "面向全球用户展示" },
    { icon: "📈", title: "实时分析", desc: "作品表现数据分析" }
  ];

  return (
    <div className="min-h-screen bg-background">
      <Navigation />
      
      {/* Hero Section */}
      <section className="relative pt-16 pb-12 overflow-hidden">
        <div 
          className="absolute inset-0 z-0"
          style={{
            backgroundImage: `url(${createHero})`,
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
                创作中心
              </span>
            </h1>
            <p className="text-xl text-muted-foreground mb-8">
              将您的创意转化为独特的NFT，开启数字艺术创作之旅
            </p>
            
            <div className="flex flex-col sm:flex-row gap-4 justify-center">
              <Button variant="hero" size="hero" className="group">
                开始创作
                <ArrowRight className="ml-2 group-hover:translate-x-1 transition-transform" />
              </Button>
              <Button variant="glass" size="hero">
                查看教程
              </Button>
            </div>
          </div>
        </div>
      </section>

      {/* Creation Steps */}
      <section className="py-16">
        <div className="container mx-auto px-4">
          <div className="text-center mb-16">
            <h2 className="text-3xl md:text-4xl font-bold mb-4">
              <span className="bg-gradient-to-r from-brand-primary to-brand-secondary bg-clip-text text-transparent">
                四步轻松创建NFT
              </span>
            </h2>
            <p className="text-lg text-muted-foreground">
              简单易用的创作流程，让任何人都能成为NFT创作者
            </p>
          </div>

          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-8">
            {steps.map((step, index) => (
              <Card key={index} className="gradient-card border-white/10 hover:border-white/20 transition-smooth group hover:scale-105 shadow-elevated text-center">
                <CardHeader>
                  <div className={`w-16 h-16 rounded-2xl bg-gradient-to-br ${step.color} p-4 mx-auto mb-4 group-hover:scale-110 transition-bounce`}>
                    <div className="text-white">
                      {step.icon}
                    </div>
                  </div>
                  <div className="text-sm text-brand-primary font-semibold mb-2">
                    步骤 {index + 1}
                  </div>
                  <CardTitle className="text-xl">{step.title}</CardTitle>
                </CardHeader>
                <CardContent>
                  <p className="text-muted-foreground">{step.description}</p>
                </CardContent>
              </Card>
            ))}
          </div>
        </div>
      </section>

      {/* Features Grid */}
      <section className="py-16 bg-card/20">
        <div className="container mx-auto px-4">
          <div className="text-center mb-16">
            <h2 className="text-3xl md:text-4xl font-bold mb-4">
              <span className="bg-gradient-to-r from-brand-secondary to-brand-accent bg-clip-text text-transparent">
                强大的创作功能
              </span>
            </h2>
          </div>

          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
            {features.map((feature, index) => (
              <div key={index} className="gradient-card rounded-xl p-6 border border-white/10 hover:border-white/20 transition-smooth group hover:scale-105">
                <div className="text-4xl mb-4">{feature.icon}</div>
                <h3 className="text-xl font-semibold mb-2">{feature.title}</h3>
                <p className="text-muted-foreground">{feature.desc}</p>
              </div>
            ))}
          </div>
        </div>
      </section>

      {/* CTA Section */}
      <section className="py-16">
        <div className="container mx-auto px-4">
          <div className="gradient-card rounded-3xl p-12 border border-white/10 max-w-4xl mx-auto text-center">
            <div className="flex justify-center mb-6">
              <CheckCircle className="w-16 h-16 text-brand-primary" />
            </div>
            <h3 className="text-3xl font-bold mb-4 bg-gradient-to-r from-brand-primary to-brand-secondary bg-clip-text text-transparent">
              准备好开始创作了吗？
            </h3>
            <p className="text-muted-foreground mb-8 text-lg max-w-2xl mx-auto">
              加入数万名创作者，在Vigaviga平台上展示您的才华，通过社区互动获得收益
            </p>
            <div className="flex flex-col sm:flex-row gap-4 justify-center">
              <Button variant="hero" size="lg">
                立即开始创作
              </Button>
              <Button variant="glass" size="lg">
                查看创作者指南
              </Button>
            </div>
          </div>
        </div>
      </section>
      
      <Footer />
    </div>
  );
};

export default Create;