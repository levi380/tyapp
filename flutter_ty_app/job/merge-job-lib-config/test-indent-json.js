import * as fs from "node:fs";
import * as path from "node:path";
import lodash from "lodash";
import {
  get_all_file,
  read_file,
  read_file_full_path,
  write_file_silently,
  compute_short_path,
  compute_full_path,
  remove_file,
  format_date,
  copy_file,
  format_now,
  write_file,
  write_smart_json_file
} from "../file-utils/write-folder-file.js";

 

 
const json_raw = JSON.parse(read_file("./package.json").toString());



// write_file("./package-nice.json", JsonStringifyNice(json_raw));
   
json_raw['update_date'] = format_now()

 
write_smart_json_file("./package-nice-22333.json",json_raw)

