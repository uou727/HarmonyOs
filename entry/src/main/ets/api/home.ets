import { IHomeData } from '../models/HomeData';
import { IRoomRecommendList } from '../models/RoomRecommendDataSource';
import { http } from '../utils/http'

// 首页数据
export const getHomeDataApi = (): Promise<IHomeData> => {
  return http.get<IHomeData>('/home/info');
}

// 获取首页周边房源数据
export const getRoomRecommendListApi = (): Promise<IRoomRecommendList> => {
  return http.get<IRoomRecommendList>('/house/nearbyHouses')
}