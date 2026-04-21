import {
  copy_dir,
  remove_file,
  archiver_file_to_zip,
  format_date,
  compute_full_path,
} from "../../file-utils/write-folder-file.js";
 
import { upload_md_zip } from "../module/upload-md-zip.js";

import { compute_config } from "../module/compute_config.js";

remove_file("./dist/auto-doc-md/");
copy_dir("./job/output/generate_document", "./dist/auto-doc-md/");

const date_str = format_date(Date.now());
const file_name = `auto-doc-md-${date_str}.zip`;
archiver_file_to_zip("./dist/auto-doc-md/", "./dist/", file_name);

const file_path = `./dist/${file_name}`;
const file_path_full = compute_full_path(file_path);

const config = await compute_config();


setTimeout(async()=>{

  if (config.upload_md_zip) {
    console.log('当前配置 需要上传 md zip -------',);
    await upload_md_zip({
      project_name: config.project_name,
      file_name: file_name,
      file_path,
      file_path_full,
    });
  }else{
    console.log('当前配置 不 需要上传 md zip -------',);
  }
  

},3000)
