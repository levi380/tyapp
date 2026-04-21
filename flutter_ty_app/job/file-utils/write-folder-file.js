/**
 * 文件 操作 封装
 */
import * as fs from "node:fs";
import colors from "colors";
import path from "node:path";
import { fileURLToPath, pathToFileURL } from "url";
import lodash from "lodash";
import archiver from "archiver";
import extractZip from "extract-zip";
import {writeJsonFile ,writeJsonFileSync} from 'write-json-file';
// import { cwd } from 'node:process';
const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
/**
 * 日期格式化
 * @param {*} value  时间戳
 * @returns 
 */
export const format_date = (value) => {
  let time = new Date(parseInt(value));
  let y = time.getFullYear();
  let m = (time.getMonth() + 1 + "").padStart(2, 0);
  let d = (time.getDate() + "").padStart(2, 0);
  let h = (time.getHours() + "").padStart(2, 0);
  let mm = (time.getMinutes() + "").padStart(2, 0);
  let s = (time.getSeconds() + "").padStart(2, 0);
  return `${y}-${m}-${d}-${h}-${mm}-${s}`;
};
/**
 * 日期格式化
 * @param {*} value  时间戳
 * @returns 
 */
export const format_now = () => {
  return format_date(Date.now())
 
};
// console.log("__dirname------", __dirname);
// console.log("process.cwd------", process.cwd());
// pubspec.yaml
// package.json
/**
 * 
 * @param {*} dirname  目录
 * @returns 
 */
const find_root_workspace = (dirname) => {
  let root_rolder = "";
  let is_exist_pubspec_yaml = fs.existsSync(
    path.resolve(dirname, "pubspec.yaml")
  );
  let is_exist_package_json = fs.existsSync(
    path.resolve(dirname, "package.json")
  );
  if (is_exist_pubspec_yaml || is_exist_package_json) {
    root_rolder = dirname;
  } else {

    let father_dir = path.resolve(dirname, "../")
    if(father_dir!=dirname){
      root_rolder = find_root_workspace(father_dir);
    } 

  }
  return root_rolder;
};
/**
 * 转换  job/doc  到   ../../
 * @param {*} str  相对路径
 */
const compute_relative_path = (str) => {
  str = str.replace(/\\/g, "/");
  str = lodash.trim(str, "/");
  let arr = str.split("/");
  let arr2 = [];
  arr.map((x) => {
    arr2.push("../");
  });
  return arr2.join("");
};
/**
 * 项目根目录
 */
export const root_workspace = find_root_workspace(__dirname);
// const relative_path = path.relative(root_workspace, __dirname);
// const dot_relative_path = compute_relative_path(relative_path);
// console.log("find_root_workspace-------", root_workspace);
// console.log("relative_path------", relative_path);
// console.log("dot_relative_path----", dot_relative_path);
// export const  root_workspace = path.resolve( __dirname, '../../');
// cwd()    工作空间
/**
 * 计算 相对于 项目根目录 的路径
 * @param {*} str 原路径
 * @returns 
 */
export const compute_short_path = (str) => {
  return path.relative(root_workspace, str).replace(/\\/g, "/");
};
/**
 *  带工作空间的全路径
 * @param {*} subpath  文件地址
 * @returns e
 */
export const compute_full_path = (file_path) => {
  let full_path = path.resolve(root_workspace, file_path);
  //
  // console.log("计算所得： 全路径：  ",full_path);
  return full_path;
};
/**
 *  带工作空间的全路径  带 file:// 协议前缀的
 * @param {*} file_path 文件地址
 * @returns
 */
export const compute_full_file_href = (file_path) => {
  let full_file_href = pathToFileURL(compute_full_path(file_path)).href;
  // console.log("计算所得： 全路径：  ",full_file_href);
  return full_file_href;
};
/**
 * 检查文件是否存在
 * @param {*} file_path  文件地址
 * @returns
 */
export const check_file_exist = (file_path) => {
  if (!path.isAbsolute(file_path)) {
    file_path = compute_full_path(file_path);
  }
  // console.log('file_path-',file_path);
  let is_exist = fs.existsSync(file_path);
  if (is_exist) {
    // console.log( colors.red(`${file_path}-----文件存在----  `) );
    var stat = fs.statSync(file_path);
    if (stat.isFile()) {
      // 判断是文件还是目录
      return true;
    } else if (stat.isDirectory()) {
      return false;
    }
  } else {
    return false;
  }
};
// 输出目录
// let write_folder = "./job/output/env";
/**
 * 确保  输出目录存在
 * @param {*} write_folder  需要操作的目录路径
 */
export const ensure_write_folder_exist = (write_folder) => {
  if (!path.isAbsolute(write_folder)) {
    write_folder = compute_full_path(write_folder);
  }
  // console.log('write_folder-',write_folder);
  let is_exist = fs.existsSync(write_folder);
  if (is_exist) {
    // console.log( colors.red(`${write_folder}-----文件夹已存在----  `) );
  } else {
    try {
      // 创建文件夹
      fs.mkdirSync(write_folder, { recursive: true });
      // console.log(colors.green(`创建文件夹   ${write_folder} 完成`));
    } catch (err) {
      console.log(`创建文件夹   ${write_folder}  出错`, err);
    }
  }
};
/**
 * 创建文件
 * @param {*} file_path  目标地址
 * @param {*} str  文件内容
 * @param {*} log  打印日志
 */
export const write_file = (raw_file_path, str, log = true) => {
  //带工作空间的全路径
  let file_path = compute_full_path(raw_file_path);
  //目录名字
  let dir_path = path.dirname(file_path);
  //确保目录存在
  ensure_write_folder_exist(dir_path);
  try {
    // 创建文件
    fs.writeFileSync(file_path, str);
    log && console.log(colors.green(`写入文件   ${file_path}  完成`));
  } catch (err) {
    console.log(`写入文件   ${file_path}  出错`, err);
  }
};
/**
 * 创建文件
 * @param {*} file_path  目标地址
 * @param {*} str  文件内容
 */
export const write_file_silently = (raw_file_path, str) => {
  write_file(raw_file_path, str, false);
};
/**
 * 删除文件 或者文件夹
 * @param {*} file_path 目标地址
 */
export const remove_file = (raw_file_path) => {
  //带工作空间的全路径
  let file_path = compute_full_path(raw_file_path);
  try {
    let stats = fs.existsSync(file_path);
    // console.log("stats---------", stats);
    if (stats) {
      // console.log(`删除文件  ${file_path} 文件已存在 将进行删除-----`);
      fs.rmSync(file_path, { recursive: true, force: true });
    } else {
      // console.log(`删除文件  ${file_path} 文件不存在  -----`);
    }
  } catch (err) {
    console.log(`删除文件 ${file_path}  出错 ：`, err);
  }
};
/**
 *  复制文件
 * @param {*} raw_src_path  来源文件地址
 * @param {*} raw_target_path  目标文件地址
 * @param {*} log  打印日志
 */
export const copy_file = (raw_src_path, raw_target_path, log = true) => {
  //带工作空间的全路径
  let src_path = compute_full_path(raw_src_path);
  //带工作空间的全路径
  let target_path = compute_full_path(raw_target_path);
  //目录名字
  let target_dir_path = path.dirname(target_path);
  //确保目录存在
  ensure_write_folder_exist(target_dir_path);
  // 文件内容
  let file_content = fs.readFileSync(src_path);
  write_file(target_path, file_content, log);
};
/**
 *  复制文件
 * @param {*} raw_src_path  来源文件地址
 * @param {*} raw_target_path  目标文件地址
 */
export const copy_file_silently = (raw_src_path, raw_target_path) => {
  copy_file(raw_src_path, raw_target_path, false);
};
/**
 * 复制文件夹
 * @param {*} raw_src 来源目录
 * @param {*} raw_dist 目标目录
 */ 
export const copy_dir = function (raw_src, raw_dist) {
  //带工作空间的全路径
  let src = compute_full_path(raw_src);
  //带工作空间的全路径
  let dist = compute_full_path(raw_dist);
  //确保目录存在
  ensure_write_folder_exist(dist);
  var paths = fs.readdirSync(src);
  paths.forEach((p) => {
    var _src = src + "/" + p;
    var _dist = dist + "/" + p;
    var stat = fs.statSync(_src);
    if (stat.isFile()) {
      // 判断是文件还是目录
      copy_file(_src, _dist, false);
    } else if (stat.isDirectory()) {
      copy_dir(_src, _dist); // 当是目录是，递归复制
    }
  });
};
 
/**
 * 读取文件夹 下的子目录
 * @param {*} raw_src  需要读取的 文件目录
 * @returns 
 */
export const read_children_folder = (raw_src) => {
  //带工作空间的全路径
  let src = compute_full_path(raw_src);
  //确保目录存在
  ensure_write_folder_exist(src);
  var paths = fs.readdirSync(src);
  let children_folder = [];
  paths.forEach((p) => {
    var _src = src + "/" + p;
    var stat = fs.statSync(_src);
    if (stat.isFile()) {
      // 判断是文件还是目录
    } else if (stat.isDirectory()) {
      children_folder.push(p);
    }
  });
  return children_folder;
};
 

/**
 * 删除除了保护目录的之外的所有目录
 * @param {*} raw_src 需要删除的 文件目录
 * @param {*} exclude 需要保留的 直接 子目录
 */
export const remove_file_with_excluded = (raw_src, exclude = []) => {
  // 读取文件夹 下的子目录
  let children_folder = read_children_folder(raw_src);
  console.log("children_folder------- ", children_folder);
  // 要删除的目录
  lodash.pullAll(children_folder, exclude);
  //带工作空间的全路径
  let src = compute_full_path(raw_src);
  //循环删除
  children_folder.map((x) => {
    remove_file(src + "/" + x);
  });
};
/**
 * 扫描
 * 遍历指定目录下的所有 .scss/.js文件
 * @param {*} raw_dir 需要遍历 扫描 的 目录
 */
export const get_all_file = function (raw_dir, type = ".js") {
  //带工作空间的全路径
  let dir = compute_full_path(raw_dir);
  //确保目录存在
  ensure_write_folder_exist(dir);
  let res = [];
  function traverse(dir) {
    fs.readdirSync(dir).forEach((file) => {
      const pathname = path.join(dir, file);
      if (fs.statSync(pathname).isDirectory()) {
        traverse(pathname);
      } else {
        if (pathname.endsWith(type)) {
          res.push(pathname);
        }
      }
    });
  }
  traverse(dir);
  return res;
};

/**
 * 删除指定目录下的所有 .gz 文件
 * @param {*} raw_dir
 */
export  const remove_file_by_type = function (raw_dir,file_type='.gz',recursive=false) {
  //带工作空间的全路径
  let dir = compute_full_path(raw_dir)

let res = [];
function traverse(dir) {
 fs.readdirSync(dir).forEach((file) => {
   const pathname = path.join(dir, file);
   if (fs.statSync(pathname).isDirectory()) {
    if (recursive){
      // 递归遍历子目录
      traverse(pathname);
    }  
    
   } else {
     if (pathname.endsWith(file_type)) {
      console.log(`删除文件  ${pathname} 文件已存在 将进行删除-----`);
      fs.rmSync(pathname, {   force: true }); 
     }
   }
 });
}
traverse(dir);
return res;
};


/**
 * 
 * @param {*} file_path 需要读取文件 的短路径
 * @returns 
 */
export const read_file = (file_path) => {
  try {
    //带工作空间的全路径
    let full_path = compute_full_path(file_path);
    //文件内容
    let file_content = fs.readFileSync(full_path);
    return file_content;
  } catch (err) {
    console.log(`读取文件 ${file_path}  出错 ：`, err);
    return ``;
  }
};
/**
 * 
 * @param {*} full_path  需要读取文件 的全路径
 * @returns 
 */
export const read_file_full_path = (full_path) => {
  try {
    //文件内容
    let file_content = fs.readFileSync(full_path);
    return file_content;
  } catch (err) {
    console.log(`读取文件 ${full_path}  出错 ：`, err);
    return ``;
  }
};
/**
 * 
 * @param {*} source_file  需要 引入的 json 文件 路径
 * @returns 
 */
export const import_json_data = (source_file) => {
  // const  { default:json_data} = await import( subpath, { assert: { type: "json" }, } );
  //  return json_data
  //带工作空间的全路径
  let full_path = compute_full_path(source_file);
  // const json_data = JSON.parse( await readFile(new URL(subpath, import.meta.url)) );
  // const json_data = JSON.parse( await fs.readFile(  new URL(pathToFileURL(file_path ) )  ) );
  // console.log(' pathToFileURL(file_path ) ----', pathToFileURL(file_path ) );
  //文件内容
  let file_content = fs.readFileSync(source_file);
  // const json_data = JSON.parse( await fsPromises.readFile(  pathToFileURL(file_path ).href  )    );
  const json_data = JSON.parse(file_content);
  return json_data;
};
/**
 * 
 * @param {*} source_file  需要 引入的 js 文件 路径
 * @returns 
 */
export const import_js_data = async (source_file) => {
  //带工作空间的全路径
  let full_file_href = compute_full_file_href(source_file);
  //  const { default: barData } =
  //  await import('./bar.json', { assert: { type: 'json' } });
  let result = {};
  try {
    result = await import(full_file_href);
  } catch (err) {
    // result = error
    console.log(`读取文件 ${full_file_href}  出错 ：`, err);
  }
  // console.log( 'import_js_data-------', result );
  return result;
};









/**
 *  压缩文件
 * @param {*} source_dir 需要解压的目录
 * @param {*} target_dir 压缩后放置的目录
 * @param {*} file_name  压缩后文件名字
 */
export const archiver_file_to_zip = async (source_dir,target_dir, file_name) => {
  // let target_dir = "./zip-sdk/";
  // create a file to stream archive data to.
  ensure_write_folder_exist(target_dir);
  let target_path = compute_full_path(`${target_dir}${file_name}`) ;
  const output = fs.createWriteStream(target_path,{
    // flags:"w"
  });
  const archive = archiver("zip", {
    zlib: { level: 9 }, // Sets the compression level.
  });
  // listen for all archive data to be written
  // 'close' event is fired only when a file descriptor is involved
  output.on("close", function () {
    let size_kb = Math.ceil(archive.pointer() / 1024);
    let size_mb = (archive.pointer() / 1024 / 1024).toFixed(2);
    console.log("文件 压缩完成  文件流 关闭 .");
    console.log(`压缩后文件来源： ${source_dir}  `);
    console.log(`压缩后文件目录： ${target_dir}  `);
    console.log(`压缩后文件地址： ${target_path}  `);
    console.log(`压缩后文件大小： ${size_kb} KB`);
    console.log(`压缩后文件大小： ${size_mb} MB`);
  });
  // good practice to catch warnings (ie stat failures and other non-blocking errors)
  archive.on("warning", function (err) {
    if (err.code === "ENOENT") {
      // log warning
    } else {
      // throw error
      throw err;
    }
  });
  // good practice to catch this error explicitly
  archive.on("error", function (err) {
    throw err;
  });
  // // append files from a sub-directory and naming it `new-subdir` within the archive
  // archive.directory('subdir/', 'new-subdir');
  // // append files from a sub-directory, putting its contents at the root of archive
  // archive.directory('subdir/', false);
  archive.directory(compute_full_path(source_dir) , false);
  // pipe archive data to the file
  archive.pipe(output);
  archive.finalize();
};


/**
 * 解压 zip 文件
 * @param {*} source_file 需要解压的zip 文件
 * @param {*} target_dir  解压目标目录
 * @param {*} remove_old  是否清空解压目标目录
 * @param {*} newFilename 解压文件名字
 */
export const extract_zip_file =  async(source_file,target_dir,remove_old=false,remove_new=false,newFilename ) => {

  try {
   let file_name= path.basename(source_file,'.zip')
   console.log('解压  ',file_name)
    let  source = compute_full_path(source_file)
    target_dir = target_dir || `./dist/unzip-result/${file_name}/`
    if(remove_old){
      remove_file(target_dir)
    }
    
    let  target = compute_full_path(target_dir)

    await extractZip(source, { dir: target ,onEntry: (entry, zipfile) => {
      // 修改解压路径和文件名
      if (!entry.isDirectory && newFilename) {
          entry.fileName = newFilename;
      }
      return entry;
  }})
    if(remove_new) {
      remove_file(source_file)
    }
    console.log('解压 zip 文件 完成',source_file)
  } catch (err) {
    console.log('解压 zip 文件 出错',err)
    console.log('解压 zip 文件 出错',source_file)
  }

}



/**
 *  输出 带缩进 换行的 json 文件 
 * 
 */
export const  write_smart_json_file=(shore_file_path,json_obj)=>{

  try {
    let  file_path = compute_full_path(shore_file_path)
    writeJsonFileSync( file_path, json_obj)
    console.log(colors.green(`写入文件   ${file_path}  完成`))
  } catch (err) {
    console.log('输出 带缩进 换行的 json 文件  出错',err)
  }




}