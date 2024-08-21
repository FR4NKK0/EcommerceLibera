--
-- User java
--

create user 'java'@'%' identified by 'Web Master';
GRANT SELECT, INSERT, UPDATE, DELETE ON `java`.* TO 'java'@'%';