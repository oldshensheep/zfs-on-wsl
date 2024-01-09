# ZFS-on-WSL

## 安装过程

```bash
git clone https://github.com/oldshensheep/zfs-on-wsl
```

配置 `config.sh` 设置zfs版本，内核版本等

安装依赖 (用的APT包管理器)

```bash
./install_deps.sh
```

编译在wsl2中编译zfs

```bash
./build_kernel.sh
```

注意把`<bzImage Path>`替换成你下载的bzImage的路径，例如`C:\\Fun\\bzImage`

编译完成后把bzImage复制到Windows的文件系统中，任何修改`C:\User\<username>\.wslconfig`

```ini
[wsl2]
kernel=<bzImage Path>
```

然后`wsl --shutdown`关闭运行中的实例，然后重新启动WSL2。

重启后在WSL2中安装zfsutils

```bash
./install_zfsutils.sh
```

安装完成后输入`sudo zfs version`查看是否安装成功，成功会输出类似：

```bash
zfs-2.1.4-0ubuntu0.1
zfs-kmod-2.1.5-1
```
