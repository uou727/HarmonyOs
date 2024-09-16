import Card from '../../components/Card/Index'
import { IHomeServiceItem, IHomeServiceList } from '../../models/ServiceData';
import { rvp } from '../../utils/responsive';

@Component
export default struct DomesticService {
  @Prop homeServiceList: IHomeServiceList

  @Builder
  renderBuilder() {
    // 默认插槽
    Column() {
      Row() {
        Text('家庭服务').fontSize(rvp(16)).fontWeight(700)
        Row({ space: rvp(10) }) {
          Text('全部服务').fontSize(rvp(12)).fontColor($r('app.color.garry'))
          Image($r('app.media.arrow_right')).width(rvp(4))
        }
      }.justifyContent(FlexAlign.SpaceBetween).width('100%')

      Grid() {
        ForEach(this.homeServiceList, (value: IHomeServiceItem) => {
          GridItem() {
            Column({ space: rvp(10) }) {
              Image(value.icon).width(rvp(24)).height(rvp(24)).objectFit(ImageFit.Fill)
              Text(value.title).fontSize(rvp(12))
            }
          }.width(rvp(60))
        })
      }
      .columnsTemplate('1fr 1fr 1fr 1fr 1fr')
      .rowsTemplate('1fr 1fr 1fr')
      .rowsGap(rvp(22))
      .columnsGap(rvp(18))
      .width('100%')
      .height(rvp(188))
      .margin({ top: rvp(20), bottom: rvp(18) })

    }
  }

  build() {
    Column() {
      Card({
        cardPadding: 8,
        contentBuilderParams: () => {
          this.renderBuilder()
        }
      })
    }.width('100%').margin({ top: rvp(43) })
  }
}