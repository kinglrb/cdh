Hadoop3编译
# --------------------------------3.2.2----------------------
# centos7.7
# jdk-8u231-linux-x64.tar.gz （hadoop 3.3.x需jdk 1.8）
https://www.oracle.com/java/technologies/javase/javase-jdk8-downloads.html
# apache-maven-3.8.1-bin.tar.gz
https://maven.apache.org/download.cgi
# protobuf-2.5.0.tar.gz（只能用2.5.0版本）
https://github.com/protocolbuffers/protobuf/releases/tag/v2.5.0
# cmake3.20.2
https://cmake.org/files/v3.20/cmake-3.20.2.tar.gz
# apache-ant-1.10.10-bin.tar.gz
https://ant.apache.org/bindownload.cgi
# findbugs-3.0.1.tar.gz
http://findbugs.sourceforge.net/downloads.html
# hadoop-3.2.2-src.tar.gz
https://archive.apache.org/dist/hadoop/common/hadoop-3.2.2/hadoop-3.2.2-src.tar.gz
# -------------------------------------------安装依赖包：
yum install gcc gcc-c++ gcc-header make autoconf automake libtool curl lzo-devel zlib-devel openssl openssl-devel ncurses-devel snappy snappy-devel bzip2 bzip2-devel lzo lzo-devel lzop libXtst zlib -y
# 解压文件： 
tar -zxvf jdk-8u201-linux-x64.tar.gz
tar -zxvf apache-ant-1.10.10-bin.tar.gz
tar -zxvf findbugs-3.0.1.tar.gz
tar -zxvf cmake-3.20.2-linux-x86_64.tar.gz
tar -zxvf hadoop-3.3.0-src.tar.gz

tar -zxvf protobuf-2.5.0.tar.gz
cd protobuf-2.5.0
./configure && make && make check && make install
# 重建/etc/ld.so.cache文件

vim /etc/profile：
export JAVA_HOME=/opt/jdk1.8
export PROTOBUF_HOME=/opt/protobuf-2.5
export MAVEN_HOME=/opt/maven-3.8
export CMAKE_HOME=/opt/cmake-3.20
export ANT_HOME=/opt/ant-1.10
export FIND_BUGS_HOME=/opt/findbugs-3.1
export PATH=$JAVA_HOME/bin:$PROTOBUF_HOME:$MAVEN_HOME/bin:$CMAKE_HOME/bin:$ANT_HOME/bin:$FIND_BUGS_HOME/bin:$PATH

cd hadoop-3.3.0-src：
mvn clean package -DskipTests -Pdist,native -Dtar

# -------------------------------Hadoop-3.1.3
# CentOS7.4
# 1、jdk-8u231-linux-x64.tar.gz （hadoop3.1.3需jdk 1.8）
https://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html
# 2、apache-maven-3.6.2-bin.tar.gz（Maven项目管理工具3.5以上即可，用以编译hadoop源码）
https://maven.apache.org/download.cgi
# 3、protobuf-2.5.0.tar.gz
https://github.com/protocolbuffers/protobuf/releases/tag/v2.5.0
# 4、cmake-3.13.5.tar.gz（编译hadoop 3.1.3，至少需要cmake3.1以上，推荐cmake3.7以上）
https://cmake.org/files/v3.13/
https://cmake.org/download/
# 5、apache-ant-1.10.7-bin.tar.gz（可不安装，选1.10.5或1.10.7即可，1.10.6与JDK1.8可能有点冲突）
https://www.apache.org/dist/ant/binaries/
# 6、findbugs-3.0.1.tar.gz（可不安装）
https://sourceforge.net/projects/findbugs/
http://findbugs.sourceforge.net/downloads.html
# 7、hadoop-3.1.3-src.tar.gz
https://hadoop.apache.org/releases.html
# -----------------------------------------------解压软件包
# jdk、maven、ant、findbugs、cmake解压至/opt；
# protobuf解压至当前路径，需要编译； 
# hadoop源码解压至工作路径
tar -zxvf jdk-8u231-linux-x64.tar.gz -C /opt/java/
tar -zxvf apache-maven-3.6.2-bin.tar.gz -C /opt/maven/
tar -zxvf protobuf-2.5.0.tar.gz
tar -zxvf cmake-3.13.5.tar.gz -C /opt/cmake/
tar -zxvf apache-ant-1.10.7-bin.tar.gz -C /opt/ant/
tar -zxvf findbugs-3.0.1.tar.gz -C /opt/findbugs/
tar -zxvf hadoop-3.1.3-src.tar.gz -C /home/wuyunfeng/workspace/hadoop-3.1.3-src
 
sudo vim /etc/profile
	export JAVA_HOME=/opt/java
	export PATH=$JAVA_HOME/bin:$PATH
	export MAVEN_HOME=/opt/maven
	export PATH=$MAVEN_HOME/bin:$PATH
	export PROTOC_HOME=/opt/protobuf
	export PATH=$PROTOC_HOME/bin:$PATH
	export ANT_HOME=/opt/ant
	export PATH=$ANT_HOME/bin:$PATH	
	export FINDBUGS_HOME=/opt/findbugs
	export PATH=$FINDBUGS_HOME/bin:$PATH	
source /etc/profile
java -version
mvn -v 
protoc --version
ant -version
findbugs -version
cmake -version
# ---------------------------装高版cmake
# 删除cmake：
yum erase cmake
tar -zxvf cmake-3.13.5.tar.gz -C /opt/cmake
cd /opt/cmake
./configure
sudo make && make install

# -------------------安装依赖包,注意顺序
yum install gcc gcc-c++
yum install make
# yum install cmake
yum install autoconf automake libtool curl
yum install lzo-devel zlib-devel openssl openssl-devel ncurses-devel
yum install snappy snappy-devel bzip2 bzip2-devel lzo lzo-devel lzop libXtst
# 3.2.2增加依赖gcc-header zlib glibc-headers，不确定是否需求
# --------------------安装ProtocolBuffer2.5.0
# 安装JDK及全部依赖包后,编译ProtocolBuffer2.5.0
cd /data/protobuf-2.5.0
# --prefix=XXX"将软件编译至XXX路径"
./configure --prefix=/opt/protobuf
make && make install

# -------------------------------编译Hadoop 3.1.3
cd 
mvn clean package -DskipTests -Pdist,native -Dtar
mvn clean package -DskipTests -Pdist,native -Dtar -Dsnappy.lib=/opt/ -Dbundle.snappy  
# 修改-Dsnappy.lib路径
# 第一次编译,maven需要下载很多jar包，时间可能会很久

# 编译后文件路径
hadoop-3.1.3-src/hadoop-dist/target/hadoop-3.1.3.tar.gz
# -----------------------------------------------------------------
