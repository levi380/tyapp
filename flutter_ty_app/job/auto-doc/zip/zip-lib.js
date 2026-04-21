 
import {
  copy_dir,
  remove_file,
  archiver_file_to_zip,
  format_date,
  copy_file
} from "../../file-utils/write-folder-file.js";
remove_file("./dist/auto-doc-lib/");

copy_dir("./job/auto-doc/", "./dist/auto-doc-lib/job/auto-doc/");
copy_dir("./job/file-utils/", "./dist/auto-doc-lib/job/file-utils/");
copy_dir("./job/git-utils/", "./dist/auto-doc-lib/job/git-utils/");
copy_dir("./job/merge-job-lib-config/", "./dist/auto-doc-lib/job/merge-job-lib-config/");
copy_dir("./job/merge-gitignore/", "./dist/auto-doc-lib/job/merge-gitignore/");
archiver_file_to_zip( "./dist/auto-doc-lib/", "./dist/", `auto-doc-lib-${ format_date(Date.now())}.zip`   );

 