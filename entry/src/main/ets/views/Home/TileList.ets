import { ITileList, ITileItem } from '../../models/HomeData';
import { rvp } from '../../utils/responsive';

@Component
export default struct TileList {
  @Prop tileList: ITileList

  build() {
    Row({ space: 32 }) {
      ForEach(this.tileList, (tile: ITileItem) => {
        Column({ space: 8 }) {
          Image(tile.imageURL).width('100%').height(rvp(58))
          Row({ space: 5 }) {
            Text(tile.title).fontSize(rvp(12)).fontColor($r('app.color.black'))
            Text(tile.sub_title).fontSize(rvp(10)).fontColor($r('app.color.garry'))
          }.width('100%')
        }.width(rvp(148))
      }, (tile: ITileItem) => tile.id + '')

    }.width('100%')
    .margin({ top: rvp(12) })
  }
}