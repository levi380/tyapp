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
 *  当前项目根目录下有 jobs.config.json-------执行合并操作
 * @param {*} file_path
 */
const merge_jobs_config_when_exist = (file_path) => {
  copy_file("./jobs.config.json", "./jobs-before-merge.json");
  // 读取 jobs.config.json
  const json_raw = JSON.parse(read_file("./jobs.config.json").toString());
  // 读取jobs.config.json

  const json_auto_doc = JSON.parse(
    read_file(file_path + "default.jobs.config.json").toString()
  );

  const final_json = lodash.merge({}, json_auto_doc, json_raw);

  // final_json["update_time"] = format_now();

  write_smart_json_file("./jobs.config.json", final_json);

  copy_file(file_path + "default.jobs.config.js", "./jobs.config.js");
};

/**
 *  当前项目根目录下没有 jobs.config.json-------执行拷贝操作
 * @param {*} file_path
 */

const merge_jobs_config_when_not_exist = (file_path) => {
  // 读取jobs.config.json

  // const json_auto_doc = JSON.parse(read_file(file_path+'default.jobs.config.json').toString());

  // const final_json = lodash.merge({}, json_auto_doc);

  // final_json["update_time"] = format_now();
  // write_smart_json_file("./jobs.config.json",final_json)

  // write_smart_json_file("./jobs.config.json",final_json)

  copy_file(file_path + "jobs.config.json", "./jobs.config.json");
  copy_file(file_path + "default.jobs.config.js", "./jobs.config.js");
};

export const merge_jobs_config = async (file_path) => {
  // file_path = "./job/auto-doc/config/default.jobs.config.json"

  if (check_file_exist("./jobs.config.json")) {
    console.log("当前项目根目录下有 jobs.config.json-------执行合并操作");
    merge_jobs_config_when_exist(file_path);
  } else {
    console.log("当前项目根目录下没有 jobs.config.json-------执行拷贝操作");
    merge_jobs_config_when_not_exist(file_path);
  }
};

export const restore_jobs_config = () => {
  try {
    copy_file("./jobs.config.json", "./jobs-before-restore.json");
    copy_file("./jobs-before-merge.json", "./jobs.config.json");
  } catch (error) {
    console.log("没有备份文件：---jobs-before-merge.json----");
  }
};
// merge_json();

// restore_json()
