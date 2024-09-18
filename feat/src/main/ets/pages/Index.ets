import { getHomeDataApi } from '../../../../../entry/src/main/ets/api/home'

@Entry
@Component
struct Index {
  @State message: string = 'Hello World';

  aboutToAppear() {
    this.getHomeData()
  }

  async getHomeData() {
    const homeData = await getHomeDataApi()
    console.log(JSON.stringify(homeData.bannerList))
  }

  build() {
    RelativeContainer() {
      Text(this.message)
        .id('HelloWorld')
        .fontSize(50)
        .fontWeight(FontWeight.Bold)
        .alignRules({
          center: { anchor: '__container__', align: VerticalAlign.Center },
          middle: { anchor: '__container__', align: HorizontalAlign.Center }
        })
    }
    .height('100%')
    .width('100%')
  }
}