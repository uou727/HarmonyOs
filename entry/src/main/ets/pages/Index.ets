import Home from './Home';
import See from './See';
import Service from './Service';
import Discover from './Discover';
import My from './My';
import { rvp } from '../utils/responsive';
import { window } from '@kit.ArkUI';

// 必须放在入口页面
PersistentStorage.persistProp('token', '')

@Entry
@Component
struct Index {
  // 当前 tab 高亮的下标
  @State currentIndex: number = 3;
  @StorageProp('bottomHeight') bottomHeight: number = 0
  setNavBarColor = async (color: string) => {
    const windowClass = await window.getLastWindow(getContext(this))
    windowClass.setWindowSystemBarProperties({
      statusBarContentColor: color
    })
  }

  // aboutToAppear(): void {
  //   this.setNavBarColor()
  // }

  // 生成 tab 的函数
  @Builder
  TabBuilder(index: number, text: string, icon: Resource, activeIcon: Resource) {
    Column() {
      // 项目中常用的颜色、大小等会定义成常量，将来方便复用和统一调整。而不常用的大小颜色就不需要定义了，直接写死即可。
      Image(this.currentIndex === index ? activeIcon : icon).width(rvp(28))
      Text(text)
        .fontSize(rvp(10))
        .fontColor(this.currentIndex === index ? $r('app.color.black') : '#a0a0a0')
        .height(rvp(15))
    }.width('100%').height('100%').justifyContent(FlexAlign.Center)
  }

  build() {
    Column() {
      Tabs({ barPosition: BarPosition.End, index: this.currentIndex }) {
        TabContent() {
          Home()
        }.tabBar(this.TabBuilder(0, '首页', $r('app.media.tabbar_home'), $r('app.media.tabbar_home_active')))

        TabContent() {
          See()
        }.tabBar(this.TabBuilder(1, '想看', $r('app.media.tabbar_see'), $r('app.media.tabbar_see_active')))

        TabContent() {
          Service()
        }.tabBar(this.TabBuilder(2, '服务', $r('app.media.tabbar_service'), $r('app.media.tabbar_service_active')))

        TabContent() {
          Discover()
        }.tabBar(this.TabBuilder(3, '发现', $r('app.media.tabbar_discover'), $r('app.media.tabbar_discover_active')))

        TabContent() {
          My()
        }.tabBar(this.TabBuilder(4, '我的', $r('app.media.tabbar_my'), $r('app.media.tabbar_my_active')))
      }
      .vertical(false)
      .barMode(BarMode.Fixed)
      .onChange((index: number) => {
        this.currentIndex = index
        if (index === 0) {
          this.setNavBarColor('#FFFFFF')
        } else if (index === 1) {
          this.setNavBarColor('#000000')
        }
      })
      .barHeight(rvp(50) + this.bottomHeight) // 设置 tab 导航栏的高度，默认 56
      .scrollable(false)
      .width('100%')
      .height('100%')
      .backgroundColor($r('app.color.white'))
    }.height('100%')
  }
}