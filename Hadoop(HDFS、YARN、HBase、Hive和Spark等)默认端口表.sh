# �˿�	����
9000	fs.defaultFS��                                �磺hdfs://172.25.40.171:9000
9001	dfs.namenode.rpc-address                      #DataNode����������˿�
50070	dfs.namenode.http-address
50470	dfs.namenode.https-address
50100	dfs.namenode.backup.address
50105	dfs.namenode.backup.http-address
50090	dfs.namenode.secondary.http-address��         �磺172.25.39.166:50090
50091	dfs.namenode.secondary.https-address��        �磺172.25.39.166:50091
50020	dfs.datanode.ipc.address
50075	dfs.datanode.http.address
50475	dfs.datanode.https.address
50010	dfs.datanode.address��                        DataNode�����ݴ���˿�
8480	dfs.journalnode.rpc-address
8481	dfs.journalnode.https-address
8032	yarn.resourcemanager.address
8088	yarn.resourcemanager.webapp.address��         YARN��http�˿�
8090	yarn.resourcemanager.webapp.https.address
8030	yarn.resourcemanager.scheduler.address
8031	yarn.resourcemanager.resource-tracker.address
8033	yarn.resourcemanager.admin.address
8042	yarn.nodemanager.webapp.address
8040	yarn.nodemanager.localizer.address
8188	yarn.timeline-service.webapp.address
10020	mapreduce.jobhistory.address
19888	mapreduce.jobhistory.webapp.address
2888	ZooKeeper��                                  Leader����Follower������
3888	ZooKeeper��                                  ����Leaderѡ��
2181	ZooKeeper��                                  �����ͻ��˵�����
60010	hbase.master.info.port��                     HMaster��http�˿�
60000	hbase.master.port��                          HMaster��RPC�˿�
60030	hbase.regionserver.info.port��               HRegionServer��http�˿�
60020	hbase.regionserver.port��                    HRegionServer��RPC�˿�
8080	hbase.rest.port��                            HBase REST server�Ķ˿�
10000	hive.server2.thrift.port
9083	hive.metastore.uris

# -----------------------------------------------��������������˿�-------------------------------------------------------
# -Hadoop��Hbase��Hive��Spark��Kafka��
# Hadoop��    
    50070�� HDFS WEB UI�˿�
    8020 �� �߿��õ�HDFS RPC�˿�
    9000 �� �Ǹ߿��õ�HDFS RPC�˿�
    8088 �� Yarn ��WEB UI �ӿ�
    8485 �� JournalNode ��RPC�˿�
    8019 �� ZKFC�˿�
# Zookeeper:
    2181 �� �ͻ�������zookeeper�Ķ˿�
    2888 �� zookeeper��Ⱥ��ͨѶʹ�ã�Leader�����˶˿�
    3888 �� zookeeper�˿� ����ѡ��leader
# Hbase:
    60010�� Hbase��master��WEB UI�˿�
    60030�� Hbase��regionServer��WEB UI ����˿�    
# Hive:
    9083 :  metastore����Ĭ�ϼ����˿�
    10000�� Hive ��JDBC�˿�
# Spark��
    7077 �� spark ��master��worker����ͨѶ�Ķ˿�  standalone��Ⱥ�ύApplication�Ķ˿�
    8080 �� master��WEB UI�˿�  ��Դ����
    8081 �� worker��WEB UI �˿�  ��Դ����
    4040 �� Driver��WEB UI �˿�  �������
    18080�� Spark History Server��WEB UI �˿�
# Kafka��
    9092 �� Kafka��Ⱥ�ڵ�֮��ͨ�ŵ�RPC�˿�
# Redis��
    6379 �� Redis����˿�
# CDH��
    7180 �� Cloudera Manager WebUI�˿�
    7182 �� Cloudera Manager Server �� Agent ͨѶ�˿�
# HUE��
    8888 �� Hue WebUI �˿�