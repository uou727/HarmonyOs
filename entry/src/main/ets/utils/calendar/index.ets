export function getCalendar() {
  const date = new Date()
  const currentMonth = date.getMonth() + 1

  return [
    aclcLastMonth(currentMonth, 2),
    aclcLastMonth(currentMonth, 1),
    currentMonth,
    aclcNextMonth(currentMonth, 1),
    aclcNextMonth(currentMonth, 2),
    aclcNextMonth(currentMonth, 3),
  ].map((val: number): string => addZero(val))
}

// 计算之前的月份
function aclcLastMonth(currenMonth: number, num: number) {
  const val = currenMonth - num
  return val < 1 ? 12 + val : val
}

function aclcNextMonth(currenMonth: number, num: number) {
  const val = currenMonth + num
  return val > 12 ? val - 12 : val
}

function addZero(val: number) {
  return val < 10 ? '0' + val : val + ''
}