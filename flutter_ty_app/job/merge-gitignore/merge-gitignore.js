import * as fs from "node:fs";
import * as path from "node:path";
import lodash from "lodash";
import {
  get_all_file,
  read_file,
  read_file_full_path,
  write_file,
  write_file_silently,
  compute_short_path,
  remove_file,
  format_date,
  copy_file,
  format_now,
 
  write_smart_json_file
} from "../file-utils/write-folder-file.js";


/**
 *  重写 git  配置文件 
 * @param {*} add_arr 
 */

export const merge_gitignore =(add_arr=[])=>{
 
  let content= read_file(".gitignore").toString()

  let arr= content.split("\n").filter(x=>x)

  let new_arr=[]
    arr.map(x=>{
      new_arr.push(x.trim())
  })

  let new_add=''

  add_arr.map(x=>{
    if(!new_arr.includes(x)){
      new_add += `${x}\n`
    }
  })
 

  if(new_add){
    content+='\n'
    content+=new_add
  }

  write_file(".gitignore",content)
 



}