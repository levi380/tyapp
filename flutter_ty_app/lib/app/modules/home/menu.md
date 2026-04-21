1. 导航

- 什么时候现实收藏
- 什么时候显示全部
- 什么时候显示电竞VR体育，电竞VR体育的位置
- 最后一个娱乐为什么不显示 匹配 id 匹配到的时候显示
- 联赛id跟列表传参id怎么对应

先去 全部联赛列表里面找到对应的联赛的 tid，然后在去拉接口。（热门联赛）

热门：

- 中 英 繁体。

列表：

0. mmp ms = 1 110 才匹配（已开赛的）其他直接显示时间。

1. 列表怎么分组的
2. 比分怎么展示的（滚球展示,）
2. 新手版的怎么展示的 (只显示赌赢的)

3. 联赛名称 后面 红色1（红黄牌，

4. flag 展示规则
5. 角球等等

```agsl
import { i18n_t } from "src/boot/i18n.js";
export const play_title = (title = 'coming song') => {
  return [
    { // 角球
      title: i18n_t('football_playing_way.corner'),
      id:1,
      unfold:0,
      show_tab:false,
      hps:[{
        hl:[{}]
      }],
      pids:'-111,113,-114,-119,-121,-122',
      hps_key:'hpsCorner',// 角球
      play_id:1001,
    },
    {  // 十五分钟玩法
      title: i18n_t('football_playing_way.hps15Minutes'),
      id:17,
      unfold:0,
      show_tab:false,
      hps15Minutes:[{
        hl:[{}]
      }],
      pids:'32,33,34,231,232,233',
      hps_key:'hps15Minutes',// 15分钟
      play_id:1007,
    },
    { // 波胆
      title: i18n_t('football_playing_way.hpsBold'),
      id: 18,
      unfold:0,
      show_tab:false,
      hps:[{
        hl:[{}]
      }],
      pids: "7",
      hps_key:'hpsBold',
      play_id:1008,
    },
    { // 特色组合
      title: i18n_t('football_playing_way.feature'),
      id: 11,
      unfold:0,
      show_tab:false,
      hps:[{
        hl:[{}]
      }],
      pids: "13,101,345,105",
      hps_key:'hpsCompose',
      play_id:1010,
    },
    {// 罚牌
      title: i18n_t('football_playing_way.penalty_cards'),
      id:5,
      unfold:0,
      show_tab:false,
      hps:[{
        hl:[{}]
      }],
      pids:'310,306,307,311,308,309',
      hps_key:'hpsPunish',// 罚牌
      play_id:1003,
    },
    {// 晋级
      title: i18n_t('football_playing_way.promotion'),
      id:3,
      unfold:0,
      show_tab:false,
      hps:[{
        hl:[{}]
      }],
      pids:'-135,-136',
      hps_key:'hpsPromotion',
      play_id:1005,
    },
    // 冠军
    {
      title: i18n_t('football_playing_way.champion'),
      id:30,
      unfold:0,
      show_tab:false,
      hps:[{
        hl:[{}]
      }],
      pids:'136',
      hps_key:'hpsOutright',
      play_id:1006,
    },
    // 加时
    {
      title: i18n_t('football_playing_way.overtime'),
      id:4,
      unfold:0,
      show_tab:false,
      hps:[{
        hl:[{}]
      }],
      pids:'-126,-128,-127,-129,-130,-332',
      hps_key:'hpsOvertime', 
      play_id:1002,
    },
    // 点球大战
    {
      title: i18n_t('football_playing_way.penalty_shootout'),
      id:2,
      unfold:0,
      show_tab:false,
      hps:[{
        hl:[{}]
      }],
      pids:'-333,-334,-335',
      hps_key:'hpsPenalty', 
      play_id:1004,
    },
    // 篮球
    {
      title:  i18n_t('basketball_playing_way.quarter'),
      id:6,
      unfold:0,
      show_tab:false,
      hps:[{
        hl:[{}]
      }],
      pids:'48,46,45',
      hps_key:'hpsAdd', // 篮球小节玩法
      play_id:2003,
    },
    // 网球
    {
      title: title,
      id:7,
      unfold:0,
      show_tab:false,
      hps:[{
        hl:[{}]
      }],
      pids:'162,163,164',
      hps_key:'hpsAdd',
      play_id:2003,
    },
    //乒乓球
    {
      title: title,
      id:8,
      unfold:0,
      show_tab:false,
      hps:[{
        hl:[{}]
      }],
      pids:'175,176,177',
      hps_key:'hpsAdd',
      play_id:2003,
    },
    //斯诺克
    {
      title: title,
      id:9,
      unfold:0,
      show_tab:false,
      hps:[{
        hl:[{}]
      }],
      pids:'184,185,186,190,191',
      hps_key:'hpsAdd',
      play_id:2003,
    },
  ]
}
```

1.元数据
/// 1011 菜单id -》 loadTournamentMatch -》key-value ： value中的 mid tid

早盘和滚球 ld开赛 nd未开赛的 直接拼 01

tid 和 mid 去 originDataEntity 中遍历查找。

2.csid 列表数据一致性问题

3.时间：中午12点。

## ws

ms - mpp

折叠 C8. 取消订阅。
C9: 折叠不订阅。（解决折叠不显示的赛事 结束后 收不到消息，不该显示的继续显示了）。

冠军也要订阅，赔率变化很少，需要订阅盘口的变化。
C105:

## 列表

1。顺序问题。

2. 关盘:
3. 增加赛事: C109:从关-开 拉列表数据。
4.

/// 赛事列表 上下跳动。

//常规球类 id csid  常规id为 100+csid
1: "足球"  
2: "篮球"
3: "棒球"
4: "冰球"
5: "网球"
6: "美式足球"
7: "斯诺克"
8: "乒乓球"
9: "排球"
10: "羽毛球"
11: "手球"
12: "拳击/格斗"
13: "沙滩排球"
14: "橄榄球"
15: "曲棍球"
16: "水球"
17: "田径"
18: "娱乐"
19: "游泳"
20:"体操"
21:"跳水"
22:"射击"
23:'举重'
24:'射箭'
25:'击剑'
26: "冰壶",
27: "跆拳道"
28: "高尔夫"
29: "自行车"
30: "赛马"
31: "帆船"
32: "划船"
33: "赛车"
34: "柔道"
35: "空手道"
36: "摔跤"
37: "板球"
38: "飞镖"
39: "沙滩足球"
40: "其他"
50:"趣味 "
//电子球类 csid
90: "电子足球"
91: "电子篮球"
//Vr球种 csid   ( 全id => `3${csid}` )
1001:"VR足球"
1002:"VR赛狗"
1004:"VR篮球"
1009:"VR泥地摩托车"
1010:"VR摩托车"
1011:"VR赛马"
//电子竞技 csid  ( 全id => `2${csid}` )
100:"英雄联盟"
101:"Dota2"
102:"CS:GO/CS2"
103:"王者荣耀"


//一级菜单
1:"滚球"  //实时滚球类
2:"今日"  //当日赛事
3:"早盘"  //早盘赛事
4:"冠军"  //菜单id对应客户端400，冠军类赛事
5:"即将开赛"  //即将开赛
6："串关" //串关赛事
300:"VR体育"  //体育类赛事
2000:"电竞"   //电子竞技类 赛事
5000："热门赛种"  //热门赛事球类复刻版50000 5000
28:"赛果"  //赛事结果 全球种
0:"收藏" //自定义id 0

//二级菜单
`${常规球种id(例如足球csid 1+100 = 101)}${一级菜单(例如今日2)}` 

生成唯一id
const mi = `${常规球类csid}${一级菜单id}`;
//例如 足球今日  1012


初始化菜单数据默认值

获取菜单数据 仅在main_layout调用一次 读取本地菜单数据的同时 调用菜单接口更新数据

调用菜单接口获取最新菜单数据

格式化菜单数据，把接口数据格式化成页面所使用的数据

初始化当前选中的菜单

设置自定义的菜单唯一key，列表监听菜单唯一key变化 调用列表接口

请求早盘、串关日期菜单接口 更新日期菜单 （如果当前菜单是早盘、串关）

请求接口 获取虚拟体育联赛菜单 （如果当前菜单是虚拟体育菜单）

请求菜单数量接口 更新菜单数量


赛事列表的渲染需要等待5个元数据接口请求完成

接口1： 获取 新旧菜单ID对应
接口2： 获取 菜单-联赛-赛事
接口3： 获取 国际化菜单
接口4： 获取 元数据接口
接口5： 获取 菜单数量统计


列表数据渲染
整个列表看起来是树形结构（开赛/未开赛-球种-联赛-赛事），但实现是平铺的**（赛事同层级**），就是说每个赛事都包含（开赛/未开赛-球种-联赛-赛事），所以数据处理需提前处理好哪些是显示的（开赛/未开赛-球种-联赛），动态渲染每个赛事结构；

次要玩法为赛事级，每个赛事不一样，根据 matchs 接口和 bymids 接口 计算最终显示的次要玩法；

列表的虚拟计算需提前处理好每个赛事的结构（开赛/未开赛-球种-联赛-赛事），这几个显示与否直接影响每个赛事的高度，从而影响虚拟计算结果；

次要玩法是赛事级别的，参与虚拟计算的时候根据 matchs 接口提前处理次要玩法显示还是隐藏, 但最终显示在界面上需根据 bymids 赔率接口判断次要玩法是否显示；

matchs 接口和 bymids 接口数据不同步，导致的问题是虚拟计算的时候是次要玩法显示，但是最终显示的时候是不显示的，所以存在整体偏移量不对（正常现象）；

次要玩法的展开和收缩直接影响每个赛事高度，纠正赛事高度的同事，需要重新计算；（类似波胆玩法的展开导致赛事高度变化很大）

虚拟计算的列表个数为展开时 18 个， 每折叠一个加 1， 就说说假如全部折叠这时显示联赛，那么显示的个数为 36（有最大限制 32 满足所有机型）

2.1 元数据处理
2.1.1 赛事列表的渲染需要等待5个元数据接口请求完成

//冠军 400 下sl
const miArr = item.sl.map(n=>{
return n.mi;//401 402.....
})
//冠军 5000 下sl
const miArr = item.sl.map(n=>{
return n.mi;//401 402.....
})

//电竞 2000+ （2100 2101 2103 2102）
const miArr = data.filter(n=>{
return +n.mi > 2000 && +n.mi < 3000;
})
//vr体育 300 下sl
const miArr = item.sl.map(n=>{
return n.mi;//31001 31002.....
})
/// user-pc-vite/types/index.ts :56
/** ol玩法投注项 */ interface Ol{
/** 投注項类型? */ ot: string
/** 投注项的name? */ on: string
/** 赔率 */ ov: string
/** 投注项id */ oid: any
/** 断档赔率 */ obv: string
/** 投注项状态 1：开 2：封 3：关 4：锁 */ os: number
/** 投注项头名称 */ ott: string
/** 投注项列ID? */ otd: number
/** 投注项聚合名称 */ otv: string
}
/** Ol投注项 结果 */ interface OlResult extends Ol {
/** 投注项结果:0?,1?,2走水,3输,4赢,5赢半,6输半 */
result: 0 | 1 | 2 | 3 | 4 | 5 | 6,
}