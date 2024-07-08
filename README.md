###使用結構

![image](https://i.imgur.com/MSTYjcD.png)

###部屬
可參考 sample.env

        DBname="postgres"
        Addr="127.0.0.1"
        Port= 5432
        Username= "postgres"
        Name= "postgres"
        Password= "" ##postgres 使用密碼
        StripeSK="" ##String 所使用secret key

###建立g-server image
        docker build -f ./DockerFile-backend -t g-server .
###建立docker network
已建立名為Poya的brige network

        docker network create --driver bridge --subnet=172.19.0.0/16 Poya
###利用docker compose 建立後端系統
參考docker-compose_test.yaml 修改後為docker-composer.yaml

        docker-compose -f './docker-composer.yaml' up -d
###Redis
        docker pull redis
        docker run --name redis-lab -p 6379:6379 -d redis


###String 測試結帳參考帳戶
        卡號 4242 4242 4242 4242 
        日期 12 / 34
        ccv 567
        zip-code 12345

###Swagger
        https://www.po-ya.site/swagger/index.html