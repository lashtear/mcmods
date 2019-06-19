#! /bin/bash

MPNAME=MechTech1.7
MPSLUG=mechtech-1-7
MPVERSION=0.0.6.0

s=../mods-as-distributed
st=staging
u=unpacked
p=mods
sv=servermods

sjtotal=$(egrep '^(solder|git)file ' $0 |wc -l)
sjdone=0

. pkg-mod-lib.sh

rm -rf $u $p $st $sv
mkdir -p $p

#cat >>"$p/mod.sql" <<EOF
#TRUNCATE TABLE solder_mods;
#TRUNCATE TABLE solder_modversions;
#TRUNCATE TABLE solder_build_modversion;
#TRUNCATE TABLE solder_builds;
#TRUNCATE TABLE solder_modpacks;
#EOF

cat >>"$p/mod.sql" <<EOF
INSERT INTO
  solder_modpacks (name, slug, recommended, latest,
		   url, icon_md5, logo_md5, background_md5,
		   created_at, updated_at, hidden, private)
  VALUES ('$MPNAME', '$MPSLUG', '$MPVERSION', '$MPVERSION',
	  NULL, ' ', ' ', ' ',
	  now(), now(), 0, 0)
  ON DUPLICATE KEY UPDATE
    latest='$MPVERSION',
    updated_at=now();

INSERT INTO
  solder_builds (modpack_id, version, created_at, updated_at,
		 minecraft, forge, is_published, private,
		 minecraft_md5)
  SELECT id AS modpack_id, '$MPVERSION', now(), now(),
      '1.7.10', NULL, 1, 0,
      ' '
  FROM solder_modpacks
  WHERE name='$MPNAME'
  ON DUPLICATE KEY UPDATE
    updated_at=now();

EOF

set -o pipefail

(

# base config
( cd $HOME/git/mt17-conf.git; git tag $MPVERSION )
gitfile "$HOME/git/mt17-conf.git" config "$MPVERSION"
( cd $HOME/git/mechanipus-resource-pack.git; git tag $MPVERSION )
stagegitfile "$HOME/git/mechanipus-resource-pack.git" mechanipus "$MPVERSION"
solderfile --staged --client mechanipus.zip mechanipus-resource-pack "$MPVERSION" resourcepacks mechanipus.zip

# lex manos
solderfile --client forge-1.7.10-10.13.2.1236-universal.jar forge 10.13.2.1236 bin modpack.jar

# chickenbones
solderfile ChickenChunks-1.7.10-1.3.4.14-universal.jar chicken-chunks 1.3.4.14
solderfile CodeChickenCore-1.7.10-1.0.4.29-universal.jar code-chicken-core 1.0.4.29
solderfile EnderStorage-1.7.10-1.4.5.26-universal.jar ender-storage 1.4.5.26
solderfile NotEnoughItems-1.7.10-1.0.3.68-universal.jar not-enough-items 1.0.3.68
solderfile Translocator-1.7.10-1.1.1.13-universal.jar translocator 1.1.1.13
solderfile WR-CBE-1.7.10-1.4.1.9-universal.jar wr-cbe 1.4.1.9

solderfile ForgeMultipart-1.7.10-1.1.0.314-universal.jar forge-multi-part 1.1.0.314 mods/1.7.10

# cult of the full hub
solderfile CoFHCore-[1.7.10]3.0.0B8-36.jar cofhcore 3.0.0B8-36
solderfile CoFHLib-[1.7.10]1.0.0B7-29.jar cofhlib 1.1.0B7-29 mods/1.7.10
solderfile ThermalExpansion-[1.7.10]4.0.0B6-16.jar thermal-expansion 4.0.0B6-16
solderfile ThermalFoundation-[1.7.10]1.0.0B3-8.jar thermal-foundation 1.1.0B3-8
solderfile RedstoneArsenal-[1.7.10]1.1.0RC1-19.jar redstone-arsenal 1.1.0RC1-19
solderfile MineFactoryReloaded-[1.7.10]2.8.0RC5-694.jar mine-factory-reloaded 2.8.0RC5-694
solderfile NetherOres-[1.7.10]2.3.0RC3-84.jar nether-ores 2.3.0RC3-84

solderfile MineFactoryReloaded-CompatMagicalCrops.jar mine-factory-reloaded-compat-magical-crops 1.7.10

solderfile BiomesOPlenty-1.7.10-2.1.0.1019-universal.jar biomes-o-plenty 2.1.0.1019

# prof mobius
solderfile Waila-1.5.5_1.7.10.jar waila 1.5.5
solderfile Jabba-1.1.4_1.7.10.jar jabba 1.1.4_1.7.10

solderfile [1.7.10]bspkrsCore-universal-6.14.jar bspkrs-core 6.14 mods/1.7.10
solderfile --client [1.7.10]ArmorStatusHUD-client-1.27.jar armor-status-hud 1.27
solderfile --client [1.7.10]StatusEffectHUD-client-1.26.jar status-effect-hud 1.26
solderfile [1.7.2]Treecapitator-universal-2.0.3.jar treecapitator 2.0.3

solderfile Aroma1997Core-1.7.10-1.0.2.13.jar aroma-core 1.0.2.13
solderfile BetterChests-1.7.10-1.1.1.8.jar better-chests 1.1.1.8

solderfile antiqueatlas-4.0.1a-1.7.10.jar antique-atlas 4.0.1a

solderfile Metallurgy-1.7.10-4.0.6.80.jar metallurgy 4.0.6.80
solderfile MetallurgyCore-1.7.10-4.0.4.18.jar metallurgy-core 4.0.4.18

solderfile AOBD-2.3.2.jar aobd 2.3.2
solderfile TConstruct_mc1.7.10_1.6.0d40.1.jar tinkers-construct 1.6.0d40.1
solderfile natura-1.7.10-2.2.0-b1.jar natura 2.2.0-b1
solderfile IguanaTinkerTweaks-1.7.10-2.0.4.jar iguana-tinker-tweaks 2.0.4
solderfile Mantle-mc1.7.10-0.3.1.jar mantle 0.3.1
solderfile ExtraTiC-1.7.10-1.0.3.jar extra-tic 1.0.3
solderfile TiCTooltips-mc1.7.10-1.1.10.jar tic-tooltips 1.1.10
solderfile TMechworks_mc1.7.10_0.2.8.jar tinkers-mechworks 0.2.8

# myrathi
solderfile FlatSigns-1.7.10-universal-2.0.0.17.jar flat-signs 2.0.0.17
#solderfile FinndusFillies-1.7.10-universal-2.1.0.12.jar finndus-fillies 2.1.0.12
solderfile ObsidiPlates-1.7.10-universal-3.0.0.18.jar obsidiplates 3.0.0.18

solderfile industrialcraft-2-2.2.649-experimental.jar industrial-craft 2-2.2.649

solderfile appliedenergistics2-rv1-stable-1.jar applied-energistics 2-rv1-stable-1
solderfile ExtraCells-1.7.10-2.1.13bnull.jar extra-cells 2.1.13bnull

solderfile BetterStorage-1.7.10-0.11.0.120.jar better-storage 0.11.0.120
solderfile backpack-2.0.1-1.7.x.jar backpack 2.0.1
solderfile ironchest-1.7.10-6.0.62.742-universal.jar ironchest 6.0.62.742
solderfile InventoryTweaks-1.59-dev-152.jar inventory-tweaks 1.59-dev-152

solderfile BigReactors-0.4.0A.jar big-reactors 0.4.0A

solderfile buildcraft-6.2.1.jar buildcraft 6.2.1
solderfile forestry_1.7.10-3.2.0.5.jar forestry 3.2.0.5 #conflict reika
solderfile Railcraft_1.7.10-9.4.0.0.jar railcraft 9.4.0.0

solderfile BiblioCraft[v1.9.1][MC1.7.10].jar bibliocraft v1.9.1
solderfile BiblioWoods[Forestry][v1.7].jar bibliowoods-forestry v1.7 #need forestry
solderfile BiblioWoods[BiomesOPlenty][v1.9].jar bibliowoods-bop v1.9
solderfile BiblioWoods[Natura][v1.5].jar bibliowoods-natura v1.5

# bdew
#solderfile bdlib-mc1710-1.4.4.22.jar bdlib 1.4.4.22
#solderfile gendustry-mc1710-1.3.3.25.jar gendustry 1.3.3.25 #need forestry
#solderfile generators-mc1710-0.9.1.13.jar generators 0.9.1.13
#solderfile neiaddons-mc1710-1.12.2.9.jar neiaddons 1.12.2.9
#solderfile pressure-mc1710-0.9.3.27.jar pressure 0.9.3.27

#solderfile binnie-mods-2.0-dev4.jar binnie-mods 2.0-dev4 #need forestry

solderfile Chisel-1.7.10-1.5.7.jar chisel 1.5.7

# ProjectRED
PROJREDVER=4.5.7.58
solderfile ProjectRed-1.7.10-$PROJREDVER-Base.jar projectred-base $PROJREDVER
solderfile ProjectRed-1.7.10-$PROJREDVER-Compat.jar projectred-compat $PROJREDVER
solderfile ProjectRed-1.7.10-$PROJREDVER-Integration.jar projectred-integration $PROJREDVER
solderfile ProjectRed-1.7.10-$PROJREDVER-Lighting.jar projectred-lighting $PROJREDVER
solderfile ProjectRed-1.7.10-$PROJREDVER-Mechanical_beta.jar projectred-mechanical-beta $PROJREDVER
solderfile ProjectRed-1.7.10-$PROJREDVER-World.jar projectred-world $PROJREDVER

# Reika
REIKAVER=V2
#solderfile DragonAPI\ 1.7.10\ $REIKAVER.jar dragon-api $REIKAVER
solderfile dragon-api-v2-minus-all.jar dragon-api ${REIKAVER}-3
solderfile CaveControl\ 1.7.10\ $REIKAVER.jar cave-control $REIKAVER
solderfile CritterPet\ 1.7.10\ $REIKAVER.jar critter-pet $REIKAVER
solderfile ElectriCraft\ 1.7.10\ $REIKAVER.jar electricraft $REIKAVER
solderfile ExpandedRedstone\ 1.7.10\ $REIKAVER.jar expanded-redstone $REIKAVER
solderfile GeoStrata\ 1.7.10\ $REIKAVER.jar geostrata $REIKAVER
solderfile ReactorCraft\ 1.7.10\ $REIKAVER.jar reactorcraft $REIKAVER
solderfile RotaryCraft\ 1.7.10\ $REIKAVER.jar rotarycraft $REIKAVER
solderfile UsefulTNT\ 1.7.10\ $REIKAVER.jar useful-tnt $REIKAVER
solderfile VoidMonster\ 1.7.10\ $REIKAVER.jar void-monster $REIKAVER
solderfile ChromatiCraft\ 1.7.10\ $REIKAVER.jar chromaticraft $REIKAVER

# magic stuff
solderfile witchery-1.7.10-0.20.6.jar witchery 0.20.6
solderfile Thaumcraft-1.7.10-4.2.1.4.jar thaumcraft 4.2.1.4
solderfile Baubles-1.7.10-1.0.1.9.jar baubles 1.0.1.9 mods/1.7.10
solderfile ThaumcraftGates-1.4.0.jar thaumcraft-gates 1.4.0
solderfile ThaumcraftMobAspects-1.7.2-2A.jar thaumcraft-mob-aspects 2A
solderfile ThaumicTinkerer-2.5-1.7.10-161.jar thaumic-tinkerer 2.5-1.7.10-161
solderfile Forbidden\ Magic-1.7.10-0.55.jar forbidden-magic 0.55
solderfile twilightforest-1.7.10-2.3.2.jar twilightforest 2.3.2
solderfile Botania\ r1.3-138.jar botania r1.3-138
solderfile BloodMagic-1.7.10-1.2.1b-1.jar blood-magic 1.2.1b-1
solderfile thaumicenergistics-0.8.6b.jar thaumic-energistics 0.8.6b
solderfile thaumcraftneiplugin-1.7.10-1.6a.jar thaumcraft-nei-plugin 1.6a
solderfile Automagy-1.7.10-0.14.jar automagy 0.14
solderfile ThaumicExploration-1.7.10-1.1-31.jar thaumic-exploration 1.1-31
solderfile 1.7.10\ Technomancy\ 0.8.1.jar technomancy 0.8.1
solderfile craftingpillars-1.7.10-1.5.8.jar crafting-pillars 1.5.8

solderfile ArchimedesShips-1.7.1.jar archimedes-ships 1.7.1
solderfile weaponmod-1.14.2.jar weaponmod 1.14.2
solderfile Caveworld_1.7.10-v1.8.3.jar caveworld 1.8.3

solderfile ElectricalAge_BETA-1.9_r43.jar electrical-age 1.9_r43

solderfile Enchiridion-1.7.X-1.2b.jar enchiridion 1.2b
solderfile Mariculture-1.7.10-1.2.3d.jar mariculture 1.2.3d

solderfile LanteaCraft-1.7.10-52.jar lanteacraft 1.7.10-52

solderfile EnhancedPortals_1.7.10-universal-3.0.9.jar enhanced-portals 3.0.9

solderfile extrautilities-1.1.0k.jar extra-utilities 1.1.0k

GALACVER=3.0.6.235
solderfile MicdoodleCore-1.7-$GALACVER.jar micdoodle-core $GALACVER
solderfile GalacticraftCore-1.7-$GALACVER.jar galacticraft-core $GALACVER
solderfile Galacticraft-Planets-1.7-$GALACVER.jar galacticraft-planets $GALACVER

solderfile Ganys\ End-1.8.5.jar ganys-end 1.8.5
solderfile Ganys\ Nether-1.7.7.jar ganys-nether 1.7.7
solderfile Ganys\ Surface-1.9.3.jar ganys-surface 1.9.3
solderfile Headcrumbs-1.2.7.jar headcrumbs 1.2.7

# nightkosh
solderfile GraveStone\ 2.10.2.jar gravestone 2.10.2
# subaraki
solderfile GraveStones-1.7.2_1.4.jar gravestones 1.4

# AtomicStryker's stuff
#solderfile InfernalMobs-1.7.10.jar infernal-mobs 1.7.10 # apocalyptically unbalanced with deadlyworld
#solderfile MagicYarn-1.7.10.jar magic-yarn 1.7.10 # buggy/unneeded
#solderfile PetBat-1.7.10.jar pet-bat 1.7.10
#solderfile RopePlus-1.7.10.jar rope-plus 1.7.10
#solderfile Necromancy-1.7.10.jar # unthematic?
#stagezipdata Minions-1.7.10.zip # kinda ridiculous
#stagezipdata Ruins-1.7.10.zip # filled with crap
#stagezipdata StalkerCreepers-1.7.10.zip
#stagezipdata BattleTowers-1.7.10.zip

# Father Toast's stuff
#solderfile LavaMonsters-1.7.10-2.2.1.jar lava-monsters 2.2.1
#solderfile SpecialMobs-1.7.10-3.0.2.jar special-mobs 3.0.2
#solderfile UtilityMobs-1.7.10-3.1.1.jar utility-mobs 3.1.1
solderfile DeadlyWorld-1.7.10-1.0.2.jar deadly-world 1.0.2
#stagezipdata LostBooks-1.7.10-1.2.1-UNZIP-ME.zip # kinda crap

solderfile LycanitesMobsComplete\ 1.10.7.1\ \[1.7.10\].jar lycanites-mobs-complete 1.10.7.1

solderfile --client JSTR_Universal_1.7.x.zip john-smith 1.7 resourcepacks
#solderfile Fanver_Universal_1.7.x.zip soartex-fanver-universal 1.1.0 resourcepacks
#solderfile ChromaHills-128x1.7SEUS1.0.9.zip chroma-hills-128x-SEUS 1.0.9 resourcepacks
solderfile --client Invictus_Universal_1.7.x.zip soartex-invictus-universal 1.1.0 resourcepacks
#solderfile Invictus-1.0-Shader.zip soartex-invictus-shader 1.0 resourcepacks

solderfile magicalcrops-1.7.10_0.1.jar magical-crops 1.7.10-0.1

MEKVER=7.1.1.127
solderfile Mekanism-1.7.10-$MEKVER.jar mekanism $MEKVER
solderfile MekanismGenerators-1.7.10-$MEKVER.jar mekanism-generators $MEKVER
solderfile MekanismTools-1.7.10-$MEKVER.jar mekanism-tools $MEKVER

# Calclavia's stuff
solderfile resonant-engine-2.0.0.151-core.jar resonant-engine 2.0.0.151
#solderfile universal-electricity-4.0.0.88-core.jar universal-electricity 4.0.0.88
solderfile mffs-4.1.0.36-core.jar mffs 4.1.0.36
#solderfile resonant-induction-0.3.4.134-core.jar resonant-induction 0.3.4.134
# http://tracker.calclavia.com/issue/RI-116

solderfile OpenModsLib-1.7.10-0.6-snapshot-225.jar open-mods-lib 0.6-snapshot-225
solderfile OpenBlocks-1.7.10-1.3-snapshot-435.jar open-blocks 1.3-snapshot-435
solderfile OpenEye-0.6-1.7.10-snapshot-133.jar openeye 0.6-snapshot-133

# Sangar's stuff
solderfile OpenComputers-MC1.7.10-1.4.1.14-universal.jar open-computers 1.4.1.14

solderfile RandomThings-2.1.7.jar random-things 2.1.7

solderfile Reliquary-1.2.214.jar reliquary 1.2.214
solderfile LibSandstone-1.0.0-84e82becfe61487fee1c05e2e93faacd.jar libsandstone 1.0.0-84e82becfe61487fee1c05e2e93faacd mods/1.7.10 LibSandstone-1.0.0.jar

solderfile EnderIO-1.7.10-2.1.5.248.jar enderio 2.1.5.248

#solderfile CraftGuide-1.6.8.1.zip craftguide 1.6.8.1

solderfile 'Carpenter'\''s Blocks v3.3.0 - MC 1.7.10.jar' carpenters-blocks v3.3.0
solderfile Thaumcarpentry-0.0.1.5-1.7.10.jar thaumcarpentry 0.0.1.5

solderfile RemainInMotion-2.1.1.jar remain-in-motion 2.1.1

#solderfile MorePlayerModels_1.7.10.jar more-player-models 1.7.10 # site down

solderfile Pam\'s\ DesertCraft\ 1.7.10a.zip pams-desertcraft 1.7.10a
solderfile Pam\'s\ HarvestCraft\ 1.7.10a.zip pams-harvestcraft 1.7.10a
solderfile Pam\'s\ Random\ Plants\ 1.7.2a.zip pams-random-plants 1.7.2a
solderfile Pam\'s\ Temperate\ Plants\ 1.7.2b.zip pams-temperate-plants 1.7.2b
solderfile Pam\'s\ WeeeFlowers\ 1.7.2b.zip pams-weee-flowers 1.7.2b
solderfile WailaHarvestability-mc1.7.x-1.1.0.jar waila-harvestability 1.1.0

stagezipdata Growthcraft-1.7.10.zip
solderfile --staged growthcraft-core-1.7.10-2.1.0a.jar growthcraft-core 2.1.0a
solderfile --staged growthcraft-bamboo-1.7.10-2.1.0.jar growthcraft-bamboo 2.1.0
solderfile --staged growthcraft-bees-1.7.10-2.1.0.jar growthcraft-bees 2.1.0
solderfile --staged growthcraft-cellar-1.7.10-2.1.0a.jar growthcraft-cellar 2.1.0a
solderfile --staged growthcraft-fishtrap-1.7.10-2.1.0a.jar growthcraft-fishtrap 2.1.0a
solderfile --staged growthcraft-grapes-1.7.10-2.1.0.jar growthcraft-grapes 2.1.0
solderfile --staged growthcraft-hops-1.7.10-2.1.0.jar growthcraft-hops 2.1.0
solderfile --staged growthcraft-rice-1.7.10-2.1.0a.jar growthcraft-rice 2.1.0a
solderfile --staged growthcraft-apples-1.7.10-2.1.0.jar growthcraft-apples 2.1.0

stagezipdata liteloader-installer-1.7.10-03.jar
solderfile --staged --client liteloader-1.7.10.jar liteloader 1.7.10

#solderfile mod_macros_0.10.12_for_1.7.10.litemod macros 0.10.12
solderfile --client mod_voxelMap_1.2.3_for_1.7.10.litemod voxel-map 1.2.3

solderfile --client TabbyChat-1.7.10-1.11.1.65-fml.jar tabby-chat 1.11.1.65

solderfile mystcraft-1.7.10-0.11.0.00.jar mystcraft 0.11.0.00

solderfile fastcraft-1.9.jar fastcraft 1.9

#solderfile ShadersModCore-v2.3.28-mc1.7.10-f.jar shaders-mod-core 2.3.28
#solderfile SEUS-v10.1-Ultra-DOF.zip seus-ultra-dof v10.1 shaderpacks
#solderfile SEUS-v10.1-Standard.zip seus-standard v10.1 shaderpacks

# incompatible with galacticraft :(
#stagezipdata 'MC 1.7.10 - Player API core 1.0.zip'
#solderfile --staged PlayerAPI-1.7.10-1.0.jar player-api 1.0
#stagezipdata 'MC 1.7.10 - Render Player API core 1.0.zip'
#solderfile --staged RenderPlayerAPI-1.7.10-1.0.jar render-player-api 1.0
#stagezipdata 'MC 1.7.10 - Smart Moving 15.2.zip'
#solderfile --staged SmartCore-1.7.10-1.0.jar smart-moving-core 1.0
#solderfile --staged SmartMoving-1.7.10-15.2.jar smart-moving 15.2
#solderfile --staged SmartRender-1.7.10-2.0.jar smart-moving-render 2.0

) | zenity --progress --auto-close --auto-kill --text 'Generating TechnicSolder packages and SQL from simple JARs'

if [ $? -ne 0 ]; then
    exit 1;
fi

cat >>"$p/mod.sql" <<EOF

INSERT INTO
  solder_builds (modpack_id, version, created_at, updated_at,
		 minecraft, forge, is_published, private,
		 minecraft_md5)
  SELECT id AS modpack_id, '$MPVERSION', now(), now(),
      '1.7.10', NULL, 1, 0,
      ' '
  FROM solder_modpacks
  WHERE name='$MPNAME'
  ON DUPLICATE KEY UPDATE
    updated_at=now();

INSERT INTO
  solder_modpacks (name, slug, recommended, latest,
		   url, icon_md5, logo_md5, background_md5,
		   created_at, updated_at, hidden, private)
  VALUES ('$MPNAME', '$MPSLUG', '$MPVERSION', '$MPVERSION',
	  NULL, ' ', ' ', ' ',
	  now(), now(), 0, 0)
  ON DUPLICATE KEY UPDATE
    latest='$MPVERSION',
    updated_at=now();

EOF

rsync -acvzP --bwlimit=256k mods/ mcmods@kuu.accela.net:/var/www/mcmods/TechnicSolder/public/repo/mods

ssh mcmods@kuu.accela.net sh -c 'mysql < /var/www/mcmods/TechnicSolder/public/repo/mods/mod.sql'

# end
