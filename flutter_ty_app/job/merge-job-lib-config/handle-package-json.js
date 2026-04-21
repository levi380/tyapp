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
  copy_file,
  format_now,
  write_file,
  write_smart_json_file,
  check_file_exist,
} from "../file-utils/write-folder-file.js";

/**
 *  当前项目根目录下有 package.json-------执行合并操作
 * @param {*} file_path
 */
const merge_package_json_when_exist = (file_path) => {
  copy_file("./package.json", "./package-before-merge.json");

  // 读取package.json

  const json_raw = JSON.parse(read_file("./package.json").toString());

  // 读取package.json

  const json_auto_doc = JSON.parse(read_file(file_path).toString());

  const final_json = lodash.merge({}, json_raw, json_auto_doc);

  // final_json["update_time"] = format_now();
  write_smart_json_file("./package.json", final_json);
};

/**
 *  当前项目根目录下没有 package.json-------执行拷贝操作
 * @param {*} file_path
 */
const merge_package_json_when_not_exist = (file_path) => {
  // 读取package.json

  // const json_auto_doc = JSON.parse(read_file(file_path).toString());

  // const final_json = lodash.merge({}, json_auto_doc);

  // final_json["update_time"] = format_now();
  // write_smart_json_file("./package.json",final_json)

  copy_file(file_path, "./package.json");
};

export const merge_package_json = (file_path) => {
  if (check_file_exist("./package.json")) {
    console.log("当前项目根目录下有 package.json-------执行合并操作");
    merge_package_json_when_exist(file_path);
  } else {
    console.log("当前项目根目录下没有 package.json-------执行拷贝操作");
    merge_package_json_when_not_exist(file_path);
  }
};

export const restore_package_json = () => {
  try {
    copy_file("./package.json", "./package-before-restore.json");
    copy_file("./package-before-merge.json", "./package.json");
  } catch (error) {
    console.log("没有备份文件：---package-before-merge.json----");
  }
};
// merge_json();

// restore_json()
