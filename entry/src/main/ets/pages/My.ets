import ScrollContainer from '../components/ScrollContainer/Index'
import { PADDING } from '../constants/size'
import { getWindowTopHeight, rvp } from '../utils/responsive'
import Bg from '../views/My/Bg'
import NavBar from '../views/My/NavBar'
import TimePlan from '../views/My/TimePlan'
import UserInfo from '../views/My/UserInfo'


@Component
export default struct My {
  @StorageProp('topHeight') topHeight: number = 0


  @Builder
  contentBuilder() {
    Stack() {
      Bg()
      Column() {
        UserInfo()
        TimePlan()
      }.padding({ left: rvp(PADDING), right: rvp(PADDING), top: getWindowTopHeight() })
    }.width('100%')
    .height('100%')
    .alignContent(Alignment.TopStart)
  }

  @Builder
  navBuilder() {
    NavBar()
  }

  build() {
    ScrollContainer({
      contentBuilder: () => {
        this.contentBuilder()
      },
      navBuilder: this.navBuilder
    })
  }
}