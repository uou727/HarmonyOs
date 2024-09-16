import NavBar from '../../components/NavBar'
import { rvp } from '../../utils/responsive'
import showToast from '../../utils/showToast/showToast'
import { router } from '@kit.ArkUI'

@Entry
@Component
struct LoginPhone {
  @StorageProp('topHeight') topHeight: number = 0
  @State phone: string = ''
  @State isValidPhone: boolean = false
  @State isAgree: boolean = false
  phoneReg = /^1[3-9][0-9]{9}$/
  goLoginCode = () => {
    if (!this.isAgree) {
      return;
    }
    if (!this.isValidPhone) {
      showToast('手机号不符合格式')
      return;
    }
    // 验证码在下一个页面发送
    router.pushUrl({ url: 'pages/Login/LoginCode', params: { phone: this.phone } })
  }

  @Builder
  LoginPhoneForm() {
    Column() {
      Stack() {
        TextInput({ placeholder: '请输入手机号' }).inputStyles().onChange((val) => {
          this.phone = val
          if (val.length === 11 && this.phoneReg.test(val)) {
            this.isValidPhone = true
          } else {
            this.isValidPhone = false
          }
        })
        if (this.isValidPhone) {
          Image($r('app.media.success')).width(rvp(12)).height(rvp(8)).margin({ right: rvp(5) })
        }
      }.alignContent(Alignment.End)

      Divider().color('#C4EDCE')
      Row() {
        // Image($r('app.media.radio')).width(rvp(14)).height(rvp(14))
        Radio({
          value: 'phone',
          group: ''
        })
          .checked(this.isAgree)
          .onClick(() => {
            this.isAgree = !this.isAgree
          })
          .radioStyle({
            checkedBackgroundColor: $r('app.color.primary')
          })
          .width(rvp(14))
          .height(rvp(14))
        Text() {
          Span('同意').fontSize(rvp(12)).fontColor('#C1C1C1')
          Span('《用户协议》').fontSize(rvp(12)).fontColor($r('app.color.primary'))
          Span('和').fontSize(rvp(12)).fontColor('#C1C1C1')
          Span('《隐私政策》').fontSize(rvp(12)).fontColor($r('app.color.primary'))
        }.margin({ left: rvp(6) })
      }.margin({ top: rvp(16) }).width('100%')

      Button('获取验证码')
        .onClick(() => this.goLoginCode())
        .stateEffect(this.isAgree && this.isValidPhone)
        .margin({ top: rvp(40) })
        .backgroundColor(this.isAgree && this.isValidPhone ? $r('app.color.primary') : '#F0F0F0')
        .fontColor(this.isAgree && this.isValidPhone ? $r('app.color.white') : '#C1C1C1')
        .fontSize(rvp(12))
        .padding({
          top: rvp(12),
          bottom: rvp(12),
          left: rvp(15),
          right: rvp(15)
        })
    }.margin({ top: rvp(47) }).padding({ left: rvp(37), right: rvp(37) }).alignItems(HorizontalAlign.End)
  }

  build() {
    Column() {
      NavBar({ title: '验证码登录' })
      this.LoginPhoneForm()
    }
    .padding({ top: this.topHeight })
    .width('100%').height('100%').linearGradient({
      angle: 180,
      colors: [
        ['#DEFBE5', 0],
        ['#ffffff', 0.3],
        ['#ffffff', 1],
      ]
    })
  }
}

@Styles
function pressedStyles() {
  // 无法实现点击时，完全透明
  .backgroundColor('rgba(255, 255, 255, 0)')
  .borderRadius(0)
}

@Extend(TextInput)
function inputStyles() {
  .padding({
    left: 0,
    right: 0,
    top: 0,
    bottom: rvp(8)
  })
  .backgroundColor(Color.Transparent)
  .placeholderColor('#C1C1C1')
  .placeholderFont({ size: rvp(16) })
  .caretColor('#C1C1C1')
  .type(InputType.PhoneNumber)
  .maxLength(11)
  .stateStyles({
    pressed: pressedStyles,
    clicked: pressedStyles
  })
  .border({
    width: { bottom: 1 },
    color: '#C4EDCE'
  })
  .borderRadius(0)
}