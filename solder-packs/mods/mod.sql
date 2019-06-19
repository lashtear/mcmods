INSERT INTO
  solder_modpacks (name, slug, recommended, latest,
		   url, icon_md5, logo_md5, background_md5,
		   created_at, updated_at, hidden, private)
  VALUES ('mmt5', 'mmt5', '0.1.5', '0.1.5',
	  NULL, ' ', ' ', ' ',
	  now(), now(), 0, 0)
  ON DUPLICATE KEY UPDATE
    latest='0.1.5',
    updated_at=now();

INSERT INTO
  solder_builds (modpack_id, version, created_at, updated_at,
		 minecraft, forge, is_published, private,
		 minecraft_md5)
  SELECT id AS modpack_id, '0.1.5', now(), now(),
      '1.12.2', NULL, 1, 0,
      ' '
  FROM solder_modpacks
  WHERE name='mmt5'
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('mmt5-config', 'mmt5-config', 'mmt5-config', 'Lashtear',
	  'http://mechanipus.com/', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='Lashtear',
    link='http://mechanipus.com/';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '0.1.5', '30024f67a6e21399cc9962291b266747', now(), now()
  FROM solder_mods
  WHERE name='mmt5-config'
  ON DUPLICATE KEY UPDATE
    md5='30024f67a6e21399cc9962291b266747',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='mmt5-config'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='0.1.5'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('mechanipus-resource-pack-mmt5', 'mechanipus-resource-pack-mmt5', 'mechanipus-resource-pack-mmt5', 'Lashtear',
	  'http://mechanipus.com/', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='Lashtear',
    link='http://mechanipus.com/';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '0.1.5', 'fb741022435714fafa2adcecc757b55d', now(), now()
  FROM solder_mods
  WHERE name='mechanipus-resource-pack-mmt5'
  ON DUPLICATE KEY UPDATE
    md5='fb741022435714fafa2adcecc757b55d',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='mechanipus-resource-pack-mmt5'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='0.1.5'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('forge', 'forge', 'forge', 'lex manos',
	  'http://files.minecraftforge.net/', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='lex manos',
    link='http://files.minecraftforge.net/';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '14.23.4.2705', 'bd058fe18191e159595bdc9d20b4cd95', now(), now()
  FROM solder_mods
  WHERE name='forge'
  ON DUPLICATE KEY UPDATE
    md5='bd058fe18191e159595bdc9d20b4cd95',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='forge'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='14.23.4.2705'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('chicken-chunks', 'chicken-chunks', 'chicken-chunks', 'chicken_bones, covers1624',
	  'https://www.curseforge.com/minecraft/mc-mods/codechicken-lib-1-8', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='chicken_bones, covers1624',
    link='https://www.curseforge.com/minecraft/mc-mods/codechicken-lib-1-8';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '2.4.1.71', 'c0721dd297dd7a808d3eadfd63189e43', now(), now()
  FROM solder_mods
  WHERE name='chicken-chunks'
  ON DUPLICATE KEY UPDATE
    md5='c0721dd297dd7a808d3eadfd63189e43',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='chicken-chunks'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='2.4.1.71'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('code-chicken-lib', 'code-chicken-lib', 'code-chicken-lib', 'chicken_bones, covers1624',
	  'https://www.curseforge.com/minecraft/mc-mods/codechicken-lib-1-8', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='chicken_bones, covers1624',
    link='https://www.curseforge.com/minecraft/mc-mods/codechicken-lib-1-8';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '3.2.0.345', 'f6f356cbe0261d59fb9a2763ce6fc561', now(), now()
  FROM solder_mods
  WHERE name='code-chicken-lib'
  ON DUPLICATE KEY UPDATE
    md5='f6f356cbe0261d59fb9a2763ce6fc561',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='code-chicken-lib'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='3.2.0.345'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('not-enough-items', 'not-enough-items', 'not-enough-items', 'chicken_bones, covers1624',
	  'https://www.curseforge.com/minecraft/mc-mods/codechicken-lib-1-8', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='chicken_bones, covers1624',
    link='https://www.curseforge.com/minecraft/mc-mods/codechicken-lib-1-8';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '2.4.1.233', 'b20ed90ff757a6aa651b2af3692848cc', now(), now()
  FROM solder_mods
  WHERE name='not-enough-items'
  ON DUPLICATE KEY UPDATE
    md5='b20ed90ff757a6aa651b2af3692848cc',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='not-enough-items'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='2.4.1.233'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('translocators', 'translocators', 'translocators', 'chicken_bones, covers1624',
	  'https://www.curseforge.com/minecraft/mc-mods/codechicken-lib-1-8', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='chicken_bones, covers1624',
    link='https://www.curseforge.com/minecraft/mc-mods/codechicken-lib-1-8';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '2.5.0.73', '2f3dac32fc9934969e5ccddc7899d585', now(), now()
  FROM solder_mods
  WHERE name='translocators'
  ON DUPLICATE KEY UPDATE
    md5='2f3dac32fc9934969e5ccddc7899d585',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='translocators'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='2.5.0.73'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('ender-storage', 'ender-storage', 'ender-storage', 'chicken_bones, covers1624',
	  'https://www.curseforge.com/minecraft/mc-mods/codechicken-lib-1-8', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='chicken_bones, covers1624',
    link='https://www.curseforge.com/minecraft/mc-mods/codechicken-lib-1-8';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '2.4.4.132', '9eca39538b8583d84b7882667f1cef21', now(), now()
  FROM solder_mods
  WHERE name='ender-storage'
  ON DUPLICATE KEY UPDATE
    md5='9eca39538b8583d84b7882667f1cef21',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='ender-storage'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='2.4.4.132'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('forge-multipart', 'forge-multipart', 'forge-multipart', 'chicken_bones, covers1624',
	  'https://www.curseforge.com/minecraft/mc-mods/codechicken-lib-1-8', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='chicken_bones, covers1624',
    link='https://www.curseforge.com/minecraft/mc-mods/codechicken-lib-1-8';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '2.4.2.60', '32b3a535c201ef0c510c18d42fcf076e', now(), now()
  FROM solder_mods
  WHERE name='forge-multipart'
  ON DUPLICATE KEY UPDATE
    md5='32b3a535c201ef0c510c18d42fcf076e',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='forge-multipart'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='2.4.2.60'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('redstone-flux', 'redstone-flux', 'redstone-flux', 'TeamCOFH',
	  'https://teamcofh.com/', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='TeamCOFH',
    link='https://teamcofh.com/';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '2.0.2.3', '6354d443936886750d88435efef32959', now(), now()
  FROM solder_mods
  WHERE name='redstone-flux'
  ON DUPLICATE KEY UPDATE
    md5='6354d443936886750d88435efef32959',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='redstone-flux'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='2.0.2.3'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('cofh-core', 'cofh-core', 'cofh-core', 'TeamCOFH',
	  'https://teamcofh.com/', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='TeamCOFH',
    link='https://teamcofh.com/';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '4.5.2.19', 'feafc6b7f6697b541d04e5611fc2d7f2', now(), now()
  FROM solder_mods
  WHERE name='cofh-core'
  ON DUPLICATE KEY UPDATE
    md5='feafc6b7f6697b541d04e5611fc2d7f2',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='cofh-core'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='4.5.2.19'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('cofh-world', 'cofh-world', 'cofh-world', 'TeamCOFH',
	  'https://teamcofh.com/', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='TeamCOFH',
    link='https://teamcofh.com/';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '1.2.0.5', '06e60b587a2e758b95e13db384e1e9e1', now(), now()
  FROM solder_mods
  WHERE name='cofh-world'
  ON DUPLICATE KEY UPDATE
    md5='06e60b587a2e758b95e13db384e1e9e1',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='cofh-world'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='1.2.0.5'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('thermal-cultivation', 'thermal-cultivation', 'thermal-cultivation', 'TeamCOFH',
	  'https://teamcofh.com/', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='TeamCOFH',
    link='https://teamcofh.com/';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '0.3.0.7', 'a4eb75481e1b61ae25b561f19619c381', now(), now()
  FROM solder_mods
  WHERE name='thermal-cultivation'
  ON DUPLICATE KEY UPDATE
    md5='a4eb75481e1b61ae25b561f19619c381',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='thermal-cultivation'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='0.3.0.7'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('thermal-dynamics', 'thermal-dynamics', 'thermal-dynamics', 'TeamCOFH',
	  'https://teamcofh.com/', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='TeamCOFH',
    link='https://teamcofh.com/';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '2.5.1.14', 'b1264255778e8ab4609400c270306428', now(), now()
  FROM solder_mods
  WHERE name='thermal-dynamics'
  ON DUPLICATE KEY UPDATE
    md5='b1264255778e8ab4609400c270306428',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='thermal-dynamics'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='2.5.1.14'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('thermal-expansion', 'thermal-expansion', 'thermal-expansion', 'TeamCOFH',
	  'https://teamcofh.com/', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='TeamCOFH',
    link='https://teamcofh.com/';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '5.5.0.29', '0aa8aeb4fb22c9bc9ad35a30f92b0eba', now(), now()
  FROM solder_mods
  WHERE name='thermal-expansion'
  ON DUPLICATE KEY UPDATE
    md5='0aa8aeb4fb22c9bc9ad35a30f92b0eba',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='thermal-expansion'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='5.5.0.29'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('thermal-foundation', 'thermal-foundation', 'thermal-foundation', 'TeamCOFH',
	  'https://teamcofh.com/', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='TeamCOFH',
    link='https://teamcofh.com/';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '2.5.0.19', 'dc44fc341a4f1a0cf6a6cff3e7b8c9e2', now(), now()
  FROM solder_mods
  WHERE name='thermal-foundation'
  ON DUPLICATE KEY UPDATE
    md5='dc44fc341a4f1a0cf6a6cff3e7b8c9e2',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='thermal-foundation'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='2.5.0.19'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('no-nv-flash', 'no-nv-flash', 'no-nv-flash', 'TeamCOFH',
	  'https://teamcofh.com/', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='TeamCOFH',
    link='https://teamcofh.com/';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '1.2.0.3', '377262f18d7f5f75e545c4132099ae66', now(), now()
  FROM solder_mods
  WHERE name='no-nv-flash'
  ON DUPLICATE KEY UPDATE
    md5='377262f18d7f5f75e545c4132099ae66',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='no-nv-flash'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='1.2.0.3'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('connected-textures', 'connected-textures', 'connected-textures', 'tterrag1098, Drullkus, Minecreatr',
	  'https://minecraft.curseforge.com/projects/ctm', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='tterrag1098, Drullkus, Minecreatr',
    link='https://minecraft.curseforge.com/projects/ctm';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '0.3.0.15', '7ed839b7d26e904741bd0c0826147284', now(), now()
  FROM solder_mods
  WHERE name='connected-textures'
  ON DUPLICATE KEY UPDATE
    md5='7ed839b7d26e904741bd0c0826147284',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='connected-textures'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='0.3.0.15'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('chisel', 'chisel', 'chisel', 'tterrag1098, Drullkus, Minecreatr',
	  'https://minecraft.curseforge.com/projects/chisel', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='tterrag1098, Drullkus, Minecreatr',
    link='https://minecraft.curseforge.com/projects/chisel';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '0.2.0.31', 'a8af290debf0d952e0f9ac5db72c44b2', now(), now()
  FROM solder_mods
  WHERE name='chisel'
  ON DUPLICATE KEY UPDATE
    md5='a8af290debf0d952e0f9ac5db72c44b2',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='chisel'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='0.2.0.31'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('mantle', 'mantle', 'mantle', 'mDiyo, boni, et al',
	  'https://minecraft.curseforge.com/projects/mantle', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='mDiyo, boni, et al',
    link='https://minecraft.curseforge.com/projects/mantle';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '1.3.2.24', '60c469bd67360b32c0130f7d531c91d8', now(), now()
  FROM solder_mods
  WHERE name='mantle'
  ON DUPLICATE KEY UPDATE
    md5='60c469bd67360b32c0130f7d531c91d8',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='mantle'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='1.3.2.24'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('natura', 'natura', 'natura', 'mDiyo, boni, et al',
	  'https://minecraft.curseforge.com/projects/natura', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='mDiyo, boni, et al',
    link='https://minecraft.curseforge.com/projects/natura';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '4.3.2.49', 'c4e03783dfec10f538d67cf796997ea5', now(), now()
  FROM solder_mods
  WHERE name='natura'
  ON DUPLICATE KEY UPDATE
    md5='c4e03783dfec10f538d67cf796997ea5',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='natura'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='4.3.2.49'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('tinkers-construct', 'tinkers-construct', 'tinkers-construct', 'mDiyo, boni, et al',
	  'https://minecraft.curseforge.com/projects/tinkers-construct', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='mDiyo, boni, et al',
    link='https://minecraft.curseforge.com/projects/tinkers-construct';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '2.10.1.87', '28b2b41a925ade0d5325dd000383b904', now(), now()
  FROM solder_mods
  WHERE name='tinkers-construct'
  ON DUPLICATE KEY UPDATE
    md5='28b2b41a925ade0d5325dd000383b904',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='tinkers-construct'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='2.10.1.87'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('constructs-armor', 'constructs-armor', 'constructs-armor', 'TheIllusiveC4',
	  'https://minecraft.curseforge.com/projects/constructs-armory', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='TheIllusiveC4',
    link='https://minecraft.curseforge.com/projects/constructs-armory';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '1.0.1.1', '9a726be6f9ef59951946a58caa8af574', now(), now()
  FROM solder_mods
  WHERE name='constructs-armor'
  ON DUPLICATE KEY UPDATE
    md5='9a726be6f9ef59951946a58caa8af574',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='constructs-armor'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='1.0.1.1'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('harvest-tweaks', 'harvest-tweaks', 'harvest-tweaks', 'boni',
	  'https://minecraft.curseforge.com/projects/harvest-tweaks', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='boni',
    link='https://minecraft.curseforge.com/projects/harvest-tweaks';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '0.1.5', 'ae7fb4b80d36bd3a349e808764f020da', now(), now()
  FROM solder_mods
  WHERE name='harvest-tweaks'
  ON DUPLICATE KEY UPDATE
    md5='ae7fb4b80d36bd3a349e808764f020da',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='harvest-tweaks'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='0.1.5'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('tinker-tool-leveling', 'tinker-tool-leveling', 'tinker-tool-leveling', 'boni',
	  'https://minecraft.curseforge.com/projects/tinkers-tool-leveling', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='boni',
    link='https://minecraft.curseforge.com/projects/tinkers-tool-leveling';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '1.0.5', '42a802a09a8d9a5f9b4af1878659cf6c', now(), now()
  FROM solder_mods
  WHERE name='tinker-tool-leveling'
  ON DUPLICATE KEY UPDATE
    md5='42a802a09a8d9a5f9b4af1878659cf6c',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='tinker-tool-leveling'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='1.0.5'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('plus-tic', 'plus-tic', 'plus-tic', 'Landmaster_phuong0429',
	  'https://minecraft.curseforge.com/projects/plustic', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='Landmaster_phuong0429',
    link='https://minecraft.curseforge.com/projects/plustic';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '6.5.2.0', 'de928b137fa469732e230e3930974505', now(), now()
  FROM solder_mods
  WHERE name='plus-tic'
  ON DUPLICATE KEY UPDATE
    md5='de928b137fa469732e230e3930974505',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='plus-tic'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='6.5.2.0'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('tinker-survival', 'tinker-survival', 'tinker-survival', 'wendall911',
	  'https://minecraft.curseforge.com/projects/tinkersurvival', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='wendall911',
    link='https://minecraft.curseforge.com/projects/tinkersurvival';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '1.1.0.4', '92898e1ccf37097adaa64de12aecb302', now(), now()
  FROM solder_mods
  WHERE name='tinker-survival'
  ON DUPLICATE KEY UPDATE
    md5='92898e1ccf37097adaa64de12aecb302',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='tinker-survival'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='1.1.0.4'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('biomes-o-plenty', 'biomes-o-plenty', 'biomes-o-plenty', 'Adubbz and Forstride',
	  'https://www.minecraftforum.net/forums/mapping-and-modding-java-edition/minecraft-mods/1286162-biomes-o-plenty-over-50-new-biomes-with-new-trees', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='Adubbz and Forstride',
    link='https://www.minecraftforum.net/forums/mapping-and-modding-java-edition/minecraft-mods/1286162-biomes-o-plenty-over-50-new-biomes-with-new-trees';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '7.0.1.2384', '7654528fa4ad9a4c74ce5be13db2b058', now(), now()
  FROM solder_mods
  WHERE name='biomes-o-plenty'
  ON DUPLICATE KEY UPDATE
    md5='7654528fa4ad9a4c74ce5be13db2b058',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='biomes-o-plenty'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='7.0.1.2384'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('tough-as-nails', 'tough-as-nails', 'tough-as-nails', 'Adubbz and Forstride',
	  'https://www.minecraftforum.net/forums/mapping-and-modding-java-edition/minecraft-mods/2696397-tough-as-nails-difficulty-through-realism-seasons', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='Adubbz and Forstride',
    link='https://www.minecraftforum.net/forums/mapping-and-modding-java-edition/minecraft-mods/2696397-tough-as-nails-difficulty-through-realism-seasons';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '3.1.0.115', '808b71cd7b34376db51643115cdddd29', now(), now()
  FROM solder_mods
  WHERE name='tough-as-nails'
  ON DUPLICATE KEY UPDATE
    md5='808b71cd7b34376db51643115cdddd29',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='tough-as-nails'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='3.1.0.115'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('better-foliage', 'better-foliage', 'better-foliage', 'Octarine_Noise',
	  'https://minecraft.curseforge.com/projects/better-foliage', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='Octarine_Noise',
    link='https://minecraft.curseforge.com/projects/better-foliage';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '2.1.10', '8d7144600726eb29a0dcbfdac244ce19', now(), now()
  FROM solder_mods
  WHERE name='better-foliage'
  ON DUPLICATE KEY UPDATE
    md5='8d7144600726eb29a0dcbfdac244ce19',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='better-foliage'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='2.1.10'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('journey-map', 'journey-map', 'journey-map', 'techbrew',
	  'https://minecraft.curseforge.com/projects/journeymap', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='techbrew',
    link='https://minecraft.curseforge.com/projects/journeymap';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '5.5.2', 'a8242797ea36ec4bb60cd7521775f165', now(), now()
  FROM solder_mods
  WHERE name='journey-map'
  ON DUPLICATE KEY UPDATE
    md5='a8242797ea36ec4bb60cd7521775f165',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='journey-map'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='5.5.2'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('chameleon', 'chameleon', 'chameleon', 'jacquadro',
	  'https://minecraft.curseforge.com/projects/chameleon', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='jacquadro',
    link='https://minecraft.curseforge.com/projects/chameleon';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '4.1.3', '42c642acc3068ae8402edf90ee23cb7b', now(), now()
  FROM solder_mods
  WHERE name='chameleon'
  ON DUPLICATE KEY UPDATE
    md5='42c642acc3068ae8402edf90ee23cb7b',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='chameleon'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='4.1.3'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('storage-drawers', 'storage-drawers', 'storage-drawers', 'jacquadro',
	  'https://minecraft.curseforge.com/projects/storage-drawers', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='jacquadro',
    link='https://minecraft.curseforge.com/projects/storage-drawers';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '5.3.7', 'e2a9440ccfb7cfb5794a7aaf2a79b31f', now(), now()
  FROM solder_mods
  WHERE name='storage-drawers'
  ON DUPLICATE KEY UPDATE
    md5='e2a9440ccfb7cfb5794a7aaf2a79b31f',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='storage-drawers'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='5.3.7'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('storage-drawers-extras', 'storage-drawers-extras', 'storage-drawers-extras', 'jacquadro',
	  'https://minecraft.curseforge.com/projects/storage-drawers-extras', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='jacquadro',
    link='https://minecraft.curseforge.com/projects/storage-drawers-extras';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '3.1.0', '13465a6b89f1ea03f788460f6cfbecdb', now(), now()
  FROM solder_mods
  WHERE name='storage-drawers-extras'
  ON DUPLICATE KEY UPDATE
    md5='13465a6b89f1ea03f788460f6cfbecdb',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='storage-drawers-extras'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='3.1.0'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('just-enough-items', 'just-enough-items', 'just-enough-items', 'mezz',
	  'https://minecraft.curseforge.com/projects/jei', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='mezz',
    link='https://minecraft.curseforge.com/projects/jei';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '4.10.0.198', '1836688dd665f417d62c294bdaf94b8a', now(), now()
  FROM solder_mods
  WHERE name='just-enough-items'
  ON DUPLICATE KEY UPDATE
    md5='1836688dd665f417d62c294bdaf94b8a',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='just-enough-items'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='4.10.0.198'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('more-overlays', 'more-overlays', 'more-overlays', 'feldim2425',
	  'https://minecraft.curseforge.com/projects/more-overlays', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='feldim2425',
    link='https://minecraft.curseforge.com/projects/more-overlays';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '1.13', '6b40fad4a64223a9a184fa41594565cd', now(), now()
  FROM solder_mods
  WHERE name='more-overlays'
  ON DUPLICATE KEY UPDATE
    md5='6b40fad4a64223a9a184fa41594565cd',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='more-overlays'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='1.13'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('iron-chest', 'iron-chest', 'iron-chest', 'progwml6, Alexbegt',
	  'https://minecraft.curseforge.com/projects/iron-chests', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='progwml6, Alexbegt',
    link='https://minecraft.curseforge.com/projects/iron-chests';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '7.0.40.824', '4def0674ad87115ea65f6cf8f57aae09', now(), now()
  FROM solder_mods
  WHERE name='iron-chest'
  ON DUPLICATE KEY UPDATE
    md5='4def0674ad87115ea65f6cf8f57aae09',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='iron-chest'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='7.0.40.824'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('baubles', 'baubles', 'baubles', 'Azanor',
	  'https://www.minecraftforum.net/forums/mapping-and-modding-java-edition/minecraft-mods/1294623-baubles-1-4-6-1-5-2-updated-2018-1-10', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='Azanor',
    link='https://www.minecraftforum.net/forums/mapping-and-modding-java-edition/minecraft-mods/1294623-baubles-1-4-6-1-5-2-updated-2018-1-10';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '1.5.2', '2531662d2ed0e39b70d3244c250b105e', now(), now()
  FROM solder_mods
  WHERE name='baubles'
  ON DUPLICATE KEY UPDATE
    md5='2531662d2ed0e39b70d3244c250b105e',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='baubles'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='1.5.2'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('botania', 'botania', 'botania', 'vazkii',
	  'https://botaniamod.net/index.php', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='vazkii',
    link='https://botaniamod.net/index.php';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '1.10-354', '6c5aa6f8ab71340240a1ae1740c9a51b', now(), now()
  FROM solder_mods
  WHERE name='botania'
  ON DUPLICATE KEY UPDATE
    md5='6c5aa6f8ab71340240a1ae1740c9a51b',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='botania'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='1.10-354'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('akashic-tome', 'akashic-tome', 'akashic-tome', 'vazkii',
	  'https://minecraft.curseforge.com/projects/akashic-tome', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='vazkii',
    link='https://minecraft.curseforge.com/projects/akashic-tome';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '1.2-10', '5f2612d767e251091cc30fd95ac0b7c9', now(), now()
  FROM solder_mods
  WHERE name='akashic-tome'
  ON DUPLICATE KEY UPDATE
    md5='5f2612d767e251091cc30fd95ac0b7c9',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='akashic-tome'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='1.2-10'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('auto-reg-lib', 'auto-reg-lib', 'auto-reg-lib', 'vazkii',
	  'https://minecraft.curseforge.com/projects/autoreglib', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='vazkii',
    link='https://minecraft.curseforge.com/projects/autoreglib';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '1.3-18', '21fa8829746813d8fdafa119c0dbd4a7', now(), now()
  FROM solder_mods
  WHERE name='auto-reg-lib'
  ON DUPLICATE KEY UPDATE
    md5='21fa8829746813d8fdafa119c0dbd4a7',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='auto-reg-lib'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='1.3-18'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('quark', 'quark', 'quark', 'vazkii',
	  'https://minecraft.curseforge.com/projects/quark', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='vazkii',
    link='https://minecraft.curseforge.com/projects/quark';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '1.4-125', 'f2573397f16bc6952e8e77c061ee1a0d', now(), now()
  FROM solder_mods
  WHERE name='quark'
  ON DUPLICATE KEY UPDATE
    md5='f2573397f16bc6952e8e77c061ee1a0d',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='quark'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='1.4-125'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('industrial-foregoing', 'industrial-foregoing', 'industrial-foregoing', 'Buuz135',
	  'https://minecraft.curseforge.com/projects/industrial-foregoing', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='Buuz135',
    link='https://minecraft.curseforge.com/projects/industrial-foregoing';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '1.10.2-178', '80d7a937c534a99b5c7a50ccdbf6ce51', now(), now()
  FROM solder_mods
  WHERE name='industrial-foregoing'
  ON DUPLICATE KEY UPDATE
    md5='80d7a937c534a99b5c7a50ccdbf6ce51',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='industrial-foregoing'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='1.10.2-178'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('integration-foregoing', 'integration-foregoing', 'integration-foregoing', 'Jackyy, Buuz135',
	  'https://minecraft.curseforge.com/projects/integration-foregoing', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='Jackyy, Buuz135',
    link='https://minecraft.curseforge.com/projects/integration-foregoing';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '1.7.1', 'f163a67026e01787e81d0b7ee3db27aa', now(), now()
  FROM solder_mods
  WHERE name='integration-foregoing'
  ON DUPLICATE KEY UPDATE
    md5='f163a67026e01787e81d0b7ee3db27aa',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='integration-foregoing'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='1.7.1'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('smooth-water', 'smooth-water', 'smooth-water', 'asiekierka',
	  'https://minecraft.curseforge.com/projects/smoothwater', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='asiekierka',
    link='https://minecraft.curseforge.com/projects/smoothwater';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '0.1.4', '73e2893325100813fe43cf8e2db1ea18', now(), now()
  FROM solder_mods
  WHERE name='smooth-water'
  ON DUPLICATE KEY UPDATE
    md5='73e2893325100813fe43cf8e2db1ea18',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='smooth-water'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='0.1.4'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('wearable-backpacks', 'wearable-backpacks', 'wearable-backpacks', 'PuppetzMedia, asiekierka, buildcraftchildsplay, copygirl, InsomniaKitten, mindlesspuppetz',
	  'https://minecraft.curseforge.com/projects/wearable-backpacks', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='PuppetzMedia, asiekierka, buildcraftchildsplay, copygirl, InsomniaKitten, mindlesspuppetz',
    link='https://minecraft.curseforge.com/projects/wearable-backpacks';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '3.1.3', 'e7ff2366bcdad0e37218f4415369e975', now(), now()
  FROM solder_mods
  WHERE name='wearable-backpacks'
  ON DUPLICATE KEY UPDATE
    md5='e7ff2366bcdad0e37218f4415369e975',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='wearable-backpacks'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='3.1.3'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('dark-utilities', 'dark-utilities', 'dark-utilities', 'Darkhax',
	  'https://minecraft.curseforge.com/projects/dark-utilities', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='Darkhax',
    link='https://minecraft.curseforge.com/projects/dark-utilities';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '1.8.211', 'c4793e4a683851d34d20280278283eaf', now(), now()
  FROM solder_mods
  WHERE name='dark-utilities'
  ON DUPLICATE KEY UPDATE
    md5='c4793e4a683851d34d20280278283eaf',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='dark-utilities'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='1.8.211'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('bookshelf', 'bookshelf', 'bookshelf', 'Darkhax',
	  'https://minecraft.curseforge.com/projects/bookshelf', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='Darkhax',
    link='https://minecraft.curseforge.com/projects/bookshelf';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '2.3.552', 'd556449730e2f066336bce2c494911b0', now(), now()
  FROM solder_mods
  WHERE name='bookshelf'
  ON DUPLICATE KEY UPDATE
    md5='d556449730e2f066336bce2c494911b0',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='bookshelf'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='2.3.552'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('wawla', 'wawla', 'wawla', 'Darkhax',
	  'https://minecraft.curseforge.com/projects/wawla-what-are-we-looking-at', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='Darkhax',
    link='https://minecraft.curseforge.com/projects/wawla-what-are-we-looking-at';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '2.5.257', '69b25294bbc094d0f052c917c48c39d5', now(), now()
  FROM solder_mods
  WHERE name='wawla'
  ON DUPLICATE KEY UPDATE
    md5='69b25294bbc094d0f052c917c48c39d5',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='wawla'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='2.5.257'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('old-java-warning', 'old-java-warning', 'old-java-warning', 'Darkhax',
	  'https://minecraft.curseforge.com/projects/oldjavawarning', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='Darkhax',
    link='https://minecraft.curseforge.com/projects/oldjavawarning';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '1.0.2', 'b2b1a2e53c48ed383ad110f57b9c2581', now(), now()
  FROM solder_mods
  WHERE name='old-java-warning'
  ON DUPLICATE KEY UPDATE
    md5='b2b1a2e53c48ed383ad110f57b9c2581',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='old-java-warning'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='1.0.2'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('kelpie', 'kelpie', 'kelpie', 'Darkhax',
	  'https://minecraft.curseforge.com/projects/kelpie', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='Darkhax',
    link='https://minecraft.curseforge.com/projects/kelpie';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '1.0.2', 'fb23249a367f5743f19df497971efd85', now(), now()
  FROM solder_mods
  WHERE name='kelpie'
  ON DUPLICATE KEY UPDATE
    md5='fb23249a367f5743f19df497971efd85',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='kelpie'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='1.0.2'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('cyclic', 'cyclic', 'cyclic', 'Lothrazar',
	  'https://minecraft.curseforge.com/projects/cyclic', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='Lothrazar',
    link='https://minecraft.curseforge.com/projects/cyclic';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '1.15.15', '41e1e8a4017feaa1c7461536b53cf9d7', now(), now()
  FROM solder_mods
  WHERE name='cyclic'
  ON DUPLICATE KEY UPDATE
    md5='41e1e8a4017feaa1c7461536b53cf9d7',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='cyclic'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='1.15.15'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('rustic', 'rustic', 'rustic', 'mangoose3039',
	  'https://minecraft.curseforge.com/projects/rustic', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='mangoose3039',
    link='https://minecraft.curseforge.com/projects/rustic';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '1.0.6', 'd4ca7f7e2c47d5c059f78fe2092fe417', now(), now()
  FROM solder_mods
  WHERE name='rustic'
  ON DUPLICATE KEY UPDATE
    md5='d4ca7f7e2c47d5c059f78fe2092fe417',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='rustic'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='1.0.6'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('dynamic-trees', 'dynamic-trees', 'dynamic-trees', 'mangoose3039',
	  'https://minecraft.curseforge.com/projects/dynamictrees', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='mangoose3039',
    link='https://minecraft.curseforge.com/projects/dynamictrees';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '0.7.8', 'f8e77655cbe23bce1845978c1575d397', now(), now()
  FROM solder_mods
  WHERE name='dynamic-trees'
  ON DUPLICATE KEY UPDATE
    md5='f8e77655cbe23bce1845978c1575d397',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='dynamic-trees'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='0.7.8'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('dynamic-trees-bop', 'dynamic-trees-bop', 'dynamic-trees-bop', 'mangoose3039',
	  'https://minecraft.curseforge.com/projects/dtbop', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='mangoose3039',
    link='https://minecraft.curseforge.com/projects/dtbop';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '1.2', 'f38d7d17f281e322169e00ad6a2be571', now(), now()
  FROM solder_mods
  WHERE name='dynamic-trees-bop'
  ON DUPLICATE KEY UPDATE
    md5='f38d7d17f281e322169e00ad6a2be571',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='dynamic-trees-bop'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='1.2'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('nether-chest', 'nether-chest', 'nether-chest', 'mangoose3039',
	  'https://minecraft.curseforge.com/projects/nether-chest', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='mangoose3039',
    link='https://minecraft.curseforge.com/projects/nether-chest';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '0.2.3', '4adae0791e5baffcbec347b5e493e257', now(), now()
  FROM solder_mods
  WHERE name='nether-chest'
  ON DUPLICATE KEY UPDATE
    md5='4adae0791e5baffcbec347b5e493e257',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='nether-chest'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='0.2.3'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('dynamic-surroundings', 'dynamic-surroundings', 'dynamic-surroundings', 'OreCruncher',
	  'https://minecraft.curseforge.com/projects/dynamic-surroundings', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='OreCruncher',
    link='https://minecraft.curseforge.com/projects/dynamic-surroundings';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '3.4.9.14', '10e4d1f2f075e380dab24662951771d7', now(), now()
  FROM solder_mods
  WHERE name='dynamic-surroundings'
  ON DUPLICATE KEY UPDATE
    md5='10e4d1f2f075e380dab24662951771d7',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='dynamic-surroundings'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='3.4.9.14'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('tumbleweed', 'tumbleweed', 'tumbleweed', 'konwboj',
	  'https://minecraft.curseforge.com/projects/tumbleweed', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='konwboj',
    link='https://minecraft.curseforge.com/projects/tumbleweed';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '0.4.5', '7989e219edc82122abb861c384c1fd70', now(), now()
  FROM solder_mods
  WHERE name='tumbleweed'
  ON DUPLICATE KEY UPDATE
    md5='7989e219edc82122abb861c384c1fd70',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='tumbleweed'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='0.4.5'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('cyclops-core', 'cyclops-core', 'cyclops-core', 'kroeser, josephcsible, Yulife',
	  'https://minecraft.curseforge.com/projects/cyclops-core', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='kroeser, josephcsible, Yulife',
    link='https://minecraft.curseforge.com/projects/cyclops-core';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '0.11.6', '2bc9d6d6120c4d8853d92e90373a321f', now(), now()
  FROM solder_mods
  WHERE name='cyclops-core'
  ON DUPLICATE KEY UPDATE
    md5='2bc9d6d6120c4d8853d92e90373a321f',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='cyclops-core'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='0.11.6'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('integrated-dynamics', 'integrated-dynamics', 'integrated-dynamics', 'kroeser, josephcsible, Yulife',
	  'https://minecraft.curseforge.com/projects/integrated-dynamics', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='kroeser, josephcsible, Yulife',
    link='https://minecraft.curseforge.com/projects/integrated-dynamics';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '0.11.13', '4478d1e83a22ed7fceaa125e5c33be5e', now(), now()
  FROM solder_mods
  WHERE name='integrated-dynamics'
  ON DUPLICATE KEY UPDATE
    md5='4478d1e83a22ed7fceaa125e5c33be5e',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='integrated-dynamics'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='0.11.13'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('integrated-tunnels', 'integrated-tunnels', 'integrated-tunnels', 'kroeser, josephcsible, Yulife',
	  'https://minecraft.curseforge.com/projects/integrated-tunnels', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='kroeser, josephcsible, Yulife',
    link='https://minecraft.curseforge.com/projects/integrated-tunnels';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '1.5.6', '992bb6a7ab7aa94310a8ac588cfb9391', now(), now()
  FROM solder_mods
  WHERE name='integrated-tunnels'
  ON DUPLICATE KEY UPDATE
    md5='992bb6a7ab7aa94310a8ac588cfb9391',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='integrated-tunnels'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='1.5.6'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('common-capabilities', 'common-capabilities', 'common-capabilities', 'kroeser, josephcsible, Yulife',
	  'https://minecraft.curseforge.com/projects/common-capabilities', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='kroeser, josephcsible, Yulife',
    link='https://minecraft.curseforge.com/projects/common-capabilities';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '1.4.0', '849fc2d780e84b5f0fd211f6c2fea7a7', now(), now()
  FROM solder_mods
  WHERE name='common-capabilities'
  ON DUPLICATE KEY UPDATE
    md5='849fc2d780e84b5f0fd211f6c2fea7a7',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='common-capabilities'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='1.4.0'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('expanded-bonemeal', 'expanded-bonemeal', 'expanded-bonemeal', 'josephcsible',
	  'https://minecraft.curseforge.com/projects/expandedbonemeal', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='josephcsible',
    link='https://minecraft.curseforge.com/projects/expandedbonemeal';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '1.2.1', 'c8aa0da94048971dc372a6a1a98cba8e', now(), now()
  FROM solder_mods
  WHERE name='expanded-bonemeal'
  ON DUPLICATE KEY UPDATE
    md5='c8aa0da94048971dc372a6a1a98cba8e',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='expanded-bonemeal'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='1.2.1'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('infinite-fluids', 'infinite-fluids', 'infinite-fluids', 'josephcsible',
	  'https://minecraft.curseforge.com/projects/infinitefluids', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='josephcsible',
    link='https://minecraft.curseforge.com/projects/infinitefluids';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '1.2.0', '188a10c0b7333a3084701a645758b436', now(), now()
  FROM solder_mods
  WHERE name='infinite-fluids'
  ON DUPLICATE KEY UPDATE
    md5='188a10c0b7333a3084701a645758b436',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='infinite-fluids'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='1.2.0'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('piston-compression', 'piston-compression', 'piston-compression', 'josephcsible',
	  'https://minecraft.curseforge.com/projects/pistoncompression', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='josephcsible',
    link='https://minecraft.curseforge.com/projects/pistoncompression';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '1.1.1', '9eba0115ce717c3103b2eb7e77ffa7f5', now(), now()
  FROM solder_mods
  WHERE name='piston-compression'
  ON DUPLICATE KEY UPDATE
    md5='9eba0115ce717c3103b2eb7e77ffa7f5',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='piston-compression'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='1.1.1'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('web-slinger', 'web-slinger', 'web-slinger', 'stormwind',
	  'https://minecraft.curseforge.com/projects/web-slinger', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='stormwind',
    link='https://minecraft.curseforge.com/projects/web-slinger';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '1.1.1', '5b7e075c116cdb547f7c4d4dbb5741ac', now(), now()
  FROM solder_mods
  WHERE name='web-slinger'
  ON DUPLICATE KEY UPDATE
    md5='5b7e075c116cdb547f7c4d4dbb5741ac',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='web-slinger'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='1.1.1'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('guide-api', 'guide-api', 'guide-api', 'TehNut, Tombenpotter',
	  'https://minecraft.curseforge.com/projects/guide-api', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='TehNut, Tombenpotter',
    link='https://minecraft.curseforge.com/projects/guide-api';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '2.1.5-60', '4b7670624202650a6686ff149055e787', now(), now()
  FROM solder_mods
  WHERE name='guide-api'
  ON DUPLICATE KEY UPDATE
    md5='4b7670624202650a6686ff149055e787',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='guide-api'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='2.1.5-60'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('blood-magic', 'blood-magic', 'blood-magic', 'WayOfTime',
	  'https://minecraft.curseforge.com/projects/blood-magic', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='WayOfTime',
    link='https://minecraft.curseforge.com/projects/blood-magic';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '2.2.12-97', '098c9b6f4a558c252ee3c7adf239ef19', now(), now()
  FROM solder_mods
  WHERE name='blood-magic'
  ON DUPLICATE KEY UPDATE
    md5='098c9b6f4a558c252ee3c7adf239ef19',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='blood-magic'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='2.2.12-97'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('applied-energistics', 'applied-energistics', 'applied-energistics', 'AlgorithmX2',
	  'https://ae-mod.info/', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='AlgorithmX2',
    link='https://ae-mod.info/';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '2-rv5-stable11', '639a39deebc80faf9412e84569ae95b2', now(), now()
  FROM solder_mods
  WHERE name='applied-energistics'
  ON DUPLICATE KEY UPDATE
    md5='639a39deebc80faf9412e84569ae95b2',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='applied-energistics'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='2-rv5-stable11'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('chisels-and-bits', 'chisels-and-bits', 'chisels-and-bits', 'AlgorithmX2',
	  'https://minecraft.curseforge.com/projects/chisels-bits', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='AlgorithmX2',
    link='https://minecraft.curseforge.com/projects/chisels-bits';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '14.17', '8f12fcaa92d0b9459cd5cab6f36c852a', now(), now()
  FROM solder_mods
  WHERE name='chisels-and-bits'
  ON DUPLICATE KEY UPDATE
    md5='8f12fcaa92d0b9459cd5cab6f36c852a',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='chisels-and-bits'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='14.17'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('flat-colored-blocks', 'flat-colored-blocks', 'flat-colored-blocks', 'AlgorithmX2',
	  'https://minecraft.curseforge.com/projects/flat-colored-blocks', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='AlgorithmX2',
    link='https://minecraft.curseforge.com/projects/flat-colored-blocks';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '6.6', '074599820db4b78c2a46454e0d8dfbac', now(), now()
  FROM solder_mods
  WHERE name='flat-colored-blocks'
  ON DUPLICATE KEY UPDATE
    md5='074599820db4b78c2a46454e0d8dfbac',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='flat-colored-blocks'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='6.6'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('extra-bit-manipulation', 'extra-bit-manipulation', 'extra-bit-manipulation', 'phylogeny',
	  'https://minecraft.curseforge.com/projects/extra-bit-manipulation', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='phylogeny',
    link='https://minecraft.curseforge.com/projects/extra-bit-manipulation';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '3.2.1', 'edef9f77348184cfe76bfb57e23068be', now(), now()
  FROM solder_mods
  WHERE name='extra-bit-manipulation'
  ON DUPLICATE KEY UPDATE
    md5='edef9f77348184cfe76bfb57e23068be',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='extra-bit-manipulation'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='3.2.1'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('truetype-font-replacement', 'truetype-font-replacement', 'truetype-font-replacement', 'CubeX2',
	  'https://minecraft.curseforge.com/projects/truetype-font-replacement', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='CubeX2',
    link='https://minecraft.curseforge.com/projects/truetype-font-replacement';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '1.9.1', 'dc86b7d4ab028ed67bc0c6b961ef6633', now(), now()
  FROM solder_mods
  WHERE name='truetype-font-replacement'
  ON DUPLICATE KEY UPDATE
    md5='dc86b7d4ab028ed67bc0c6b961ef6633',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='truetype-font-replacement'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='1.9.1'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('pams-harvestcraft', 'pams-harvestcraft', 'pams-harvestcraft', 'MatrexsVigil',
	  'https://minecraft.curseforge.com/projects/pams-harvestcraft', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='MatrexsVigil',
    link='https://minecraft.curseforge.com/projects/pams-harvestcraft';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '1.12.2u', '71c45f67fa3a2dffb46a46d8d744abe6', now(), now()
  FROM solder_mods
  WHERE name='pams-harvestcraft'
  ON DUPLICATE KEY UPDATE
    md5='71c45f67fa3a2dffb46a46d8d744abe6',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='pams-harvestcraft'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='1.12.2u'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('mr-tjp-core', 'mr-tjp-core', 'mr-tjp-core', 'Mr_TJP',
	  'https://minecraft.curseforge.com/projects/mrtjpcore', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='Mr_TJP',
    link='https://minecraft.curseforge.com/projects/mrtjpcore';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '2.1.3.35', 'f464043a361b73759767c79b360ec408', now(), now()
  FROM solder_mods
  WHERE name='mr-tjp-core'
  ON DUPLICATE KEY UPDATE
    md5='f464043a361b73759767c79b360ec408',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='mr-tjp-core'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='2.1.3.35'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('project-red-base', 'project-red-base', 'project-red-base', 'Mr_TJP',
	  'https://minecraft.curseforge.com/projects/project-red-base', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='Mr_TJP',
    link='https://minecraft.curseforge.com/projects/project-red-base';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '4.9.1.92', 'bde25e61b9bddba0fbeefcea865a22d9', now(), now()
  FROM solder_mods
  WHERE name='project-red-base'
  ON DUPLICATE KEY UPDATE
    md5='bde25e61b9bddba0fbeefcea865a22d9',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='project-red-base'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='4.9.1.92'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('project-red-integration', 'project-red-integration', 'project-red-integration', 'Mr_TJP',
	  'https://minecraft.curseforge.com/projects/project-red-integration', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='Mr_TJP',
    link='https://minecraft.curseforge.com/projects/project-red-integration';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '4.9.1.92', '3061dc2b70f3d9efe715e2e6ed751cef', now(), now()
  FROM solder_mods
  WHERE name='project-red-integration'
  ON DUPLICATE KEY UPDATE
    md5='3061dc2b70f3d9efe715e2e6ed751cef',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='project-red-integration'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='4.9.1.92'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('project-red-fabrication', 'project-red-fabrication', 'project-red-fabrication', 'Mr_TJP',
	  'https://minecraft.curseforge.com/projects/project-red-fabrication', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='Mr_TJP',
    link='https://minecraft.curseforge.com/projects/project-red-fabrication';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '4.9.1.92', '56b74bba9534142714f11c0450fdc086', now(), now()
  FROM solder_mods
  WHERE name='project-red-fabrication'
  ON DUPLICATE KEY UPDATE
    md5='56b74bba9534142714f11c0450fdc086',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='project-red-fabrication'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='4.9.1.92'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('project-red-compatibility', 'project-red-compatibility', 'project-red-compatibility', 'Mr_TJP',
	  'https://minecraft.curseforge.com/projects/project-red-compat', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='Mr_TJP',
    link='https://minecraft.curseforge.com/projects/project-red-compat';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '4.9.1.92', '1e8bd6c9c70d8c6e26806eef8bc69b65', now(), now()
  FROM solder_mods
  WHERE name='project-red-compatibility'
  ON DUPLICATE KEY UPDATE
    md5='1e8bd6c9c70d8c6e26806eef8bc69b65',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='project-red-compatibility'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='4.9.1.92'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('project-red-world', 'project-red-world', 'project-red-world', 'Mr_TJP',
	  'https://minecraft.curseforge.com/projects/project-red-world', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='Mr_TJP',
    link='https://minecraft.curseforge.com/projects/project-red-world';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '4.9.1.92', '64f3e19f53d0e399d2318e6964ee3f5b', now(), now()
  FROM solder_mods
  WHERE name='project-red-world'
  ON DUPLICATE KEY UPDATE
    md5='64f3e19f53d0e399d2318e6964ee3f5b',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='project-red-world'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='4.9.1.92'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('project-red-lighting', 'project-red-lighting', 'project-red-lighting', 'Mr_TJP',
	  'https://minecraft.curseforge.com/projects/project-red-lighting', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='Mr_TJP',
    link='https://minecraft.curseforge.com/projects/project-red-lighting';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '4.9.1.92', '2d993a0362deb8bf1852c763def98218', now(), now()
  FROM solder_mods
  WHERE name='project-red-lighting'
  ON DUPLICATE KEY UPDATE
    md5='2d993a0362deb8bf1852c763def98218',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='project-red-lighting'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='4.9.1.92'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('ender-core', 'ender-core', 'ender-core', 'tterrag1098, CrazyPants, Henry_Loenwind',
	  'https://minecraft.curseforge.com/projects/endercore', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='tterrag1098, CrazyPants, Henry_Loenwind',
    link='https://minecraft.curseforge.com/projects/endercore';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '0.5.31', 'f6466e61fdd17fb2905f22f652f737ad', now(), now()
  FROM solder_mods
  WHERE name='ender-core'
  ON DUPLICATE KEY UPDATE
    md5='f6466e61fdd17fb2905f22f652f737ad',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='ender-core'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='0.5.31'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('ender-io', 'ender-io', 'ender-io', 'tterrag1098, CrazyPants, Henry_Loenwind',
	  'https://minecraft.curseforge.com/projects/ender-io', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='tterrag1098, CrazyPants, Henry_Loenwind',
    link='https://minecraft.curseforge.com/projects/ender-io';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '5.0.26', '9541972d9d2bd5317044b23e7cdea4c0', now(), now()
  FROM solder_mods
  WHERE name='ender-io'
  ON DUPLICATE KEY UPDATE
    md5='9541972d9d2bd5317044b23e7cdea4c0',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='ender-io'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='5.0.26'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('ender-zoo', 'ender-zoo', 'ender-zoo', 'tterrag1098, CrazyPants, Henry_Loenwind',
	  'https://minecraft.curseforge.com/projects/ender-zoo', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='tterrag1098, CrazyPants, Henry_Loenwind',
    link='https://minecraft.curseforge.com/projects/ender-zoo';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '1.4.0.49', '256ab65f8b7068ac669dfa35b4885c76', now(), now()
  FROM solder_mods
  WHERE name='ender-zoo'
  ON DUPLICATE KEY UPDATE
    md5='256ab65f8b7068ac669dfa35b4885c76',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='ender-zoo'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='1.4.0.49'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('elec-core', 'elec-core', 'elec-core', 'Elec332',
	  'https://minecraft.curseforge.com/projects/eleccore', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='Elec332',
    link='https://minecraft.curseforge.com/projects/eleccore';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '1.8.434', 'a231f81f1ec6d40af0ea2e7dd3356def', now(), now()
  FROM solder_mods
  WHERE name='elec-core'
  ON DUPLICATE KEY UPDATE
    md5='a231f81f1ec6d40af0ea2e7dd3356def',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='elec-core'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='1.8.434'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('mcjtylib', 'mcjtylib', 'mcjtylib', 'McJty',
	  'https://minecraft.curseforge.com/projects/mcjtylib', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='McJty',
    link='https://minecraft.curseforge.com/projects/mcjtylib';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '3.0.2', '086e89faf7879ccede1546bde73dad6e', now(), now()
  FROM solder_mods
  WHERE name='mcjtylib'
  ON DUPLICATE KEY UPDATE
    md5='086e89faf7879ccede1546bde73dad6e',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='mcjtylib'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='3.0.2'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('rf-tools', 'rf-tools', 'rf-tools', 'McJty',
	  'https://minecraft.curseforge.com/projects/rftools', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='McJty',
    link='https://minecraft.curseforge.com/projects/rftools';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '7.54', '6def110bb753f3d429319f5aa3a560fc', now(), now()
  FROM solder_mods
  WHERE name='rf-tools'
  ON DUPLICATE KEY UPDATE
    md5='6def110bb753f3d429319f5aa3a560fc',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='rf-tools'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='7.54'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('deep-resonance', 'deep-resonance', 'deep-resonance', 'McJty',
	  'https://minecraft.curseforge.com/projects/deep-resonance', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='McJty',
    link='https://minecraft.curseforge.com/projects/deep-resonance';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '1.7.0', '1968b6ed8c8f22a6205e3a41ab296e67', now(), now()
  FROM solder_mods
  WHERE name='deep-resonance'
  ON DUPLICATE KEY UPDATE
    md5='1968b6ed8c8f22a6205e3a41ab296e67',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='deep-resonance'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='1.7.0'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('restrictions', 'restrictions', 'restrictions', 'McJty',
	  'https://minecraft.curseforge.com/projects/restrictions', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='McJty',
    link='https://minecraft.curseforge.com/projects/restrictions';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '1.2.0', 'af3e27fa529d9dae11c460aa07063d09', now(), now()
  FROM solder_mods
  WHERE name='restrictions'
  ON DUPLICATE KEY UPDATE
    md5='af3e27fa529d9dae11c460aa07063d09',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='restrictions'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='1.2.0'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('not-enough-wands', 'not-enough-wands', 'not-enough-wands', 'McJty',
	  'https://minecraft.curseforge.com/projects/not-enough-wands', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='McJty',
    link='https://minecraft.curseforge.com/projects/not-enough-wands';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '1.7.0', '108299e4ebf8b279337edc0ee960f75c', now(), now()
  FROM solder_mods
  WHERE name='not-enough-wands'
  ON DUPLICATE KEY UPDATE
    md5='108299e4ebf8b279337edc0ee960f75c',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='not-enough-wands'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='1.7.0'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('rf-tools-dimensions', 'rf-tools-dimensions', 'rf-tools-dimensions', 'McJty',
	  'https://minecraft.curseforge.com/projects/rftools-dimensions', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='McJty',
    link='https://minecraft.curseforge.com/projects/rftools-dimensions';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '5.60', '913bc3d8771ae2fe56d36e7514a7f2b2', now(), now()
  FROM solder_mods
  WHERE name='rf-tools-dimensions'
  ON DUPLICATE KEY UPDATE
    md5='913bc3d8771ae2fe56d36e7514a7f2b2',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='rf-tools-dimensions'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='5.60'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('rf-lux', 'rf-lux', 'rf-lux', 'McJty',
	  'https://minecraft.curseforge.com/projects/rf-lux', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='McJty',
    link='https://minecraft.curseforge.com/projects/rf-lux';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '0.3.0', 'a877cc12faa067683f6d0a6f6a8e8b71', now(), now()
  FROM solder_mods
  WHERE name='rf-lux'
  ON DUPLICATE KEY UPDATE
    md5='a877cc12faa067683f6d0a6f6a8e8b71',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='rf-lux'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='0.3.0'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('rf-tools-power', 'rf-tools-power', 'rf-tools-power', 'McJty',
	  'https://minecraft.curseforge.com/projects/rftools-power', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='McJty',
    link='https://minecraft.curseforge.com/projects/rftools-power';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '1.1.0', 'e0236e281d08025cd5a41b9e032fa550', now(), now()
  FROM solder_mods
  WHERE name='rf-tools-power'
  ON DUPLICATE KEY UPDATE
    md5='e0236e281d08025cd5a41b9e032fa550',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='rf-tools-power'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='1.1.0'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('rf-tools-control', 'rf-tools-control', 'rf-tools-control', 'McJty',
	  'https://minecraft.curseforge.com/projects/rftools-control', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='McJty',
    link='https://minecraft.curseforge.com/projects/rftools-control';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '1.9.1', '950b0ceb6cfc3ed38dabb74b55cd8379', now(), now()
  FROM solder_mods
  WHERE name='rf-tools-control'
  ON DUPLICATE KEY UPDATE
    md5='950b0ceb6cfc3ed38dabb74b55cd8379',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='rf-tools-control'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='1.9.1'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('compact-machines-3', 'compact-machines-3', 'compact-machines-3', 'Davenonymous',
	  'https://minecraft.curseforge.com/projects/compact-machines', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='Davenonymous',
    link='https://minecraft.curseforge.com/projects/compact-machines';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '3.0.12-b215', 'd41b1a09b6572764e123e3ce5f19a36f', now(), now()
  FROM solder_mods
  WHERE name='compact-machines-3'
  ON DUPLICATE KEY UPDATE
    md5='d41b1a09b6572764e123e3ce5f19a36f',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='compact-machines-3'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='3.0.12-b215'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('extra-utils-2', 'extra-utils-2', 'extra-utils-2', 'RWTema',
	  'https://minecraft.curseforge.com/projects/extra-utilities', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='RWTema',
    link='https://minecraft.curseforge.com/projects/extra-utilities';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '1.7.6', '488e711e4f7d7564cf884c2db2968a6f', now(), now()
  FROM solder_mods
  WHERE name='extra-utils-2'
  ON DUPLICATE KEY UPDATE
    md5='488e711e4f7d7564cf884c2db2968a6f',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='extra-utils-2'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='1.7.6'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('diet-hopper', 'diet-hopper', 'diet-hopper', 'RWTema',
	  'https://minecraft.curseforge.com/projects/diet-hoppers', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='RWTema',
    link='https://minecraft.curseforge.com/projects/diet-hoppers';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '1.1', '03a8076e48641b3abbea3496a1ad718c', now(), now()
  FROM solder_mods
  WHERE name='diet-hopper'
  ON DUPLICATE KEY UPDATE
    md5='03a8076e48641b3abbea3496a1ad718c',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='diet-hopper'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='1.1'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('bdew-lib', 'bdew-lib', 'bdew-lib', 'bdew',
	  'https://minecraft.curseforge.com/projects/bdlib', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='bdew',
    link='https://minecraft.curseforge.com/projects/bdlib';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '1.14.3.12', '495dff85b09d2d0f6af4264cb331b9bc', now(), now()
  FROM solder_mods
  WHERE name='bdew-lib'
  ON DUPLICATE KEY UPDATE
    md5='495dff85b09d2d0f6af4264cb331b9bc',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='bdew-lib'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='1.14.3.12'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('advanced-generators', 'advanced-generators', 'advanced-generators', 'bdew',
	  'https://minecraft.curseforge.com/projects/advanced-generators', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='bdew',
    link='https://minecraft.curseforge.com/projects/advanced-generators';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '0.9.20.12', '28bd24a4058dd21fb7b7d954c0632a97', now(), now()
  FROM solder_mods
  WHERE name='advanced-generators'
  ON DUPLICATE KEY UPDATE
    md5='28bd24a4058dd21fb7b7d954c0632a97',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='advanced-generators'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='0.9.20.12'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('pressure-pipes', 'pressure-pipes', 'pressure-pipes', 'bdew',
	  'https://minecraft.curseforge.com/projects/pressure-pipes', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='bdew',
    link='https://minecraft.curseforge.com/projects/pressure-pipes';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '1.3.1.6', 'a66186b4a7dba2cb67a1333185f368c1', now(), now()
  FROM solder_mods
  WHERE name='pressure-pipes'
  ON DUPLICATE KEY UPDATE
    md5='a66186b4a7dba2cb67a1333185f368c1',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='pressure-pipes'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='1.3.1.6'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('ae2-stuff', 'ae2-stuff', 'ae2-stuff', 'bdew',
	  'https://minecraft.curseforge.com/projects/ae2-stuff', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='bdew',
    link='https://minecraft.curseforge.com/projects/ae2-stuff';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '0.7.0.4', '11409244f82de9b52324654c89395211', now(), now()
  FROM solder_mods
  WHERE name='ae2-stuff'
  ON DUPLICATE KEY UPDATE
    md5='11409244f82de9b52324654c89395211',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='ae2-stuff'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='0.7.0.4'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('proxy', 'proxy', 'proxy', 'bdew',
	  'https://minecraft.curseforge.com/projects/proxy', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='bdew',
    link='https://minecraft.curseforge.com/projects/proxy';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '0.9.1.5', '34df4ff8da7bd002bcd77ca4cbc81dec', now(), now()
  FROM solder_mods
  WHERE name='proxy'
  ON DUPLICATE KEY UPDATE
    md5='34df4ff8da7bd002bcd77ca4cbc81dec',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='proxy'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='0.9.1.5'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('compacter', 'compacter', 'compacter', 'bdew',
	  'https://minecraft.curseforge.com/projects/compacter', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='bdew',
    link='https://minecraft.curseforge.com/projects/compacter';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '1.3.0.3', '938fd34486933498ed0cc9093cf2acda', now(), now()
  FROM solder_mods
  WHERE name='compacter'
  ON DUPLICATE KEY UPDATE
    md5='938fd34486933498ed0cc9093cf2acda',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='compacter'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='1.3.0.3'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('jei-bees', 'jei-bees', 'jei-bees', 'bdew',
	  'https://minecraft.curseforge.com/projects/jei-bees', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='bdew',
    link='https://minecraft.curseforge.com/projects/jei-bees';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '0.9.0.5', 'f9648ee88eb11e031e1dacf5ba1a4b02', now(), now()
  FROM solder_mods
  WHERE name='jei-bees'
  ON DUPLICATE KEY UPDATE
    md5='f9648ee88eb11e031e1dacf5ba1a4b02',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='jei-bees'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='0.9.0.5'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('hwyla', 'hwyla', 'hwyla', 'TehNut',
	  'https://minecraft.curseforge.com/projects/hwyla', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='TehNut',
    link='https://minecraft.curseforge.com/projects/hwyla';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '1.8.25-B41', '19975aa4b1f9641d5a4354db457f06e9', now(), now()
  FROM solder_mods
  WHERE name='hwyla'
  ON DUPLICATE KEY UPDATE
    md5='19975aa4b1f9641d5a4354db457f06e9',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='hwyla'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='1.8.25-B41'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('immersive-engineering', 'immersive-engineering', 'immersive-engineering', 'BluSunrize, malte0811, Mr_Hazard',
	  'https://minecraft.curseforge.com/projects/immersive-engineering', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='BluSunrize, malte0811, Mr_Hazard',
    link='https://minecraft.curseforge.com/projects/immersive-engineering';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '0.12-82', '0b9bee26ab1e84ca8c552d08779c6524', now(), now()
  FROM solder_mods
  WHERE name='immersive-engineering'
  ON DUPLICATE KEY UPDATE
    md5='0b9bee26ab1e84ca8c552d08779c6524',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='immersive-engineering'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='0.12-82'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('immersive-cables', 'immersive-cables', 'immersive-cables', 'SanAndreasP',
	  'https://minecraft.curseforge.com/projects/immersive-cables', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='SanAndreasP',
    link='https://minecraft.curseforge.com/projects/immersive-cables';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '1.3.0', '0be915c96886eab82a1c3406490e05e7', now(), now()
  FROM solder_mods
  WHERE name='immersive-cables'
  ON DUPLICATE KEY UPDATE
    md5='0be915c96886eab82a1c3406490e05e7',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='immersive-cables'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='1.3.0'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('san-lib', 'san-lib', 'san-lib', 'SanAndreasP',
	  'https://minecraft.curseforge.com/projects/sanlib', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='SanAndreasP',
    link='https://minecraft.curseforge.com/projects/sanlib';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '1.4.4', '2fe5595add6a1c498fbc6d8eb902e88b', now(), now()
  FROM solder_mods
  WHERE name='san-lib'
  ON DUPLICATE KEY UPDATE
    md5='2fe5595add6a1c498fbc6d8eb902e88b',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='san-lib'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='1.4.4'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('immersive-tech', 'immersive-tech', 'immersive-tech', 'FerroO2000',
	  'https://minecraft.curseforge.com/projects/immersive-tech', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='FerroO2000',
    link='https://minecraft.curseforge.com/projects/immersive-tech';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '1.3.10', '6d9ce728e14563f8a43c23fa98c98058', now(), now()
  FROM solder_mods
  WHERE name='immersive-tech'
  ON DUPLICATE KEY UPDATE
    md5='6d9ce728e14563f8a43c23fa98c98058',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='immersive-tech'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='1.3.10'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('questionably-immersive', 'questionably-immersive', 'questionably-immersive', 'Flaxbeard',
	  'https://minecraft.curseforge.com/projects/questionably-immersive', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='Flaxbeard',
    link='https://minecraft.curseforge.com/projects/questionably-immersive';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '0.1.0', '506cf6db639da3f835fbd19f326799d4', now(), now()
  FROM solder_mods
  WHERE name='questionably-immersive'
  ON DUPLICATE KEY UPDATE
    md5='506cf6db639da3f835fbd19f326799d4',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='questionably-immersive'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='0.1.0'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('immersive-petroleum', 'immersive-petroleum', 'immersive-petroleum', 'Flaxbeard',
	  'https://minecraft.curseforge.com/projects/immersive-petroleum', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='Flaxbeard',
    link='https://minecraft.curseforge.com/projects/immersive-petroleum';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '1.1.9', '6a82e43131897441b25bf3ad1fa58e8a', now(), now()
  FROM solder_mods
  WHERE name='immersive-petroleum'
  ON DUPLICATE KEY UPDATE
    md5='6a82e43131897441b25bf3ad1fa58e8a',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='immersive-petroleum'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='1.1.9'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('engineers-doors', 'engineers-doors', 'engineers-doors', 'Nihiltres',
	  'https://minecraft.curseforge.com/projects/engineers-doors', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='Nihiltres',
    link='https://minecraft.curseforge.com/projects/engineers-doors';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '0.7.2', '2b4beecd49d372c3e627c7e43645f64e', now(), now()
  FROM solder_mods
  WHERE name='engineers-doors'
  ON DUPLICATE KEY UPDATE
    md5='2b4beecd49d372c3e627c7e43645f64e',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='engineers-doors'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='0.7.2'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('animania', 'animania', 'animania', 'Purplicious_Cow, raptorfarian, RazzleberryFox, Tschipp',
	  'https://minecraft.curseforge.com/projects/animania', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='Purplicious_Cow, raptorfarian, RazzleberryFox, Tschipp',
    link='https://minecraft.curseforge.com/projects/animania';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '1.4.8', '6a750f57e8c795509e75d851cda9a2bb', now(), now()
  FROM solder_mods
  WHERE name='animania'
  ON DUPLICATE KEY UPDATE
    md5='6a750f57e8c795509e75d851cda9a2bb',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='animania'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='1.4.8'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('craft-studio', 'craft-studio', 'craft-studio', 'ZeAmateis, Timmypote',
	  'https://www.curseforge.com/minecraft/mc-mods/craftstudio-api', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='ZeAmateis, Timmypote',
    link='https://www.curseforge.com/minecraft/mc-mods/craftstudio-api';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '1.0.0.93-alpha', '7d1d60eaa965104abe6938e8aa3c8987', now(), now()
  FROM solder_mods
  WHERE name='craft-studio'
  ON DUPLICATE KEY UPDATE
    md5='7d1d60eaa965104abe6938e8aa3c8987',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='craft-studio'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='1.0.0.93-alpha'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('camera-obscura', 'camera-obscura', 'camera-obscura', 'RazzleberryFox, Cojomax99, ProfMobius',
	  'https://minecraft.curseforge.com/projects/camera-obscura', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='RazzleberryFox, Cojomax99, ProfMobius',
    link='https://minecraft.curseforge.com/projects/camera-obscura';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '1.0.3', '4af244c4d9ef732eb1fb1ef496577e0f', now(), now()
  FROM solder_mods
  WHERE name='camera-obscura'
  ON DUPLICATE KEY UPDATE
    md5='4af244c4d9ef732eb1fb1ef496577e0f',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='camera-obscura'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='1.0.3'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('ptr-lib', 'ptr-lib', 'ptr-lib', 'RazzleberryFox, ProfMobius, taelnia',
	  'https://minecraft.curseforge.com/projects/ptrlib', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='RazzleberryFox, ProfMobius, taelnia',
    link='https://minecraft.curseforge.com/projects/ptrlib';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '1.0.2', '8371e57f7af69a5181e47277ff843aea', now(), now()
  FROM solder_mods
  WHERE name='ptr-lib'
  ON DUPLICATE KEY UPDATE
    md5='8371e57f7af69a5181e47277ff843aea',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='ptr-lib'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='1.0.2'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('decocraft', 'decocraft', 'decocraft', 'RazzleberryFox, ProfMobius, taelnia',
	  'https://minecraft.curseforge.com/projects/decocraft2', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='RazzleberryFox, ProfMobius, taelnia',
    link='https://minecraft.curseforge.com/projects/decocraft2';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '2.6.0', '4dcd149a95b4d79685f47cab0049a3c2', now(), now()
  FROM solder_mods
  WHERE name='decocraft'
  ON DUPLICATE KEY UPDATE
    md5='4dcd149a95b4d79685f47cab0049a3c2',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='decocraft'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='2.6.0'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('peaceful-surface', 'peaceful-surface', 'peaceful-surface', 'ZLainSama',
	  'https://minecraft.curseforge.com/projects/peacefulsurface', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='ZLainSama',
    link='https://minecraft.curseforge.com/projects/peacefulsurface';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '1.12.2-v1', 'b196868edaa32e8fce461f918acff6bb', now(), now()
  FROM solder_mods
  WHERE name='peaceful-surface'
  ON DUPLICATE KEY UPDATE
    md5='b196868edaa32e8fce461f918acff6bb',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='peaceful-surface'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='1.12.2-v1'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('random-things', 'random-things', 'random-things', 'lumien',
	  'https://minecraft.curseforge.com/projects/random-things', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='lumien',
    link='https://minecraft.curseforge.com/projects/random-things';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '4.1.9', 'dfbc69a512490f83aac9f68d22df2450', now(), now()
  FROM solder_mods
  WHERE name='random-things'
  ON DUPLICATE KEY UPDATE
    md5='dfbc69a512490f83aac9f68d22df2450',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='random-things'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='4.1.9'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('forestry', 'forestry', 'forestry', 'SirSengir, CovertJaguar, mezz, MysteriousAges',
	  'https://minecraft.curseforge.com/projects/forestry', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='SirSengir, CovertJaguar, mezz, MysteriousAges',
    link='https://minecraft.curseforge.com/projects/forestry';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '5.8.0.311', '46b4a3b6f4477f7e9d002ac6c09ed69e', now(), now()
  FROM solder_mods
  WHERE name='forestry'
  ON DUPLICATE KEY UPDATE
    md5='46b4a3b6f4477f7e9d002ac6c09ed69e',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='forestry'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='5.8.0.311'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('binnies-mods', 'binnies-mods', 'binnies-mods', 'Binnie567, mezz',
	  'https://minecraft.curseforge.com/projects/binnies-mods', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='Binnie567, mezz',
    link='https://minecraft.curseforge.com/projects/binnies-mods';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '2.5.0.167', '1936ceca2fdff1c44966d4fa52815cce', now(), now()
  FROM solder_mods
  WHERE name='binnies-mods'
  ON DUPLICATE KEY UPDATE
    md5='1936ceca2fdff1c44966d4fa52815cce',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='binnies-mods'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='2.5.0.167'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('open-computers', 'open-computers', 'open-computers', 'Sangar',
	  'https://minecraft.curseforge.com/projects/opencomputers', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='Sangar',
    link='https://minecraft.curseforge.com/projects/opencomputers';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '1.7.2.67', 'ed07fd7aa567f7ffe5e263ebd7a017a2', now(), now()
  FROM solder_mods
  WHERE name='open-computers'
  ON DUPLICATE KEY UPDATE
    md5='ed07fd7aa567f7ffe5e263ebd7a017a2',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='open-computers'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='1.7.2.67'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('ichun-util', 'ichun-util', 'ichun-util', 'iChun',
	  'https://minecraft.curseforge.com/projects/ichunutil', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='iChun',
    link='https://minecraft.curseforge.com/projects/ichunutil';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '7.1.4', 'fd85da24584c6a342f4cd08fbbe5c534', now(), now()
  FROM solder_mods
  WHERE name='ichun-util'
  ON DUPLICATE KEY UPDATE
    md5='fd85da24584c6a342f4cd08fbbe5c534',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='ichun-util'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='7.1.4'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('mob-amputation', 'mob-amputation', 'mob-amputation', 'iChun',
	  'https://minecraft.curseforge.com/projects/mob-amputation', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='iChun',
    link='https://minecraft.curseforge.com/projects/mob-amputation';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '7.0.0', 'e39e7ff7153c436f9159770d1a8dbef9', now(), now()
  FROM solder_mods
  WHERE name='mob-amputation'
  ON DUPLICATE KEY UPDATE
    md5='e39e7ff7153c436f9159770d1a8dbef9',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='mob-amputation'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='7.0.0'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('ding', 'ding', 'ding', 'iChun',
	  'https://minecraft.curseforge.com/projects/ding', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='iChun',
    link='https://minecraft.curseforge.com/projects/ding';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '1.0.1', 'b381c81080d41af19cc5c51bcdf01ad2', now(), now()
  FROM solder_mods
  WHERE name='ding'
  ON DUPLICATE KEY UPDATE
    md5='b381c81080d41af19cc5c51bcdf01ad2',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='ding'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='1.0.1'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('glass', 'glass', 'glass', 'iChun',
	  'https://minecraft.curseforge.com/projects/general-laymans-aesthetic-spying-screen-glass', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='iChun',
    link='https://minecraft.curseforge.com/projects/general-laymans-aesthetic-spying-screen-glass';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '7.0.0', 'f4573ac015f1ab33ad76d143ab41a0b6', now(), now()
  FROM solder_mods
  WHERE name='glass'
  ON DUPLICATE KEY UPDATE
    md5='f4573ac015f1ab33ad76d143ab41a0b6',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='glass'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='7.0.0'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('extra-cells', 'extra-cells', 'extra-cells', 'Destroyer7128, DrummerMC, Nedelosk, Pwnie2012',
	  'https://minecraft.curseforge.com/projects/extracells2', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='Destroyer7128, DrummerMC, Nedelosk, Pwnie2012',
    link='https://minecraft.curseforge.com/projects/extracells2';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '2.5.13a60', 'ae484202c2bd963efbeac8fd93fc357d', now(), now()
  FROM solder_mods
  WHERE name='extra-cells'
  ON DUPLICATE KEY UPDATE
    md5='ae484202c2bd963efbeac8fd93fc357d',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='extra-cells'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='2.5.13a60'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('help-fixer', 'help-fixer', 'help-fixer', 'Matthew Prenger',
	  'https://minecraft.curseforge.com/projects/helpfixer', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='Matthew Prenger',
    link='https://minecraft.curseforge.com/projects/helpfixer';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '1.5.18', '1a567ed23ed883d9e91090e87c5ba103', now(), now()
  FROM solder_mods
  WHERE name='help-fixer'
  ON DUPLICATE KEY UPDATE
    md5='1a567ed23ed883d9e91090e87c5ba103',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='help-fixer'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='1.5.18'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('mc-multi-part', 'mc-multi-part', 'mc-multi-part', 'Amadornes, MRebhan',
	  'https://minecraft.curseforge.com/projects/mcmultipart', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='Amadornes, MRebhan',
    link='https://minecraft.curseforge.com/projects/mcmultipart';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '2.5.1', 'f0ebe3182a89519bc44c1d59269b404d', now(), now()
  FROM solder_mods
  WHERE name='mc-multi-part'
  ON DUPLICATE KEY UPDATE
    md5='f0ebe3182a89519bc44c1d59269b404d',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='mc-multi-part'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='2.5.1'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('fmp-to-cb', 'fmp-to-cb', 'fmp-to-cb', 'Agent Epsilon',
	  'https://minecraft.curseforge.com/projects/fmp-to-c-b', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='Agent Epsilon',
    link='https://minecraft.curseforge.com/projects/fmp-to-c-b';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '1.0.1', '8a54f27ef6adff3ce315288cd8e2d418', now(), now()
  FROM solder_mods
  WHERE name='fmp-to-cb'
  ON DUPLICATE KEY UPDATE
    md5='8a54f27ef6adff3ce315288cd8e2d418',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='fmp-to-cb'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='1.0.1'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('bibliocraft', 'bibliocraft', 'bibliocraft', 'Nuchaz',
	  'https://minecraft.curseforge.com/projects/bibliocraft', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='Nuchaz',
    link='https://minecraft.curseforge.com/projects/bibliocraft';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '2.4.5', '1c08dbf311f734d0431599dee5853414', now(), now()
  FROM solder_mods
  WHERE name='bibliocraft'
  ON DUPLICATE KEY UPDATE
    md5='1c08dbf311f734d0431599dee5853414',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='bibliocraft'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='2.4.5'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('malisis-core', 'malisis-core', 'malisis-core', 'Ordinastie',
	  'https://minecraft.curseforge.com/projects/malisiscore', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='Ordinastie',
    link='https://minecraft.curseforge.com/projects/malisiscore';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '6.4.0', '205386764a666418ae5f950225f67fc8', now(), now()
  FROM solder_mods
  WHERE name='malisis-core'
  ON DUPLICATE KEY UPDATE
    md5='205386764a666418ae5f950225f67fc8',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='malisis-core'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='6.4.0'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('malisis-doors', 'malisis-doors', 'malisis-doors', 'Ordinastie',
	  'https://minecraft.curseforge.com/projects/malisisdoors', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='Ordinastie',
    link='https://minecraft.curseforge.com/projects/malisisdoors';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '7.3.0', 'b9a395ac4ff7da5a60a0e89a253d6abf', now(), now()
  FROM solder_mods
  WHERE name='malisis-doors'
  ON DUPLICATE KEY UPDATE
    md5='b9a395ac4ff7da5a60a0e89a253d6abf',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='malisis-doors'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='7.3.0'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('malisis-blocks', 'malisis-blocks', 'malisis-blocks', 'Ordinastie',
	  'https://minecraft.curseforge.com/projects/malisisblocks', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='Ordinastie',
    link='https://minecraft.curseforge.com/projects/malisisblocks';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '6.1.0', '01bbcfa808e6e641138455d5b4a8f99d', now(), now()
  FROM solder_mods
  WHERE name='malisis-blocks'
  ON DUPLICATE KEY UPDATE
    md5='01bbcfa808e6e641138455d5b4a8f99d',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='malisis-blocks'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='6.1.0'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('malisis-switches', 'malisis-switches', 'malisis-switches', 'Ordinastie',
	  'https://minecraft.curseforge.com/projects/malisisswitches', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='Ordinastie',
    link='https://minecraft.curseforge.com/projects/malisisswitches';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '5.1.0', 'c9675326cebcff5848d19aed88b5ec83', now(), now()
  FROM solder_mods
  WHERE name='malisis-switches'
  ON DUPLICATE KEY UPDATE
    md5='c9675326cebcff5848d19aed88b5ec83',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='malisis-switches'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='5.1.0'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('creative-core', 'creative-core', 'creative-core', 'CreativeMD',
	  'https://minecraft.curseforge.com/projects/creativecore', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='CreativeMD',
    link='https://minecraft.curseforge.com/projects/creativecore';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '1.9.22', '049541445104c335522cd727c22a8f4c', now(), now()
  FROM solder_mods
  WHERE name='creative-core'
  ON DUPLICATE KEY UPDATE
    md5='049541445104c335522cd727c22a8f4c',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='creative-core'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='1.9.22'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('item-physic-full', 'item-physic-full', 'item-physic-full', 'CreativeMD',
	  'https://minecraft.curseforge.com/projects/itemphysic', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='CreativeMD',
    link='https://minecraft.curseforge.com/projects/itemphysic';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '1.4.12', '3d4e07b8d1f16ccf7f9002d4daf80109', now(), now()
  FROM solder_mods
  WHERE name='item-physic-full'
  ON DUPLICATE KEY UPDATE
    md5='3d4e07b8d1f16ccf7f9002d4daf80109',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='item-physic-full'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='1.4.12'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('realworld', 'realworld', 'realworld', '10paktimbits',
	  'http://10paksmods.net/', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='10paktimbits',
    link='http://10paksmods.net/';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '1.17', 'e7edec0d28b043e5d52df0812dbe28db', now(), now()
  FROM solder_mods
  WHERE name='realworld'
  ON DUPLICATE KEY UPDATE
    md5='e7edec0d28b043e5d52df0812dbe28db',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='realworld'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='1.17'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('cooking-for-blockheads', 'cooking-for-blockheads', 'cooking-for-blockheads', 'BlayTheNinth, Zero9010',
	  'https://minecraft.curseforge.com/projects/cooking-for-blockheads', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='BlayTheNinth, Zero9010',
    link='https://minecraft.curseforge.com/projects/cooking-for-blockheads';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '6.4.40', '8da2be4cec2d6146f6c31ed96e64f573', now(), now()
  FROM solder_mods
  WHERE name='cooking-for-blockheads'
  ON DUPLICATE KEY UPDATE
    md5='8da2be4cec2d6146f6c31ed96e64f573',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='cooking-for-blockheads'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='6.4.40'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('world-edit', 'world-edit', 'world-edit', 'sk89q',
	  'https://minecraft.curseforge.com/projects/worldedit', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='sk89q',
    link='https://minecraft.curseforge.com/projects/worldedit';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '6.1.8', '6c2ec70c8ef6124bb1d09382c42b0c25', now(), now()
  FROM solder_mods
  WHERE name='world-edit'
  ON DUPLICATE KEY UPDATE
    md5='6c2ec70c8ef6124bb1d09382c42b0c25',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='world-edit'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='6.1.8'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('roots2', 'roots2', 'roots2', 'elucent, epicsquid',
	  'https://minecraft.curseforge.com/projects/roots', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='elucent, epicsquid',
    link='https://minecraft.curseforge.com/projects/roots';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '2-0.104', '317985a5069d36529df562de6789a873', now(), now()
  FROM solder_mods
  WHERE name='roots2'
  ON DUPLICATE KEY UPDATE
    md5='317985a5069d36529df562de6789a873',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='roots2'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='2-0.104'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('clarity', 'clarity', 'clarity', 'elucent, epicsquid',
	  'https://minecraft.curseforge.com/projects/clarity', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='elucent, epicsquid',
    link='https://minecraft.curseforge.com/projects/clarity';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '1.1', '1449c9208e1394c77ec8724919ec84db', now(), now()
  FROM solder_mods
  WHERE name='clarity'
  ON DUPLICATE KEY UPDATE
    md5='1449c9208e1394c77ec8724919ec84db',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='clarity'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='1.1'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('embers', 'embers', 'embers', 'elucent, epicsquid',
	  'https://minecraft.curseforge.com/projects/embers', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='elucent, epicsquid',
    link='https://minecraft.curseforge.com/projects/embers';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '0.230', '36d6b775cf7b48d17d2aa2c9d10c087e', now(), now()
  FROM solder_mods
  WHERE name='embers'
  ON DUPLICATE KEY UPDATE
    md5='36d6b775cf7b48d17d2aa2c9d10c087e',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='embers'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='0.230'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('mystical-lib', 'mystical-lib', 'mystical-lib', 'elucent, epicsquid',
	  'https://minecraft.curseforge.com/projects/mysticallib', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='elucent, epicsquid',
    link='https://minecraft.curseforge.com/projects/mysticallib';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '0.1.12', '0a97fc0a153a73b3711429175659fb17', now(), now()
  FROM solder_mods
  WHERE name='mystical-lib'
  ON DUPLICATE KEY UPDATE
    md5='0a97fc0a153a73b3711429175659fb17',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='mystical-lib'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='0.1.12'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('mystical-world', 'mystical-world', 'mystical-world', 'elucent, epicsquid',
	  'https://minecraft.curseforge.com/projects/mystic-world', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='elucent, epicsquid',
    link='https://minecraft.curseforge.com/projects/mystic-world';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '0.1.1', '862de5c165b18cd08f0ccea81b39a369', now(), now()
  FROM solder_mods
  WHERE name='mystical-world'
  ON DUPLICATE KEY UPDATE
    md5='862de5c165b18cd08f0ccea81b39a369',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='mystical-world'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='0.1.1'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('open-blocks', 'open-blocks', 'open-blocks', 'Mikemoo',
	  'https://minecraft.curseforge.com/projects/openblocks', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='Mikemoo',
    link='https://minecraft.curseforge.com/projects/openblocks';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '1.7.6', '6d1423ec0f82e80869f5683b6a9bc5e6', now(), now()
  FROM solder_mods
  WHERE name='open-blocks'
  ON DUPLICATE KEY UPDATE
    md5='6d1423ec0f82e80869f5683b6a9bc5e6',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='open-blocks'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='1.7.6'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('open-mods-lib', 'open-mods-lib', 'open-mods-lib', 'Mikemoo',
	  'https://minecraft.curseforge.com/projects/openmodslib', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='Mikemoo',
    link='https://minecraft.curseforge.com/projects/openmodslib';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '0.11.5', '89d42a0a0983fb28353f6c7c61299608', now(), now()
  FROM solder_mods
  WHERE name='open-mods-lib'
  ON DUPLICATE KEY UPDATE
    md5='89d42a0a0983fb28353f6c7c61299608',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='open-mods-lib'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='0.11.5'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('actually-additions', 'actually-additions', 'actually-additions', 'Ellpeck, canitzp, Shadows_Of_Fire',
	  'https://minecraft.curseforge.com/projects/actually-additions', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='Ellpeck, canitzp, Shadows_Of_Fire',
    link='https://minecraft.curseforge.com/projects/actually-additions';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '1.12.2-r135', '2a87ee2db4eb0c864c3923cd909a89e5', now(), now()
  FROM solder_mods
  WHERE name='actually-additions'
  ON DUPLICATE KEY UPDATE
    md5='2a87ee2db4eb0c864c3923cd909a89e5',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='actually-additions'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='1.12.2-r135'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('forgelin', 'forgelin', 'forgelin', 'Shadowfacts',
	  'https://minecraft.curseforge.com/projects/shadowfacts-forgelin', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='Shadowfacts',
    link='https://minecraft.curseforge.com/projects/shadowfacts-forgelin';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '1.7.4', 'dfed3c055049fdc9c7d3c58276c6dbea', now(), now()
  FROM solder_mods
  WHERE name='forgelin'
  ON DUPLICATE KEY UPDATE
    md5='dfed3c055049fdc9c7d3c58276c6dbea',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='forgelin'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='1.7.4'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('tesla-core-lib', 'tesla-core-lib', 'tesla-core-lib', 'Face_of_Cat',
	  'https://minecraft.curseforge.com/projects/tesla-core-lib', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='Face_of_Cat',
    link='https://minecraft.curseforge.com/projects/tesla-core-lib';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '1.0.14', 'ef8c145c53cf7c4664eae733c615975f', now(), now()
  FROM solder_mods
  WHERE name='tesla-core-lib'
  ON DUPLICATE KEY UPDATE
    md5='ef8c145c53cf7c4664eae733c615975f',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='tesla-core-lib'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='1.0.14'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('not-enough-ids', 'not-enough-ids', 'not-enough-ids', 'fewizz, Adaptivity, Player, TheSilentium',
	  'https://minecraft.curseforge.com/projects/notenoughids', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='fewizz, Adaptivity, Player, TheSilentium',
    link='https://minecraft.curseforge.com/projects/notenoughids';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '1.5.4.2', '65ba6cf9737a0eaeac3e347e3eeb2ad7', now(), now()
  FROM solder_mods
  WHERE name='not-enough-ids'
  ON DUPLICATE KEY UPDATE
    md5='65ba6cf9737a0eaeac3e347e3eeb2ad7',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='not-enough-ids'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='1.5.4.2'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('streams', 'streams', 'streams', 'delvr',
	  'https://minecraft.curseforge.com/projects/streams', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='delvr',
    link='https://minecraft.curseforge.com/projects/streams';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '1.12-0.4.4', '61871f324acb36406cdb054dd1887170', now(), now()
  FROM solder_mods
  WHERE name='streams'
  ON DUPLICATE KEY UPDATE
    md5='61871f324acb36406cdb054dd1887170',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='streams'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='1.12-0.4.4'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('farseek', 'farseek', 'farseek', 'delvr',
	  'https://minecraft.curseforge.com/projects/farseek', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='delvr',
    link='https://minecraft.curseforge.com/projects/farseek';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '1.12-2.3', '3a0c334dce1170ed940fec2790595854', now(), now()
  FROM solder_mods
  WHERE name='farseek'
  ON DUPLICATE KEY UPDATE
    md5='3a0c334dce1170ed940fec2790595854',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='farseek'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='1.12-2.3'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('custom-main-menu', 'custom-main-menu', 'custom-main-menu', 'Lumien',
	  'https://minecraft.curseforge.com/projects/custom-main-menu', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='Lumien',
    link='https://minecraft.curseforge.com/projects/custom-main-menu';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '2.0.8', 'd2b524661874c6fb2f96a77c3c3c2f1f', now(), now()
  FROM solder_mods
  WHERE name='custom-main-menu'
  ON DUPLICATE KEY UPDATE
    md5='d2b524661874c6fb2f96a77c3c3c2f1f',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='custom-main-menu'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='2.0.8'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('apple-skin', 'apple-skin', 'apple-skin', 'squeek502',
	  'https://minecraft.curseforge.com/projects/appleskin', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='squeek502',
    link='https://minecraft.curseforge.com/projects/appleskin';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '1.0.9', '4ecbfdfa90a43aa075512e3bd84ff2a6', now(), now()
  FROM solder_mods
  WHERE name='apple-skin'
  ON DUPLICATE KEY UPDATE
    md5='4ecbfdfa90a43aa075512e3bd84ff2a6',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='apple-skin'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='1.0.9'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('apple-core', 'apple-core', 'apple-core', 'squeek502, Girafi',
	  'https://minecraft.curseforge.com/projects/applecore', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='squeek502, Girafi',
    link='https://minecraft.curseforge.com/projects/applecore';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '3.1.3', 'c340cd3f5a2c3a90f5f8e83cc985fab7', now(), now()
  FROM solder_mods
  WHERE name='apple-core'
  ON DUPLICATE KEY UPDATE
    md5='c340cd3f5a2c3a90f5f8e83cc985fab7',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='apple-core'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='3.1.3'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('initial-inventory', 'initial-inventory', 'initial-inventory', 'jaredlll08',
	  'https://minecraft.curseforge.com/projects/initial-inventory', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='jaredlll08',
    link='https://minecraft.curseforge.com/projects/initial-inventory';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '3.0.0', '8f881f074f526b1ca6499f489bff2b6f', now(), now()
  FROM solder_mods
  WHERE name='initial-inventory'
  ON DUPLICATE KEY UPDATE
    md5='8f881f074f526b1ca6499f489bff2b6f',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='initial-inventory'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='3.0.0'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('clumps', 'clumps', 'clumps', 'jaredlll08',
	  'https://minecraft.curseforge.com/projects/clumps', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='jaredlll08',
    link='https://minecraft.curseforge.com/projects/clumps';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '3.1.1', 'f8c25184c61e9bc12344b77a7572ea08', now(), now()
  FROM solder_mods
  WHERE name='clumps'
  ON DUPLICATE KEY UPDATE
    md5='f8c25184c61e9bc12344b77a7572ea08',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='clumps'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='3.1.1'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('mod-tweaker', 'mod-tweaker', 'mod-tweaker', 'jaredlll08',
	  'https://minecraft.curseforge.com/projects/modtweaker', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='jaredlll08',
    link='https://minecraft.curseforge.com/projects/modtweaker';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '4.0.12', 'cf4cf1550ce946343cc24d3e09ca456b', now(), now()
  FROM solder_mods
  WHERE name='mod-tweaker'
  ON DUPLICATE KEY UPDATE
    md5='cf4cf1550ce946343cc24d3e09ca456b',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='mod-tweaker'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='4.0.12'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('controlling', 'controlling', 'controlling', 'jaredlll08',
	  'https://minecraft.curseforge.com/projects/controlling', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='jaredlll08',
    link='https://minecraft.curseforge.com/projects/controlling';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '3.0.6', 'a8ed0e3e93999c7e9ec5f289d8465148', now(), now()
  FROM solder_mods
  WHERE name='controlling'
  ON DUPLICATE KEY UPDATE
    md5='a8ed0e3e93999c7e9ec5f289d8465148',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='controlling'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='3.0.6'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('slimy-boyos', 'slimy-boyos', 'slimy-boyos', 'jaredlll08',
	  'https://minecraft.curseforge.com/projects/slimyboyos', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='jaredlll08',
    link='https://minecraft.curseforge.com/projects/slimyboyos';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '1.0.0', '867acfbb2699dedd5d7d7b4a3a092ed8', now(), now()
  FROM solder_mods
  WHERE name='slimy-boyos'
  ON DUPLICATE KEY UPDATE
    md5='867acfbb2699dedd5d7d7b4a3a092ed8',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='slimy-boyos'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='1.0.0'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('mt-lib', 'mt-lib', 'mt-lib', 'jaredlll08',
	  'https://minecraft.curseforge.com/projects/mtlib', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='jaredlll08',
    link='https://minecraft.curseforge.com/projects/mtlib';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '3.0.5', '82e3afd02f576371b99236dbd474998e', now(), now()
  FROM solder_mods
  WHERE name='mt-lib'
  ON DUPLICATE KEY UPDATE
    md5='82e3afd02f576371b99236dbd474998e',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='mt-lib'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='3.0.5'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('craft-tweaker2', 'craft-tweaker2', 'craft-tweaker2', 'jaredlll08, kindlich, StanH',
	  'https://minecraft.curseforge.com/projects/crafttweaker', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='jaredlll08, kindlich, StanH',
    link='https://minecraft.curseforge.com/projects/crafttweaker';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '4.1.9', '8e84da46ba675c02217479deef9efec6', now(), now()
  FROM solder_mods
  WHERE name='craft-tweaker2'
  ON DUPLICATE KEY UPDATE
    md5='8e84da46ba675c02217479deef9efec6',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='craft-tweaker2'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='4.1.9'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('recurrent-complex', 'recurrent-complex', 'recurrent-complex', 'Ivorius',
	  'https://minecraft.curseforge.com/projects/recurrent-complex', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='Ivorius',
    link='https://minecraft.curseforge.com/projects/recurrent-complex';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '1.4.7', '8b6ba3f142d717606c8c560ad264ccef', now(), now()
  FROM solder_mods
  WHERE name='recurrent-complex'
  ON DUPLICATE KEY UPDATE
    md5='8b6ba3f142d717606c8c560ad264ccef',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='recurrent-complex'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='1.4.7'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('iv-toolkit', 'iv-toolkit', 'iv-toolkit', 'Ivorius',
	  'https://minecraft.curseforge.com/projects/ivtoolkit', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='Ivorius',
    link='https://minecraft.curseforge.com/projects/ivtoolkit';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '1.3.3', 'b825c640b9f30f1156a0ca4f4e214714', now(), now()
  FROM solder_mods
  WHERE name='iv-toolkit'
  ON DUPLICATE KEY UPDATE
    md5='b825c640b9f30f1156a0ca4f4e214714',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='iv-toolkit'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='1.3.3'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('lag-goggles', 'lag-goggles', 'lag-goggles', 'Terminator_NL_44352929',
	  'https://minecraft.curseforge.com/projects/laggoggles', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='Terminator_NL_44352929',
    link='https://minecraft.curseforge.com/projects/laggoggles';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '4.1', 'a4be9ea8f381ac7c265455a382e7d74d', now(), now()
  FROM solder_mods
  WHERE name='lag-goggles'
  ON DUPLICATE KEY UPDATE
    md5='a4be9ea8f381ac7c265455a382e7d74d',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='lag-goggles'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='4.1'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('fast-leaf-decay', 'fast-leaf-decay', 'fast-leaf-decay', 'Olafski',
	  'https://minecraft.curseforge.com/projects/fast-leaf-decay', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='Olafski',
    link='https://minecraft.curseforge.com/projects/fast-leaf-decay';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '14', '257963b58d025b0c4719322c616e097a', now(), now()
  FROM solder_mods
  WHERE name='fast-leaf-decay'
  ON DUPLICATE KEY UPDATE
    md5='257963b58d025b0c4719322c616e097a',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='fast-leaf-decay'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='14'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_mods (name, description, pretty_name, author,
	       link, created_at, updated_at)
  VALUES ('soot', 'soot', 'soot', 'BordListian',
	  'https://minecraft.curseforge.com/projects/soot', now(), now())
  ON DUPLICATE KEY UPDATE
    updated_at=now(),
    author='BordListian',
    link='https://minecraft.curseforge.com/projects/soot';

INSERT INTO
  solder_modversions (mod_id, version, md5, created_at, updated_at)
  SELECT id AS mod_id, '0.18-hotfix', '52dc211fae95b1a7cedbafc1d267b903', now(), now()
  FROM solder_mods
  WHERE name='soot'
  ON DUPLICATE KEY UPDATE
    md5='52dc211fae95b1a7cedbafc1d267b903',
    updated_at=now();

INSERT INTO
  solder_build_modversion (modversion_id, build_id,
			   created_at, updated_at)
  SELECT
    solder_modversions.id AS modversion_id,
    solder_builds.id AS build_id,
    now(), now()
  FROM
    solder_builds
  LEFT JOIN (solder_modversions, solder_mods, solder_modpacks)
  ON (solder_mods.name='soot'
    AND solder_mods.id=solder_modversions.mod_id
    AND solder_modversions.version='0.18-hotfix'
    AND solder_builds.version='0.1.5'
    AND solder_builds.modpack_id=solder_modpacks.id
    AND solder_modpacks.slug='mmt5')
  ON DUPLICATE KEY UPDATE
    updated_at=now();


INSERT INTO
  solder_builds (modpack_id, version, created_at, updated_at,
		 minecraft, forge, is_published, private,
		 minecraft_md5)
  SELECT id AS modpack_id, '0.1.5', now(), now(),
      '1.12.2', NULL, 1, 0,
      ' '
  FROM solder_modpacks
  WHERE name='mmt5'
  ON DUPLICATE KEY UPDATE
    minecraft='1.12.2',
    updated_at=now();

INSERT INTO
  solder_modpacks (name, slug, recommended, latest,
		   url, icon_md5, logo_md5, background_md5,
		   created_at, updated_at, hidden, private)
  VALUES ('mmt5', 'mmt5', '0.1.5', '0.1.5',
	  NULL, ' ', ' ', ' ',
	  now(), now(), 0, 0)
  ON DUPLICATE KEY UPDATE
    recommended='0.1.5',
    latest='0.1.5',
    updated_at=now();

