export interface ITagItem {
  "name": string
}

export type ITagList = ITagItem[]


export interface IRoomRecommendItem {
  "id": string
  "housePicture": string
  "tags": ITagList
  "houseTitle": string
  "address": string
  "rentArea": string
  "rentPriceUnit": string
  "rentPriceListing": string
}


export type IRoomRecommendList = IRoomRecommendItem[]


@Observed
export class RoomRecommendDataSource implements IDataSource {
  roomRecommendDataList: IRoomRecommendList = []
  listeners: DataChangeListener[] = []

  // 实现了 IDatatSource接口
  // 接口要求必须定义四个方法 getData、totalCOunt、registerDataChangeListener、unregisterDataChangeListener
  // 读取对应下标的数据
  getData(index: number): IRoomRecommendItem {
    return this.roomRecommendDataList[index]
  }

  // 返回数据总长度
  totalCount(): number {
    return this.roomRecommendDataList.length
  }

  // 保存单个数据
  setData(item: IRoomRecommendItem) {
    // 只会更新数据不会更新UI
    this.roomRecommendDataList.push(item)
    // 调用官方提供的方法更新UI
    this.notifyDataAdd(this.roomRecommendDataList.length - 1)
  }

  // 更新所有的数据
  setList(list: IRoomRecommendList) {
    // 只会更新数据不会更新UI
    this.roomRecommendDataList = list
    // 调用官方提供的方法更新UI
    this.notifyDataReload()
  }

  // 该方法为框架侧调用，为LazyForEach组件向其数据源处添加listener监听
  registerDataChangeListener(listener: DataChangeListener): void {
    if (this.listeners.indexOf(listener) < 0) {
      console.info('add listener');
      this.listeners.push(listener);
    }
  }

  // 该方法为框架侧调用，为对应的LazyForEach组件在数据源处去除listener监听
  unregisterDataChangeListener(listener: DataChangeListener): void {
    const pos = this.listeners.indexOf(listener);
    if (pos >= 0) {
      console.info('remove listener');
      this.listeners.splice(pos, 1);
    }
  }

  // 通知LazyForEach组件需要重载所有子组件
  notifyDataReload(): void {
    this.listeners.forEach(listener => {
      listener.onDataReloaded();
    })
  }

  // 通知LazyForEach组件需要在index对应索引处添加子组件
  notifyDataAdd(index: number): void {
    this.listeners.forEach(listener => {
      listener.onDataAdd(index);
    })
  }
}