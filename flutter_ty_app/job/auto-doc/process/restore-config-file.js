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
  write_smart_json_file
} from "../../file-utils/write-folder-file.js";

import  { restore_package_json} from "../../merge-job-lib-config/handle-package-json.js"
import  { restore_jobs_config} from "../../merge-job-lib-config/handle-job-config-json.js"


restore_package_json()
restore_jobs_config()
