import fs from '@ohos.file.fs';
import { Context } from '@ohos.abilityAccessCtrl';


/**
 * 复制文件到缓存目录下
 * @param path :文件路径
 * @param context :Context
 * @returns Promise<string> 移动后文件路径
 */
export async function copyFileToCache(path: string, context: Context): Promise<string> {
  try {

    let file = fs.openSync(path, fs.OpenMode.READ_ONLY) //只读
    if (file) {
      let fileDir: string = `${context.cacheDir}` //临时文件目录
      //时间戳生成随机文件名
      let newPath: string = `${new Date().getTime()}_${path.split("/")[path.split("/").length-1]}`
      let targetPath: string = `${fileDir}/${newPath}`
      fs.copyFileSync(file.fd, targetPath)
      return newPath
    } else {
      return ''
    }

  } catch (e) {
    return Promise.resolve('')
  }
}



