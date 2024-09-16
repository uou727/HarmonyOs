import { PADDING } from '../../constants/size'
import { IHomeServiceItem, IHomeServiceList, IVipServiceItem, IVipServiceList } from '../../models/ServiceData'
import { rvp } from '../../utils/responsive'

@Component
export default struct Vip {
  @StorageProp('topHeight') topHeight: number = 0
  @Prop vipServiceList: IVipServiceList = []

  build() {
    Stack() {
      Image($r('app.media.vip_bg')).width('100%').height('100%').objectFit(ImageFit.Fill)

      Column({ space: rvp(10) }) {
        Row({ space: rvp(5) }) {
          Image($r('app.media.crown')).width(rvp(18)).height(rvp(18))
          Text('开通谷粒卡享特权').fontSize(rvp(16)).fontColor($r('app.color.white'))
          Blank()
          Image($r('app.media.vip')).width(rvp(43)).height(rvp(19)).objectFit(ImageFit.Fill)
        }.width('100%').padding({ left: rvp(39), right: rvp(41) })

        Row() {
          ForEach(this.vipServiceList, (vip: IVipServiceItem) => {
            Column({ space: rvp(4) }) {
              Text(vip.name).fontColor($r('app.color.white'))
              Text(vip.content + '').fontColor($r('app.color.white'))
            }
          })
          // Column({ space: rvp(4) }) {
          //   Text('余额').fontColor($r('app.color.white'))
          //   Text('0元').fontColor($r('app.color.white'))
          // }
          //
          // Column({ space: rvp(4) }) {
          //   Text('优惠卷').fontColor($r('app.color.white'))
          //   Text('4张').fontColor($r('app.color.white'))
          // }
          //
          // Column({ space: rvp(4) }) {
          //   Text('会员特权').fontColor($r('app.color.white'))
          //   Text('0项').fontColor($r('app.color.white'))
          // }
          //
          // Column({ space: rvp(4) }) {
          //   Text('会员福利').fontColor($r('app.color.white'))
          //   Text('0个').fontColor($r('app.color.white'))
          // }
        }.width('100%').justifyContent(FlexAlign.SpaceBetween).padding({ left: rvp(35), right: rvp(35) })
      }
    }
    .width('100%')
    .height(rvp(99))
    .margin({ top: rvp(49) + this.topHeight })
  }
}