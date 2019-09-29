> 参考链接: https://www.jianshu.com/p/1f0073e43777

#### # docker 创建带 auth 验证的 mongodb 数据库

    
    # 启动带有授权的 mongo 数据库
    # mkdir -p /data/mongodb/db /data/mongodb/config
    docker-compose up -d


    # docker 直接启动
    docker run --restart=always --name mongodb -v /data/mongodb/db:/data/db -p 27017:27017 -d mongo --auth
    

#### # 设置mongo的用户名和密码

    docker exec -it xxxx mongo
    

此时`show dbs`无法执行，需要认证。
切换到admin并创建root用户：

    use admin
    db.createUser({ user: 'root', pwd: 'root', roles: [ { role: "userAdminAnyDatabase", db: "admin" } ] })
    db.auth('root','root')
    
    # 修改密码
    db.updateUser('<用户名>',{pwd:'<密码>',roles:[{role:'userAdminAnyDatabase',db:'<db name>'}]})
    use <db name>
    db.auth('<用户名>','<密码>')

    # 删除用户
    # 必须在该用户所在数据库才能删除
    use app
    db.dropUser('<用户名>')

    # 删除app数据库
    use app
    db.dropDatabase()

如上，可以看到root用户创建成功。exit退出mongo命令行，带验证的mongodb已经创建成功。


#### 普通用户创建
接下来创建普通用户，并演示验证。再次执行`mongo` 进入mongodb命令行。

可以看到root用户验证成功,并且可以查看数据库。

下面创建普通用户，和创建`root`用户基本一致，只是角色不同 。

    //拥有对数据库app的读写权限。
    use app
    db.createUser({
        user: "swen",
        pwd: "swen",
        roles: [{ role: "readWrite", db: "app" }]
      })

创建成功并exit退出，swen用户可以对(只能对)app进行操作。
下面做基本演示。

    use app
    db.auth('swen','swen')



远程链接测试
    
    mongo localhost:27017/app -uswen -pswen

    
    
    
