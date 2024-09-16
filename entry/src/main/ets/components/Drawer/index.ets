import { PADDING } from '../../constants/size'
import { rvp } from '../../utils/responsive'

@Component
export default struct Drawer {
  @Builder
  custom() {
  }

  @Prop title: string = ''
  @BuilderParam contentBuilderParam: () => void = this.custom
  @Link visible: boolean

  build() {
    if (this.visible) {
      Stack() {
        // 遮罩
        Column() {
        }.width('100%')
        .height('100%')
        .backgroundColor('rgba(0,0,0,0.7)')
        .onClick(() => {
          this.visible = false
        })

        Column() {
          this.contentBuilderParam()
        }
        .width('100%')
        .padding(rvp(PADDING))
        .backgroundColor('#F6F6F6')
        .borderRadius({ topLeft: rvp(10), topRight: rvp(10) })
        .transition(TransitionEffect.translate({ x: 0, y: 181 }).animation({ duration: 400 }))
        .alignItems(HorizontalAlign.Start)
      }
      .width('100%')
      .height('100%')
      .alignContent(Alignment.Bottom)
    }
  }
}