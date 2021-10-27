// eclipse中开发hadoop的三种配置模式
hdfs的api编程

// -----------------------------本地模式开发

①在windows的eclipse里直接运行main方法，会将job提交给本地执行器localjobrunner执行
输入输出数据在本地路径

②在linux的eclipse里直接运行main方法，但不要添加yarn配置，也会提交给localjobrunner执行
输入输出数据放在本地路径下

1、通过API操作HDFS
// Windows下，linux下只需要修改路径
1.1、HDFS获取文件系统
  @Test
     public void initHDFS() throws IOException {
         //创建配置信息
         Configuration config = new Configuration();
         //获取文件系统 
         FileSystem fs = FileSystem.get(config);
         //打印文件系统
         System.out.println(fs.toString());
     }
	 
1.2、HDFS文件夹创建
@Test
     public void mkdir() throws Exception{
   String path2 = "file:///G:\\dir";
   //创建配置信息
         Configuration config = new Configuration();
         //获取文件系统 
         FileSystem fs = FileSystem.get(config);
         //打印文件系统
         System.out.println(fs.toString());
         //3.创建目录
         fs.mkdirs(new Path(path2));
         //4.关闭
         fs.close();
         System.out.println("创建文件夹成功");
     }
1.3、上传文件

  @Test
     public void uploadHDFS() throws IOException {
   //创建配置信息
         Configuration conf = new Configuration();
         //获取文件系统
         FileSystem fs = FileSystem.get(conf);
         //要上传的本地文件上传的路径
         Path input = new Path("G:\\word.txt");
         //输出的路径，iput复制到output
         Path output = new Path("G:\\dir");
         //以拷贝的方式
         fs.copyFromLocalFile(input, output);
         fs.close();
         System.out.println("上传成功！！！");
     }  
	 
1.4、文件下载
  @Test
     public void downloadHDFS() throws IOException{
   //创建配置信息
         Configuration conf = new Configuration();
         //获取文件系统
         FileSystem fs = FileSystem.get(conf);
         //下载文件
         //boolean delSrc:是否将原文件删除
         //Path src ：要下载的路径
         //Path dst ：要下载到哪
         //boolean useRawLocalFileSystem ：是否校验文件
         fs.copyToLocalFile(false,
                 new Path("G:\\dir\\word.txt"),
                 new Path("G:\\"),
                 true);
         fs.close();
         System.out.println("下载成功！！");
     }

1.5、删除文件夹
@Test
 public void deleteHDFS() throws IOException{
   //创建配置对象
         Configuration conf = new Configuration();
         FileSystem fs = FileSystem.get(conf);
 //Path var1   : HDFS地址
 //boolean var2 : 是否递归删除
 fs.delete(new Path("G:\\dir"), true);
 fs.close();
         System.out.println("删除成功啦");
     }

// ---------------------Hadoop伪分布式模式开发
配置hadoop伪分布式，并启动
①windows的eclipse里直接运行main方法，会将job提交给本地执行器localjobrunner执行
输入输出数据在hdfs中(hdfs://localhost:9000)
在linux的eclipse里直接运行main方法，但不添加yarn相关配置，也会提交给localjobrunner执行
输入输出数据在hdfs中(hdfs://localhost:9000)
1、通过API操作HDFS
// 以Windows下，linux下只需要修改路径

1.1、HDFS获取文件系统

    @Test
     public void initHDFS() throws IOException {
   //1.创新配置信息对象
         Configuration configuration = new Configuration();
         //2.链接文件系统
         //final URI uri  地址,使用java.net.URI，建议用URI.create("hdfs://localhost:9000")方式，不用new URI("xxx")
         //final Configuration conf  配置
         //String user   Linux或者windos用户
         FileSystem fs = FileSystem.get(URI.create("hdfs://localhost:9000"), configuration);
         //打印文件系统
         System.out.println(fs.toString());
     }
1.2、创建目录

     @Test
     public void mkdir() throws Exception{
   //1.创新配置信息对象
         Configuration configuration = new Configuration();
         //2.链接文件系统
         //final URI uri  地址
         //final Configuration conf  配置
         //String user   Linux用户
         FileSystem fs = FileSystem.get(URI.create("hdfs://localhost:9000"), configuration);
         //3.创建目录
         fs.mkdirs(new Path("hdfs://localhost:9000/idea/aa"));
         //4.关闭
         fs.close();
         System.out.println("创建文件夹成功");
     }
1.3、上传文件

     @Test
     public void uploadHDFS() throws IOException, InterruptedException {
   //创建配置信息
         Configuration configuration = new Configuration();
         //获取文件系统
         FileSystem fs = FileSystem.get(URI.create("hdfs://localhost:9000"), configuration,"hy");
         //要上传的本地文件上传的路径
         Path input = new Path("G:\\word.txt");
         //输出的路径，iput复制到output
         Path output = new Path("hdfs://localhost:9000/idea/aa");
         //以拷贝的方式
         fs.copyFromLocalFile(input, output);
         fs.close();
         System.out.println("上传成功！！！");
     }  

// --------------------------------------完全分布式模式下开发
// 配置hadoop完全分布式模式，并启动
// C:\Windows\System32\drivers\etc\hosts

 @Test
 public void initHDFS() throws IOException, InterruptedException {
   //1.创新配置信息对象
         Configuration configuration = new Configuration();
 //2.链接文件系统
 //final URI uri 地址,使用java.net.URI，建议用URI.create("hdfs://hp001")方式，不用new URI("xxx")
 //final Configuration conf 配置
 //String user   Linux或者windos用户
         FileSystem fs = FileSystem.get(URI.create("hdfs://hp001"), configuration,"hadoop");
 //打印文件系统
         System.out.println(fs.toString());
     }
 @Test
 public void mkdir() throws Exception{
   //1.创新配置信息对象
         Configuration configuration = new Configuration();
 //2.链接文件系统
 //final URI uri 地址
 //final Configuration conf 配置
 //String user   Linux用户
         FileSystem fs = FileSystem.get(URI.create("hdfs://hp001"), configuration,"hadoop");
 //3.创建目录
 fs.mkdirs(new Path("hdfs://hp001/user"));
 //4.关闭
 fs.close();
         System.out.println("创建文件夹成功");
     }
 @Test
 public void uploadHDFS() throws IOException, InterruptedException {
   //创建配置信息
         Configuration configuration = new Configuration();
 //获取文件系统
         FileSystem fs = FileSystem.get(URI.create("hdfs://hp001"), configuration,"hadoop");
 //要上传的本地文件上传的路径，window目录
         Path input = new Path("G:\\word.txt");
 //输出的路径，iput复制到output
         Path output = new Path("hdfs://hp001/user");
 //以拷贝的方式
 fs.copyFromLocalFile(input, output);
 fs.close();
         System.out.println("上传成功！！！");
     }  
