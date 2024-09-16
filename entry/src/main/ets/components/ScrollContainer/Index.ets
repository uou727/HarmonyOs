import { IColor } from '../../models/HomeData';
import { WindowManager } from '@kit.SpeechKit';
import { window } from '@kit.ArkUI';

@Component
export default struct ScrollContainer {
  @Builder
  defaultBuilder() {
  }

  @BuilderParam contentBuilder: () => void = this.defaultBuilder
  @BuilderParam navBuilder: ($$: IColor) => void = this.defaultBuilder
  @Prop isDark: boolean = false
  scrollY: number = 0;
  @State bgColor: string = 'rgba(255, 255, 255, 0)'
  @State fontColor: string = 'rgb(255, 255, 255)'
  @StorageProp('topHeight') topHeight: number = 0
  windowClass?: window.Window

  async aboutToAppear() {
    this.getWindowClass()
  }

  async getWindowClass() {
    this.windowClass = await window.getLastWindow(getContext(this))
    if (this.isDark) {
      this.bgColor = '#ffffff'
      this.windowClass!.setWindowSystemBarProperties({
        statusBarContentColor: "#000000"
      })
    }
  }

  // 处理滚动
  handleScroll = (scrollX: number, scrollY: number) => {
    // 更新并修正 scrollY 的值
    this.scrollY += scrollY;
    if (this.scrollY < 0) {
      this.scrollY = 0
    }
    this.calcColor();
  }
  // 计算颜色
  calcColor = () => {
    if (this.scrollY < 10) {
      this.bgColor = this.isDark ? '#ffffff' : 'rgba(255, 255, 255, 0)'
      this.fontColor = 'rgb(255, 255, 255)'
      if (this.isDark) {
        return
      }

      this.windowClass!.setWindowSystemBarProperties({
        statusBarContentColor: "#ffffff"
      })
    } else if (this.scrollY <= 100) {
      const colorOpacity = this.isDark ? 1 : (this.scrollY - 10) / (100 - 10)
      this.bgColor = `rgba( 255, 255, 255, ${colorOpacity} )`
      this.fontColor = `rgba( 0, 0, 0, ${colorOpacity} )`
    } else {
      if (this.isDark) {
        return
      }
      this.bgColor = 'rgb(255, 255, 255)'
      this.fontColor = 'rgb(0, 0, 0)'
      this.windowClass!.setWindowSystemBarProperties({
        statusBarContentColor: "#000000"
      })
    }
  }

  build() {
    Stack() {
      Scroll() {
        Column() {
          // 渲染内容
          this.contentBuilder()
        }.align(Alignment.TopStart)
      }
      .height('100%')
      .scrollBar(BarState.Off)
      .align(Alignment.TopStart)
      .backgroundColor($r('app.color.bg_gray_second'))
      .padding({ bottom: 10 })
      .onDidScroll(this.handleScroll)

      Column() {
        // 渲染头部导航
        this.navBuilder({ fontColor: this.fontColor })
      }.backgroundColor(this.bgColor).padding({ top: this.topHeight })

    }.height('100%').alignContent(Alignment.TopStart)
  }
}