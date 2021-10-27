一、Hive基本使用——数据类型
# 1、基本数据类型
tinyint, smallint, int, bigint, boolean, float, double, string, binary, timestamp, decimal, char, varchar, date
# 2、集合类型
array: #array类型由一系列相同数据类型的元素组成，可通过下标访问元素，例array[i]
map: #map包含key->value键值对，可以通过key访问元素，例map['key']
struct: #可以包含不同数据类型的元素，可通过"点语法"方式获得元素，里struct.key1

二、Hive表操作
# 显示所有表
show tables;
# 显示表的表述信息
desc [extended, formatted] tablename;
# 显示建表语句
show create table tablename;
# 删除表
drop table tablename;

三、相关注意项
# 1、关闭Hadoop的安全模式
hadoop dfsadmin -safemode leave
# 2、hive命令行显示当前所在的数据库
set hive.cli.print.current.db=true;
# 3、hive命令行显示查询的列表
set hive.cli.print.header=true;

四、建表实例
#创建数据表
drop table testtable;
create table if not exists testtable (
name string comment 'name value',
address string comment 'address value'
)
row format delimited fields terminated by '\t' lines terminated by '\n' stored as textfile;

#查看数据表描述信息
desc testtable;
desc extended testtable;
desc formatted testtable;

#从本地文件加载数据并覆盖掉原表中的数据
load data local inpath '/usr/local/src/data' overwrite into table testtable;
# 从本地文件加载数据，不覆盖原表中的数据
load data local inpath '/usr/local/src/data' into table testtable;

#创建一个外部表
drop table if exists employees;
create external table if not exists employees(
name string,
salary float,
subordinates array<string>,
deductions map<string, float>,
address struct<street:string, city:string, state:string, zip:int>
)
row format delimited fields terminated by '\t'
collection items terminated by ','
map keys terminated by ':'
lines terminated by '\n'
stored as textfile
location '/data/';

#插入employees中的数据格式
liuyazhuang	123	a1,a2,a3	k1:1,k2:2,k3:3	s1,s2,s3,9
提示
# 不通过MR查询的情况：
1、select * from 表 [limit count]
# 2、通过分区表的分区条件查询
五、Hive建表的其他操作
# 1、由一个表创建另一个表
create table lyz1 like lyz;
# 2、从其他表查询创建表
create table lyz1 as select name, addr from lyz;

六、Hive不同文件读取对比
1、stored as textfile
# 直接查看文件
hadoop fs -text
2、stored as sequencefile
hadoop fs -text
3、stored as rcfile
hive -service rcfilecat path
4、stored as inputformat 'class' outformat 'class'

七、Hive使用SerDe
SerDe是"Serializer"和"Deserializer"的简写
Hive使用SerDe(和FileFormat)来读、写表的行
读写数据的顺序如下：
    HDFS文件->InputFileFormat-><key, value>->Deserializer->row对象
    Row对象->Serializer-><key, value>->OutputFileFormat->HDFS

八、Hive分区表
1、分区
select查询,一般会扫描整表内容，消耗很多时间
Hive分区表,创建时指定partition分区空间

2、分区语法
create table tablename(name string) partitioned by (key type, ...)
3、创建一个分区表
drop table if exists employees;
create table if not exists employees(
name string,
salary float,
subordinates array<string>,
deductions map<string, float>,
address struct<street:string, city:string, state:string, zip:int>
)
# 分区表
partitioned by (st string, type string)
#指定分割符
row format delimited
fields terminated by '\t'
collection items terminated by ','
map keys terminated by ':'
lines terminated by '\n'
stored as textfile;

4、Hive分区表操作
1) 增加分区
alter table tablename add if not exists partition(country='xxx'[, state='yyy']);
2) 删除分区
alter table tablename drop if exists partition(country='xxx'[,state='yyyy']);
3) 查看表中的分区
show partitions tablename;

九、Hive分桶
1、分桶
# 对于每一个表(table)或者分区，Hive可以进一步组成桶，也就是说桶是更为系列度的数据范围划分。
# Hive是针对某一列进行分桶。
# Hive采用对列值哈希，然后除以桶的个数求余的方式决定该条记录存放在哪个桶中。
2、好处
# 获得更高的查询处理效率
# 使取样更高效

3、分桶实例
drop table if exists bucketed_user;
create table if not exists bucketed_user(
id int,
name string
)
clustered by(id) sorted by(name) into 4 buckets
row format delimited fields terminated by '\t'
sorted as textfile;
 
set hive.enforce.bucketing=true;
 
insert overwrite table bucketed_user select addr, name from testtext;
————————————————
链接：https://blog.csdn.net/l1028386804/article/details/80547441