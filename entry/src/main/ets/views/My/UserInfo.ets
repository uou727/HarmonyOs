import { PADDING } from '../../constants/size';
import { rvp } from '../../utils/responsive';
import { router } from '@kit.ArkUI';
import { IUserInfo } from '../../models/User';
import { getUserInfoApi } from '../../api/user';

@Component
export default struct UserInfo {
  @StorageProp('topHeight') topHeight: number = 0
  @StorageProp('token') token: number = 0
  @StorageProp('userInfo') userData: IUserInfo = {
    id: 0,
    nickname: "",
    avatar: ""
  }

  aboutToAppear(): void {
    console.log('userInfo', JSON.stringify(this.userData))
    console.log('token', JSON.stringify(this.token))
    if (this.userData.nickname || !this.token) {
      return
    }
    this.getUserInfo()
  }

  getUserInfo = async () => {
    console.log('user')
    const user = await getUserInfoApi()
    AppStorage.setOrCreate('userInfo', user)

  }

  build() {
    Column() {
      Row({ space: rvp(10) }) {
        Image(this?.userData?.avatar ? this.userData.avatar : $r('app.media.profilePicture'))
          .width(rvp(60))
          .height(rvp(60))
        if (this.userData.nickname) {
          Column({ space: rvp(4) }) {
            Text(this.userData.nickname).fontSize(rvp(16)).fontColor(Color.White)
            Text('谷粒点15').fontSize(rvp(12)).fontColor(Color.White)
          }.alignItems(HorizontalAlign.Start).layoutWeight(1)
        } else {
          Text('请登录').fontSize(rvp(16)).fontColor(Color.White)
        }
      }.width('100%')
      .onClick(() => {
        console.log('登录 退出')
        if (this.userData.nickname) {
          return
        }
        router.pushUrl({
          url: 'pages/Login/LoginPhone'
        })
      })
    }
    .width('100%')
    .height(rvp(71))
    .margin({ top: rvp(44) + this.topHeight })
    .padding({ top: rvp(11), left: rvp(PADDING), right: rvp(PADDING) })
  }
}