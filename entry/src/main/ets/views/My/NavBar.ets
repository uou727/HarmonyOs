import { PADDING } from '../../constants/size'
import { rvp } from '../../utils/responsive'

@Component
export default struct NavBar {
  @StorageProp('topHeight') topHeight: number = 0

  build() {
    Stack() {
      Row() {
        Row({ space: rvp(2) }) {
          Image($r('app.media.switch')).width(rvp(16)).height(rvp(16)).fillColor(Color.Black)
          Text('业主版').fontSize(rvp(14)).fontWeight(500).onClick(() => {
            console.log('1111点击按钮')
          })
        }
        .width(rvp(80))
        .height(rvp(26))
        .backgroundColor('rgba(255,255,255,0.70)')
        .borderRadius(rvp(31))
        .justifyContent(FlexAlign.Center)

        Row({ space: rvp(16) }) {
          Image($r('app.media.setting')).width(rvp(20)).height(rvp(20))
          Image($r('app.media.setting')).width(rvp(20)).height(rvp(20))
          Image($r('app.media.setting')).width(rvp(20)).height(rvp(20))
        }
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
    }.height(rvp(44)).width('100%').padding({ left: rvp(PADDING), right: rvp(PADDING) })
  }
}