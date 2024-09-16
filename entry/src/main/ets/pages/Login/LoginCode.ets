import { router } from '@kit.ArkUI';
import { getUserInfoApi, loginApi, sendSMSCodeApi } from '../../api/user';
import NavBar from '../../components/NavBar';
import { rvp } from '../../utils/responsive';
import showToast from '../../utils/showToast/showToast';


interface IParams {
  phone: string
}

@Entry
@Component
struct LoginCode {
  @StorageProp('topHeight') topHeight: number = 0
  @State phone: string = ''
  @State isSendCode: boolean = false
  @State time: number = 10;
  @State timeId: number = 0
  @State loginCode: string = ''
  @StorageLink('token') token: string = ''
  goLogin = async () => {
    const userData = await loginApi(this.phone, this.loginCode)
    this.token = userData.token

    const userInfo = await getUserInfoApi()
    AppStorage.setOrCreate('userInfo', userInfo)
    router.back({ url: 'pages/Index' })
  }

  aboutToAppear(): void {
    const params = router.getParams() as IParams
    this.phone = params.phone
    this.handleSendCode()
    this.startCountDown()
  }

  // 倒计时
  startCountDown() {
    this.time--
    this.timeId = setInterval(() => {
      this.time--
      if (this.time <= 0) {
        this.time = 60
        clearInterval(this.timeId)
        this.isSendCode = true
      }
    }, 1000)
  }

  handleSendCode = async () => {
    const code = await sendSMSCodeApi(this.phone)
    this.loginCode = code + ''
    showToast(code + '')
  }

  @Builder
  LoginPhoneForm() {
    Column() {
      Stack() {
        TextInput({ placeholder: '请输入验证码', text: this.loginCode }).inputStyles().onChange((val) => {
          this.loginCode = val
        })
        if (!this.isSendCode) {
          Text(this.time + '').fontSize(rvp(16)).fontColor($r('app.color.primary'))
        } else {
          Text('重新发送').fontSize(rvp(16)).fontColor($r('app.color.primary')).onClick(() => this.handleSendCode())
        }
      }.alignContent(Alignment.End)

      Divider().color('#C4EDCE')


      Button('确认')
        .onClick(() => this.goLogin())
        .stateEffect(this.loginCode.length === 6)
        .margin({ top: rvp(40) })
        .backgroundColor(this.loginCode.length === 6 ? $r('app.color.primary') : '#F0F0F0')
        .fontColor(this.loginCode.length === 6 ? $r('app.color.white') : '#C1C1C1')
        .fontSize(rvp(12))
        .width(rvp(100))
        .height(rvp(40))
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
  .maxLength(6)
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