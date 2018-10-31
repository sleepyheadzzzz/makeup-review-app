Steps to create the database

1. install throught brew
`brew install mysql`

2. read help infomation about mysql with brew
`brew info mysql`

3. follow the description: 
> To have launchd start mysql now and restart at login:
>  `brew services start mysql`

4. login mysql 
`mysql -uroot`

5. create database, reference: https://spring.io/guides/gs/accessing-data-mysql/
```
create database db_example; -- Create the new database
create user 'springuser'@'localhost' identified by 'ThePassword'; -- Creates the user
grant all on db_example.* to 'springuser'@'localhost'; -- Gives all the privileges to the new user on the newly created database
```