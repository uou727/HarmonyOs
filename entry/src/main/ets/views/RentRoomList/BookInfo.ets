import { BORDER_RADIUS, BORDER_RADIUS_S, PADDING } from '../../constants/size'
import createDateList, { IDateItem, IDateList } from '../../utils/createDateList/createDateList'
import { rvp } from '../../utils/responsive'

@Component
export default struct BookInfo {
  @State dateList: IDateList = createDateList()
  @State currentDateIndex: number = 0
  @State isCollapseDateList: boolean = true

  build() {
    Column() {
      Text('预约信息').fontSize(rvp(18)).fontWeight(700).fontColor(Color.Black)
      Column({ space: rvp(20) }) {
        Row({ space: rvp(16) }) {
          Text('姓名').fontColor(Color.Black).fontSize(rvp(14)).fontWeight(700).width(rvp(56))
          TextInput({ placeholder: '请输入姓名' }).textInputStyles()
        }.width('100%')

        Row({ space: rvp(16) }) {
          Text('手机号').fontColor(Color.Black).fontSize(rvp(14)).fontWeight(700).width(rvp(56))
          TextInput({ placeholder: '请输入手机号' }).type(InputType.PhoneNumber).maxLength(11).textInputStyles()
        }.width('100%')

        Row({ space: rvp(16) }) {
          Text('预约日期').fontColor(Color.Black).fontSize(rvp(14)).fontWeight(700).width(rvp(56))
          Column({ space: rvp(20) }) {
            Row() {
              Text(`${this.dateList[this.currentDateIndex].date}（${this.dateList[this.currentDateIndex].week}）`)
                .fontSize(rvp(14))
                .fontColor($r('app.color.garry'))
                .onClick(() => {
                  this.isCollapseDateList = !this.isCollapseDateList
                })
              Image($r('app.media.arrow_down_2')).width(rvp(10)).fillColor($r('app.color.garry'))
            }.width('100%').justifyContent(FlexAlign.SpaceBetween)

            if (this.isCollapseDateList) {
              Grid() {
                ForEach(this.dateList, (date: IDateItem, index) => {
                  GridItem() {
                    Column() {
                      Text(date.week)
                        .fontSize(rvp(10))
                        .fontColor(this.currentDateIndex === index ? '#24A17B' : '#999999')
                      Text(date.date)
                        .fontSize(rvp(10))
                        .fontColor(this.currentDateIndex === index ? '#24A17B' : '#999999')
                    }
                  }
                  .onClick(() => {
                    this.currentDateIndex = index
                  })
                  .border({
                    color: this.currentDateIndex === index ?
                      '#24A17B' : '#999999',
                    width: rvp(1),
                    radius: rvp(4)
                  })
                }, (date: IDateItem) => date.date + date.week)
              }.columnsTemplate('1fr 1fr 1fr').height(rvp(3 * 32 + 8)).columnsGap(rvp(6)).rowsGap(rvp(8))
            }
          }.layoutWeight(1)
        }.width('100%').alignItems(VerticalAlign.Top)

        Row({ space: rvp(16) }) {
          Text('备注信息').fontColor(Color.Black).fontSize(rvp(14)).fontWeight(700).width(rvp(56))
          TextArea({ placeholder: '请输入备注信息' }).textAreaStyles()
        }.width('100%')

      }
      .alignItems(HorizontalAlign.Start)
      .width('100%')
      .padding(rvp(PADDING))
      .margin({ top: rvp(PADDING) })
      .backgroundColor(Color.White)

      Button('预约看房')
        .type(ButtonType.Normal)
        .width('100%')
        .backgroundColor('#24A17B')
        .fontSize(rvp(14))
        .margin({ top: rvp(16) })
    }.width('100%').alignItems(HorizontalAlign.Start).borderRadius(rvp(8))
  }
}


@Extend(TextInput)
function textInputStyles() {
  .layoutWeight(1)
  .backgroundColor(Color.Transparent)
  .placeholderColor($r('app.color.garry'))
  .placeholderFont({ size: rvp(14) })
  .caretColor($r('app.color.garry'))
  .fontSize(rvp(14))
  .borderRadius(rvp(BORDER_RADIUS_S))
  .padding(0)
}

@Extend(TextArea)
function textAreaStyles() {
  .layoutWeight(1)
  .backgroundColor('#F6F6F6')
  .placeholderColor($r('app.color.garry'))
  .placeholderFont({ size: rvp(14) })
  .caretColor($r('app.color.garry'))
  .fontSize(rvp(14))
  .borderRadius(rvp(BORDER_RADIUS))
  .padding(rvp(10))
  .height(rvp(60))
}