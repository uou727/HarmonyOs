// // import { AMap, MapsInitializer, MapView, MapViewComponent, MapViewManager } from '@amap/amap_lbs_map3d';
// import { common } from '@kit.AbilityKit';
//
// // MapsInitializer.setApiKey("630451fe08f0c8ee8433f4b0cba6fc9f");
//
// interface GeneratedObjectLiteralInterface_1 {
//   deviceId: string;
//   bundleName: string;
//   moduleName: string;
//   abilityName: string;
// }
//
// @Component
// export default struct Discover {
//   private context = getContext(this) as common.UIAbilityContext
//
//   build() {
//     Column() {
//       Text('主模块')
//         .fontSize(50)
//         .fontWeight(FontWeight.Bold)
//       Blank()
//       Button('启动扩展模块').onClick((event: ClickEvent) => {
//         let wantInfo: GeneratedObjectLiteralInterface_1 = {
//           deviceId: '', // 设备id  为空则表示本设备
//           bundleName: "com.anlin.rentroom", // 包名
//           moduleName: 'feat', // moduleName 非必填
//           abilityName: 'FeatAbility'  // 启动ability名称
//         }
//         this.context.startAbility(wantInfo)
//       })
//     }.height('100%')
//     .width('100%')
//   }
// }


import ImageUploadDialog from '../components/ImageUploadDialog/ImageUploadDialog'
import { promptAction } from '@kit.ArkUI'

@Component
export default struct Discover {
  @State dialogController: CustomDialogController | null = null //选择上传类型弹窗控制器

  aboutToAppear(): void {
    this.dialogController = new CustomDialogController({
      builder: ImageUploadDialog({
        uploadURL: 'http://xxxxxxxxx', //上传地址
        success: e => { //上传成功回调，e上传成功接口返回数据
          let res = JSON.parse(e.body) as object //接口上传成功返回数据
          console.log(JSON.stringify(res), '上传成功')
          //根据实际接口返回字段获取图片url
          //url=res['data']
        },
        fail: e => { //上传失败回调
          console.log(JSON.stringify(e))
          promptAction.showToast({ message: '上传失败' })
        },
        complete: e => { //上传完成回调
          console.log(JSON.stringify(e), 'complete')
        }
      }),
      alignment: DialogAlignment.Bottom, //弹窗居于底部
      customStyle: true, //自定义样式
    })
  }

  build() {
    Column() {
      Button('上传').onClick(() => {
        this.dialogController?.open()
      })

    }.width('100%')
  }
}

