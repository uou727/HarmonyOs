import { rvp } from '../../utils/responsive';

@Component
export default struct TimePlan {
  @StorageProp('token') token: string = ''

  build() {
    Column({ space: rvp(11) }) {
      Row() {
        Text('小谷粒时光计划').fontSize(rvp(16)).fontWeight(700)
        Image($r('app.media.arrow_right')).height(rvp(12)).width(rvp(6))
      }.onClick(() => {

        console.log('时光计划', this.token)
      })
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .padding({ top: rvp(18) })

      Text('签约后可解锁会员权益').width('100%').fontSize(rvp(12)).fontWeight(500)
    }
    .width('100%')
    .margin({ top: rvp(15) })
    .height(rvp(80))
    .padding({ left: rvp(22), right: rvp(22) })
    .borderRadius(rvp(8))
    .linearGradient({
      angle: 180,
      direction: GradientDirection.Top,
      colors: [
        ['#FFEBB5', 0],
        ['#FFF1CD', 1],
      ],
      repeating: false,
    })
  }
}