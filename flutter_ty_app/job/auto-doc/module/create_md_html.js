import { read_file } from "../../file-utils/write-folder-file.js";
/**
 * 生成 项目伴生文档  单个文档 内容
 * @param {*} str   md 文件的 字符串
 * @param {*} config  其他配置
 * @returns 
 */
export const create_md_html_content = (str, config = {}) => {
  let html_template_content = read_file(
    "./job/auto-doc/module/md-html-template.html"
  ).toString();
  html_template_content = html_template_content.replaceAll(
    "project_title_place_holder",
    config.title
  );
  html_template_content = html_template_content.replaceAll(
    "md-to-html-str-place-holder",
    str
  );

  return html_template_content;
};
