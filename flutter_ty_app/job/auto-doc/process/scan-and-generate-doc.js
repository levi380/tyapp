/**
 *  提取 注释  AUTOMATIC_GENERATE_DOCUMENT.
 */

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

import {resolve_file_content,check_file_content_include_keyword} from  "../module/resolve_file_content.js"
import {mount_to_final_result_obj} from  "../module/mount_to_final_result_obj.js"
import {write_final_result_obj_to_file} from  "../module/write_final_result_obj_to_file.js"
import {standardize_final_sort} from  "../module/compute_final_sort_obj.js"
import {standardize_final_result_obj} from  "../module/standardize_final_result_obj.js"



// console.log("all_path-----0--", all_path[0]);

/**
 * 计算所有路径
 */

const compute_all_path = (config = {}) => {
  //扫描路径
  let scan_path_arr = config.scan_path_arr || [
    "./job/",
    "./src/",
    "./project/",
  ];

  // 扫描文件类型

  let scan_file_type_arr = config.scan_file_type_arr || [
    ".js",
    ".vue",
    ".dart",
    ".scss",
  ];

  //所有文件

  let all_path = [];
  // 扫描
  scan_path_arr.map((x) => {
    scan_file_type_arr.map((y) => {
      all_path = all_path.concat(get_all_file(x, y));
    });
  });

  console.log("all_path-------", all_path.length);

  return all_path;
};


/**
 * 结果对象
 */
let final_result_obj = {};







/**
 * 生成文档进程
 */

export const run_scan_and_generate_doc_process = (config) => {
  remove_file("./job/output/generate_document/");
  remove_file("./job/output/generate_html/");


  // 
  //所有路径
  let all_path = compute_all_path(config);
  const len = all_path.length
  for (let i = 0; i < len; i++) {
    let file_path = all_path[i];
    console.log(i + 1,'/', len, file_path);
    let file_content = read_file_full_path(file_path).toString();

    //   if(file_path.includes('utomatic_document_generation_test')){
    //     console.log('包含测试内容---1111111----',file_path);

    //   }
     //检查文件内容是否包含关键字
    if (check_file_content_include_keyword(file_content)) {
      // console.log("包含文档内容----22222---", file_path);
      let result_arr = resolve_file_content(
        file_content,
        compute_short_path(file_path)
      );

      mount_to_final_result_obj(final_result_obj,result_arr);
    }
  }
  // 标准化 结果对象
  final_result_obj=  standardize_final_result_obj(final_result_obj)
  // 标准化 排序 
  final_result_obj= standardize_final_sort(final_result_obj)
  // 写入 结果对象 到 文件
  write_final_result_obj_to_file(final_result_obj);
};

// run_scan_and_generate_doc_process();
