# Backup2sndacs

备份你的数据、文件到[盛大云存储](http://www.grandcloud.cn/product/ecs)

## 使用方法

* 运行 gem install backup2sndacs
* 运行 backup generate:config
* 运行 backup generate:model --trigger=mysql_backup_sndacs
* 访问 https://cs-console.grandcloud.cn/, 找到你的 "Access Key" 和 "Access Secret"
* 修改 ~/Backup/models/mysql_backup_sndacs.rb, 改为如下的形式

```
require 'rubygems'
gem 'backup2sndacs'
require 'backup2sndacs'

Backup::Model.new(:mysql_backup_sndacs, 'example backup to sndacs') do
  split_into_chunks_of 250

  database MySQL do |db|
    db.name               = "for_backup"
    db.username           = "my_username"
    db.password           = "my_password"
    db.host               = "localhost"
    db.port               = 3306
    db.socket             = "/tmp/mysql.sock"
  end

  store_with Sndacs do |s|
    s.keep = 7
    s.access_key = 'replace with access key'
    s.access_secret = 'replace with access secret'
    s.bucket = 'backup2sndacs-test1'
    s.path = 'backup'
  end
end
```

* 运行 backup perform -t mysql_backup_sndacs
* backup 支持备份目录，数据库等多种源，并且支持非对称密钥加密来保护数据安全，
   具体可以参考 backup 的文档: https://github.com/meskyanichi/backup

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
