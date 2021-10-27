// 客户端API操作
// 使用IDEA新建java项目
// 导包:
// 直接复制\hadoop.tar.gz中share目录的包，导入
// 或：
// 使用maven导入hadoop依赖，打包成war包，解压后在lib中可看到hadoop依赖包

1、上传文件
// 获取配置信息
        Configuration conf = new Configuration();
        conf.set("fs.defaultFs", "hdfs://hadoop001:8020");

        // 获取文件系统
        FileSystem fileSystem = FileSystem.get(new URI("hdfs://hadoop001:8020"), conf, "root");

        System.out.println(fileSystem);

        fileSystem.copyFromLocalFile(new Path("C:/usr/local/image/wardrobe/1.jpg"), new Path("/user/data/image/2.jpg"));

        //关闭文件系统
        fileSystem.close();

2、上传文件并删除原文件
    /**
     * 文件上传
     *
     * @throws Exception
     */
    @Test
    public void putFileToHDFS() throws Exception {
        // 获取文件系统
        Configuration conf = new Configuration();
        FileSystem fileSystem = FileSystem.get(new URI("hdfs://hadoop001:8020"), conf, "root");

        fileSystem.copyFromLocalFile(false, new Path("C:\\Users\\JessXie\\Downloads\\hadoop-2.6.5.tar.gz"), new Path("/user/data/image/"));
        fileSystem.close();
    }

3、文件下载
    /**
     * 文件下载
     *
     * @throws Exception
     */
    @Test
    public void getFileToHDFS() throws Exception {
        // 获取文件系统
        Configuration conf = new Configuration();
        // 由于是使用虚拟机hadoop集群，不是本地，所以要使用
        //  public static FileSystem get(java.net.URI uri, @NotNull Configuration conf,
        //   String user)方法，在后面加上用户参数。
        FileSystem fileSystem = FileSystem.get(new URI("hdfs://hadoop001:8020"), conf, "root");

        fileSystem.copyToLocalFile(true, new Path("/user/data/image/4.jpg"), new Path("C:\\Users\\JessXie\\Downloads\\hadoop-2.6.5.tar.gz"), true);
        fileSystem.close();
    }

4、创建文件夹
/**
     * 创建文件夹
     */
    @Test
    public void mkdirAtHDFS() throws Exception {
        // 获取文件系统
        Configuration conf = new Configuration();
        FileSystem fileSystem = FileSystem.get(new URI("hdfs://hadoop001:8020"), conf, "root");
        // 适合一级多级目录
        fileSystem.mkdirs(new Path("/user/data/image/2018"));
        fileSystem.close();
    }

5、删除文件
/**
     * 删除文件
     */
    @Test
    public void rmdirAtHDFS() throws Exception {
        // 获取文件系统
        Configuration conf = new Configuration();
        FileSystem fileSystem = FileSystem.get(new URI("hdfs://hadoop001:8020"), conf, "root");
        // 适合一级多级目录
        fileSystem.delete(new Path("/user/data/image/4.jpg"), true);
        fileSystem.close();
    }

6、修改文件名称
/**
     * 修改文件名称
     */
    @Test
    public void renameAtHDFS() throws Exception {
        // 获取文件系统
        Configuration conf = new Configuration();
        FileSystem fileSystem = FileSystem.get(new URI("hdfs://hadoop001:8020"), conf, "root");
        // 适合一级多级目录
        boolean valid = fileSystem.rename(new Path("/user/data/image/4.jpg"), new Path("/user/data/image/2.jpg"));
        System.out.println(valid ? "修改成功" : "修改失败");
        fileSystem.close();
    }

7、查看文件详情
/**
     * 查看文件详情
     */
    @Test
    public void readFileAtHDFS() throws Exception {
        // 获取文件系统
        Configuration conf = new Configuration();
        FileSystem fileSystem = FileSystem.get(new URI("hdfs://hadoop001:8020"), conf, "root");
        // 适合一级多级目录
        RemoteIterator<LocatedFileStatus> valid = fileSystem.listFiles(new Path("/"), true);
        while (valid.hasNext()) {
            // 将文件信息拿到
            LocatedFileStatus status = valid.next();
            // 打印文件信息
            System.out.println(status.getPath().getName());
            System.out.println(status.getBlockSize());
            System.out.println(status.getLen());
            System.out.println(status.getPermission());
            // 获取文件的块信息
            BlockLocation[] blockLocations = status.getBlockLocations();
            for (BlockLocation blockLocation : blockLocations) {
                System.out.println("block offset:" + blockLocation.getOffset());
                String[] hosts = blockLocation.getHosts();
                for (String host : hosts) {
                    System.out.println("host:" + host);
                }
            }

            System.out.println("----------------------------");
        }
        fileSystem.close();
    }

8、查看文件和文件夹信息
/**
     * 查看文件和文件夹信息
     */
    @Test
    public void readFolderAtHDFS() throws Exception {
        // 获取文件系统
        Configuration conf = new Configuration();
        FileSystem fileSystem = FileSystem.get(new URI("hdfs://hadoop001:8020"), conf, "root");
        // 适合一级多级目录
        FileStatus[] valid = fileSystem.listStatus(new Path("/user/data/image/"));
        for (FileStatus fileStatus : valid) {
            if (fileStatus.isDirectory()) {
                System.out.println("f---" + fileStatus.getPath().getName());
            } else {
                System.out.println("d---" + fileStatus.getPath().getName());
            }
        }
        fileSystem.close();
    }

三、客户端IO流操作
1、文件上传
/**
     * 流-上传文件
     *
     * @throws Exception
     */
    @Test
    public void putFileToHDFS() throws Exception {
        // 获取文件系统
        Configuration conf = new Configuration();
        FileSystem fileSystem = FileSystem.get(new URI("hdfs://hadoop001:8020"), conf, "root");
        // 获取输出流
        FSDataOutputStream fos = fileSystem.create(new Path("/user/data/input/hadoop-2.6.5.tar.gz"));

        // 获取输输入流
        FileInputStream fis = new FileInputStream(new File("C:\\hadoop-2.6.5.tar.gz"));

        // 流对接
        try {
            IOUtils.copyBytes(fis, fos, conf);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            IOUtils.closeStream(fis);
            IOUtils.closeStream(fos);
        }
        fileSystem.close();
    }

2、文件下载
/**
     * 流-下载文件
     *
     * @throws Exception
     */
    @Test
    public void getFileFromHDFS() throws Exception {
        // 获取文件系统
        Configuration conf = new Configuration();
        FileSystem fileSystem = FileSystem.get(new URI("hdfs://hadoop001:8020"), conf, "root");
        // 获取输入流
        FSDataInputStream fis = fileSystem.open(new Path("/user/data/hadoop-2.6.5.tar.gz"));

        // 获取输出流
        FileOutputStream fos = new FileOutputStream(new File("C:\\hadoop-2.6.5.tar.gz"));

        // 流对接
        try {
            IOUtils.copyBytes(fis, fos, conf);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            IOUtils.closeStream(fis);
            IOUtils.closeStream(fos);
        }
        fileSystem.close();
    }

3、定位文件下载
/**
     * 大文件定位下载第一块
     * @throws Exception
     */
    @Test
    public void getFileFromHDFSSeek1() throws Exception {
        // 获取文件系统
        Configuration conf = new Configuration();
        FileSystem fileSystem = FileSystem.get(new URI("hdfs://hadoop001:8020"), conf, "root");
        // 获取输入流
        FSDataInputStream fis = fileSystem.open(new Path("/user/data/image/hadoop-2.6.5.tar.gz"));

        // 获取输出流
        FileOutputStream fos = new FileOutputStream(new File("C:\\hadoop-2.6.5.tar.gz.part1"));
        // 流对接（只读取128M）
        byte[] buf = new byte[1024];
        // 1024 * 1024 * 128
        for (int i = 0; i < 1024 * 128; i++) {
            fis.read(buf);
            fos.write(buf);
        }

        // 关闭流
        try {
            IOUtils.closeStream(fis);
            IOUtils.closeStream(fos);
        } catch (Exception e) {
            e.printStackTrace();
        }
        fileSystem.close();
    }

    /**'
     * 大文件定位下载最后一块
     * @throws Exception
     */
    @Test
    public void getFileFromHDFSSeek2() throws Exception {
        // 获取文件系统
        Configuration conf = new Configuration();
        FileSystem fileSystem = FileSystem.get(new URI("hdfs://hadoop001:8020"), conf, "root");
        // 获取输入流
        FSDataInputStream fis = fileSystem.open(new Path("/user/data/image/hadoop-2.6.5.tar.gz"));

        // 获取输出流
        FileOutputStream fos = new FileOutputStream(new File("C:\\hadoop-2.6.5.tar.gz.part2"));
        // 流对接（只读取128M）
        fis.seek(1024 * 1024 * 128);
        try {
            IOUtils.copyBytes(fis, fos, conf);
        } catch (Exception e){
            e.printStackTrace();
        } finally {
            IOUtils.closeStream(fis);
            IOUtils.closeStream(fos);
        }
        fileSystem.close();

    }