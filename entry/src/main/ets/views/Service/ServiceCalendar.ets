import Card from '../../components/Card/Index'
import { BORDER_RADIUS_S } from '../../constants/size'
import { IServiceActivity } from '../../models/ServiceData'
import { getCalendar } from '../../utils/calendar'
import { rvp } from '../../utils/responsive'

@Component
export default struct ServiceCalendar {
  @Prop serviceActivity: IServiceActivity
  @State calendarList: string[] = []

  aboutToAppear(): void {
    this.getData()
  }

  getData() {
    this.calendarList = getCalendar()
  }

  @Builder
  renderBuilder() {
    Column() {
      Row() {
        Text('家庭服务').fontSize(rvp(16)).fontWeight(700)
        Row({ space: rvp(10) }) {
          Text('全部服务').fontSize(rvp(12)).fontColor($r('app.color.garry'))
          Image($r('app.media.arrow_right')).width(rvp(4))
        }
      }.justifyContent(FlexAlign.SpaceBetween)
      .width('100%')
      .padding({ left: rvp(8), right: rvp(8), top: rvp(8) })


      Row() {
        ForEach(this.calendarList, (val: string, index) => {
          if (index === 2) {
            Text() {
              Span(val).fontSize(rvp(16)).fontColor($r('app.color.black')).fontWeight(700)
              Span('月').fontSize(rvp(12)).fontColor($r('app.color.gray_second'))
            }
            .backgroundColor('#CDFFD9')
            .width(rvp(46))
            .height(rvp(32))
            .textAlign(TextAlign.Center)
            .borderRadius(rvp(4))
          } else {
            Text() {
              Span(val).fontSize(rvp(16)).fontColor($r('app.color.black')).fontWeight(700)
              Span('月').fontSize(rvp(12)).fontColor($r('app.color.gray_second'))
            }.width(rvp(46)).height(rvp(32))
          }
        })
      }.justifyContent(FlexAlign.SpaceBetween).width('100%').padding({ left: rvp(8), right: rvp(8), top: rvp(16) })

      Column() {
        Text(this.serviceActivity.name).fontSize(rvp(14)).fontWeight(700).margin({ bottom: 8 })
        Row({ space: rvp(10) }) {
          Image(this.serviceActivity.img)
            .width(rvp(100))
            .height(rvp(100))
            .objectFit(ImageFit.Fill)
            .borderRadius(rvp(BORDER_RADIUS_S))
          Column() {
            Text(this.serviceActivity.title).fontSize(rvp(14)).margin({ top: rvp(7) })
            Text(this.serviceActivity.subTitle).fontSize(rvp(12)).margin({ top: rvp(7) })
            Row() {
              Button("立即参与")
                .type(ButtonType.Normal)
                .width(rvp(70))
                .height(rvp(24))
                .backgroundColor("#CDFFD9")
                .fontColor('#1F632F')
                .borderRadius(rvp(4))
            }.margin({ top: rvp(22) }).padding({ right: rvp(8) }).width('100%').justifyContent(FlexAlign.End)
          }.alignItems(HorizontalAlign.Start).layoutWeight(1)
        }
      }
      .width('100%')
      .height(rvp(140))
      .alignItems(HorizontalAlign.Start)
      .margin({ top: rvp(12) })
      .padding(rvp(8))
      .linearGradient({
        angle: 210,
        colors: [['#D0FFDB', 0], ['rgba(255, 255, 255, 1)', 0.29], ['rgba(255, 255, 255, 0)', 1]],
        repeating: false
      })
      .alignItems(HorizontalAlign.Start)
    }
  }

  build() {
    Column() {
      Card({
        cardPadding: 0, contentBuilderParams: () => {
          this.renderBuilder()
        }
      })
    }.width('100%').margin({ top: rvp(8) })
  }
}