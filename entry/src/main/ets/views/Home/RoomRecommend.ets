import { getRoomRecommendListApi } from '../../api/home';
import { BORDER_RADIUS, PADDING } from '../../constants/size';
import {
  IRoomRecommendItem,
  IRoomRecommendList,
  ITagItem,
  RoomRecommendDataSource
} from '../../models/RoomRecommendDataSource';
import { rvp } from '../../utils/responsive';
import router from '@ohos.router';

@Component
export default struct RoomRecommend {
  @State roomRecommendList: RoomRecommendDataSource = new RoomRecommendDataSource()

  aboutToAppear(): void {
    this.getRoomRecommendList()

  }

  async getRoomRecommendList() {
    const roomRecommendList = await getRoomRecommendListApi()
    this.roomRecommendList.setList(roomRecommendList)
  }

  build() {
    Column() {
      Row() {
        Text() {
          Span('周边房源')
          Span('推荐').fontColor($r('app.color.primary'))
        }.fontSize(rvp(16)).fontWeight(700).fontColor($r('app.color.black'))

        Row({ space: 6 }) {
          Text('更多推荐').fontSize(rvp(10)).fontWeight(700).fontColor($r('app.color.gray_second'))
          Image($r('app.media.arrow_right')).width(rvp(4)).height(rvp(8))
        }.onClick(() => {
          router.pushUrl({
            url: "pages/RentRoom/RentRoomList"
          })
        })
      }
      .width('100%')
      .height(rvp(44))
      .padding({ left: rvp(PADDING), right: rvp(PADDING) })
      .justifyContent(FlexAlign.SpaceBetween)
      .backgroundColor($r('app.color.white'))
      .margin({ top: rvp(23) })


      Grid() {
        LazyForEach(this.roomRecommendList, (roomRecommend: IRoomRecommendItem) => {
          GridItem() {
            Column() {
              Stack() {
                Image(roomRecommend.housePicture)
                  .height('100%')
                  .width('100%')
                  .objectFit(ImageFit.Fill)
                  .borderRadius({ topLeft: rvp(BORDER_RADIUS), topRight: rvp(BORDER_RADIUS) })
                Image($r('app.media.room_text_bg')).height('100%').width('100%').objectFit(ImageFit.Fill)
                Row({ space: 6 }) {
                  Image($r('app.media.location'))
                    .width(rvp(12))
                    .height(rvp(14))
                    .objectFit(ImageFit.Fill)
                  Text(roomRecommend.address)
                    .fontSize(rvp(10))
                    .fontColor($r('app.color.white'))
                }
                .margin({ left: rvp(8), bottom: rvp(6) })
              }
              .width('100%')
              .height(rvp(120))
              .alignContent(Alignment.BottomStart)

              // 下半部分
              Row() {
                Text() {
                  Span(roomRecommend.rentPriceListing).fontSize(rvp(14))
                  Span(roomRecommend.rentPriceUnit).fontSize(rvp(12))
                }.fontColor($r('app.color.red_text'))

                Text(roomRecommend.rentArea + '㎡')
                  .fontSize(rvp(10))
                  .fontColor($r('app.color.garry'))
              }.padding({
                left: rvp(10),
                right: rvp(10),
                top: rvp(11),
                bottom: rvp(2)
              })
              .width('100%')
              .justifyContent(FlexAlign.SpaceBetween)


              Text(roomRecommend.houseTitle)
                .fontSize(rvp(14))
                .fontColor($r('app.color.black'))
                .fontWeight(500)
                .maxLines(1)
                .textOverflow({ overflow: TextOverflow.Ellipsis })
                .padding({
                  left: rvp(10),
                  right: rvp(10),
                })

              Row() {
                ForEach(roomRecommend.tags.slice(0, 2), (tag: ITagItem, index) => {
                  Text(tag.name)
                    .padding({
                      top: rvp(1),
                      bottom: rvp(1),
                      left: rvp(6),
                      right: rvp(6)
                    })
                    .fontColor(index === 0 ? $r('app.color.white') : '#B3B3B3')
                    .backgroundColor(index === 0 ? $r('app.color.primary') : $r('app.color.bg_gray'))
                    .fontSize(rvp(12))
                    .borderRadius(2)
                })
              }.width('100%')
              .margin({ top: rvp(10) })
              .padding({
                left: rvp(10),
                right: rvp(10),
              })

            }
            .width(rvp(160))
            .height(rvp(210))
            .borderRadius(BORDER_RADIUS)
            .backgroundColor($r('app.color.white'))
          }
        }, (roomRecommend: IRoomRecommendItem) => roomRecommend.id + '')
      }
      .width('100%')
      .columnsTemplate('1fr 1fr')
      .columnsGap(8)
      .rowsGap(8)
      .padding({
        left: rvp(PADDING),
        right: rvp(PADDING),
        top: rvp(8),
        bottom: rvp(8)
      })
      .backgroundColor($r('app.color.bg_gray'))
    }
  }
}