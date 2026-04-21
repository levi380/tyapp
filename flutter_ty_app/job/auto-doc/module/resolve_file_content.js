import * as fs from "node:fs";
import * as path from "node:path";
import lodash from "lodash";
import {
  get_all_file,
  read_file,
  read_file_full_path,
  write_file_silently,
  compute_short_path,
  remove_file,
  format_date,
} from "../../file-utils/write-folder-file.js";
// 正则表达式  ([^\[\]]|\n|\r)  【】
// const regexp = /\[\[\[([^\[\]]|\n|\r)*\]\]\]/gm;
// const regexp = /\【\【\【([^\【\】]|\n|\r)*\】\】\】/gm;
const regexp = /【【【([\s\S]*?)】】】/gm;
// 关键字类型
const type_arr = [
  //文档ID
  "DOCUMENT_UUID",
  //文档菜单
  "DOCUMENT_MENU",
  //文档标题
  "DOCUMENT_TITLE",
  //段落标题
  "PARAGRAPH_TITLE",
  //段落内容
  "PARAGRAPH_CONTENT",
];


/**
 * 检查文件内容是否包含关键字
 */

export const  check_file_content_include_keyword=(file_content)=>{

    let check =false

 
    for (let i of type_arr) {
        let check_item = file_content.includes(`AUTO_` + i);
        if (check_item) {
            check =  true;
       
          break;
        }
      }

    return check

}







/**
 * 计算内容 和 类型
 * @param {*} str
 * @returns
 */
const compute_file_content_and_type = (str) => {
    let type='';
  for (let i of type_arr) {
    let check = str.includes(`AUTO_` + i);
    if (check) {
      type = i;
      // 去掉关键字
      str = str.replaceAll(`AUTO_` + i, "");
      break;
    }
  }
  str = lodash.trim(str, "\r\n");
  str = str.replaceAll("【", "");
  str = str.replaceAll("】", "");
  return {
    content: str,
    type,
  };
};
/**
 * 解析每一个正则匹配
 * @param {*} str
 * @param {*} file_path
 */
const resolve_file_content_single_file = (str, file_path) => {
  let { content, type } = compute_file_content_and_type(str);
  if (type == "PARAGRAPH_TITLE") {
    if (!content) {
      content = "段落标题为空";
      return;
    }
  }
  return {
    type,
    content,
    file_path,
  };
};
/**
 * 添加空标题
 */
const add_empty_title = (result_arr, file_path) => {
  //   let      type = "DOCUMENT_TITLE";
  let DOCUMENT_TITLE_arr = result_arr.filter((x) => x.type == "DOCUMENT_TITLE");
  if (!DOCUMENT_TITLE_arr.length) {
    let file_path_str = file_path.replaceAll("/", "_");
    file_path_str = file_path_str.replaceAll("\\", "_");
    file_path_str = file_path_str.replaceAll(".", "_");
    file_path_str = file_path_str.replaceAll(" ", "");
    result_arr.unshift({
      type: "DOCUMENT_TITLE",
      content: "文档标题为空--" + file_path_str,
      file_path,
    });
  } else {
    result_arr.unshift(DOCUMENT_TITLE_arr[0]);
  }
};
function findMatchesWithLineNumbers(contentLi, text) {
  const lines = content.split(/\r?\n/); // 按行拆分
  const matches = [];

  lines.forEach((line, index) => {
    if (line.includes(text)) {
      matches.push({
        lineNumber: index + 1, // 行号从 1 开始
        lineContent: line
      });
    }
  });

  return matches;
}
/**
 * 正则匹配 文档内容
 * @param {*} file_content
 * @param {*} file_path
 */
export const resolve_file_content = (file_content = "", file_path) => {
  remove_file("./job/output/generate_document");
  // console.log(file_content );
  let arr = [...file_content.matchAll(regexp)];
  // console.log(`arr ---length----`, arr.length);
  if (file_path.includes("自动化生成文档介绍")) {
    write_file_silently(
      "./job/output/generate_document/自动化生成文档介绍.json",
      JSON.stringify(arr)
    );
  }
  if (!arr.length) {
    return [];
  }
  const lines = file_content.split(/\r?\n/)
  let result_arr = [];
  for (let i = 0; i < arr.length; i++) {
    const item = arr[i][0]
    // console.log(`arr${i}-------`, arr[i][0]);
    const doc_info = resolve_file_content_single_file(item, file_path)
    if (item.includes('DOCUMENT_TITLE'))
      doc_info.line_num = lines.findIndex((v) => v.includes(item))
    result_arr.push(doc_info);
  }
  //添加空标题
  add_empty_title(result_arr, file_path);
  return result_arr;
};
