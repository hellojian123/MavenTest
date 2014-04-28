var ioc = {
	datasource:{
		type:"org.apache.commons.dbcp.BasicDataSource",
		events:{
			depose:"close"
		},
		fields:{
			/*
			driverClassName:"org.postgresql.Driver",
			url:"jdbc:postgresql://ec2-107-22-190-179.compute-1.amazonaws.com:5432/db24nor561gp9p",
			username:"loyaxjftushvqg",
			password:"Kc8o-RjfUF9Mww4kAMfQZsum8M"
			*/

			/*
			driverClassName:"com.mysql.jdbc.Driver",
			url:"jdbc:mysql://127.0.0.1:3306/maven_test?useUnicode=true&characterEncoding=utf-8",
			username:"root",
			password:"root"
			 */

			driverClassName:"com.mysql.jdbc.Driver",
			url:"jdbc:mysql://us-cdbr-cb-east-01.cleardb.net:3306/cb_isoft?useUnicode=true&characterEncoding=utf-8",
			username:"b217abbb470895",
			password:"7e5dbbfe"


		}
	},
	dao : {
		type : "org.nutz.dao.impl.NutDao",
		args : [{refer:"datasource"}]
	}
}