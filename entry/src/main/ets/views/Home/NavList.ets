import { INavItem, INavList } from '../../models/HomeData';
import { rvp } from '../../utils/responsive';

@Component
export default struct NavList {
  @Prop navList: INavList

  build() {
    Grid() {
      ForEach(this.navList, (nav: INavItem) => {
        GridItem() {
          Column({ space: rvp(8) }) {
            Image(nav.imageURL).width(rvp(58)).height(rvp(56)).objectFit(ImageFit.Fill)
            Text(nav.title).fontSize(rvp(12)).fontColor($r('app.color.black'))
          }
        }
      }, (nav: INavItem) => nav.id + '')
    }
    .width('100%')
    .height(rvp(170))
    .rowsTemplate('1fr 1fr')
    .columnsTemplate('1fr 1fr 1fr 1fr')
    .rowsGap(14)
    .columnsGap(32)
    .margin({ top: rvp(24) })
  }
}