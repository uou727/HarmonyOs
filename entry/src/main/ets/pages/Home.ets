import SwiperLayout from '../views/Home/SwiperLayout';
import SearchBar from '../views/Home/SearchBar';
import NavList from '../views/Home/NavList';
import TileList from '../views/Home/TileList';
import PlanList from '../views/Home/PlanList';
import Ad from '../views/Home/Ad';
import RoomRecommend from '../views/Home/RoomRecommend';
import ScrollContainer from '../components/ScrollContainer/Index';

import { getHomeDataApi } from '../api/home';
import { BannerListDataSource, IColor, INavList, IPlanList, ITileList } from '../models/HomeData';
import { PADDING } from '../constants/size';

@Component
export default struct Home {
  // 首页数据
  @State bannerList: BannerListDataSource = new BannerListDataSource()
  @State navList: INavList = [];
  @State tileList: ITileList = [];
  @State planList: IPlanList = [];
  @State adPicture: string = '';
  scrollY: number = 0;
  @State fontColor: string = 'rgb(255, 255, 255)'

  // 组件生命周期
  aboutToAppear() {
    this.getHomeData()
  }

  async getHomeData() {
    const homeData = await getHomeDataApi()
    console.log(JSON.stringify(homeData.bannerList))
    this.bannerList.setList(homeData.bannerList);
    this.navList = homeData.navList;
    this.tileList = homeData.tileList;
    this.planList = homeData.planList;
    this.adPicture = homeData.adPicture;
  }

  // 处理滚动
  handleScroll = (xOffset: number, yOffset: number) => {
    this.scrollY += yOffset;
    if (this.scrollY < 0) {
      this.scrollY = 0;
    }
    this.calcColor()
  }
  // 计算颜色
  calcColor = () => {
    // 滚动计算的 scrollY 的值到达顶部可能不是 0，给点误差
    if (this.scrollY > 10) {
      this.fontColor = 'rgb(0, 0, 0)'
    } else {
      this.fontColor = 'rgb(255, 255, 255)'
    }
  }

  @Builder
  contentBuilder() {
    SwiperLayout({ bannerList: this.bannerList })
    Column() {
      NavList({ navList: this.navList })
      TileList({ tileList: this.tileList })
      PlanList({ planList: this.planList })
      Ad({ adPicture: this.adPicture })
    }.padding({ left: PADDING, right: PADDING })

    RoomRecommend()
  }

  @Builder
  navBuilder($$: IColor) {
    SearchBar({fontColor: $$.fontColor });
  }

  build() {
    ScrollContainer({
      contentBuilder: () => {
        this.contentBuilder()
      },
      navBuilder: this.navBuilder
    })
  }
}