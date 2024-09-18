import { copyFileToCache } from '../../utils/phone/phone'
import { request } from '@kit.BasicServicesKit';
import camera from '@ohos.multimedia.camera';
import camerapicker from '@ohos.multimedia.cameraPicker';
import { BusinessError } from '@ohos.base';
import { common } from '@kit.AbilityKit';
import { photoAccessHelper } from '@kit.MediaLibraryKit';

//上传回调数据类型
interface ReceiveRes {
  body: string
  headers: object
}


@Extend(Text)
function custText() {
  .width('100%')
  .height('48')
  .fontColor('#39364D')
  .textAlign(TextAlign.Center)
}

@CustomDialog
export default struct ImageUploadDialog {
  dialogController: CustomDialogController
  @Prop uploadURL: string = ''; //上传接口地址
  private context = getContext(this) as common.UIAbilityContext; //UIAbilityContext
  private success: (res: ReceiveRes) => void = () => {
  } //上传成功回调
  private fail: (res: request.TaskState[]) => void = () => {
  } //上传失败回调
  private complete: (res: request.TaskState[]) => void = () => {
  } //上传完成回调

  //开始上传图片 path：图片路径后缀（图片名称）
  async uploadImage(path: string) {
    let uri = `internal://cache/${path}` //上传图片全路径
    let uploadConfig: request.UploadConfig = {
      url: this.uploadURL,
      header: {},
      method: "POST",
      files: [{
        filename: path,
        name: "file",
        uri,
        type: path.split('.')[path.split('.').length-1]
      }],
      data: [],
    };
    try {
      let uploadTask: request.UploadTask = await request.uploadFile(this.context, uploadConfig)
      //上传中回调
      uploadTask.on('progress', (size, total) => {
        console.log(size.toString(), total.toString(), '上传进度')
      })

      //每上传一张图片成功回调
      uploadTask.on('headerReceive', (data: object) => {
        let res = data as ReceiveRes
        this.success && this.success(res)
      })

      //所有上传完成回调
      uploadTask.on('complete', (taskStates: request.TaskState[]) => {
        console.info("upOnComplete complete taskState:" + JSON.stringify(taskStates));
        this.complete && this.complete(taskStates)
      })
      //上传失败回调
      uploadTask.on('fail', (taskStates: request.TaskState[]) => {
        console.info("upOnComplete fail taskState:" + JSON.stringify(taskStates));
        this.fail && this.fail(taskStates)
      })
    } catch (e) {
      console.log(JSON.stringify(e), 'e')
    }

  }

  build() {
    Column() {
      //拍照
      Text('拍照').custText().onClick(async () => {

        try {
          let pickerProfile: camerapicker.PickerProfile = {
            cameraPosition: camera.CameraPosition.CAMERA_POSITION_BACK
          };
          let pickerResult: camerapicker.PickerResult = await camerapicker.pick(this.context,
            [camerapicker.PickerMediaType.PHOTO, camerapicker.PickerMediaType.PHOTO], pickerProfile);
          if (pickerResult?.resultUri) {
            //关闭弹窗
            this.dialogController.close()
            //复制图片到缓存目录（缓存目录才有读写权限）
            let filePath = await copyFileToCache(pickerResult.resultUri, this.context)
            if (filePath) {
              //上传头像并设置
              this.uploadImage(filePath)
            }

          }
        } catch (error) {
          let err = error as BusinessError;
          console.error(`the pick call failed. error code: ${err.code}`);
        }

      })
      Divider().color('#F7F9FA').width('100%').strokeWidth(1)
      //从手机相册选择
      Text('从手机相册选择').custText().onClick(async () => {
        const photoSelectOptions = new photoAccessHelper.PhotoSelectOptions();
        photoSelectOptions.MIMEType = photoAccessHelper.PhotoViewMIMETypes.IMAGE_TYPE; // 过滤选择媒体文件类型为IMAGE
        photoSelectOptions.maxSelectNumber = 1; // 选择媒体文件的最大数目
        const photoViewPicker = new photoAccessHelper.PhotoViewPicker();
        photoViewPicker.select(photoSelectOptions)
          .then(async (photoSelectResult: photoAccessHelper.PhotoSelectResult) => {
            if (photoSelectResult.photoUris.length) {
              //复制图片到缓存目录（缓存目录才有读写权限）
              let filePath = await copyFileToCache(photoSelectResult.photoUris[0], this.context)
              if (filePath) {
                this.uploadImage(filePath)
              }
            }
          })
          .catch((err: BusinessError) => {

          })
      })
      Button('取消', { type: ButtonType.Capsule })
        .backgroundColor('#F7F7F7')
        .fontSize('16fp')
        .fontColor('#333333')
        .width('100%')
        .margin({ top: '30' })
        .onClick(() => {
          this.dialogController.close()
        })
    }
    .width('100%')
    .padding({
      left: '16',
      top: '11',
      right: '16',
      bottom: '16'
    })
    .backgroundColor(Color.White)
    .borderRadius({
      topLeft: '24',
      topRight: '24'
    })
  }
}

