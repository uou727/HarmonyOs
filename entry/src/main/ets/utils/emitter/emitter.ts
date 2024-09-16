type ICallback = (arg: any) => any
type ICallbacks = ICallback[]

interface IEvent {
  [key: string]: ICallbacks
}

function createEmitter() {
  /*
   * 存储自定义事件容器
   * 容器结构:
   *    {
   *      事件名称： [ 回调函数1，回调函数2，回调函数3 ]
   *    }
   * */
  const callback = []
  const events = []
  return {
    /*
     * 绑定事件
     * eventName: 事件名称
     * callback：自定义事件回调函数
     * */
    on(eventName: string, callback: ICallback) {
      if (events[eventName]) {
        events[eventName].push(callback)
      } else {
        events[eventName] = [callback]
      }
    },
    // 解绑事件
    off(eventName: string, callback: ICallback) {
      const callbacks = events[eventName]
      if (!callbacks) {
        return
      }
      if (callbacks) {
        events[eventName] = callbacks.filter(cb => cb !== callback)
      } else {
        delete events[eventName]
      }
    },
    // 触发事件
    emit(eventName: string, arg?: unknown) {
      const callBacks = events[eventName]
      if (!callBacks) {
        return
      }
      callBacks.forEach(cb => cb(arg))
    }
  }
}

const globalEmitter = createEmitter()

export default globalEmitter