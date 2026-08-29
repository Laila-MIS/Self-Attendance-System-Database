-- MySQL dump 10.13  Distrib 8.0.46, for Linux (x86_64)
--
-- Host: localhost    Database: student_system
-- ------------------------------------------------------


--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `role_id` int NOT NULL AUTO_INCREMENT,
  `role_name` varchar(50) COLLATE utf8mb3_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb3_unicode_ci,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`role_id`),
  UNIQUE KEY `roles_role_name_key` (`role_name`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;


--
-- Table structure for table `branch`
--

CREATE TABLE `branch` (
  `branch_id` int NOT NULL AUTO_INCREMENT,
  `branch_name` varchar(100) COLLATE utf8mb3_unicode_ci NOT NULL,
  `branch_code` varchar(10) COLLATE utf8mb3_unicode_ci NOT NULL,
  `city` varchar(50) COLLATE utf8mb3_unicode_ci NOT NULL,
  `branch_status` varchar(30) COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'Active',
  `created_date` date NOT NULL DEFAULT (curdate()),
  `center_latitude` decimal(9,6) DEFAULT NULL,
  `center_longitude` decimal(9,6) DEFAULT NULL,
  `radius_meters` int DEFAULT NULL,
  `region` varchar(50) COLLATE utf8mb3_unicode_ci NOT NULL,
  `created_by` int NOT NULL,
  PRIMARY KEY (`branch_id`),
  UNIQUE KEY `branch_branch_code_key` (`branch_code`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;


--
-- Table structure for table `department`
--

CREATE TABLE `department` (
  `department_id` int NOT NULL AUTO_INCREMENT,
  `department_code` varchar(50) NOT NULL,
  `department_name` varchar(100) NOT NULL,
  `is_active` tinyint(1) DEFAULT '1',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`department_id`),
  UNIQUE KEY `department_code` (`department_code`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


--
-- Table structure for table `days_of_week`
--

CREATE TABLE `days_of_week` (
  `day_id` tinyint NOT NULL,
  `day_name_ar` varchar(20) NOT NULL,
  `day_name_en` varchar(20) NOT NULL,
  `is_weekend` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`day_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='جدول الأيام';


--
-- Table structure for table `permissions`
--

CREATE TABLE `permissions` (
  `permission_id` int NOT NULL AUTO_INCREMENT,
  `permission_name` varchar(100) COLLATE utf8mb3_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb3_unicode_ci,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`permission_id`),
  UNIQUE KEY `permissions_permission_name_key` (`permission_name`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;


--
-- Table structure for table `role_permissions`
--

CREATE TABLE `role_permissions` (
  `role_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`role_id`,`permission_id`),
  KEY `role_permissions_permission_id_fkey` (`permission_id`),
  CONSTRAINT `role_permissions_permission_id_fkey` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`permission_id`),
  CONSTRAINT `role_permissions_role_id_fkey` FOREIGN KEY (`role_id`) REFERENCES `roles` (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;


--
-- Table structure for table `account`
--

CREATE TABLE `account` (
  `account_id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `password_hash` text CHARACTER SET utf8mb3 COLLATE utf8mb3_bin,
  `role_id` int NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_login_at` datetime DEFAULT NULL,
  `email_verified` tinyint(1) NOT NULL DEFAULT '0',
  `email_verified_at` datetime DEFAULT NULL,
  `email_token` text,
  `email_token_expires_at` datetime DEFAULT NULL,
  `last_email_sent_at` datetime DEFAULT NULL,
  `created_by` int NOT NULL DEFAULT '1',
  PRIMARY KEY (`account_id`),
  UNIQUE KEY `account_username_key` (`username`),
  KEY `idx_account_email_token` (`email_token`(255)),
  KEY `fk_account_role` (`role_id`),
  KEY `fk_created_by` (`created_by`),
  CONSTRAINT `fk_account_role` FOREIGN KEY (`role_id`) REFERENCES `roles` (`role_id`),
  CONSTRAINT `fk_created_by` FOREIGN KEY (`created_by`) REFERENCES `account` (`account_id`)
) ENGINE=InnoDB AUTO_INCREMENT=116 DEFAULT CHARSET=utf8mb3;


--
-- Table structure for table `staff`
--

CREATE TABLE `staff` (
  `staff_id` int NOT NULL,
  `first_name` varchar(50) COLLATE utf8mb3_unicode_ci NOT NULL,
  `last_name` varchar(50) COLLATE utf8mb3_unicode_ci NOT NULL,
  `gender` varchar(8) COLLATE utf8mb3_unicode_ci NOT NULL,
  `staff_email` varchar(250) COLLATE utf8mb3_unicode_ci NOT NULL,
  `phone_number` varchar(15) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `registered_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by_account_id` int NOT NULL,
  `staff_status` varchar(30) COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'On Duty',
  `note` text COLLATE utf8mb3_unicode_ci,
  `branch_id` int NOT NULL,
  `department_id` int NOT NULL,
  `account_id` int NOT NULL,
  `job_title` varchar(100) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`staff_id`),
  UNIQUE KEY `staff_staff_id_key` (`staff_id`),
  KEY `fk_staff_branch` (`branch_id`),
  KEY `fk_staff_created_by_account_id` (`created_by_account_id`),
  KEY `fk_staff_account_id` (`account_id`),
  KEY `fk_staff_dept` (`department_id`),
  CONSTRAINT `fk_staff_account_id` FOREIGN KEY (`account_id`) REFERENCES `account` (`account_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_staff_branch` FOREIGN KEY (`branch_id`) REFERENCES `branch` (`branch_id`),
  CONSTRAINT `fk_staff_created_by_account_id` FOREIGN KEY (`created_by_account_id`) REFERENCES `account` (`account_id`),
  CONSTRAINT `fk_staff_dept` FOREIGN KEY (`department_id`) REFERENCES `department` (`department_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;


--
-- Table structure for table `student`
--

CREATE TABLE `student` (
  `student_id` int NOT NULL AUTO_INCREMENT,
  `full_name` varchar(50) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `national_id` bigint DEFAULT NULL,
  `gender` varchar(8) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `date_of_birth` date DEFAULT NULL,
  `birth_date_hijri` varchar(10) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `district` varchar(100) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `current_city` varchar(100) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `marital_status` varchar(50) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `beneficiary_status` varchar(50) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `specialization` varchar(100) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `education_level` varchar(100) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `birth_city` varchar(100) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `student_email` varchar(250) COLLATE utf8mb3_unicode_ci NOT NULL,
  `phone_number` varchar(15) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `registered_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by_account_id` int NOT NULL,
  `student_status` enum('Active','Inactive','Graduated','Suspended','Withdrawn') COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'Active',
  `note` text COLLATE utf8mb3_unicode_ci,
  `practical_branch_id` int DEFAULT NULL,
  `theoretical_branch_id` int DEFAULT NULL,
  `account_id` int NOT NULL,
  `iban` varchar(34) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`student_id`),
  UNIQUE KEY `student_national_id_key` (`national_id`),
  KEY `fk_student_created_by_account_id` (`created_by_account_id`),
  KEY `fk_student_account_id` (`account_id`),
  KEY `fk_student_practical_branch` (`practical_branch_id`),
  KEY `fk_student_theoretical_branch` (`theoretical_branch_id`),
  CONSTRAINT `fk_student_account_id` FOREIGN KEY (`account_id`) REFERENCES `account` (`account_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_student_created_by_account_id` FOREIGN KEY (`created_by_account_id`) REFERENCES `account` (`account_id`),
  CONSTRAINT `fk_student_practical_branch` FOREIGN KEY (`practical_branch_id`) REFERENCES `branch` (`branch_id`),
  CONSTRAINT `fk_student_theoretical_branch` FOREIGN KEY (`theoretical_branch_id`) REFERENCES `branch` (`branch_id`)
) ENGINE=InnoDB AUTO_INCREMENT=127 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

DELIMITER ;;
CREATE TRIGGER `before_delete_student` BEFORE DELETE ON `student` FOR EACH ROW BEGIN
    DELETE FROM attendance 
    WHERE enrollment_id IN (
        SELECT enrollment_id 
        FROM enrollment 
        WHERE student_id = OLD.student_id
    );
    
    DELETE FROM enrollment 
    WHERE student_id = OLD.student_id;
    
    DELETE FROM account 
    WHERE account_id = OLD.account_id;
END ;;
DELIMITER ;


--
-- Table structure for table `programs`
--

CREATE TABLE `programs` (
  `program_id` int NOT NULL AUTO_INCREMENT,
  `program_code` varchar(20) COLLATE utf8mb3_unicode_ci NOT NULL,
  `program_name` varchar(150) COLLATE utf8mb3_unicode_ci NOT NULL,
  `study_weeks` smallint NOT NULL,
  `program_status` varchar(20) COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'Active',
  `description` text COLLATE utf8mb3_unicode_ci,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` int NOT NULL,
  PRIMARY KEY (`program_id`),
  UNIQUE KEY `programs_program_code_key` (`program_code`),
  KEY `fk_programs_created_by_account` (`created_by`),
  CONSTRAINT `fk_programs_created_by_account` FOREIGN KEY (`created_by`) REFERENCES `account` (`account_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;


--
-- Table structure for table `batch`
--

CREATE TABLE `batch` (
  `batch_id` int NOT NULL AUTO_INCREMENT,
  `batch_code` varchar(50) COLLATE utf8mb3_unicode_ci NOT NULL,
  `lecture_type` enum('practical','theoretical') COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'practical',
  `program_id` int NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `start_time` time NOT NULL,
  `end_time` time NOT NULL,
  `days_of_week` varchar(50) COLLATE utf8mb3_unicode_ci NOT NULL,
  `note` text COLLATE utf8mb3_unicode_ci,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` int NOT NULL,
  `batch_status` varchar(20) COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'Active',
  `total_sessions` int DEFAULT NULL,
  PRIMARY KEY (`batch_id`),
  UNIQUE KEY `batch_batch_code_key` (`batch_code`),
  KEY `fk_batch_program` (`program_id`),
  CONSTRAINT `fk_batch_program` FOREIGN KEY (`program_id`) REFERENCES `programs` (`program_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;


--
-- Table structure for table `course`
--

CREATE TABLE `course` (
  `course_code` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `course_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `course_description` text COLLATE utf8mb4_unicode_ci,
  `created_by` int NOT NULL,
  `created_at` date DEFAULT (curdate()),
  PRIMARY KEY (`course_code`),
  KEY `fk_course_created_by` (`created_by`),
  CONSTRAINT `fk_course_created_by` FOREIGN KEY (`created_by`) REFERENCES `account` (`account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


--
-- Table structure for table `section`
--

CREATE TABLE `section` (
  `section_id` int NOT NULL AUTO_INCREMENT,
  `batch_id` int NOT NULL,
  `section_code` varchar(10) NOT NULL,
  `gender_type` enum('M','F','X') DEFAULT 'X',
  `section_status` enum('Active','Inactive','Completed','Cancelled') NOT NULL DEFAULT 'Active',
  `max_students` int DEFAULT '30',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `created_by` int DEFAULT NULL,
  PRIMARY KEY (`section_id`),
  UNIQUE KEY `uk_section_code` (`section_code`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DELIMITER ;;
CREATE TRIGGER `auto_section_code` BEFORE INSERT ON `section` FOR EACH ROW BEGIN
    DECLARE last_num INT;

    SELECT COALESCE(MAX(CAST(SUBSTRING(section_code, 2) AS UNSIGNED)), 100)
    INTO last_num
    FROM section;

    SET NEW.section_code = CONCAT(NEW.gender_type, last_num + 1);
END ;;
DELIMITER ;


--
-- Table structure for table `course_section`
--

CREATE TABLE `course_section` (
  `course_section_id` int NOT NULL AUTO_INCREMENT,
  `course_id` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `section_id` int NOT NULL,
  `instructor_id` int NOT NULL,
  `semester` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`course_section_id`),
  UNIQUE KEY `uq_course_section` (`course_id`,`section_id`,`semester`),
  KEY `fk_course_section_section` (`section_id`),
  KEY `fk_course_section_instructor` (`instructor_id`),
  CONSTRAINT `fk_course_section_course` FOREIGN KEY (`course_id`) REFERENCES `course` (`course_code`),
  CONSTRAINT `fk_course_section_instructor` FOREIGN KEY (`instructor_id`) REFERENCES `staff` (`staff_id`),
  CONSTRAINT `fk_course_section_section` FOREIGN KEY (`section_id`) REFERENCES `section` (`section_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


--
-- Table structure for table `enrollment`
--

CREATE TABLE `enrollment` (
  `enrollment_id` int NOT NULL AUTO_INCREMENT,
  `student_id` int NOT NULL,
  `batch_id` int NOT NULL,
  `program_id` int NOT NULL,
  `enrolled_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `enroll_status` varchar(20) COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'Active',
  `created_by` int NOT NULL,
  PRIMARY KEY (`enrollment_id`),
  KEY `fk_enrollment_student` (`student_id`),
  KEY `fk_enrollment_batch` (`batch_id`),
  KEY `fk_enrollment_created_by_account` (`created_by`),
  KEY `fk_enrollment_program` (`program_id`),
  CONSTRAINT `fk_enrollment_batch` FOREIGN KEY (`batch_id`) REFERENCES `batch` (`batch_id`),
  CONSTRAINT `fk_enrollment_created_by_account` FOREIGN KEY (`created_by`) REFERENCES `account` (`account_id`),
  CONSTRAINT `fk_enrollment_program` FOREIGN KEY (`program_id`) REFERENCES `programs` (`program_id`),
  CONSTRAINT `fk_enrollment_student` FOREIGN KEY (`student_id`) REFERENCES `student` (`student_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=154 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;


--
-- Table structure for table `section_enrollment`
--

CREATE TABLE `section_enrollment` (
  `section_enrollment_id` int NOT NULL AUTO_INCREMENT,
  `section_id` int NOT NULL,
  `enrollment_id` int NOT NULL,
  `joined_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `is_active` tinyint DEFAULT '1',
  `notes` text,
  PRIMARY KEY (`section_enrollment_id`),
  UNIQUE KEY `uk_section_student` (`section_id`,`enrollment_id`),
  KEY `fk_section_enrollment_enrollment` (`enrollment_id`),
  CONSTRAINT `fk_section_enrollment_enrollment` FOREIGN KEY (`enrollment_id`) REFERENCES `enrollment` (`enrollment_id`),
  CONSTRAINT `fk_section_enrollment_section` FOREIGN KEY (`section_id`) REFERENCES `section` (`section_id`)
) ENGINE=InnoDB AUTO_INCREMENT=139 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


--
-- Table structure for table `lecture_session`
--

CREATE TABLE `lecture_session` (
  `session_id` int NOT NULL AUTO_INCREMENT,
  `section_id` int DEFAULT NULL,
  `session_date` date NOT NULL,
  `start_time` time NOT NULL,
  `end_time` time NOT NULL,
  `lecture_type` enum('practical','theoretical') NOT NULL,
  `delivery_mode` enum('onsite','online','hybrid') NOT NULL,
  `session_name` varchar(100) DEFAULT NULL,
  `description` text,
  `session_status` enum('scheduled','ongoing','completed','cancelled') DEFAULT 'scheduled',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `created_by` int DEFAULT NULL,
  PRIMARY KEY (`session_id`),
  KEY `created_by` (`created_by`),
  KEY `idx_date` (`session_date`),
  KEY `idx_status` (`session_status`),
  KEY `fk_lecture_session_section` (`section_id`),
  CONSTRAINT `fk_lecture_session_section` FOREIGN KEY (`section_id`) REFERENCES `section` (`section_id`),
  CONSTRAINT `lecture_session_ibfk_2` FOREIGN KEY (`created_by`) REFERENCES `account` (`account_id`)
) ENGINE=InnoDB AUTO_INCREMENT=404 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


--
-- Table structure for table `attendance`
--

CREATE TABLE `attendance` (
  `attendance_id` int NOT NULL AUTO_INCREMENT,
  `enrollment_id` int NOT NULL,
  `attendance_date` date NOT NULL DEFAULT (curdate()),
  `checkin_time` time NOT NULL DEFAULT (curtime()),
  `checkin_latitude` decimal(9,6) NOT NULL,
  `checkin_longitude` decimal(9,6) NOT NULL,
  `checkin_branch_name` varchar(100) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `checkout_time` time DEFAULT NULL,
  `checkout_latitude` decimal(9,6) DEFAULT NULL,
  `checkout_longitude` decimal(9,6) DEFAULT NULL,
  `checkout_branch_name` varchar(100) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `device_fingerprint` varchar(250) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `status_code` varchar(20) COLLATE utf8mb3_unicode_ci NOT NULL,
  `note` text COLLATE utf8mb3_unicode_ci,
  `recorded_by_account_id` int NOT NULL,
  PRIMARY KEY (`attendance_id`),
  KEY `fk_attendance_enrollment` (`enrollment_id`),
  KEY `attendance_recorded_by_account_id_fkey` (`recorded_by_account_id`),
  CONSTRAINT `attendance_recorded_by_account_id_fkey` FOREIGN KEY (`recorded_by_account_id`) REFERENCES `account` (`account_id`),
  CONSTRAINT `fk_attendance_enrollment` FOREIGN KEY (`enrollment_id`) REFERENCES `enrollment` (`enrollment_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=774 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci COMMENT='OLD SYSTEM - Historical data only';


--
-- Table structure for table `attendance_v2`
--

CREATE TABLE `attendance_v2` (
  `attendance_id` int NOT NULL AUTO_INCREMENT,
  `session_id` int NOT NULL,
  `enrollment_id` int NOT NULL,
  `status` enum('present','absent','late','excused','present_different_branch','pending','present_no_checkout','late_no_checkout','permission','permission_no_checkout','late_permission') NOT NULL,
  `recorded_at` date DEFAULT (curdate()),
  `recorded_by` int NOT NULL,
  PRIMARY KEY (`attendance_id`),
  UNIQUE KEY `uk_session_enrollment` (`session_id`,`enrollment_id`),
  KEY `fk_attendance_v2_enrollment` (`enrollment_id`),
  CONSTRAINT `fk_attendance_v2_enrollment` FOREIGN KEY (`enrollment_id`) REFERENCES `enrollment` (`enrollment_id`),
  CONSTRAINT `fk_attendance_v2_session` FOREIGN KEY (`session_id`) REFERENCES `lecture_session` (`session_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6046 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


--
-- Table structure for table `attendance_detail`
--

CREATE TABLE `attendance_detail` (
  `attendance_id` int NOT NULL,
  `checkin_time` time DEFAULT NULL,
  `checkin_latitude` decimal(10,8) DEFAULT NULL,
  `checkin_longitude` decimal(11,8) DEFAULT NULL,
  `checkin_branch_id` int DEFAULT NULL,
  `checkout_time` time DEFAULT NULL,
  `checkout_latitude` decimal(10,8) DEFAULT NULL,
  `checkout_longitude` decimal(11,8) DEFAULT NULL,
  `checkout_branch_id` int DEFAULT NULL,
  `device_fingerprint` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`attendance_id`),
  KEY `fk_detail_checkin_branch` (`checkin_branch_id`),
  KEY `fk_detail_checkout_branch` (`checkout_branch_id`),
  CONSTRAINT `fk_detail_attendance_v2` FOREIGN KEY (`attendance_id`) REFERENCES `attendance_v2` (`attendance_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_detail_checkin_branch` FOREIGN KEY (`checkin_branch_id`) REFERENCES `branch` (`branch_id`),
  CONSTRAINT `fk_detail_checkout_branch` FOREIGN KEY (`checkout_branch_id`) REFERENCES `branch` (`branch_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


--
-- Table structure for table `attendance_excuse`
--

CREATE TABLE `attendance_excuse` (
  `excuse_id` int NOT NULL AUTO_INCREMENT,
  `attendance_id` int NOT NULL,
  `excuse_type` enum('Hospital Visit','Sick Leave','Maternity Leave','Road Accident','Bereavement','Technical Issue','Other') NOT NULL,
  `excuse_reason` text,
  `excuse_document` varchar(255) DEFAULT NULL,
  `submitted_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `submitted_by` int NOT NULL,
  `approval_status` enum('pending','approved','rejected') DEFAULT 'pending',
  `reviewed_by` int DEFAULT NULL,
  `reviewed_at` datetime DEFAULT NULL,
  `review_notes` text,
  `approval_type` enum('medical','personal') DEFAULT NULL,
  PRIMARY KEY (`excuse_id`),
  KEY `fk_excuse_attendance_v2` (`attendance_id`),
  KEY `idx_approval_status` (`approval_status`),
  KEY `idx_submitted_by` (`submitted_by`),
  CONSTRAINT `fk_excuse_attendance_v2` FOREIGN KEY (`attendance_id`) REFERENCES `attendance_v2` (`attendance_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=191 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


--
-- Temporary view structure for view `v_constraints`
--

CREATE VIEW `v_constraints` AS 
SELECT 
    `information_schema`.`tc`.`TABLE_NAME` AS `table_name`,
    `information_schema`.`tc`.`CONSTRAINT_NAME` AS `constraint_name`,
    `information_schema`.`tc`.`CONSTRAINT_TYPE` AS `constraint_type`,
    `information_schema`.`kcu`.`COLUMN_NAME` AS `column_name`,
    `information_schema`.`kcu`.`REFERENCED_TABLE_NAME` AS `ref_table`,
    `information_schema`.`kcu`.`REFERENCED_COLUMN_NAME` AS `ref_column`,
    `information_schema`.`rc`.`UPDATE_RULE` AS `on_update`,
    `information_schema`.`rc`.`DELETE_RULE` AS `on_delete` 
FROM ((`information_schema`.`TABLE_CONSTRAINTS` `tc` 
LEFT JOIN `information_schema`.`KEY_COLUMN_USAGE` `kcu` 
    ON (((`information_schema`.`tc`.`CONSTRAINT_NAME` = `information_schema`.`kcu`.`CONSTRAINT_NAME`) 
    AND (`information_schema`.`tc`.`TABLE_SCHEMA` = `information_schema`.`kcu`.`TABLE_SCHEMA`)))) 
LEFT JOIN `information_schema`.`REFERENTIAL_CONSTRAINTS` `rc` 
    ON (((`information_schema`.`tc`.`CONSTRAINT_NAME` = `information_schema`.`rc`.`CONSTRAINT_NAME`) 
    AND (`information_schema`.`tc`.`TABLE_SCHEMA` = `information_schema`.`rc`.`CONSTRAINT_SCHEMA`)))) 
WHERE (`information_schema`.`tc`.`TABLE_SCHEMA` = 'student_system') 
ORDER BY `information_schema`.`tc`.`TABLE_NAME`, `information_schema`.`tc`.`CONSTRAINT_TYPE`;


--
-- Final view structure for view `v_schema`
--

CREATE VIEW `v_schema` AS 
SELECT DISTINCT 
    `information_schema`.`c`.`TABLE_NAME` AS `table_name`,
    `information_schema`.`c`.`COLUMN_NAME` AS `column_name`,
    `information_schema`.`c`.`DATA_TYPE` AS `data_type`,
    `information_schema`.`c`.`CHARACTER_MAXIMUM_LENGTH` AS `max_length`,
    `information_schema`.`c`.`IS_NULLABLE` AS `is_nullable`,
    `information_schema`.`c`.`COLUMN_DEFAULT` AS `column_default`,
    `information_schema`.`c`.`COLUMN_KEY` AS `key_type`,
    `information_schema`.`c`.`EXTRA` AS `extra_info`,
    `information_schema`.`c`.`COLUMN_COMMENT` AS `comment`,
    `information_schema`.`tc`.`CONSTRAINT_TYPE` AS `constraint_type`,
    `information_schema`.`c`.`ORDINAL_POSITION` AS `ORDINAL_POSITION` 
FROM ((`information_schema`.`COLUMNS` `c` 
LEFT JOIN `information_schema`.`KEY_COLUMN_USAGE` `kcu` 
    ON (((`information_schema`.`c`.`TABLE_NAME` = `information_schema`.`kcu`.`TABLE_NAME`) 
    AND (`information_schema`.`c`.`COLUMN_NAME` = `information_schema`.`kcu`.`COLUMN_NAME`) 
    AND (`information_schema`.`c`.`TABLE_SCHEMA` = `information_schema`.`kcu`.`TABLE_SCHEMA`)))) 
LEFT JOIN `information_schema`.`TABLE_CONSTRAINTS` `tc` 
    ON (((`information_schema`.`kcu`.`CONSTRAINT_NAME` = `information_schema`.`tc`.`CONSTRAINT_NAME`) 
    AND (`information_schema`.`kcu`.`TABLE_SCHEMA` = `information_schema`.`tc`.`TABLE_SCHEMA`)))) 
WHERE (`information_schema`.`c`.`TABLE_SCHEMA` = 'student_system') 
ORDER BY `information_schema`.`c`.`TABLE_NAME`, `information_schema`.`c`.`ORDINAL_POSITION`;

-- Dump completed on 2026-08-25 17:14:41
