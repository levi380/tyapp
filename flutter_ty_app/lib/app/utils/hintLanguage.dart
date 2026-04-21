//返回不同提示语言
import '../services/models/res/event_info_entity.dart';
 class HintLanguage{
   static String gethint(String language, EventInfo2Data data) {
     switch (language) {
       case "CN":
         return data.zh;
       case "TW":
         return data.tw;
       case "GB":
         return data.tw;
       case "VN":
         return data.es;
       case "TH":
         return data.th;
       case "MY":
         return data.mya;
       case "ID":
         return data.es;
       case "PT":
         return data.es;
       case "KR":
         return data.es;
       case "ES":
         return data.es;
       case "MM":
         return data.es;
     }
     return data.zh;
   }
}
