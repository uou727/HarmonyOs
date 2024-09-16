import { rvp } from '../../utils/responsive';

@Component
export default struct bg {
  @StorageProp('topHeight') topHeight: number = 0

  build() {
    Column() {
    }
    .width('100%')
    .height(rvp(175) + this.topHeight)
    .linearGradient({
      angle: 180,
      direction: GradientDirection.Top,
      colors: [
        ['#6DC782', 0],
        ['#8FE1A2', 0.3],
        ['#8FE1A2', 1],
      ],
      repeating: false,
    })
  }
}