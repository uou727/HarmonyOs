import { getRentRoomListApi } from '../../api/rentRoom';
import { BORDER_RADIUS, PADDING } from '../../constants/size';
import { IGetRentRoomListParams, IRentRoomItem, RentRoomListDataSource } from '../../models/RentRoomData';
import { IRoomRecommendItem, ITagItem } from '../../models/RoomRecommendDataSource';
import globalEmitter from '../../utils/emitter/emitter';
import { rvp } from '../../utils/responsive';
import { router } from '@kit.ArkUI';

@Component
export default struct WaterfallFlow {
  @StorageProp('topHeight') topHeight: number = 0
  @State roomList: RentRoomListDataSource = new RentRoomListDataSource()
  @State isEnd: boolean = false
  @State refreshing: boolean = false;
  @State refreshOffset: number = 0;
  @State total: number = 0
  @State refreshState: RefreshStatus = RefreshStatus.Inactive;
  @State searchOptions: IGetRentRoomListParams = {
    page: 1,
    limit: 10
  }

  aboutToAppear() {
    this.getRentRoomList();
    globalEmitter.on('search', (searchOptions: Partial<IGetRentRoomListParams>) => {
      const keys = Object.keys(searchOptions)
      keys.forEach(key => {
        const val: string = Reflect.get(searchOptions, key)
        Reflect.set(this.searchOptions, key, val)
      })
      console.log('11111', JSON.stringify(this.searchOptions))
      this.getRentRoomList()

    })
  }

  // 请求数据
  getRentRoomList = async () => {
    const res = await getRentRoomListApi(this.searchOptions)
    if (this.searchOptions.page === 1) {
      this.roomList.setList(res.records)
      this.refreshing = false;
    } else {
      this.roomList.pushDataList(res.records)
    }
    this.total = Number(res.total)
  }

  // 上拉加载
  loadMore() {
    if (this.roomList.totalCount() >= this.total) {
      console.log(JSON.stringify(this.roomList.totalCount()))
      this.isEnd = true
      return
    }
    this.isEnd = false
    this.searchOptions.page++
    this.getRentRoomList()
  }

  // 下拉刷新
  initData() {
    this.searchOptions.page = 1
    this.total = 0
    this.getRentRoomList()
    console.log('1111')
  }

  getText = (room: IRentRoomItem) => {
    return Reflect.get(room.activity!, '#text')
  }

  @Builder
  refreshBuilder() {
    Stack({ alignContent: Alignment.Bottom }) {
      // 可以通过刷新状态控制是否存在Progress组件
      // 当刷新状态处于下拉中或刷新中状态时Progress组件才存在
      if (this.refreshState != RefreshStatus.Inactive && this.refreshState != RefreshStatus.Done) {
        Progress({ value: this.refreshOffset, total: 64, type: ProgressType.Ring })
          .width(32).height(32)
          .style({ status: this.refreshing ? ProgressStatus.LOADING : ProgressStatus.PROGRESSING })
          .margin(10)
      }
    }
    .clip(true)
    .height("100%")
    .width("100%")
  }

  @Builder
  footerBuilder() {
    Row({ space: rvp(10) }) {
      if (this.isEnd) {
        Text('到底了，没有其他数据了').fontSize(12).margin({ top: rvp(4) })
      } else {
        Refresh({ refreshing: true })
        Text('数据加载中').fontSize(12).margin({ top: rvp(4) })
      }
    }.width('100%').justifyContent(FlexAlign.Center).alignItems(VerticalAlign.Center)
  }

  build() {
    Column() {
      Refresh({ refreshing: $$this.refreshing, builder: this.refreshBuilder() }) {
        WaterFlow({ footer: this.footerBuilder }) {
          // 这里设置一个高度作为空白
          FlowItem() {
          }.height(rvp(6))

          FlowItem() {
          }.height(rvp(6))

          LazyForEach(this.roomList, (room: IRentRoomItem) => {
            FlowItem() {
              Column() {
                // !room.activity长图样式
                if (!room.activity) {
                  Stack() {

                    Image(room.housePicture)
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
                      Text(room.address)
                        .fontSize(rvp(10))
                        .fontColor($r('app.color.white'))
                    }
                    .margin({ left: rvp(8), bottom: rvp(6) })
                  }
                  .width('100%')
                  .height(rvp(120))
                  .alignContent(Alignment.BottomStart)
                } else {
                  // room.activity长图样式
                  Column({ space: rvp(3) }) {
                    Row({ space: rvp(4) }) {
                      Image(room.activity.icon).width(rvp(26)).height(rvp(26))
                      Text(room.activity.title).fontSize(rvp(14)).fontWeight(700)
                    }.width('100%')

                    Row() {
                      Text(this.getText(room))
                        .fontColor(room.activity.textColor)
                        .fontSize(rvp(10))
                        .textAlign(TextAlign.Start)
                        .padding({
                          left: rvp(8),
                          right: rvp(8),
                          top: rvp(4),
                          bottom: rvp(4)
                        })
                        .backgroundColor(room.activity.textBackGroundColor)
                        .borderRadius(rvp(21))
                    }.width('100%').justifyContent(FlexAlign.Start)

                    Image(room.housePicture)
                      .width('100%')
                      .height(rvp(165))
                      .objectFit(ImageFit.Fill)
                      .borderRadius(rvp(8))
                  }.width('100%').padding({ top: rvp(12), left: rvp(10), right: rvp(10) })
                }
                // 下半部分
                Column() {
                  Row() {
                    Text() {
                      Span(room.rentPriceListing).fontSize(rvp(14))
                      Span(room.rentPriceUnit).fontSize(rvp(12))
                    }.fontColor($r('app.color.red_text'))

                    Text(room.rentArea + '㎡')
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


                  Text(room.houseTitle)
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
                    ForEach(room.tags.slice(0, 2), (tag: ITagItem, index) => {
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
                  }.width('100%').margin({ top: rvp(10) }).padding({
                    left: rvp(10),
                    right: rvp(10),
                  })
                }

              }
              .width('100%')
              .height('100%')
              .borderRadius(BORDER_RADIUS)
              .backgroundColor($r('app.color.white'))

            }.width(rvp(160)).height(room.activity ? rvp(320) : rvp(210)).onClick(() => {
              router.pushUrl({
                url: 'pages/RentRoom/RentRoomDetail',
                params: {
                  id: room.id
                }
              })
            })
          }, (room: IRoomRecommendItem) => room.id)
        }
        .columnsTemplate("1fr 1fr")
        .rowsGap(rvp(8))
        .backgroundColor($r('app.color.bg_gray'))
        .width('100%')
        .layoutDirection(FlexDirection.Column)
        .padding({
          left: rvp(10),
          right: rvp(10),
          bottom: PADDING
        })

        .onReachEnd(() => this.loadMore())
      }.onOffsetChange((offset: number) => {
        this.refreshOffset = offset;
      })
      .onStateChange((state: RefreshStatus) => {
        this.refreshState = state;
      })
      .onRefreshing(() => {
        this.initData()
      })

    }.padding({ top: this.topHeight + rvp(88) })
  }
}