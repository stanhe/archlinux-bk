# Install archlinux automatically

## 安装 arch
![install](http://pcnl48lkv.bkt.clouddn.com/arch/install.gif)
下载最新的archlinux.iso文件
烧录并启动 [my_iso](https://pan.baidu.com/s/1xxsRbA7_TXVXWMro9sYMcQ)

手动分区，使用cfdisk

我的分区方案

> 分为5个分区，且从逻辑分区5开始，不需要对分区格式化和创建路径。

* sda5 -> /
* sda6 -> swap
* sda7 -> boot
* sda8 -> var
* sda9 -> home

``` 
;; 运行脚本前只需要完成5个分区就行
;; 输入下面指令执行脚本

sh -c "$(wget https://gitee.com/stanhe/rollback-arch/raw/master/install.sh -O -)"
```
安装过程只需要一些确认步骤，点击enter 或 y enter，安装过程会要求输入 root密码和 stan用户的密码，完成后自动重启。
完成安装后就可以安装自己喜欢的桌面及其他相关软件了。

## 系统恢复(我的软件备份)

### 恢复系统

```
;; login with root
visudo ;;修改wheel组的权限为 NOPASSWD
su - stan
sudo pacman -S wget
sh -c "$(wget https://gitee.com/stanhe/rollback-arch/raw/master/rollbk.sh -O -)"

;;脚本运行后会自动重启，但是修改了zsh却缺少依赖，所以不能登入stan帐号，这时先登入root，再切换到 stan 执行 bksys

;; login with root
su - stan
bksys 
sudo reboot

```
所有更新完成，系统恢复完成。

### 错误
```
;;error:i3blocks:...说明镜像中i3blocks不可用了，需要删除.shell/pkglist中的i3blocks才能完成回滚,自动重启。

;;完成bksys后修改/etc/pacman.conf，然后更新arch官方镜像下载i3blocks.
sudo pacman -S archlinux-keyring
sudo pacman -S i3blocks

```

