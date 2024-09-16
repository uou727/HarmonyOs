import { IServiceData } from '../models/ServiceData';
import { http } from '../utils/http'

// 获取租房列表数据
export const getServiceDataApi = (): Promise<IServiceData> => {
  return http.get<IServiceData>('/service/info')
}
