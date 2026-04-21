import * as fs from "node:fs";
import * as path from "node:path";
import lodash from "lodash";
import markdownit from "markdown-it";
import hljs from "highlight.js";

import {
  get_all_file,
  read_file,
  read_file_full_path,
  write_file_silently,
  compute_short_path,
  
} from "../../file-utils/write-folder-file.js";

import { create_md_html_content } from "../module/create_md_html.js";
import { create_doc_index_html_content } from "../module/create_doc_index_html.js";

/**
 * MD 转 html
 * @param {*} content
 * @returns
 */
const compute_html_str = (content,config) => {
  const md = markdownit({
    html: true,
    linkify: true,
    // typographer: true,
    breaks: true,
    highlight: function (str, lang) {
      /* 使用 highlight.js 进行语法高亮 */
      if (lang && hljs.getLanguage(lang)) {
        try {
          return (
            '<pre class="hljs"><code class="lang-' +
            lang +
            '">' +
            hljs.highlight(lang, str, true).value +
            "</code></pre>"
          );
        } catch (__) {}
      }
      /** 使用默认样式类进行高亮 */
      return (
        '<pre class="hljs"><code>' + md.utils.escapeHtml(str) + "</code></pre>"
      );
    },
  });

  return create_md_html_content(md.render(content),config);
};

//扫描路径
let scan_path_arr = ["./job/output/generate_document/"];

// 扫描文件类型

let scan_file_type = [".md"];
//所有文件

let all_path = [];

export const run_md_to_html_process = (config) => {


  // 扫描
  scan_path_arr.map((x) => {
    scan_file_type.map((y) => {
      all_path = all_path.concat(get_all_file(x, y));
    });
  });

  let file_name_arr = [];

  for (let i = 0; i < all_path.length; i++) {
    let file_path = all_path[i];

    file_path = file_path.replace(/\\/g, "/");
    let file_path_arr = file_path.split("/job/output/generate_document/");

    let file_name = file_path_arr[1].substring(0, file_path_arr[1].length - 3);

    file_name_arr.push(file_name);
    let file_content = read_file_full_path(file_path).toString();

    let html_str = compute_html_str(file_content,config);
    write_file_silently(`./job/output/generate_html/pages/${file_name}.html`, html_str,false);
  }

  write_file_silently(
    `./job/output/generate_html/all-menu.json`,
    JSON.stringify(file_name_arr)
  );

  write_file_silently(
    `./job/output/generate_html/index.html`,
    create_doc_index_html_content(file_name_arr,config)
  );
};

// run_md_to_html_process();
