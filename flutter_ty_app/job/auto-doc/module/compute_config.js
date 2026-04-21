import { import_json_data } from "../../file-utils/write-folder-file.js";

import { get_git_info } from "../../git-utils/git-utils.js";

export const compute_config = async () => {
  let config = {};

  const default_config = await import_json_data(
    "./job/auto-doc/config/default.jobs.config.json"
  );
  let  jobs_config ={} 



  try {
    jobs_config = await import_json_data("./jobs.config.json");
  } catch (error) {
    console.log('项目根目录下没有---jobs.config.json----建议手动拷贝 ./job/auto-doc/config/default.jobs.config.json 到  ./jobs.config.json',);
  }



  // console.log('项目根目录 jobs.config.json-------jobs_config ',jobs_config);
  if (jobs_config["auto_doc"]) {
    console.log("项目根目录 jobs.config.json-------内存在  auto_doc 配置 ");
    config = jobs_config["auto_doc"];
  } else {
    console.log(
      "项目根目录 jobs.config.json-------内不存在  auto_doc 配置,使用默认配置 "
    );
    config = default_config["auto_doc"];
  }

  /**
   * 获取项目信息
   */

  const git_info = get_git_info();
  config.git_info = git_info;
  config.title = `${git_info.name.toLocaleUpperCase()} ${
    config.title
  }-项目伴生文档`;
  config.project_name = git_info.name.toLocaleUpperCase();

  return config;
};
