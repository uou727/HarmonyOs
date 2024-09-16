import { rvp } from '../../utils/responsive'
import { BusinessError } from '@kit.BasicServicesKit';
import { calendarMgr } from '../../entryability/EntryAbility'
import { calendarManager } from '@kit.CalendarKit';
import call from '@ohos.telephony.call';

const calendarAccount: calendarManager.CalendarAccount = {
  name: 'CreateMyCalendarByPromise',
  type: calendarManager.CalendarType.LOCAL,
  displayName: 'MyApplication'
};

@Component
export default struct Book {
  @Link visible: boolean
  @State calendar: calendarManager.Calendar | undefined = undefined;

  build() {
    Row() {
      Column({ space: rvp(4) }) {
        Image($r('app.media.my_icon_1')).width(rvp(18))
        Text('99+').fontSize(rvp(10)).fontColor($r('app.color.garry'))
      }

      Column({ space: rvp(4) }) {
        Image($r('app.media.message')).width(rvp(18)).fillColor($r('app.color.black'))
        Text('咨询').fontSize(rvp(10)).fontColor($r('app.color.garry'))
      }

      Button('立即预定', { type: ButtonType.Normal })
        .borderRadius(rvp(2))
        .backgroundColor('#24A17B')
        .padding({ left: rvp(30), right: rvp(30) })
        .height(rvp(34))
        .onClick(() => {
          this.visible = true
        })
      Button('去看房', { type: ButtonType.Normal })
        .borderRadius(rvp(2))
        .backgroundColor('#6BE3BE')
        .padding({ left: rvp(30), right: rvp(30) })
        .height(rvp(34))// .onClick(() => {
          //   calendarMgr?.createCalendar(calendarAccount).then((data: calendarManager.Calendar) => {
          //     console.info(`Succeeded in creating calendar data->${JSON.stringify(data)}`);
          //     this.calendar = data;
          //   }).catch((error: BusinessError) => {
          //     console.error(`Failed to create calendar. Code: ${error.code}, message: ${error.message}`);
          //   });
          // })
        .onClick(() => {
          // 续跳转到拨号界面，并显示拨号的号码
          call.makeCall("13712341234", (err) => {
            if (!err) {
              console.log("make call success.");
            } else {
              console.log("make call fail, err is:" + JSON.stringify(err));
            }
          });
        })
    }.backgroundColor($r('app.color.white')).height(rvp(50)).justifyContent(FlexAlign.SpaceEvenly).width('100%')
  }
}