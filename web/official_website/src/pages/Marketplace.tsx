import Navigation from "@/components/Navigation";
import Footer from "@/components/Footer";
import { Card, CardContent } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import marketplaceHero from "@/assets/marketplace-hero.jpg";
import { Search, Filter, Heart, Eye, TrendingUp, Star } from "lucide-react";

const Marketplace = () => {
  const featuredNFTs = [
    { id: 1, title: "数字梦境", artist: "创作者A", price: "2.5 ETH", likes: 1234, views: 5678 },
    { id: 2, title: "未来城市", artist: "创作者B", price: "1.8 ETH", likes: 987, views: 3456 },
    { id: 3, title: "抽象空间", artist: "创作者C", price: "3.2 ETH", likes: 2345, views: 7890 },
    { id: 4, title: "光影世界", artist: "创作者D", price: "1.5 ETH", likes: 876, views: 2345 },
    { id: 5, title: "色彩爆炸", artist: "创作者E", price: "2.1 ETH", likes: 1567, views: 4321 },
    { id: 6, title: "几何美学", artist: "创作者F", price: "1.9 ETH", likes: 1098, views: 3789 },
  ];

  const categories = ["全部", "艺术", "摄影", "音乐", "游戏", "体育", "收藏品"];

  return (
    <div className="min-h-screen bg-background">
      <Navigation />
      
      {/* Hero Section */}
      <section className="relative pt-16 pb-12 overflow-hidden">
        <div 
          className="absolute inset-0 z-0"
          style={{
            backgroundImage: `url(${marketplaceHero})`,
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
                NFT市场
              </span>
            </h1>
            <p className="text-xl text-muted-foreground mb-8">
              发现独特的数字艺术作品，支持创作者，收集珍贵NFT
            </p>
            
            {/* Search Bar */}
            <div className="flex flex-col sm:flex-row gap-4 max-w-2xl mx-auto">
              <div className="flex-1 relative">
                <Search className="absolute left-3 top-1/2 transform -translate-y-1/2 text-muted-foreground w-5 h-5" />
                <input
                  type="text"
                  placeholder="搜索NFT作品、创作者..."
                  className="w-full pl-10 pr-4 py-3 bg-card/50 border border-white/20 rounded-lg backdrop-blur-sm focus:outline-none focus:ring-2 focus:ring-brand-primary"
                />
              </div>
              <Button variant="hero" size="lg">
                搜索
              </Button>
            </div>
          </div>
        </div>
      </section>

      {/* Categories & Filters */}
      <section className="py-8 border-b border-white/10">
        <div className="container mx-auto px-4">
          <div className="flex flex-wrap items-center justify-between gap-4">
            <div className="flex flex-wrap gap-2">
              {categories.map((category) => (
                <Badge
                  key={category}
                  variant={category === "全部" ? "default" : "secondary"}
                  className="px-4 py-2 cursor-pointer hover:scale-105 transition-smooth"
                >
                  {category}
                </Badge>
              ))}
            </div>
            <div className="flex gap-2">
              <Button variant="outline" size="sm">
                <Filter className="w-4 h-4 mr-2" />
                筛选
              </Button>
              <Button variant="outline" size="sm">
                <TrendingUp className="w-4 h-4 mr-2" />
                热门
              </Button>
            </div>
          </div>
        </div>
      </section>

      {/* NFT Grid */}
      <section className="py-16">
        <div className="container mx-auto px-4">
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
            {featuredNFTs.map((nft) => (
              <Card key={nft.id} className="gradient-card border-white/10 hover:border-white/20 transition-smooth group hover:scale-105 shadow-elevated">
                <CardContent className="p-0">
                  {/* NFT Image Placeholder */}
                  <div className="aspect-square bg-gradient-to-br from-brand-primary/20 to-brand-secondary/20 rounded-t-lg flex items-center justify-center relative overflow-hidden">
                    <div className="text-6xl opacity-30">🎨</div>
                    <div className="absolute top-4 right-4 flex gap-2">
                      <div className="bg-background/80 backdrop-blur-sm rounded-full p-2">
                        <Heart className="w-4 h-4 text-red-400" />
                      </div>
                      <div className="bg-background/80 backdrop-blur-sm rounded-full p-2">
                        <Star className="w-4 h-4 text-yellow-400" />
                      </div>
                    </div>
                  </div>
                  
                  <div className="p-6">
                    <h3 className="text-xl font-semibold mb-2">{nft.title}</h3>
                    <p className="text-muted-foreground text-sm mb-4">by {nft.artist}</p>
                    
                    <div className="flex items-center justify-between mb-4">
                      <div className="text-2xl font-bold text-brand-primary">{nft.price}</div>
                      <div className="flex gap-4 text-sm text-muted-foreground">
                        <div className="flex items-center gap-1">
                          <Heart className="w-4 h-4" />
                          {nft.likes}
                        </div>
                        <div className="flex items-center gap-1">
                          <Eye className="w-4 h-4" />
                          {nft.views}
                        </div>
                      </div>
                    </div>
                    
                    <div className="flex gap-2">
                      <Button variant="hero" size="sm" className="flex-1">
                        购买
                      </Button>
                      <Button variant="glass" size="sm" className="flex-1">
                        出价
                      </Button>
                    </div>
                  </div>
                </CardContent>
              </Card>
            ))}
          </div>
          
          <div className="text-center mt-12">
            <Button variant="outline" size="lg">
              加载更多作品
            </Button>
          </div>
        </div>
      </section>
      
      <Footer />
    </div>
  );
};

export default Marketplace;