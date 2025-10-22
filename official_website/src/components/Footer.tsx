import { Twitter, Github, MessageCircle } from "lucide-react";
import { Button } from "@/components/ui/button";
import logo from "@/assets/logo.webp";

const Footer = () => {
  return (
    <footer className="border-t border-white/10 bg-card/50 backdrop-blur-sm">
      <div className="container mx-auto px-4 py-12">
        <div className="grid grid-cols-1 md:grid-cols-4 gap-8">
          {/* Brand */}
          <div className="col-span-1 md:col-span-2">
            <div className="flex items-center mb-4">
              <img
                src={logo}
                style={{ width: "2rem", height: "2rem" }}
                alt="Vigaviga logo"
              />

              <span className="text-2xl font-bold bg-gradient-to-r from-brand-primary to-brand-secondary bg-clip-text text-transparent">
                Vigaviga
              </span>
            </div>
            <p className="text-muted-foreground mb-6 max-w-md">
              下一代NFT社交平台，让创作者通过社区互动获得真实收益。
            </p>
            <div className="flex space-x-4">
              <Button
                variant="ghost"
                size="icon"
                className="hover:text-brand-primary"
              >
                <Twitter className="w-5 h-5" />
              </Button>
              <Button
                variant="ghost"
                size="icon"
                className="hover:text-brand-primary"
              >
                <Github className="w-5 h-5" />
              </Button>
              <Button
                variant="ghost"
                size="icon"
                className="hover:text-brand-primary"
              >
                <MessageCircle className="w-5 h-5" />
              </Button>
            </div>
          </div>

          {/* Links */}
          <div>
            <h3 className="font-semibold text-foreground mb-4">产品</h3>
            <ul className="space-y-2">
              <li>
                <a
                  href="#"
                  className="text-muted-foreground hover:text-brand-primary transition-smooth"
                >
                  NFT市场
                </a>
              </li>
              <li>
                <a
                  href="#"
                  className="text-muted-foreground hover:text-brand-primary transition-smooth"
                >
                  创作工具
                </a>
              </li>
              <li>
                <a
                  href="#"
                  className="text-muted-foreground hover:text-brand-primary transition-smooth"
                >
                  社区
                </a>
              </li>
              <li>
                <a
                  href="#"
                  className="text-muted-foreground hover:text-brand-primary transition-smooth"
                >
                  收益系统
                </a>
              </li>
            </ul>
          </div>

          <div>
            <h3 className="font-semibold text-foreground mb-4">支持</h3>
            <ul className="space-y-2">
              <li>
                <a
                  href="#"
                  className="text-muted-foreground hover:text-brand-primary transition-smooth"
                >
                  帮助中心
                </a>
              </li>
              <li>
                <a
                  href="#"
                  className="text-muted-foreground hover:text-brand-primary transition-smooth"
                >
                  开发者文档
                </a>
              </li>
              <li>
                <a
                  href="#"
                  className="text-muted-foreground hover:text-brand-primary transition-smooth"
                >
                  联系我们
                </a>
              </li>
              <li>
                <a
                  href="#"
                  className="text-muted-foreground hover:text-brand-primary transition-smooth"
                >
                  隐私政策
                </a>
              </li>
            </ul>
          </div>
        </div>

        <div className="border-t border-white/10 mt-12 pt-8 flex flex-col md:flex-row justify-between items-center">
          <p className="text-muted-foreground text-sm">
            © 2024 Vigaviga. All rights reserved.
          </p>
          <p className="text-muted-foreground text-sm mt-4 md:mt-0">
            Built with ❤️ for the creator economy
          </p>
        </div>
      </div>
    </footer>
  );
};

export default Footer;
