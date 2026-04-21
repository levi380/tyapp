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

/**
 * 计算菜单的层级深度
 * @param {*} title_mapping
 * @returns
 */
const compute_max_len = (title_mapping) => {
  let path_len = [];

  for (let key in title_mapping) {
    path_len.push(title_mapping[key]["path_arr"].length);
  }

  let max_len = Math.max(...path_len);

  return max_len;
};

const rebuild_new_title_mapping = (mapping_obj, result_obj, key_path) => {
  let key_arr = Object.keys(mapping_obj);

  key_arr.sort((a, b) => (parseInt(a) || 0) - parseInt(b || 0) < 0);

  key_arr.map((x, index) => {
    let new_x = "";

    if (parseInt(x) > 0) {
      new_x = x.substring(("" + parseInt(x)).length);
    } else {
      new_x = x;
    }

    // console.log('x---- ---',x );
    // console.log('new_x-------', new_x);
    let new_key_path = key_path
      ? `${key_path}.${index + 1}-${new_x}`
      : `${index + 1}-${new_x}`;

    if (lodash.isString(mapping_obj[x])) {
      result_obj[`${new_key_path}`] = mapping_obj[x];
    } else {
      rebuild_new_title_mapping(mapping_obj[x], result_obj, new_key_path);
    }
  });
};

/**
 * 重新加工计算  document_title_mapping
 * @param {*} title_mapping
 */
const rebuild_new_document_title_mapping = (title_mapping) => {
  let menu_max_layer = compute_max_len(title_mapping);

  let new_title_mapping = {};

  for (let key in title_mapping) {
    let item = title_mapping[key];
    lodash.set(new_title_mapping, item["path_dot"], key);
  }

  write_file_silently(
    "./job/output/generate_document/new_title_mapping.json",
    JSON.stringify(new_title_mapping)
  );

  let result_obj = {};

  rebuild_new_title_mapping(new_title_mapping, result_obj, "");

  let new_result_obj = {};

  for (let key in result_obj) {
    let arr_1 = key.split(".");
    new_result_obj[result_obj[key]] = {
      new_path_dot: key,
      new_path_arr: arr_1,

      new_path: key.replaceAll(".", "/"),
      DOCUMENT_MENU_NEW: arr_1.slice(0, arr_1.length - 1).join("/"),
      DOCUMENT_TITLE_NEW: arr_1[arr_1.length - 1],
    };
  }

  write_file_silently(
    "./job/output/generate_document/new_result_obj.json",
    JSON.stringify(new_result_obj)
  );

  for (let key in title_mapping) {
    title_mapping[key] = {
      ...title_mapping[key],
      ...new_result_obj[key],
    };
  }
};

/**
 * 获取有效UUID
 *
 * @param {Array} docs
 * @returns
 */
function getEfficientDocumentUUID(docs) {
  let uids = [];
  if (docs[0].DOCUMENT_UUID=='tyApp-ffec4c85-6e72-4e9e-b232-50e804d0ffa1-sz') {
    console.log('WS集中处理执行扩展类');
  }
  const paths = new Set();
  for (let i = 0; i < docs.length; i++) {
    const doc = docs[i];

    if (doc.DOCUMENT_UUID && !uids.includes(doc.DOCUMENT_UUID)) {
      uids.push(doc.DOCUMENT_UUID)
    }

    paths.add(`\t${doc.FILE_PATH}:${doc.LINE_NUM||0}`);
  }

  if (uids.length == 1) {
    return uids[0];
  }

  console.log(
    "\x1b[31m%s\x1b[0m",
    uids.length === 0 ? '没有配置UUID' : '存在多个不一样的UUID',
    `   \x1b[33m[DOCUMENT_MENU ${docs[0].DOCUMENT_MENU}]   [DOCUMENT_TITLE ${docs[0].DOCUMENT_TITLE}]，涉及文件如下：`
  );

  console.log("\x1b[31m%s\x1b[0m", [...paths].join('\n'), '\n\n')

  return "";
}

/**
 *  计算排序相关对象
 * @param {*} final_result_obj
 */
export const standardize_final_sort = (final_result_obj) => {
  let new_document_title_mapping = {};
  for (let key in final_result_obj) {
    let { DOCUMENT_MENU, DOCUMENT_TITLE } = final_result_obj[key][0];

    const DOCUMENT_UUID = getEfficientDocumentUUID(final_result_obj[key]);

    let path_str = `${DOCUMENT_MENU}/${DOCUMENT_TITLE}`;
    let obj = {
      DOCUMENT_UUID,
      DOCUMENT_MENU,
      DOCUMENT_TITLE,
      path: path_str,
      path_arr: path_str.split("/"),
      path_dot: path_str.replaceAll("/", "."),
    };

    new_document_title_mapping[key] = obj;
  }
  write_file_silently(
    "./job/output/generate_document/document_title_mapping.json",
    JSON.stringify(new_document_title_mapping)
  );

  rebuild_new_document_title_mapping(new_document_title_mapping);

  write_file_silently(
    "./job/output/generate_document/new_document_title_mapping.json",
    JSON.stringify(new_document_title_mapping)
  );

  let new_final_result_obj = {};

  for (let key in final_result_obj) {
    let title_config = new_document_title_mapping[key];
    new_final_result_obj[title_config.DOCUMENT_TITLE_NEW] = [];
    let arr = final_result_obj[key];

    arr.map((x) => {
      new_final_result_obj[title_config.DOCUMENT_TITLE_NEW].push({
        ...x,
        ...title_config,
      });
    });
  }
  write_file_silently(
    "./job/output/generate_document/generate_content.json",
    JSON.stringify(final_result_obj)
  );

  return new_final_result_obj;
};
