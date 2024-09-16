import { rvp } from '../../utils/responsive'

@Component
export default struct Bg {
  @StorageProp('topHeight') topHeight: number = 0

  build() {
    Stack() {
      Image($r('app.media.service_bg'))
        .width('100%')
        .height(rvp(185) + this.topHeight)
        .objectFit(ImageFit.Fill)

      Image($r('app.media.arrow_down_2'))
        .width(rvp(10))
        .height(rvp(3))
        .objectFit(ImageFit.Fill)
        .margin({ top: rvp(176) + this.topHeight })
    }.width('100%').alignContent(Alignment.Top)
  }
}