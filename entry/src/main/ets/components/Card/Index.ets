import { rvp } from '../../utils/responsive'

@Component
export default struct Index {
  @BuilderParam contentBuilderParams: () => void = this.customBuilder
  @Prop cardPadding: number = 8

  @Builder
  customBuilder() {
  }

  build() {
    Column() {
      this.contentBuilderParams()
    }.width('100%').padding(rvp(this.cardPadding)).borderRadius(rvp(10)).backgroundColor($r('app.color.white'))
  }
}