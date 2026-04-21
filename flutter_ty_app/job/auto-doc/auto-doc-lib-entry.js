import { run_scan_and_generate_doc_process } from "./process/scan-and-generate-doc.js";
import { run_inner_doc_server_process } from "./process/inner-doc-server.js";
import { run_md_to_html_process } from "./process/md-to-html.js";
import {compute_config} from  "./module/compute_config.js"
 

 
//  node   auto-doc_lib-build.js   scan  convert server

// console.log("命令行参数------", process.argv);
//命令行参数
let params = [...process.argv].slice(2);

console.log("命令行参数-------", params);




const  config = await compute_config()



/**
 *默认 配置文件在   ./config/default.jobs.config.json  
 需要 复制到 项目根目录
 */ 



/**
 * 完整进程
 */
const run_inner_auto_doc_full_process = () => {
  if (params.includes("scan")) {
    console.log("包含 scan 参数----执行 扫描  进程");
    // 扫描  进程
    run_scan_and_generate_doc_process(config);
  }
  if (params.includes("convert")) {
    console.log("包含 convert 参数----执行 转化  md  to  html  进程");
    // 转化  md  to  html  进程
    run_md_to_html_process(config);
  }
  if (params.includes("server")) {
    console.log("包含 server 参数----执行 http server 服务  调用");
    // http server 服务  调用
    run_inner_doc_server_process(config);
  }
};


if(params.length > 0){
  run_inner_auto_doc_full_process();
}else{

  console.log("请添加 scan, convert, server 参数  中的 单个 或者 全部   ");
  console.log( `
    
  scan    参数----执行 扫描  进程
  convert 参数----执行 转化  md  to  html  进程
  server  参数----执行 http server 服务  调用

    `);
  process.exit(1);  // 退出进程
}
 
