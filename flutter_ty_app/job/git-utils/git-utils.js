import shell from "shelljs";
if (!shell.which("git")) {
  shell.echo("Sorry, this script requires git");
  shell.exit(1);
}
export const get_git_info = () => {
  // let fetch_remote_address =
  //仓库地址
  let fetch_remote_address = shell
    .exec("git remote -v  ")
    .toString()
    .split("\n")[0];
  fetch_remote_address = fetch_remote_address.trim().replace("\n", " ");
  let fetch_remote_address_arr = fetch_remote_address
    .split(" ")
    .filter((x) => x.includes("http"));
  let address = (fetch_remote_address_arr[0] || "").trim();
  if (address) {
    if (address.includes("\t")) {
      address = address.split("\t")[1];
    }
  }
  let name = "";
  if (address) {
    let name_arr = address.split("/");
    name = name_arr[name_arr.length - 1];
    name = name.split(".")[0];
  }
  console.log("git --address-----", address);
  console.log("git --name-----", name);
  return {
    address,
    name,
    
  };
};
console.log("git --解析-----", get_git_info());
