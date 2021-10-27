# MapReduce���򿪷����̣�
��ѭ�㷨˼·��Mapper��Reducer����ҵִ�еĲ��衣

# MapReduce���򣬰��������֣�map��reduce
map��reduce����ƣ�ȡ�����������㷨˼·
map��reduce��ִ����Ҫ��ҵ�ĵ��ȡ�

# MapReduce������ѭ����
	�������⣬ȷ�����������㷨˼·��
	��ƺ�ʵ��mapreduce�����е�Mapper
	��ƺ�ʵ��mapreduce�����е�Reducer
	������ҵ����
mapreduce�����Ǻ����ͱ�̣����֡��ֶ���֮����˼��

# ��дMapReduce����Ĳ���
�C��дһ��Mapper��
�C��дһ��Reducer��
�C��дһ��Driver�ࣨ��Job������Mapper��Reducer�����
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
# �°�Mapper  API
�C org.apache.hadoop.mapreduce Class Mapper<KEYIN,VALUEIN,KEYOUT,VALUEOUT>
# �°� Reducer API
�C org.apache.hadoop.mapreduce Class Reducer<KEYIN,VALUEIN,KEYOUT,VALUEOUT>
 # Job����ģʽ
# MapReduce������������ģʽ
�C
�CLocal(Standalone) Mode��ֻ��һ��Java������������÷ֲ�ʽ����ʹ��HDFS�ļ�ϵͳ��ʹ�ñ���Linux�ļ�ϵͳ��
# �CPseudo-distributed Mode��ͬһ̨������������������ JVM ���̣�ÿ��hadoop daemon������һ��������JVM�����У���α�ֲ�ʽ��������
�CFully-distributed Mode�������ڶ�̨�����ϵķֲ�ʽģʽ��
# Standalone mode ʹ��local filesystem �Լ� local MapReducer job runner
# Distributed mode ʹ��HDFS �Լ� MapReduce daemons
 
# ��Ӧ�������ļ�
# conf/core-site.xmlΪHadoop�趨Ĭ�ϵ��ļ�ϵͳ
<configuration>
	<property>
		<name> fs.default.name </name>
		<value>       VALUE      </value>
	</property>
</configuration>
Standalone mode:    VALUE=file:///
Pseudo-distributed mode: VALUE=hdfs://localhost:9000
Fully-Distributed mode��   VALUE=hdfs://namenode
# conf/mapred-site.xml
<configuration>
	<property>
		<name> mapred.job.tracker </name>
		<value>            VALUE         </value>
	</property>
</configuration>
Standalone mode:          VALUE=local
Pseudo-distributed mode: VALUE=localhost:9001
Fully-Distributed mode��   VALUE=jobtracker:9001

# HDFS clientʹ��������Ծ���NameNode��λ�ã�����HDFS client�Ϳ������ӵ���NameNode.

# �������
# ���
����Ŀ�ϣ�ѡ��[File]=>Export��������ĿΪһ��jar��
# ����
hadoop jar yourjar.jar mainClassName  -conf inputfolder outputfolder
# MapReduce�����û�����
�C url  http://localhost:50030/
# ��ȡ���
�CHadoop fs �Cls outputfolder
# ������ҵ
�C���봫ͳ��Log���
�Cʹ��Reporter ��������Դ������ȶ�

# Mapreduce������
������ֽ��MapReduce��ҵ
��Word Count�����У�������ʳ���Ƶ�ʵ��ܺ�
  �����а�����д��ĸH����ת��ΪСд
  ��Word Count�����У�������ʳ���Ƶ�ʵ��ܺ��뵥�ʵĸ���
# ������ҵ
  �C������Job1��Job2����Ҫ����
   ������ҵ
      JobClinet.runjob(conf1)
      JobClinet.runjob(conf2)
   ������ҵ
  �C
  �C����ͨ��Hadoop�Դ���JobControl����