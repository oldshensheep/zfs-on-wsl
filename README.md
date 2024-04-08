# ZFS-on-WSL

## 安装过程

```bash
git clone https://github.com/oldshensheep/zfs-on-wsl
```

配置 `config.sh` 设置zfs版本，内核版本等

安装依赖 (用的APT包管理器)，我自己使用的是ArchLinux，如果有问题，或者是其他系统可参照<https://openzfs.github.io/openzfs-docs/Developer%20Resources/Building%20ZFS.html#installing-dependencies>

```bash
./install_deps.sh
```

编译在wsl2中编译zfs

```bash
./build_kernel.sh
```


编译完成后修改`config.sh`中的`WSL_CONFIG_PATH` 需修改`${username}`为自己的用户名。  
然后执行脚本替换内核和zfs utils，安装完成后需要重启wsl才能生效。  
`install_zfs_kernel.sh`会修改wsl的配置文件，所以不用手动修改了。

```bash
./install_zfs_kernel.sh
./install_zfsutils.sh
```

安装完成后输入`sudo zfs version`查看是否安装成功，成功会输出类似：

```bash
zfs-2.1.4-0ubuntu0.1
zfs-kmod-2.1.5-1
```
