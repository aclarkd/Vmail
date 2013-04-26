CREATE TABLE `domain` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `description` VARCHAR(255) CHARACTER SET utf8 NOT NULL,
  `aliases` INT(10) NOT NULL DEFAULT '0',
  `mailboxes` INT(10) NOT NULL DEFAULT '0',
  `max_quota` BIGINT(20) NOT NULL DEFAULT '0',
  `quota` BIGINT(20) NOT NULL DEFAULT '0',
  `created` DATETIME NOT NULL,
  `modified` DATETIME NOT NULL,
  `active` TINYINT(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=INNODB;

CREATE TABLE `email` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(255) NOT NULL,
  `local_part` VARCHAR(255) NOT NULL,
  `domain` INT UNSIGNED NOT NULL,
  `created` DATETIME NOT NULL,
  `modified` DATETIME NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  CONSTRAINT `FK_email_domain` FOREIGN KEY (`domain`) REFERENCES `domain` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=INNODB;

CREATE TABLE `alias` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `destination` INT UNSIGNED NOT NULL,
  `source` INT UNSIGNED NOT NULL,
  `created` DATETIME NOT NULL,
  `modified` DATETIME NOT NULL,
  `active` TINYINT(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `alias` (`source`, `destination`),
  CONSTRAINT `FK_alias_source` FOREIGN KEY (`source`) REFERENCES `email` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_alias_destination` FOREIGN KEY (`destination`) REFERENCES `email` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=INNODB;

CREATE TABLE `mailbox` (
  `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(255) NOT NULL,
  `password` VARCHAR(255) NOT NULL,
  `name` VARCHAR(255) NOT NULL,
  `maildir` VARCHAR(255) NOT NULL,
  `quota` BIGINT(20) NOT NULL DEFAULT '0',
  `email` INT UNSIGNED NOT NULL,
  `created` DATETIME NOT NULL,
  `modified` DATETIME NOT NULL,
  `active` TINYINT(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  CONSTRAINT `FK_mailbox_email` FOREIGN KEY (`email`) REFERENCES `email` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=INNODB;