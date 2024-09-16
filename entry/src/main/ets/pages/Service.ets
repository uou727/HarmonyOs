import { getServiceDataApi } from '../api/service';
import { IColor } from '../models/HomeData';
import { ICleaningServiceInfoList, IHomeServiceList, IServiceActivity, IVipServiceList } from '../models/ServiceData';
import { getWindowTopHeight, rvp } from '../utils/responsive';
import { PADDING } from '../constants/size';

import Bg from '../views/Service/Bg';
import ScrollContainer from '../components/ScrollContainer/Index';
import NavBar from '../views/Service/NavBar';
import VIP from '../views/Service/Vip';
import DomesticService from '../views/Service/DomesticService';
import ServiceCalendar from '../views/Service/ServiceCalendar';
import ServiceTabs from '../views/Service/ServiceTabs';

@Component
export default struct Service {
  @State vipServiceList: IVipServiceList = [];
  @State homeServiceList: IHomeServiceList = [];
  @State cleaningServiceInfo: ICleaningServiceInfoList = [];
  @State serviceTabImage: string = ''
  @State serviceActivity: IServiceActivity = {
    "name": "",
    "img": "",
    "title": "",
    "subTitle": "",
  }

  aboutToAppear() {
    this.getServiceData()
  }

  async getServiceData() {
    const serviceData = await getServiceDataApi();
    this.vipServiceList = serviceData.vipServiceList;
    this.homeServiceList = serviceData.homeServiceList;
    this.serviceActivity = serviceData.serviceActivity;
    this.serviceTabImage = serviceData.newcomerZone.img;
    this.cleaningServiceInfo = serviceData.cleaningServiceInfo;
  }

  @Builder
  navBuilder($$: IColor) {
    NavBar({ fontColor: $$.fontColor })
  }

  @Builder
  contentBuilder() {
    Stack() {
      Bg()
      Column() {
        VIP({ vipServiceList: this.vipServiceList })
        DomesticService({ homeServiceList: this.homeServiceList })
        ServiceCalendar({ serviceActivity: this.serviceActivity })
        ServiceTabs({ serviceTabImage: this.serviceTabImage, cleaningServiceInfo: this.cleaningServiceInfo })
      }.padding({ left: rvp(PADDING), right: rvp(PADDING), top: getWindowTopHeight() })
    }.alignContent(Alignment.TopStart)
  }

  build() {
    ScrollContainer({
      navBuilder: this.navBuilder,
      contentBuilder: () => {
        this.contentBuilder()
      }
    })
  }
}