import { read_file } from "../../file-utils/write-folder-file.js";
/**
 * 生成 项目伴生文档 首页 
 * @param {*} arr  菜单
 * @param {*} config  其他配置
 * @returns 
 */
export const create_doc_index_html_content = (arr, config = {}) => {
  let html_template_content = read_file(
    "./job/auto-doc/module/index-template.html"
  ).toString();
  html_template_content = html_template_content.replaceAll(
    "project_title_place_holder",
    config.title
  );
  html_template_content = html_template_content.replaceAll(
    "all_menus_place_holder",
    JSON.stringify(arr)
  );
  return html_template_content;
};
