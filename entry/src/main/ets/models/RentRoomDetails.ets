export interface IHousePictureItem {
  "spaceName": string,
  "picList": string[]
}

export type IHousePictureList = IHousePictureItem[]

export interface IRentRoomDetailTag {
  name: string;
}

export interface IRentRoomDetailTags {
  tags: IRentRoomDetailTag[];
}

export interface IDistanceInfo {
  "distance": string
  "line": string
  "name": string
}

export interface IRentTerm {
  "checkInTime": string
  "term": string
  "kitchen": string
  "lift": string
  "seeTime": string
  "year": string
  "renovation": string
  "grounding": string
  "heating": string
  "green": string
  "protection": string
  "house": string
}

export interface IMetaInfoItem {
  "name": string
  "desc": string
}

export type IMetaInfoList = IMetaInfoItem[]


export interface IDiscountsItem {
  "tagTxtBgAroundColor": string
  "image": string
  "txt": string
  "tagTxt": string
  "tagTxtColor": string
}

export type IDiscountsList = IDiscountsItem[]

interface IHouseholdItemItem {
  "icon": string;
  "value": string;
}

export interface IHouseholdItem {
  "name": string
  "itemList": IHouseholdItemItem[]
}

export type IHouseholdList = IHouseholdItem[]

export interface ISupportItem {
  "image": string
  "title": string
  "subTitle": string
}

export type ISupportList = ISupportItem[]

export interface IRentInfoItem {
  "image": string
  "title": string
  "userTag": string
}


export type IRentInfoList = IRentInfoItem[]

export interface IRentRoomDetail {
  houseTitle: string;
  address: string;
  rentPriceUnit: string;
  housePicture: IHousePictureList;
  tags: IRentRoomDetailTags;
  rentPriceUnitListing?: string;  // 将 rentPriceUnitListing 定义为可选
  distanceInfo?: IDistanceInfo;
  rentTerm: IRentTerm;
  metaInfo: IMetaInfoList;
  id: string;
  discounts: IDiscountsList;
  householdItem: IHouseholdList;
  support: ISupportList;
  rentInfo: IRentInfoList;
}
