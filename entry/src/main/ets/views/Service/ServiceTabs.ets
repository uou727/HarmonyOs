import { rvp } from '../../utils/responsive'
import Card from '../../components/Card/Index'
import { ICleaningServiceInfoItem, ICleaningServiceInfoList } from '../../models/ServiceData'

@Component
export default struct ServiceTabs {
  @Prop serviceTabImage: string
  @State currentIndex: number = 0
  @Prop cleaningServiceInfo: ICleaningServiceInfoList

  @Builder
  TabBuilder(index: number, name: string, subName: string) {
    Column({ space: rvp(2) }) {
      Text(name).fontSize(this.currentIndex === index ? rvp(18) : rvp(14)).fontWeight(700)
      Text(subName).fontSize(rvp(12)).fontColor($r('app.color.gray_second'))
      if (this.currentIndex === index) {
        Divider()
          .strokeWidth(rvp(4))
          .width(rvp(20))
          .color('#51BB9E')
      }
    }.width('100%')
  }

  // tab内容区
  @Builder
  Content() {
    Column({ space: rvp(8) }) {
      this.NewArea()
      this.CleanRoom()
    }.height('100%').alignItems(HorizontalAlign.Start)
  }

  // 新人专区
  @Builder
  NewArea() {
    Card({ cardPadding: rvp(8) }) {
      Column() {
        Text() {
          Span('新人').fontSize(rvp(16)).fontColor($r('app.color.primary'))
          Span('专区').fontSize(rvp(16))
        }.width('100%')

        Image(this.serviceTabImage).width('100%').height(rvp(90)).objectFit(ImageFit.Fill).margin({ top: rvp(8) })
      }
    }
  }

  // 洁净家
  @Builder
  CleanRoom() {
    Card({ cardPadding: rvp(8) }) {
      Text('洁净家').fontSize(rvp(16)).fontWeight(700).width('100%')
      Row({ space: rvp(8) }) {
        ForEach(this.cleaningServiceInfo, (clean: ICleaningServiceInfoItem) => {
          Column() {
            Image(clean.img).width('100%').height(rvp(115)).objectFit(ImageFit.Fill)
            Text('日常保洁2小时').fontSize(rvp(14)).fontWeight(700).fontColor($r('app.color.black'))
            Text('推荐60㎡以内的房屋').fontSize(rvp(10)).fontWeight(500).fontColor('#666666')
            Text() {
              Span('到手价').fontSize(rvp(10)).fontWeight(500).fontColor('#666666')
              Span('￥' + clean.priceAfterDiscounts).fontSize(rvp(16)).fontWeight(500).fontColor('#D9351A')
              Span('￥' + clean.originalPrice)
                .fontSize(rvp(10))
                .fontWeight(500)
                .fontColor('#666666')
                .decoration({ type: TextDecorationType.LineThrough, color: $r('app.color.gray_second') })
            }
          }.layoutWeight(1).alignItems(HorizontalAlign.Start)
        })
      }.margin({ top: rvp(8) })
    }
  }

  build() {
    Tabs({ barPosition: BarPosition.Start, index: this.currentIndex }) {
      TabContent() {
        this.Content()
      }.tabBar(this.TabBuilder(0, '会员精选', '专业服务'))

      TabContent() {
        this.Content()
      }.tabBar(this.TabBuilder(1, '居家保洁', '解放双手'))

      TabContent() {
        this.Content()
      }.tabBar(this.TabBuilder(2, '深层清洗', '高温蒸洗'))

      TabContent() {
        this.Content()
      }.tabBar(this.TabBuilder(3, '新居乔迁', '一站搬家'))
    }
    .vertical(false)
    .barMode(BarMode.Fixed)
    .barWidth('100%')
    .barHeight(rvp(53))
    .onChange((index: number) => {
      this.currentIndex = index
    })
    .width('100%')
    .height(rvp(423))
    .margin({ top: rvp(18) })
  }
}