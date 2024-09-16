import { IBannerItem, BannerListDataSource } from '../../models/HomeData';
import { rvp } from '../../utils/responsive';

@Component
export default struct SwiperLayout {
  @ObjectLink bannerList: BannerListDataSource;
  @StorageProp('topHeight') topHeight: number = 0

  build() {
    Swiper() {
      LazyForEach(this.bannerList, (banner: IBannerItem) => {
        Image(banner.imageURL).width('100%').height('100%').objectFit(ImageFit.Fill)

      }, (banner: IBannerItem) => banner.id + '')
    }
    .autoPlay(true)
    .indicator(
      new DotIndicator()
        .color($r('app.color.indicator_color'))
        .selectedColor($r('app.color.indicator_active_color'))
    )
    .width('100%')
    .height(rvp(211 - 36) + this.topHeight)
    .onChange((index: number) => {

    })
  }
}