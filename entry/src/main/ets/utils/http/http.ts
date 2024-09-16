import axios from '@ohos/axios'
import { http } from '@kit.NetworkKit'
import { promptAction } from '@kit.ArkUI'
import { AnyObject } from '../../models/HttpModels'

const request = axios.create({
  baseURL: 'http://192.168.31.74:6060'
})

request.interceptors.request.use(
  (config) => {
    const token = AppStorage.get('token') as string;
    if (token) {
      config.headers.token = token;
    }
    return config
  }
)

request.interceptors.response.use(
  (response) => {
    if (response.data.code === 200) {
      return response.data.data
    } else {
      return Promise.reject(response.data.message)
    }
  },
  (err) => {
    promptAction.showToast({ message: err.message })
    return Promise.reject(err.message)
  }
)

export default class Http {
  get<T>(url: string, params?: AnyObject) {
    return request.get<any, T>(url, {
      params
    })
  }

  post<T>(url: string, data?: AnyObject) {
    return request.post<any, T>(url, data)
  }

  put<T>(url: string, data?: AnyObject) {
    return request.put<any, T>(url, data)
  }

  delete<T>(url: string, params?: AnyObject) {
    return request.delete<any, T>(url, {
      params
    })
  }
}