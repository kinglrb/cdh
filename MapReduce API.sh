# MapReduce程序开发流程：
遵循算法思路、Mapper、Reducer、作业执行的步骤。

# MapReduce程序，包含两部分：map和reduce
map和reduce的设计，取决解决问题的算法思路
map和reduce的执行需要作业的调度。

# MapReduce开发遵循流程
	分析问题，确定解决问题的算法思路。
	设计和实现mapreduce程序中的Mapper
	设计和实现mapreduce程序中的Reducer
	设置作业调度
mapreduce程序是函数型编程，体现“分而治之”的思想

# 编写MapReduce程序的步骤
–编写一个Mapper类
–编写一个Reducer类
–编写一个Driver类（即Job），将Mapper与Reducer类组合
# --------------------------------------------------------------
# MapReduce(JAVA)API

# Mapper
public class WordMapper extends MapReduceBase implements  
        Mapper<LongWritable, Text, Text, IntWritable> {  
    private final static IntWritable one = new IntWritable(1);  
    private Text word = new Text();  
    @Override  
    public void map(LongWritable key, Text value,OutputCollector<Text, IntWritable> output, Reporter reporter)  
            throws IOException {  
        String line = value.toString();  
         for(String word : s.split("\\W+")){  
                            if(word.length()>0){  
                output.collect(new Text(word),new IntWritable(1));  
                     }  
                        }     
            }  
}  

# Reducer
public class WordReducer extends MapReduceBase implements  
Reducer<Text, IntWritable, Text, IntWritable>{  
      
    @Override  
    public void reduce(Text key, Iterator<IntWritable> values,OutputCollector<Text, IntWritable> output, Reporter reporter)  
            throws IOException {  
        Int sum = 0;  
        while (values.hasNext()) {  
            sum += values.next().get()+sum;  
        }  
        output.collect(key, new IntWritable(sum));  
    }  
  
} 
# 新版Mapper  API
– org.apache.hadoop.mapreduce Class Mapper<KEYIN,VALUEIN,KEYOUT,VALUEOUT>
# 新版 Reducer API
– org.apache.hadoop.mapreduce Class Reducer<KEYIN,VALUEIN,KEYOUT,VALUEOUT>
 # Job运行模式
# MapReduce程序三种运行模式
–
–Local(Standalone) Mode：只用一个Java虚拟机，不采用分布式，不使用HDFS文件系统，使用本机Linux文件系统。
# –Pseudo-distributed Mode：同一台机器上启动数个独立 JVM 进程，每个hadoop daemon运行在一个单独的JVM进程中，“伪分布式”操作。
–Fully-distributed Mode：运行于多台机器上的分布式模式。
# Standalone mode 使用local filesystem 以及 local MapReducer job runner
# Distributed mode 使用HDFS 以及 MapReduce daemons
 
# 对应的配置文件
# conf/core-site.xml为Hadoop设定默认的文件系统
<configuration>
	<property>
		<name> fs.default.name </name>
		<value>       VALUE      </value>
	</property>
</configuration>
Standalone mode:    VALUE=file:///
Pseudo-distributed mode: VALUE=hdfs://localhost:9000
Fully-Distributed mode：   VALUE=hdfs://namenode
# conf/mapred-site.xml
<configuration>
	<property>
		<name> mapred.job.tracker </name>
		<value>            VALUE         </value>
	</property>
</configuration>
Standalone mode:          VALUE=local
Pseudo-distributed mode: VALUE=localhost:9001
Fully-Distributed mode：   VALUE=jobtracker:9001

# HDFS client使用这个属性决定NameNode的位置，这样HDFS client就可以连接到该NameNode.

# 程序调试
# 打包
在项目上，选择[File]=>Export，导出项目为一个jar包
# 启动
hadoop jar yourjar.jar mainClassName  -conf inputfolder outputfolder
# MapReduce网络用户界面
– url  http://localhost:50030/
# 获取结果
–Hadoop fs –ls outputfolder
# 调试作业
–加入传统的Log输出
–使用Reporter 来做错误源的输出比对

# Mapreduce工作流
将问题分解成MapReduce作业
在Word Count程序中，求出单词出现频率的总和
  单词中包含大写字母H的则转换为小写
  在Word Count程序中，求出单词出现频率的总和与单词的个数
# 运行作业
  –假设有Job1，Job2，需要运行
   线性作业
      JobClinet.runjob(conf1)
      JobClinet.runjob(conf2)
   环形作业
  –
  –可以通过Hadoop自带的JobControl运行