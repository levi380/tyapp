import lodash from "lodash";

/**
 *  重写 document_menu
 * @param {*} arr
 */
const rebuild_document_menu = (arr) => {
  let menu_arr = [];
  arr.map((x) => {
    menu_arr.push(x.DOCUMENT_MENU);
  });
  menu_arr = menu_arr.filter((x) => x);
  menu_arr.sort((a, b) => a.length > b.length);
  let menu_str = menu_arr[0] || "0无菜单";
  console.log("找到标题-------", menu_str);
  arr.map((x) => {
    x.DOCUMENT_MENU = menu_str;
  });
};

/**
 *  重写 document_title
 * @param {*} arr
 */
const rebuild_document_title_arr = (arr) => {
  let title_arr = [];
  arr.map((x) => {
    title_arr.push(x.DOCUMENT_TITLE);
  });
  title_arr = title_arr.filter((x) => x);
  title_arr.sort((a, b) => a.length > b.length);
  let title_str = title_arr[0] || "0无文档标题";
  console.log("找到标题-------", title_str);
  arr.map((x) => {
    x.DOCUMENT_TITLE = title_str;
  });
};
 

/**
 *
 * 计算 去除 排序值的  文档标题  key  数组
 * 重新 计算  文档标题
 */

const rebuild_document_title = (final_result_obj) => {
  let arr1 = Object.keys(final_result_obj);
  //去除排序值的
  let arr2 = [];

  let key_mapping = {};

  for (let i = 0; i < arr1.length; i++) {
    let str = arr1[i];
    let num = parseInt(str);
    if (num) {
      str = str.split(`${num}`)[1];
      str = str.trim();
    }
    arr2.push(str);

    key_mapping[arr1[i]] = str;
  }

  arr2 = [...new Set(arr2)];

  let new_final_result_obj = {};
  for (let key in final_result_obj) {
    if (!new_final_result_obj[key_mapping[key]]) {
      new_final_result_obj[key_mapping[key]] = [];
    }
    new_final_result_obj[key_mapping[key]] = new_final_result_obj[
      key_mapping[key]
    ].concat(final_result_obj[key]);
  }

  for (let key in new_final_result_obj) {
    rebuild_document_title_arr(new_final_result_obj[key]);
  }



  let  new_final_result_obj_2 ={}


  for (let key in new_final_result_obj) {


      let document_title = new_final_result_obj[key][0]['DOCUMENT_TITLE']

      new_final_result_obj_2[document_title] = new_final_result_obj[key]

  }



  return new_final_result_obj_2;
};









const  parse_int_str=(str)=>{
    let num = parseInt(str);
    if (num) {
      str = str.split(`${num}`)[1];
      str = str.trim();
    }
    return str;
}




/**
 *  标准化  PARAGRAPH_TITLE
 */


const rebuild_paragraph_title_arr=(arr)=>{
    let title_arr = [];
    arr.map((x) => {
      title_arr.push(x.PARAGRAPH_TITLE);
    });
    title_arr = title_arr.filter((x) => x);

    let title_mapping ={}


    title_arr.map(x=>{

      if( ! title_mapping[parse_int_str(x) ]){
        title_mapping[parse_int_str(x) ] = new Set()
      } 
      title_mapping[parse_int_str(x) ].add(x)
   
  
    })


    for(let  key  in  title_mapping){
        let arr_1 =  [...title_mapping[key] ] 

        arr_1.sort((a,b)=>a.length-b.length)
        title_mapping[key] =  arr_1[0]
    }

// 统一  PARAGRAPH_TITLE
arr.map(x=>{
    x.PARAGRAPH_TITLE = title_mapping[parse_int_str(x.PARAGRAPH_TITLE) ]
})



 

}







/**
 * 组合  PARAGRAPH_TITLE
 */

const  rebuild_paragraph_title=(final_result_obj)=>{
    
    // 标准化  PARAGRAPH_TITLE
  for (let key in final_result_obj) {

    rebuild_paragraph_title_arr(final_result_obj[key])
  
}




}




/**
 * 标准化 结果对象
 * @param {*} final_result_obj
 */
export const standardize_final_result_obj = (final_result_obj) => {
  //重新 计算  文档标题
  final_result_obj = rebuild_document_title(final_result_obj);

  for (let key in final_result_obj) {
    //补齐 document_menu
    rebuild_document_menu(final_result_obj[key]);
  }



  // 组合  PARAGRAPH_TITLE
  rebuild_paragraph_title(final_result_obj)

  return final_result_obj;
};
