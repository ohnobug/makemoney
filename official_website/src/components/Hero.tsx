import { Button } from "@/components/ui/button";
import heroImage from "@/assets/hero-bg.jpg";
import { ArrowRight, Sparkles } from "lucide-react";
import logo from "@/assets/logo.webp";

const Hero = () => {
  return (
    <section className="relative min-h-screen flex items-center justify-center overflow-hidden pt-16">
      {/* Added pt-16 for nav space */}
      {/* Background Image */}
      <div
        className="absolute inset-0 z-0"
        style={{
          backgroundImage: `url(${heroImage})`,
          backgroundSize: "cover",
          backgroundPosition: "center",
          backgroundRepeat: "no-repeat",
        }}
      >
        <div className="absolute inset-0 bg-background/60 backdrop-blur-sm" />
      </div>

      {/* Floating Elements */}
      <div className="absolute inset-0 overflow-hidden pointer-events-none">
        <div className="absolute top-1/4 left-1/4 w-32 h-32 bg-brand-primary/20 rounded-full animate-float blur-xl" />
        <div
          className="absolute top-3/4 right-1/4 w-24 h-24 bg-brand-secondary/20 rounded-full animate-float blur-xl"
          style={{ animationDelay: "2s" }}
        />
        <div
          className="absolute top-1/2 left-3/4 w-40 h-40 bg-brand-accent/20 rounded-full animate-float blur-xl"
          style={{ animationDelay: "4s" }}
        />
      </div>

      {/* Content */}
      <div className="relative z-10 container mx-auto px-4 text-center">
        <div className="max-w-4xl mx-auto">
          {/* Logo/Brand */}
          <div className="flex items-center justify-center mb-8">
            {/* <Sparkles className="w-12 h-12 text-brand-primary mr-3 animate-pulse-glow" /> */}
            <img
              src={logo}
              style={{ width: "8rem", height: "8rem" }}
              alt="Vigaviga logo"
            />
            <h1
              className="text-6xl md:text-8xl font-bold bg-gradient-to-r from-brand-primary via-brand-secondary to-brand-accent bg-clip-text text-transparent"
              style={{ lineHeight: "normal" }}
            >
              Vigaviga
            </h1>
          </div>

          {/* Tagline */}
          <h2 className="text-2xl md:text-4xl font-light text-foreground/90 mb-6 leading-relaxed">
            创造、分享、赚取
            <br />
            <span className="bg-gradient-to-r from-brand-secondary to-brand-accent bg-clip-text text-transparent font-semibold">
              下一代NFT社交平台
            </span>
          </h2>

          {/* Description */}
          <p className="text-lg md:text-xl text-muted-foreground mb-12 max-w-2xl mx-auto leading-relaxed">
            在Vigaviga，每个人都可以轻松发布NFT作品，通过社区互动获得点赞，将创意转化为真实收益。
          </p>

          {/* CTA Buttons */}
          <div className="flex flex-col sm:flex-row gap-4 justify-center items-center">
            <Button variant="hero" size="hero" className="group">
              开始创作
              <ArrowRight className="ml-2 group-hover:translate-x-1 transition-transform" />
            </Button>

            <Button variant="glass" size="hero">
              了解更多
            </Button>
          </div>

          {/* Stats */}
          <div className="flex flex-wrap justify-center gap-8 mt-16 pt-8 border-t border-white/10">
            <div className="text-center">
              <div className="text-3xl font-bold text-brand-primary">10K+</div>
              <div className="text-sm text-muted-foreground">NFT创作者</div>
            </div>
            <div className="text-center">
              <div className="text-3xl font-bold text-brand-secondary">1M+</div>
              <div className="text-sm text-muted-foreground">点赞奖励</div>
            </div>
            <div className="text-center">
              <div className="text-3xl font-bold text-brand-accent">50K+</div>
              <div className="text-sm text-muted-foreground">NFT作品</div>
            </div>
          </div>
        </div>
      </div>
    </section>
  );
};

export default Hero;
