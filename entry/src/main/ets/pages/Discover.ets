// import { AMap, MapsInitializer, MapView, MapViewComponent, MapViewManager } from '@amap/amap_lbs_map3d';
import { common } from '@kit.AbilityKit';

// MapsInitializer.setApiKey("630451fe08f0c8ee8433f4b0cba6fc9f");

interface GeneratedObjectLiteralInterface_1 {
  deviceId: string;
  bundleName: string;
  moduleName: string;
  abilityName: string;
}

@Component
export default struct Discover {
  private context = getContext(this) as common.UIAbilityContext

  build() {
    Column() {
      Text('主模块')
        .fontSize(50)
        .fontWeight(FontWeight.Bold)
      Blank()
      Button('启动扩展模块').onClick((event: ClickEvent) => {
        let wantInfo: GeneratedObjectLiteralInterface_1 = {
          deviceId: '', // 设备id  为空则表示本设备
          bundleName: "com.anlin.rentroom", // 包名
          moduleName: 'feat', // moduleName 非必填
          abilityName: 'FeatAbility'  // 启动ability名称
        }
        this.context.startAbility(wantInfo)
      })
    }.height('100%')
    .width('100%')
  }
}

