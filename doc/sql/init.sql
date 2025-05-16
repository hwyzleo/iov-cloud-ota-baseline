DROP TABLE IF EXISTS `db_baseline`.`tb_baseline`;
CREATE TABLE `db_baseline`.`tb_baseline`
(
    `id`            BIGINT       NOT NULL AUTO_INCREMENT COMMENT '主键',
    `code`          VARCHAR(20)  NOT NULL COMMENT '基线编码',
    `name`          VARCHAR(255) NOT NULL COMMENT '基线名称',
    `type`          VARCHAR(255) NOT NULL COMMENT '基线类型',
    `source`        SMALLINT     NOT NULL COMMENT '基线来源：1-BOM，2-OTA',
    `veh_model`     VARCHAR(20)  NOT NULL COMMENT '车型编码',
    `publish_date`  TIMESTAMP    NOT NULL COMMENT '发布日期',
    `baseline_desc` TEXT                  DEFAULT NULL COMMENT '基线说明',
    `description`   VARCHAR(255)          DEFAULT NULL COMMENT '备注',
    `create_time`   TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `create_by`     VARCHAR(64)           DEFAULT NULL COMMENT '创建者',
    `modify_time`   TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
    `modify_by`     VARCHAR(64)           DEFAULT NULL COMMENT '修改者',
    `row_version`   INT                   DEFAULT 1 COMMENT '记录版本',
    `row_valid`     TINYINT               DEFAULT 1 COMMENT '记录是否有效',
    PRIMARY KEY (`id`),
    UNIQUE KEY (`code`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4 COMMENT ='基线信息表';

DROP TABLE IF EXISTS `db_baseline`.`tb_ecu`;
CREATE TABLE `db_baseline`.`tb_ecu`
(
    `id`          BIGINT       NOT NULL AUTO_INCREMENT COMMENT '主键',
    `code`        VARCHAR(20)  NOT NULL COMMENT 'ECU编码',
    `name`        VARCHAR(255) NOT NULL COMMENT 'ECU名称',
    `name_en`     VARCHAR(255) NOT NULL COMMENT 'ECU英文名称',
    `type`        VARCHAR(20)  NOT NULL COMMENT 'ECU类型',
    `sort`        INT          NOT NULL COMMENT '排序',
    `description` VARCHAR(255)          DEFAULT NULL COMMENT '备注',
    `create_time` TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `create_by`   VARCHAR(64)           DEFAULT NULL COMMENT '创建者',
    `modify_time` TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
    `modify_by`   VARCHAR(64)           DEFAULT NULL COMMENT '修改者',
    `row_version` INT                   DEFAULT 1 COMMENT '记录版本',
    `row_valid`   TINYINT               DEFAULT 1 COMMENT '记录是否有效',
    PRIMARY KEY (`id`),
    UNIQUE KEY (`code`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4 COMMENT ='ECU信息表';

DROP TABLE IF EXISTS `db_baseline`.`tb_software_part`;
CREATE TABLE `db_baseline`.`tb_software_part`
(
    `id`              BIGINT       NOT NULL AUTO_INCREMENT COMMENT '主键',
    `ecu_code`        VARCHAR(20)  NOT NULL COMMENT 'ECU编码',
    `software_name`   VARCHAR(255) NOT NULL COMMENT '软件零件号',
    `software_no`     VARCHAR(50)  NOT NULL COMMENT '软件零件号',
    `software_no_ver` VARCHAR(255) NOT NULL COMMENT '软件零件号版本',
    `ota`             TINYINT      NOT NULL COMMENT '是否支持OTA',
    `description`     VARCHAR(255)          DEFAULT NULL COMMENT '备注',
    `create_time`     TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `create_by`       VARCHAR(64)           DEFAULT NULL COMMENT '创建者',
    `modify_time`     TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
    `modify_by`       VARCHAR(64)           DEFAULT NULL COMMENT '修改者',
    `row_version`     INT                   DEFAULT 1 COMMENT '记录版本',
    `row_valid`       TINYINT               DEFAULT 1 COMMENT '记录是否有效',
    PRIMARY KEY (`id`),
    UNIQUE KEY (`software_no`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4 COMMENT ='软件零件信息表';

DROP TABLE IF EXISTS `db_baseline`.`tb_software_version`;
CREATE TABLE `db_baseline`.`tb_software_version`
(
    `id`                  BIGINT       NOT NULL AUTO_INCREMENT COMMENT '主键',
    `ecu_code`            VARCHAR(20)  NOT NULL COMMENT 'ECU编码',
    `software_no`         VARCHAR(50)  NOT NULL COMMENT '软件零件号',
    `software_ver`        VARCHAR(255) NOT NULL COMMENT '软件版本',
    `software_report`     VARCHAR(255)          DEFAULT NULL COMMENT '软件测试报告',
    `software_desc`       VARCHAR(255)          DEFAULT NULL COMMENT '软件说明',
    `software_source`     SMALLINT     NOT NULL COMMENT '软件来源：1-BOM，2-OTA',
    `adapted_hardware_no` VARCHAR(50)  NOT NULL COMMENT '适配的总成硬件零件号',
    `adapted_software_no` VARCHAR(50)           DEFAULT NULL COMMENT '适配的总成软件零件号',
    `publish_date`        TIMESTAMP    NOT NULL COMMENT '发布日期',
    `description`         VARCHAR(255)          DEFAULT NULL COMMENT '备注',
    `create_time`         TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `create_by`           VARCHAR(64)           DEFAULT NULL COMMENT '创建者',
    `modify_time`         TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
    `modify_by`           VARCHAR(64)           DEFAULT NULL COMMENT '修改者',
    `row_version`         INT                   DEFAULT 1 COMMENT '记录版本',
    `row_valid`           TINYINT               DEFAULT 1 COMMENT '记录是否有效',
    PRIMARY KEY (`id`),
    INDEX `idx_software_no` (`software_no`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4 COMMENT ='软件版本信息表';

DROP TABLE IF EXISTS `db_baseline`.`tb_software_package`;
CREATE TABLE `db_baseline`.`tb_software_package`
(
    `id`                     BIGINT       NOT NULL AUTO_INCREMENT COMMENT '主键',
    `software_version_id`    BIGINT       NOT NULL COMMENT '软件版本ID',
    `package_code`           VARCHAR(255) NOT NULL COMMENT '软件包代码',
    `package_name`           VARCHAR(255) NOT NULL COMMENT '软件包名称',
    `package_type`           SMALLINT     NOT NULL COMMENT '软件包类型：1-全量，2-差分',
    `package_size`           BIGINT       NOT NULL COMMENT '软件包大小（Byte）',
    `package_md5`            VARCHAR(255) NOT NULL COMMENT '软件包MD5',
    `package_desc`           VARCHAR(255)          DEFAULT NULL COMMENT '软件包说明',
    `package_source`         SMALLINT     NOT NULL COMMENT '软件包来源：1-OTA，2-BOM',
    `base_software_no`       VARCHAR(50)  NOT NULL COMMENT '基础软件零件号',
    `base_software_ver`      VARCHAR(255) NOT NULL COMMENT '基础软件版本',
    `package_adaption_level` SMALLINT     NOT NULL COMMENT '软件包适配级别：1-基础版本及以下，2-基础版本及以上，3-与基础版本一致',
    `adapted_software_no`    VARCHAR(50)           DEFAULT NULL COMMENT '适配的总成软件零件号',
    `publish_date`           TIMESTAMP    NOT NULL COMMENT '发布日期',
    `estimated_install_time` INT                   DEFAULT NULL COMMENT '预计升级时间（分钟）',
    `ota`                    TINYINT      NOT NULL COMMENT '是否是OTA包',
    `description`            VARCHAR(255)          DEFAULT NULL COMMENT '备注',
    `create_time`            TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `create_by`              VARCHAR(64)           DEFAULT NULL COMMENT '创建者',
    `modify_time`            TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
    `modify_by`              VARCHAR(64)           DEFAULT NULL COMMENT '修改者',
    `row_version`            INT                   DEFAULT 1 COMMENT '记录版本',
    `row_valid`              TINYINT               DEFAULT 1 COMMENT '记录是否有效',
    PRIMARY KEY (`id`),
    INDEX `idx_software_version` (`software_version_id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4 COMMENT ='软件包信息表';

DROP TABLE IF EXISTS `db_baseline`.`tb_software_package_file`;
CREATE TABLE `db_baseline`.`tb_software_package_file`
(
    `id`                  BIGINT       NOT NULL AUTO_INCREMENT COMMENT '主键',
    `software_package_id` BIGINT       NOT NULL COMMENT '软件包ID',
    `file_name`           VARCHAR(255) NOT NULL COMMENT '文件名称',
    `file_url`            VARCHAR(255) NOT NULL COMMENT '文件URL',
    `mime_type`           VARCHAR(100) NOT NULL COMMENT '文件类型',
    `file_size`           BIGINT       NOT NULL COMMENT '文件大小（Byte）',
    `file_md5`            VARCHAR(255) NOT NULL COMMENT '文件MD5',
    `file_desc`           VARCHAR(255)          DEFAULT NULL COMMENT '文件说明',
    `description`         VARCHAR(255)          DEFAULT NULL COMMENT '备注',
    `create_time`         TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `create_by`           VARCHAR(64)           DEFAULT NULL COMMENT '创建者',
    `modify_time`         TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
    `modify_by`           VARCHAR(64)           DEFAULT NULL COMMENT '修改者',
    `row_version`         INT                   DEFAULT 1 COMMENT '记录版本',
    `row_valid`           TINYINT               DEFAULT 1 COMMENT '记录是否有效',
    PRIMARY KEY (`id`),
    INDEX `idx_software_package` (`software_package_id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4 COMMENT ='软件包文件表';

DROP TABLE IF EXISTS `db_baseline`.`tb_baseline_software_version`;
CREATE TABLE `db_baseline`.`tb_baseline_software_version`
(
    `id`                  BIGINT      NOT NULL AUTO_INCREMENT COMMENT '主键',
    `baseline_code`       VARCHAR(20) NOT NULL COMMENT '基线编码',
    `software_version_id` BIGINT      NOT NULL COMMENT '软件版本ID',
    `description`         VARCHAR(255)         DEFAULT NULL COMMENT '备注',
    `create_time`         TIMESTAMP   NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `create_by`           VARCHAR(64)          DEFAULT NULL COMMENT '创建者',
    `modify_time`         TIMESTAMP   NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
    `modify_by`           VARCHAR(64)          DEFAULT NULL COMMENT '修改者',
    `row_version`         INT                  DEFAULT 1 COMMENT '记录版本',
    `row_valid`           TINYINT              DEFAULT 1 COMMENT '记录是否有效',
    PRIMARY KEY (`id`),
    INDEX `idx_baseline` (`baseline_code`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4 COMMENT ='基线软件版本关系表';