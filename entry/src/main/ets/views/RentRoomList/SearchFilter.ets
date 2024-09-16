import { getCityListApi, getDistrictListApi, getProvinceListApi } from '../../api/rentRoom'
import { BORDER_RADIUS, BORDER_RADIUS_S, PADDING } from '../../constants/size'
import {
  ICityItem,
  ICityList,
  IDistrictItem,
  IDistrictList,
  IGetRentRoomListParams,
  IPaymentType,
  IProvinceItem,
  IProvinceList,
  IRentPriceItem,
  IRentPriceList,
  SEARCH_TYPE,
} from '../../models/RentRoomData'
import globalEmitter from '../../utils/emitter/emitter'
import { rvp } from '../../utils/responsive'

@Component
export default struct SearchFilter {
  @StorageProp('topHeight') topHeight: number = 0
  @State isShowSearchArea: boolean = false
  @State searchTypeList: string[] = ['地区', '租金', '付款方式', '排序']
  @State currentSearchType: number = SEARCH_TYPE.EMPTY
  @State provinceList: IProvinceList = [] // 省
  @State cityList: ICityList = [] // 市
  @State districtList: IDistrictList = [] // 区
  @State provinceCode: string = '' // 省code
  @State cityCode: string = '' // 市code
  @State districtCode: string = '' // 区code
  @State submitDistrictName: string = '' // 区名称
  @State paymentType: string[] = ["月付", "季付", "半年付", "年付"]
  @State currentPayment: IPaymentType = ''
  @State rentPriceData: IRentPriceList = [
    {
      id: 1,
      minRent: '0',
      maxRent: '0',
      text: '不限'
    },
    {
      id: 2,
      minRent: '0',
      maxRent: '1500',
      text: '1500元以下'
    },
    {
      id: 3,
      minRent: '1500',
      maxRent: '2500',
      text: '1500-2500元'
    },
    {
      id: 4,
      minRent: '2500',
      maxRent: '3500',
      text: '2500-3500元'
    },
    {
      id: 5,
      minRent: '3500',
      maxRent: '4500',
      text: '3500-4500元'
    },
    {
      id: 6,
      minRent: '4500',
      maxRent: '6000',
      text: '4500-6000元'
    },
    {
      id: 7,
      minRent: '6000',
      maxRent: '8000',
      text: '6000-8000元'
    },
    {
      id: 8,
      minRent: '8000',
      maxRent: '10000',
      text: '8000-10000元'
    },
    {
      id: 9,
      minRent: '10000',
      maxRent: '0',
      text: '10000元以上'
    }
  ]
  @State currentPriceData: Partial<IRentPriceItem> = {
    minRent: '0',
    maxRent: '0',
    text: '不限'
  }
  // 搜索条件，确认条件后修改
  @State
  submitParams: IGetRentRoomListParams = {
    page: 1,
    limit: 10,
    provinceCode: "",
    cityCode: "",
    districtCode: "",
    paymentType: ""
  }

  // 点击搜索方式打开搜索遮罩
  chooseSearchType(searchType: number) {
    if (this.currentSearchType === searchType) {
      // 还原地区搜索内容
      if (this.currentSearchType === SEARCH_TYPE.AREA) {
        this.provinceCode = this.submitParams.provinceCode!
        this.cityCode = this.submitParams.cityCode!
        this.districtCode = this.submitParams.districtCode!
      } else if (this.currentSearchType === SEARCH_TYPE.PAYMENT_METHOD) {
        this.currentPayment = this.submitParams.paymentType!
      } else if (this.currentSearchType === SEARCH_TYPE.RENT) {
        const data = this.rentPriceData.find(rentPrice => rentPrice.minRent === this.submitParams.minRent &&
          rentPrice.maxRent === this.submitParams.maxRent)!
        this.currentPriceData = data
      }
      this.hideSearchArea()
      return
    }
    this.isShowSearchArea = true
    this.currentSearchType = searchType
    if (searchType === SEARCH_TYPE.AREA) {
      // 发送请求，获取数据展示
      this.getProvinceList()
    }
  }

  // 隐藏搜索栏
  hideSearchArea() {
    this.isShowSearchArea = false
    this.currentSearchType = SEARCH_TYPE.EMPTY
  }

  // 获取省
  async getProvinceList() {
    const provinceList = await getProvinceListApi()
    this.provinceList = provinceList
    this.provinceCode = this.provinceCode ? this.provinceCode : provinceList[0].code;
    this.getCityList()
  }

  // 获取市
  async getCityList() {
    const cityList = await getCityListApi(this.provinceCode)
    this.cityList = cityList;
    this.cityCode = this.cityCode ? this.cityCode : cityList[0].code;
    this.getDistrictList()
  }

  // 获取区
  async getDistrictList() {
    const districtList = await getDistrictListApi(this.cityCode)
    this.districtList = districtList
    this.districtCode = this.districtCode ? this.districtCode : districtList[0].code;
  }

  // 地区重置
  resetPosition() {
    this.provinceCode = this.provinceList[0].code
    this.cityCode = ''
    this.districtCode = ''
    this.getProvinceList()
  }

  // 查看房源
  submitPosition() {
    // 更新搜索的省市区
    if (this.provinceCode) {
      this.submitParams.provinceCode = this.provinceCode
      this.submitParams.cityCode = this.cityCode
      this.submitParams.districtCode = this.districtCode
      this.submitDistrictName = this.districtList.find(district => district.code === this.districtCode)!.name
    }
    this.submitParams.minRent = this.currentPriceData.minRent
    this.submitParams.maxRent = this.currentPriceData.maxRent

    this.submitParams.paymentType = this.currentPayment
    this.hideSearchArea()
    const params = this.submitParams
    globalEmitter.emit('search', params)
  }

  // 地区搜索查询render
  @Builder
  locationRender() {
    Row() {
      // 省
      List() {
        ForEach(this.provinceList, (item: IProvinceItem) => {
          ListItem() {
            Row() {
              Text(item.name)
                .fontSize(rvp(12))
                .fontColor(item.code === this.provinceCode ? $r('app.color.primary') :
                $r('app.color.black'))
            }
            .width('100%')
            .padding({
              left: rvp(16),
              right: rvp(16),
              top: rvp(6),
              bottom: rvp(6)
            })
          }.onClick(() => {
            this.provinceCode = item.code
            this.cityCode = ''
            this.districtCode = ''
            this.getCityList()
          })
        }, (item: IProvinceItem) => item.code)
      }.width(rvp(120)).height('100%').backgroundColor($r('app.color.bg_gray')).scrollBar(BarState.Off)

      // 市
      List() {
        ForEach(this.cityList, (item: ICityItem) => {
          ListItem() {
            Row() {
              Text(item.name)
                .fontSize(rvp(12))
                .fontColor(item.code === this.cityCode ? $r('app.color.primary') : $r('app.color.black'))
            }
            .width('100%')
            .padding({
              left: rvp(16),
              right: rvp(16),
              top: rvp(6),
              bottom: rvp(6)
            })
          }.onClick(() => {
            this.cityCode = item.code
            this.getDistrictList()
          })
        }, (item: ICityItem) => item.code)
      }.width(rvp(120)).height('100%').backgroundColor('#EBEBEB').scrollBar(BarState.Off)

      // 区
      List() {
        ForEach(this.districtList, (item: IDistrictItem) => {
          ListItem() {
            Row() {
              Text(item.name)
                .fontSize(rvp(12))
                .fontColor(item.code === this.districtCode ? $r('app.color.primary') :
                $r('app.color.black'))
            }
            .width('100%')
            .padding({
              left: rvp(16),
              right: rvp(16),
              top: rvp(6),
              bottom: rvp(6)
            })
          }.onClick(() => {
            this.districtCode = item.code
          })
        }, (item: IDistrictItem) => item.code)
      }.width(rvp(120)).height('100%').backgroundColor('#E6E6E6').scrollBar(BarState.Off)
    }.height(rvp(240)).width('100%').backgroundColor($r('app.color.white'))

    // 按钮操作区
    Row({ space: rvp(22) }) {
      Button('重置')
        .buttonStyles(rvp(95), '#F0F0F0', $r('app.color.gray_second'))
        .onClick(() => {
          this.resetPosition()
        })
      Button('查看房源')
        .buttonStyles(rvp(211), '#67C0A8', $r('app.color.white'))
        .onClick(() => {
          this.submitPosition()
        })
    }.height(rvp(58)).width('100%').backgroundColor($r('app.color.white')).justifyContent(FlexAlign.Center)
  }

  @Builder
  rentPriceRender() {
    Grid() {
      ForEach(this.rentPriceData, (item: IRentPriceItem) => {
        GridItem() {
          Text(item.text).textStyles(item.text === this.currentPriceData.text, 94)
            .onClick(() => {
              this.currentPriceData = item
            })
        }
      }, (item: IRentPriceItem) => item.id + '')
    }
    .width('100%')
    .padding(rvp(PADDING))
    .columnsTemplate('1fr 1fr 1fr')
    .rowsGap(rvp(8))
    .height(140)


    // 按钮操作区
    Row({ space: rvp(22) }) {
      Button('重置')
        .buttonStyles(rvp(95), '#F0F0F0', $r('app.color.gray_second'))
        .onClick(() => {
          this.currentPriceData = {
            minRent: '0',
            maxRent: '0',
            text: '不限'
          }
        })
      Button('查看房源')
        .buttonStyles(rvp(211), '#67C0A8', $r('app.color.white'))
        .onClick(() => {
          this.submitPosition()
        })
    }.height(rvp(58)).width('100%').backgroundColor($r('app.color.white')).justifyContent(FlexAlign.Center)
  }

  @Builder
  paymentTypeRender() {
    Row() {
      ForEach(this.paymentType, (val: IPaymentType) => {
        Text(val)
          .textStyles(this.currentPayment === val, 70)
          .onClick(() => {
            this.currentPayment = val
          })
      }, (val: string) => val)
    }.width('100%').justifyContent(FlexAlign.SpaceBetween).padding(rvp(PADDING))

    // 按钮操作区
    Row({ space: rvp(22) }) {
      Button('重置')
        .buttonStyles(rvp(95), '#F0F0F0', $r('app.color.gray_second'))
        .onClick(() => {
          this.currentPayment = ''
        })
      Button('查看房源')
        .buttonStyles(rvp(211), '#67C0A8', $r('app.color.white'))
        .onClick(() => {
          this.submitPosition()
        })
    }.height(rvp(58)).width('100%').backgroundColor($r('app.color.white')).justifyContent(FlexAlign.Center)
  }

  @Builder
  sortRender() {
    Text('排序')
  }

  getSearchText(index: number) {
    if (index === SEARCH_TYPE.AREA) {
      return this.submitDistrictName || this.searchTypeList[index]
    } else if (index === SEARCH_TYPE.PAYMENT_METHOD) {
      return this.submitParams.paymentType || this.searchTypeList[index]
    } else {
      return this.searchTypeList[index]
    }
  }

  build() {
    Column() {
      Row() {
        ForEach(this.searchTypeList, (val: string, index) => {
          Row({ space: 3 }) {
            Text(this.getSearchText(index))
              .fontSize(rvp(14))
              .fontWeight(500)
              .constraintSize({ maxWidth: rvp(56) })
              .maxLines(1)
              .textOverflow({ overflow: TextOverflow.Ellipsis })
            Image(this.currentSearchType === index ? $r('app.media.arrow_down_3_active') :
            $r('app.media.arrow_down_3'))
              .width(rvp(6))
              .height(rvp(4))
              .fillColor($r('app.color.black'))
          }.onClick(() => {
            this.chooseSearchType(index)
          })
        }, (val: string) => val)
      }.width('100%').justifyContent(FlexAlign.SpaceBetween).padding({ left: PADDING, right: PADDING })

      if (this.isShowSearchArea) {
        Column() {
          if (this.currentSearchType === SEARCH_TYPE.AREA) {
            this.locationRender()
          }
          if (this.currentSearchType === SEARCH_TYPE.RENT) {
            this.rentPriceRender()
          }
          if (this.currentSearchType === SEARCH_TYPE.PAYMENT_METHOD) {
            this.paymentTypeRender()
          }
          if (this.currentSearchType === SEARCH_TYPE.SORT) {
            this.sortRender()
          }
        }.width('100%').backgroundColor($r('app.color.white'))

        // 遮罩
        Column() {
        }.width('100%').layoutWeight(1).backgroundColor('rgba(0, 0, 0, 0.7)')
      }
    }.width('100%').height(this.isShowSearchArea ? '100%' : rvp(44)).margin({ top: this.topHeight + rvp(44) })
  }
}

@Extend(Button)
function buttonStyles(width: number, bgColor: string | Resource, fontColor: string | Resource) {
  .type(ButtonType.Normal)
  .width(width)
  .height(rvp(26))
  .borderRadius(rvp(BORDER_RADIUS_S))
  .fontSize(rvp(12))
  .backgroundColor(bgColor)
  .fontColor(fontColor)
}

@Extend(Text)
function textStyles(isActive: boolean, width: number) {
  .width(rvp(width))
  .height(rvp(26))
  .borderRadius(BORDER_RADIUS)
  .backgroundColor(isActive ? '#67C0A8' : $r('app.color.bg_gray'))
  .fontSize(rvp(12))
  .fontColor(isActive ? Color.White : '#666666')
  .textAlign(TextAlign.Center)
}