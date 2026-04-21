

 


/**
 * 
 * 
【【【 AUTO_DOCUMENT_MENU  2000工具/1自动化生成文档工具 】】】
【【【 AUTO_DOCUMENT_TITLE  自动化生成文档工具 】】】
【【【 AUTO_PARAGRAPH_TITLE 项目文档传承难点】】】
【【【 AUTO_PARAGRAPH_CONTENT 

1. 项目较大，迭代快速
2. 人员惰性
3. 一条逻辑线 可能涉及多个文件
4. 一个文件可能涉及 多个逻辑

】】】
 * 
 */



 






/**
 * 
 * 
【【【 AUTO_DOCUMENT_UUID  cc-44fabe66-fb60-47cc-a597-f4548d6bdeb1 】】】
【【【 AUTO_DOCUMENT_MENU  2000工具/1自动化生成文档工具 】】】
【【【 AUTO_DOCUMENT_TITLE  自动化生成文档工具 】】】
【【【 AUTO_PARAGRAPH_TITLE 半自动步骤】】】
【【【 AUTO_PARAGRAPH_CONTENT 

 
```bash
#更优化的 半自动步骤 还需要 全栈支持 ，暂时无人力，先这样用吧 

# 修改 package.json 
# 项目根目录下如果有 package.json  则  修改 package.json   增加或者修改属性 "type": "module" 
# 如果没有 就 npm init  一路回车  创建一个空的  package.json  增加或者修改属性 "type": "module" 
 
# 安装基础依赖
npm  i -D  axios lodash  archiver colors cross-env extract-zip highlight.js live-server markdown-it npm-run-all open shelljs randomstring write-json-file

# 合并配置
node ./job/auto-doc/process/merge-config-file.js

# 还原 配置（如果需要还原配置）
node ./job/auto-doc/process/restore-config-file.js

```

】】】
 * 
 */



















/**
 * 
 * 
【【【 AUTO_DOCUMENT_TITLE  自动化生成文档工具 】】】
【【【 AUTO_PARAGRAPH_TITLE 安装 】】】
【【【 AUTO_PARAGRAPH_CONTENT 

```bash

# 1.1 下载并安装 nodejs   20 版本 最好  14 以上 都可以 
# https://nodejs.org/dist/


# 1.2 确认 nodejs 版本
node -v


# 1.3 解压 工具包 到项目根目录下
 

# 1.4 执行上面的半自动步骤 命令
#  脚本会自动 组合 生成 jobs.config.json ，  package.json ，jobs.config.js
#  字段注释看 jobs.config.js ，默认没有开启打包上报
 

# 1.4 安装 插件
npm i   

 
# 1.6 启动命令
npm run ada


# 1.7 其他的几个命令 自己看 package.json  scripts 部分 的 键  
npm run 对应的键执行


```



】】】
 * 
 */
 

/**
 * 

 
【【【 AUTO_PARAGRAPH_TITLE 自动化生成文档工具逻辑】】】
【【【 AUTO_PARAGRAPH_CONTENT 

通过关键字 正则匹配 分组 解析文本
AUTO_

### 容器符号  
> 三对中文中括号


### 文档菜单  可以带/正斜线 生成多层菜单
>关键字： AUTO_ DOCUMENT_MENU   把中间的空格去掉
注意 这个字段只要 同一个  DOCUMENT_TITLE 全局配置一次就可使用
排序
排序：每一阶段菜单前面加数字，可以不写
排序示例：  555工具/666教学/71代码片段



### 文档标题
> 关键字： AUTO_ DOCUMENT_TITLE   把中间的空格去掉
注意 这个字段 单个文档内必须至少配置一次 ，
如果只有一个标题 代表这个文档内的所有文档注释都是 这个标题下的内容
如果有多个 ，则每个 注释片段都带上 这个字段 
否则会自动用 此文件内第一次 配置  DOCUMENT_TITLE 的 值
排序
排序： 每一标题前面加数字，可以不写
排序示例：  123工具执行流程介绍文档

 
 


### 段落标题
> 关键字： AUTO_ PARAGRAPH_TITLE   把中间的空格去掉
排序
排序： 每一标题前面加数字，可以不写
排序示例：  555工具执行流程

 

### 段落内容
> 关键字： AUTO_ PARAGRAPH_CONTENT   把中间的空格去掉
 
 

 
】】】
 * 
 */

/**
 * 

 
【【【 AUTO_PARAGRAPH_TITLE 注意点】】】
【【【 AUTO_PARAGRAPH_CONTENT 

- 内容 可以换行 
- 关键字必须大写
- 三个中括号 之间不能有空格
- 建议每次注释 这三个关键字都写上 ,DOCUMENT_MENU 可以只配置一次就足够
- 如果过单个文件内不写文档标题 则会 用文件路径生成文档标题
- 如果过单个文件内不写段落标题 则会 用空标题 提示 占位
 
】】】

 * 
 */


/**
 * 
 * 
【【【 AUTO_DOCUMENT_TITLE 1自动化生成文档工具 】】】
【【【 AUTO_PARAGRAPH_TITLE 项目文档传承难点】】】
【【【 AUTO_PARAGRAPH_CONTENT 

1. 测试一下
 
】】】
 * 
 */
