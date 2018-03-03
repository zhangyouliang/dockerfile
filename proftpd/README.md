CREATE DATABASE xbclub_wp CHARACTER SET utf8 COLLATE utf8_bin;
GRANT ALL ON xbclub_wp.* TO 'xbclub_1520067296'@'%' IDENTIFIED BY '2sXnxngHjY2xGnz';

CREATE DATABASE wuxin_wp CHARACTER SET utf8 COLLATE utf8_bin;
GRANT ALL ON wuxin_wp.* TO 'wuxin_1520067296'@'%' IDENTIFIED BY 'aef0b100b4';
FLUSH PRIVILEGES;

CREATE DATABASE proftpd;
GRANT ALL ON proftpd.* TO 'proftpd'@'%' IDENTIFIED BY '5dDokSAJtIzpnVv';
USE proftpd;
CREATE TABLE IF NOT EXISTS `ftpgroup` (
  `groupname` varchar(16) COLLATE utf8_general_ci NOT NULL,
  `gid` smallint(6) NOT NULL DEFAULT '82',
  `members` varchar(16) COLLATE utf8_general_ci NOT NULL,
  KEY `groupname` (`groupname`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='ProFTP group table';
CREATE TABLE IF NOT EXISTS `ftpuser` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `userid` varchar(32) COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `passwd` varchar(32) COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `uid` smallint(6) NOT NULL DEFAULT '82',
  `gid` smallint(6) NOT NULL DEFAULT '82',
  `homedir` varchar(255) COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `shell` varchar(16) COLLATE utf8_general_ci NOT NULL DEFAULT '/sbin/nologin',
  `count` int(11) NOT NULL DEFAULT '0',
  `accessed` datetime NOT NULL DEFAULT '2018-03-02 13:45:45',
  `modified` datetime NOT NULL DEFAULT '2018-03-02 13:45:45',
  PRIMARY KEY (`id`),
  UNIQUE KEY `userid` (`userid`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='ProFTP user table';

INSERT INTO `ftpgroup` (`groupname`, `gid`, `members`) VALUES ('www-data', 82, 'www-data');
INSERT INTO `ftpuser` (`userid`, `passwd`, `uid`, `gid`, `homedir`, `shell`, `count`) VALUES ('wuxin', ENCRYPT('GHZb5WkBOcjoM5Y'), 82, 82, '/var/www/wuxin/www', '/sbin/nologin', 0);
INSERT INTO `ftpuser` (`userid`, `passwd`, `uid`, `gid`, `homedir`, `shell`, `count`) VALUES ('xbclub', ENCRYPT('xbclub'), 82, 82, '/var/www/wuxin/www', '/sbin/nologin', 0);
