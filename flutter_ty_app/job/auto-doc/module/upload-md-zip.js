 
import axios from "axios"
 
read_file
 
import {
    read_file
 
  } from "../../file-utils/write-folder-file.js";


const  axios_instace = axios.create({
    baseURL:"http://doc-server.dbsportxxxkd1.com",
    // baseURL:"http://127.0.0.1:18101",
    timeout: 10000, // 10 seconds timeout
    headers: {
        'Content-Type':'multipart/form-data'
    }  // form-data 格式上传
})

// // axios_instace.baseURL = 'http://127.0.0.1:18101/'
// axios_instace.baseURL = 'http://doc-server.dbsportxxxkd1.com'

// // axios_instace.defaults.headers.post['Content-Type'] = 'application/x-www-form-urlencoded'
// axios_instace.headers['Content-Type'] = 'multipart/form-data"'





/**
 * 上传 zip 文件 到 服务器
 */


export const  upload_md_zip= async(config)=>{

    
//     formData.append("file", new Blob([req.body.data]), "test.png");



// formData.append("file", new Blob([fs.readFileSync(req.body.data)]), "test.png");

const formdata = new FormData();
formdata.append("file", new Blob([read_file(config.file_path)]), config.file_name );
formdata.append("projectName", config.project_name);


 const   {data}=   await axios_instace.post("openapi/uploadzip", formdata )

 console.log('上传文件 -------',data);



}