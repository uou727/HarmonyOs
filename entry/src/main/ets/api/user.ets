import { IServiceData } from '../models/ServiceData';
import { ILogin, IUserInfo } from '../models/User';
import { http } from '../utils/http'

// 发送验证码
export const sendSMSCodeApi = (phone: string): Promise<null> => {
  return http.post<null>('/sendSMSCode', { phone })
}

// 登录
export const loginApi = (phone: string, code: string): Promise<ILogin> => {
  return http.post<ILogin>('/login', { phone, code })
}

// 获取用户数据
export const getUserInfoApi = (): Promise<IUserInfo> => {
  return http.get<IUserInfo>('/auth/user/userInfo')
}