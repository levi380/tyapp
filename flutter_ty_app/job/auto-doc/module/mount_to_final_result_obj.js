import lodash from "lodash";

/**
 * 添加数据到 挂载点
 * @param {*} obj
 */
const add_to_final_result_obj = (final_result_obj, obj) => {
  let { DOCUMENT_TITLE } = obj;

  if (!final_result_obj[DOCUMENT_TITLE]) {
    final_result_obj[DOCUMENT_TITLE] = [];
  }
  final_result_obj[DOCUMENT_TITLE].push(obj);
};

/**
 * 内容加工去除 最前面的制表符
 * @param {*} str
 * @returns
 */

const rebuild_content = (str) => {
  

  let is_code =  str.trim().startsWith("```")

  let arr = str.split("\n");

  let new_arr = [];

  arr.map((x) => {

    if(is_code){
      // x = x;
    }else{
      x = lodash.trim(x, "\t  ");
    }
  
    new_arr.push(x);
  });

  return new_arr.join("\n");
};

/**
 * 内容加工去除 最前面的制表符
 * @param {*} str
 * @returns
 */

const rebuild_title = (str) => {
  let arr = str.split("\n");

  let new_arr = [];

  arr.map((x) => {
    x = lodash.trim(x, "\t  \r\n /") ||'';
    x =  x .replaceAll('.','')
    new_arr.push(x);
  });

  new_arr = new_arr.filter((x) => x);

  return new_arr.join("");
};

/**
 * 生成 文档内容
 */

export const mount_to_final_result_obj = (final_result_obj, result_arr) => {
  if (!result_arr.length) {
    return;
  }

  let last_type = "";
  let last_DOCUMENT_UUID = "";
  let last_DOCUMENT_MENU = "";
  let last_DOCUMENT_TITLE = "";
  let line_num = 0

  let last_PARAGRAPH_TITLE = "段落标题为空--！！！";
  let last_PARAGRAPH_CONTENT = "";

  result_arr.map((x) => {
    let { type, content, file_path } = x;

    if (type == "DOCUMENT_UUID") {
      last_DOCUMENT_UUID = rebuild_title(content);
    } else if (type == "DOCUMENT_MENU") {
      last_DOCUMENT_MENU = rebuild_title(content);
    } else if (type == "DOCUMENT_TITLE") {
      last_DOCUMENT_TITLE = rebuild_title(content);
      line_num = x.line_num
    } else if (type == "PARAGRAPH_TITLE") {
      last_PARAGRAPH_TITLE = rebuild_title(content);
    } else if (type == "PARAGRAPH_CONTENT") {
      last_PARAGRAPH_CONTENT = rebuild_content(content);

      //添加数据到 挂载点
      add_to_final_result_obj(final_result_obj, {
        DOCUMENT_UUID: last_DOCUMENT_UUID,
        DOCUMENT_MENU: last_DOCUMENT_MENU,
        DOCUMENT_TITLE: last_DOCUMENT_TITLE,

        PARAGRAPH_TITLE: last_PARAGRAPH_TITLE,

        PARAGRAPH_CONTENT: last_PARAGRAPH_CONTENT,
        FILE_PATH: file_path,
        LINE_NUM: line_num,
      });
    }
  });
};
