# 工作流程
sql语法解析器，调用MR程序模板库，生成MR程序，交给MR提交器，提交给yarn执行

SLF4J: Class path contains multiple SLF4J bindings.
# 包含多个日志依赖
hive和hadoop中的SLF4J jar包重复
位置：
/usr/local/hive/lib/
/usr/local/hadoop/share/hadoop/common/lib/
# 解决办法：
删除一个即可
rm -rf slf4j-log4j12-1.7.25.jar
建议删除低版本

Exception in thread "main" java.lang.NoSuchMethodError: com.google.common.base.Preconditions.checkArgument(ZLjava/lang/String;Ljava/lang/Object;)
# hadoop和hive的两个guava.jar版本不一致
目录：
/usr/local/hive/lib/
/usr/local/hadoop/share/hadoop/common/lib/
# 解决：
删除低版本，将高版本的复制到低版本目录下


# java.net.URISyntaxException: Relative path in absolute URI: ${system:java.io.tmpdir%7D/$%7Bsystem:user.name%7D
解决
# hive-site.xml将"${system:Java.io.tmpdir}"全替换成"/hive/tmp"
sed -i 's#${system:Java.io.tmpdir}#/hive/tmp#g' hive-site.xml
或将字段<value></value>,改为目录/hive/tmp：如：
<property>
    <name>hive.querylog.location</name>
    <value>${system:java.io.tmpdir}/${system:user.name}</value>
    # <value>/hive/tmp</value>
    <description>Location of Hive run time structured log file</description>
  </property>

# hive-site.xml需配置system:java.io.tmpdir属性
# 配置文件中加入：
<property>
  <name>system:java.io.tmpdir</name>
  <value>/usr/local/hive/tmp</value>
</property>
  
# hive 报错：Relative path in absolute URI: ${system:java.io.tmpdir%7D/$%7Bsystem:user.name%7D
解决：
<property>
  <name>hive.exec.local.scratchdir</name>
  <value>$HIVE_HOME/iotmp</value>
  <description>Local scratch space for Hive jobs</description>
</property>

<property>
  <name>hive.querylog.location</name>
  <value>$HIVE_HOME/iotmp</value>
  <description>Location of Hive run time structured log file</description>
</property>

<property>
  <name>hive.downloaded.resources.dir</name>
  <value>$HIVE_HOME/iotmp</value>
  <description>Temporary local directory for added resources in the remote file system.</description>
</property>  
  
  
message from server: “Host ‘192.168.1.9’ is blocked because of many connection errors; unblock with unblock with ‘mysqladmin flush-hosts’”
# 原因：同一ip在短时间内产生太多中断连接,超过max_connection_errors最大值,导致阻塞；
解决：
1、提高max_connect_errors
# 查看max_connect_errors： 
show variables like ‘max_connect_errors’;
# 修改max_connect_errors数量为1000： 
set global max_connect_errors = 1000;

2、使用mysqladmin flush-hosts命令清理hosts文件
# 查找mysqladmin的路径
whereis mysqladmin
清理：
/usr/bin/mysqladmin flush-hosts -h192.168.1.121 -uroot -p
# 可在数据库执行：
mysql> flush hosts;  
# 备注：
master/slave主从数据库，要把主库和从库都改一遍

Public Key Retrieval is not allowed
# 连接url上加：allowPublicKeyRetrieval=true

hive客户端beeline执行sql不打印日志
# 单独去掉日志
beeline --hiveconf hive.server2.logging.operation.level=NONE
# hive-site.xml中，禁止beeline显示额外信息
  <property>
    <name>hive.server2.logging.operation.enabled</name>
    <value>true</value>
  </property>
  <property>
    <name>hive.server2.logging.operation.log.location</name>
    <value>/opt/log/hive/operation_logs</value>
  </property>


which: no hbase in (.:/usr/java/jdk1.8/bin:/bin:/bin:/usr/local/hadoop/bin:
# 配环境变量：
export PUB_KEY_HOME=~/.ssh/id_rsa
export DATA_HOME=/usr/local
export ZOO_DATADIR=$DATA_HOME/data/zoo
export ZOO_LOG_DIR=$DATA_HOME/logs/zookeeper
export ANACAONDA_HOME=/usr/local/anaconda3

export JAVA_HOME=/usr/local/jdk1.8
export HBASE_HOME=/usr/local/hbase
export HIVE_HOME=/usr/local/hive
export HADOOP_HOME=/usr/local/hadoop
export HADOOP_COMMON_HOME=/usr/local/hadoop
export HADOOP_MAPRED_HOME=/usr/local/hadoop
export SQOOP_HOME=/usr/local/sqoop
export ZOOKEEPER_HOME=/usr/local/zookeeper
export LD_LIBRARY_PATH=/usr/local/hadoop/lib/native
export SPARK_HOME=/usr/local/spark
export SCALA_HOME=/usr/local/scala

export CLASSPATH=.:$JAVA_HOME/lib:$JAVA_HOME/jre/lib:$SQOOP_HOME/lib:$SCALA_HOME/lib:$SPARK_HOME/jars:$CLASSPATH
export PATH=$ZOOKEEPER_HOME/bin:$ANACAONDA_HOME/bin:$HADOOP_HOME/bin:$HADOOP_HOME/sbin:$JAVA_HOME/bin:$JAVA_HOME/jre/bin:$HBASE_HOME/bin:$HIVE_HOME/bin:$SQOOP_HOME/bin:$SPARK_HOME/sbin:$SPARK_HOME/bin:$SCALA_HOME/bin:$PATH

# ----------------------------------------
# 建表并指定分割符
# 1,tom,18
create  table  db_hiveTest.student(id int,name string)  
row  format  delimited  fields   terminated  by  ',';
#复杂分割
# 集合
# zs	beijing,shanghai,hangzhou
create table testTable1(name string，work_location array<string> 
ROW format delimited fields terminated by '\t' 
collection items terminated by  ',';
#集合+kv
1,las,唱歌:非常喜欢-跳舞:喜欢-游泳:一般
2,jim,唱歌:喜欢-跳舞:喜欢-游泳:一般
3,kal,唱歌:喜欢-跳舞:喜欢-游泳:一般
create table testTable2(id int,name string,hobby map<string,string>) 
row format delimited fields terminated by ',' 
#集合
collection items terminated by '-' 
#kv
map keys terminated by ':' ;

#分区表partitioned
create  table part_table(id int,name string) partitioned by (hour string,country string) 
row  format  delimited  fields   terminated  by  ',';
# 分区表导入数据文件
load data local 
# local从操作系统本地文件系统导入，省略，则从hdfs导入
LOAD DATA local INPATH '/opt/..' INTO TABLE Tname [partition(field='')]
#无分区表，则去除partition()

#分桶表cluster
create table buck_Table(id int,name string) 
clustered by (id) into 4 buckets
row format delimited fields terminated by ',';
#导数
insert overwrite table stu_buck select * from student cluster by (id);

#外部表external table...location
create  external table  student_ext(id int,name string)  
row  format  delimited  fields   terminated  by  ',' location '/root/filename';

#多重插入
from source_table
insert overwrite table tbA
select id
insert overwrite table tbB
select name;

#动态分区插入
insert overwrite table tbname partition (fieldA,fieldB)
select fieldC,substr(field,1,3) as fieldA,fieldB
from dynamic_partition_table;

# insert导出数据到文件
insert overwrite local directory '/user/...' select ... from ...

#多字符分隔符建表
create table tn(id int,name string)
row format serde 'org.apache.hadoop.hive.serde2.RegexSerDe'
with serdeproperties(
'input.regex'='(.*)\\|\\|(.*)',
'output.format.string'='%1$s %2$s'
)
stored as textfile;
# input.regex 输入的正则表达式，表示||两边任意字符被抽取为一个字段
# output.format.string输出的正则表达式，%1$s %2$s分别表示表中第一、二个字段
#使用RegexSerDe类时，所有字段必须为string
