# ZFS-on-WSL

**ZFS的源码在Python版本大于等于3.10的环境下编译会不通过**，代码有BUG……

见<https://github.com/openzfs/zfs/issues/12045> 官方暂未发布新版本修复这个问题，现可以自行选择其他分支编译，或者更改python版本。

安装方法有2种
1. 下载bzImage，更改WSL2的内核为bzImage，并重启WSL2。在WSL2中安装zfsutils。
2. 自行编译bzImage，更改WSL2的内核为bzImage，并重启WSL2。通过`install-mod.sh`脚本安装自行编译的zfs管理工具

如果是系统安装的zfsutils比较新的话建议使用第一种方法。
## 方法一 安装过程

在此 https://github.com/oldshensheep/zfs-on-wsl/releases 下载编译好的支持ZFS的Kernel，下载bzImage，放到 **Windows** 的一个地方。
然后在PowerShell窗口中执行以下命令：
注意把`<bzImage Path>`替换成你下载的bzImage的路径，例如`C:\\Fun\\bzImage`
```pwsh
"
[wsl2]
kernel=<bzImage Path>
" > ~/.wslconfig
```

然后`wsl --shutdown`关闭运行中的实例，然后重新启动Ubuntu。

重启后在Ubuntu中安装zfsutils-linux
```bash
sudo apt install zfsutils-linux 
```

安装完成后输入`sudo zfs version`查看是否安装成功，成功会输出类似：
```bash
sheep@sheep-laptop ~> sudo zfs version
zfs-2.1.4-0ubuntu0.1
zfs-kmod-2.1.5-1
```
`zfs-kmod-2.1.5-1`是内核中的ZFS模块，在bzImage内

`zfs-2.1.4-0ubuntu0.1`是安装的管理工具。版本差别过大可能有BUG。

zfsutils-linux 的版本太老了可能会出BUG，可以自行编译。

## 方法二 安装过程

**在Ubuntu20.04 LTS环境下测试成功**

```bash 
git clone https://github.com/oldshensheep/zfs-on-wsl.git
cd zfs-on-wsl
source ./config.sh
./build_kernel.sh
./install-mod.sh
```
然后同样的把HOME目录里的bzImage放到Windows的一个地方，更改WSL2的内核…… 参考方法一。
