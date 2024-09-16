import { PADDING } from '../../constants/size'
import { rvp } from '../../utils/responsive'

@Component
export default struct NavBar {
  @Prop fontColor: string

  build() {
    Row() {
      Row({ space: rvp(5) }) {
        Text('请选择地址').fontColor(this.fontColor).fontSize(rvp(14))
        Image($r('app.media.arrow_down')).width(rvp(6)).height(rvp(6)).fillColor(this.fontColor)
      }

      Row({ space: rvp(28) }) {
        Column({ space: rvp(1) }) {
          Image($r('app.media.message')).width(rvp(20)).height(rvp(20)).fillColor(this.fontColor)
          Text('消息').fontSize(rvp(12)).fontColor(this.fontColor)
        }

        Column({ space: rvp(1) }) {
          Image($r('app.media.customer')).width(rvp(20)).height(rvp(20)).fillColor(this.fontColor)
          Text('行程').fontSize(rvp(12)).fontColor(this.fontColor)
        }
      }
    }
    .padding({ left: rvp(PADDING), right: rvp(PADDING) })
    .height(rvp(44))
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
  }
}