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

// 脚本执行时间
const date_str = format_date(Date.now());

/**
 * 增加文件路径
 */

const add_file_path = (arr) => {
  let md_str = "";
  let path_arr = new Set();
  arr.map((x) => path_arr.add(x.FILE_PATH));

  path_arr = Array.from(path_arr).filter((x) => x);

  md_str += `## 注释相关文件路径 ： 共${path_arr.length}个文件`;

  md_str += `
  | 序号      | 文件路径           |
  | --------------      | -------------- |`;

  path_arr.map((x, index) => {
    md_str += `
  | ${index + 1} | ${x} |`;
  });
  md_str += `
  `;
  return md_str;
};

 
/**
 * // 计算文件菜单
 *
 */
const compute_file_menu = (arr) => {
  let file_menu = "";
  let file_menu_arr = new Set();
  arr.map((x) => file_menu_arr.add(x.DOCUMENT_MENU));

  file_menu_arr = Array.from(file_menu_arr).filter((x) => x);

  file_menu = file_menu_arr[0] || "无菜单配置";

  let file_document_title = "";
  let file_document_title_arr = new Set();
  arr.map((x) => file_document_title_arr.add(x.DOCUMENT_TITLE));

  file_document_title_arr = Array.from(file_document_title_arr).filter(
    (x) => x
  );

  file_document_title = file_document_title_arr[0] || "无文档标题配置";

  file_document_title = lodash.trim(file_document_title, "/ ");

  let file_path = `/${file_menu}/${file_document_title}.md`;

  return {
    file_menu,

    file_path,
  };
};
/**
 * 根据对象生成 md 文件 字符串
 */

const generate_md_file_str = (DOCUMENT_TITLE, arr) => {
  

  let file_name = arr[0]['DOCUMENT_MENU_NEW']
  let file_path = arr[0]['new_path']
  const doc_id = arr[0]['DOCUMENT_UUID'] || ''
  let md_str = `# ${DOCUMENT_TITLE} \`[${doc_id}]\`\n\n`;
  md_str += `>  文档生成路径：md： ${file_path}.md\n\n`;
  // md_str += `>  文档生成路径: html： /${file_menu}/${DOCUMENT_TITLE}.html\n\n`;
  md_str += `#### 文档生成时间： ${date_str}\n\n`;
  //增加文件路径
  md_str += add_file_path(arr);

  let group_obj = {};

  arr.map((x) => {
    group_obj[x.PARAGRAPH_TITLE] = group_obj[x.PARAGRAPH_TITLE] || [];

    group_obj[x.PARAGRAPH_TITLE].push({
      PARAGRAPH_CONTENT: x.PARAGRAPH_CONTENT,
      FILE_PATH: x.FILE_PATH,
    });
  });

  let title_key_arr = Object.keys(group_obj);
  title_key_arr.sort((a, b) => (parseInt(a) || 0) - (parseInt(b) || 0));

  for (let title_key of title_key_arr) {
    md_str += `## ${title_key}\n\n`;
    let content_arr = group_obj[title_key];

    content_arr.map((obj) => {
      let { PARAGRAPH_CONTENT, FILE_PATH } = obj;
      md_str += `###### 文件路径： ${FILE_PATH}\n\n`;
      md_str += `${PARAGRAPH_CONTENT}\n\n`;
    });
  }

  return {
    md_str,
    file_path,
  };
};

/**
 * 根据  final_result_obj 生成文件
 */

export const write_final_result_obj_to_file = (final_result_obj) => {


  for (let key in final_result_obj) {
    let { md_str, file_path } = generate_md_file_str(
      key,
      final_result_obj[key]
    );
    write_file_silently(
      `./job/output/generate_document/${file_path}.md`,
      md_str
    );
  }
};
