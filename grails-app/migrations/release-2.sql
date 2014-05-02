--  *********************************************************************
--  Update Database Script
--  *********************************************************************
--  Change Log: changelog.groovy
--  Ran at: 23/04/14 4:34 PM
--  Against: root@localhost@jdbc:mysql://localhost:3306/webapi
--  Liquibase version: 2.0.5
--  *********************************************************************

--  Lock Database
--  Changeset release-2-1.groovy::1398234389792-1::bea18c (generated)::(Checksum: 3:5031708d64d88e0eb5f91a2cda8e1be5)
CREATE TABLE `example_run` (`id` BIGINT AUTO_INCREMENT NOT NULL, `version` BIGINT NOT NULL, `end` BIGINT NOT NULL, `example_id` BIGINT NOT NULL, `start` BIGINT NOT NULL, `url` longtext NOT NULL, `class` VARCHAR(255) NOT NULL, `exception_class` VARCHAR(255) NULL, `message` longtext NULL, `body` mediumblob NULL, `content_type` VARCHAR(255) NULL, `response_code` INT NULL, CONSTRAINT `example_runPK` PRIMARY KEY (`id`));

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('bea18c (generated)', '', NOW(), 'Create Table', 'EXECUTED', 'release-2-1.groovy', '1398234389792-1', '2.0.5', '3:5031708d64d88e0eb5f91a2cda8e1be5', 21);

--  Changeset release-2-1.groovy::1398234389792-2::bea18c (generated)::(Checksum: 3:6cf918aa14b9e8b5cec9c83c387e0516)
ALTER TABLE `example` ADD `machine_callable` bit NOT NULL DEFAULT b'1';

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('bea18c (generated)', '', NOW(), 'Add Column', 'EXECUTED', 'release-2-1.groovy', '1398234389792-2', '2.0.5', '3:6cf918aa14b9e8b5cec9c83c387e0516', 22);

--  Changeset release-2-1.groovy::1398234389792-4::bea18c (generated)::(Checksum: 3:971d3d371152175ec04a2060dfdc8799)
CREATE INDEX `FK8C3736363B84934E` ON `example_run`(`example_id`);

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('bea18c (generated)', '', NOW(), 'Create Index', 'EXECUTED', 'release-2-1.groovy', '1398234389792-4', '2.0.5', '3:971d3d371152175ec04a2060dfdc8799', 23);

--  Changeset release-2-1.groovy::1398234389792-5::bea18c::(Checksum: 3:28b92b38feb2e450a6334f2f6ab346e1)
CREATE INDEX `EXAMPLE_RUN_START_INDEX` ON `example_run`(`start`);

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('bea18c', '', NOW(), 'Create Index', 'EXECUTED', 'release-2-1.groovy', '1398234389792-5', '2.0.5', '3:28b92b38feb2e450a6334f2f6ab346e1', 24);

--  Changeset release-2-1.groovy::1398234389792-3::bea18c (generated)::(Checksum: 3:547b2fa7472f1823dd80a3000b843d82)
ALTER TABLE `example_run` ADD CONSTRAINT `FK8C3736363B84934E` FOREIGN KEY (`example_id`) REFERENCES `example` (`id`);

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('bea18c (generated)', '', NOW(), 'Add Foreign Key Constraint', 'EXECUTED', 'release-2-1.groovy', '1398234389792-3', '2.0.5', '3:547b2fa7472f1823dd80a3000b843d82', 25);

--  Release Database Lock
