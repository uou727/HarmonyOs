import { SHADOW_RADIUS } from '../../constants/size';
import { rvp } from '../../utils/responsive';

@Component
export default struct Ad {
  @Prop adPicture: string;

  build() {
    Image(this.adPicture)
      .width('100%')
      .height(rvp(61))
      .objectFit(ImageFit.Fill)
      .margin({ top: rvp(9) })
      .shadow({
        radius: rvp(SHADOW_RADIUS),
        color: $r('app.color.shadow'),
        offsetX: 0,
        offsetY: 0
      })
  }
}