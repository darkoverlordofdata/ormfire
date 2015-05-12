## db

running sequelize migrate create db file in ./db folder. Copy up one folder when satisfied,
so the application can see it.

sequelize init

sequelize model:create --coffee --name Game --attributes active:boolean,name:string,slug:string,url:string,author:string,description:string,version:string,icon:string,main:string,height:integer,width:integer
sequelize model:create --coffee --name Katra --attributes active:boolean,slug:string,title:string,description:string,image:string

sequelize migration:create --coffee

sequelize db:migrate --coffee

