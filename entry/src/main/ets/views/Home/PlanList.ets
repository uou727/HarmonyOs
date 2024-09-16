import { IPlanItem, IPlanList } from '../../models/HomeData';
import { rvp } from '../../utils/responsive';

@Component
export default struct PlanList {
  @Prop planList: IPlanList

  build() {
    Row({ space: 5 }) {
      ForEach(this.planList, (plan: IPlanItem) => {
        Image(plan.imageURL).width(rvp(78)).height(rvp(60))
      })
    }.margin({ top: rvp(18) })
  }
}