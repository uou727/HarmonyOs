import { getRentRoomDetailApi } from '../../api/rentRoom';
import NavBar from '../../components/NavBar';
import { BORDER_RADIUS, BORDER_RADIUS_S, PADDING } from '../../constants/size';
import { getWindowBottomHeight, getWindowTopHeight, rvp } from '../../utils/responsive';
import { IRentRoomDetail } from '../../models/RentRoomDetails';
import { IHousePictureItem, IRoomName, IRoomNameItem } from '../../models/RentRoomData';
import ScrollContainer from '../../components/ScrollContainer/Index';
import Book from './Book';
import Drawer from '../../components/Drawer';
import BookInfo from '../../views/RentRoomList/BookInfo';
import createDateList, { IDateList } from '../../utils/createDateList/createDateList';


@Entry
@Component
struct RentRoomDetail {
  @State roomDetail: IRentRoomDetail = {
    houseTitle: '',
    address: '',
    rentPriceUnit: '',
    housePicture: [],
    tags: {
      tags: []
    },
    rentPriceUnitListing: '', // 确保这个字段有赋值
    rentTerm: {
      checkInTime: '',
      term: '',
      kitchen: '',
      lift: '',
      seeTime: '',
      year: '',
      renovation: '',
      grounding: '',
      heating: '',
      green: '',
      protection: '',
      house: ''
    },
    metaInfo: [],
    id: '',
    discounts: [],
    householdItem: [],
    support: [],
    rentInfo: []
  };
  @State roomPictureList: string[] = []
  @State roomNameList: IRoomName = []
  @State currentRoomIndex: number = 0
  @State isScroll: boolean = false
  @State visible: boolean = false
  scrollerForPic: Scroller = new Scroller()

  aboutToAppear() {
    this.getRoomDetails()
  }

  getRoomDetails = async () => {
    // const params = router.getParams() as IRouterRoomId
    // const result = await getRentRoomDetailApi(params.id)
    const result = await getRentRoomDetailApi('BJ1827549448671068160')
    this.roomDetail = result
    let number = 0
    this.roomNameList = result.housePicture.map((item: IHousePictureItem) => {
      const roomName: IRoomNameItem = {
        spaceName: item.spaceName,
        total: item.picList.length,
        min: number,
        max: number + item.picList.length,
      }
      number = number + item.picList.length;
      return roomName
    })
    this.roomPictureList = result.housePicture.reduce((p: string[], c) => {
      return p.concat(c.picList)
    }, [])
  }

  @Builder
  renderNavBuilder() {
    NavBar({ title: this.roomDetail.houseTitle })
  }

  @Builder
  renderContant() {
    List({ space: rvp(16) }) {
      ListItem() {
      }

      ForEach(this.roomNameList, (room: IRoomNameItem, index) => {
        ListItem() {
          Column() {
            Text(`${room.spaceName} (${room.total})`)
              .fontSize(rvp(14))
              .fontColor(this.currentRoomIndex === index ? "#262626" : "#666666")
              .onClick(() => {
                if (this.isScroll) {
                  return
                }
                this.isScroll = true
                this.currentRoomIndex = index
                const total = this.roomNameList.reduce((p, c, i) => {
                  if (i < this.currentRoomIndex) {
                    return p + c.total
                  } else {
                    return p
                  }
                }, 1)
                this.scrollerForPic.scrollToIndex(total, true, ScrollAlign.CENTER)
                setTimeout(() => {
                  this.isScroll = false
                }, 700)
              })
            if (this.currentRoomIndex === index) {
              Row().width(rvp(20)).height(rvp(2)).backgroundColor($r('app.color.primary')).margin({ top: rvp(4) })
            }
          }
        }
      }, (room: IRoomNameItem) => room.spaceName + room.total)
      ListItem() {
      }
    }
    .contentEndOffset(16)
    .width('100%')
    .height(rvp(60))
    .padding({ top: rvp(PADDING), bottom: rvp(PADDING) })
    .listDirection(Axis.Horizontal)
    .edgeEffect(EdgeEffect.None)
    .scrollBar(BarState.Off)
    .margin({ top: rvp(44) + getWindowTopHeight() })

    List({ space: rvp(16), scroller: this.scrollerForPic }) {
      ListItem() {
      }

      ForEach(this.roomPictureList, (pic: string) => {
        ListItem() {
          Image(pic).width(rvp(318)).height('100%').objectFit(ImageFit.Fill)
        }
      })
    }
    .onScrollIndex((firstIndex: number) => {
      if (this.isScroll) {
        return
      }
      this.currentRoomIndex = this.roomNameList.findIndex((item) => {
        return item.min <= firstIndex && firstIndex <= item.max
      })
    })
    .contentEndOffset(16)
    .width('100%')
    .height(rvp(208))
    .padding({ top: rvp(PADDING), bottom: rvp(PADDING) })
    .listDirection(Axis.Horizontal)
    .edgeEffect(EdgeEffect.None)
    .scrollBar(BarState.Off)

    Column() {
    }.width('100%').height(rvp(800))
  }

  build() {
    Stack() {
      ScrollContainer({
        navBuilder: () => {
          this.renderNavBuilder()
        },
        contentBuilder: () => {
          this.renderContant()
        },
        isDark: true
      })

      Row() {
        Book({ visible: $visible })
      }.width('100%').height(rvp(50)).backgroundColor(Color.Red)

      Drawer({ visible: $visible }) {
        BookInfo()
      }
    }.height('100%')
    .width('100%')
    .alignContent(Alignment.Bottom)
    .padding({ bottom: getWindowBottomHeight() })
  }
}



