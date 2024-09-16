import ScrollContainer from '../components/ScrollContainer/Index'
import { PADDING } from '../constants/size'
import { rvp } from '../utils/responsive'
import FindRoom from '../views/See/FindRoom'
import NavBar from '../views/See/NavBar'

@Component
export default struct See {
  @Builder
  contentBuilder() {
    Column() {
      FindRoom()
    }
    .width('100%')
    .height('100%')
    .padding({ left: rvp(PADDING), right: rvp(PADDING) })
    .linearGradient({
      angle: 180,
      direction: GradientDirection.Top,
      colors: [
        ['#DEFBE5', 0],
        ['#ffffff', 0.3],
        ['#ffffff', 1],
      ],
      repeating: false,
    })
  }

  @Builder
  navBuilder() {
    NavBar()
  }

  build() {
    ScrollContainer({
      navBuilder: this.navBuilder,
      contentBuilder: this.contentBuilder,
    })
  }
}