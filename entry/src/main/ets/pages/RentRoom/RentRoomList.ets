import NavBar from '../../components/NavBar';
import SearchFilter from '../../views/RentRoomList/SearchFilter';
import WaterfallFlow from '../../views/RentRoomList/WaterfallFlow';

@Entry
@Component
struct RentRoomList {
  @StorageProp('topHeight') topHeight: number = 0

  build() {
    Stack() {
      WaterfallFlow()
      NavBar({ title: '租房列表' })
      SearchFilter()
    }.height('100%')
    .alignContent(Alignment.TopStart)
    .width('100%')
    .padding({ top: this.topHeight })
  }
}