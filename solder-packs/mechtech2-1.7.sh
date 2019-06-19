#! /bin/bash

MPNAME=MechanipusMagitech-2-1.7
MPSLUG=mechanipus-magitech-2-1-7
MPVERSION=0.2.1

s=../mods-as-distributed
st=mt2-staging
u=mt2-unpacked
p=mt2-mods
sv=mt2-servermods

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
( cd $HOME/git/mechanipus-magitech-2-1-7-conf.git; git tag $MPVERSION )
if [ $? -ne 0 ]; then
    echo tag failed >&2
    exit 1
fi
gitfile "$HOME/git/mechanipus-magitech-2-1-7-conf.git" magitech-config "$MPVERSION"
( cd $HOME/git/mechanipus-resource-pack.git; git tag $MPVERSION )
if [ $? -ne 0 ]; then
    echo tag failed >&2
    exit 1
fi
stagegitfile "$HOME/git/mechanipus-resource-pack.git" mechanipus "$MPVERSION"
solderfile --staged --client mechanipus.zip mechanipus-resource-pack-mt2 "$MPVERSION" resourcepacks mechanipus.zip

# lex manos
#solderfile --client forge-1.7.10-10.13.2.1291-universal.jar forge 10.13.2.1291 bin modpack.jar
#solderfile --client forge-1.7.10-10.13.3.1403-1.7.10-universal.jar forge 10.13.3.1403 bin modpack.jar
solderfile --client forge-1.7.10-10.13.3.1384-1.7.10-universal.jar forge 10.13.3.1384 bin modpack.jar

# chickenbones
solderfile CodeChickenLib-1.7.10-1.1.3.136-universal.jar code-chicken-lib 1.1.3.136 mods/1.7.10
solderfile ForgeMultipart-1.7.10-1.1.2.334-universal.jar forge-multi-part 1.1.2.334 mods/1.7.10
solderfile CodeChickenCore-1.7.10-1.0.6.43-universal.jar code-chicken-core 1.0.6.43
solderfile NotEnoughItems-1.7.10-1.0.4.106-universal.jar not-enough-items 1.0.4.106
solderfile ChickenChunks-1.7.10-1.3.4.19-universal.jar chicken-chunks 1.3.4.19
solderfile EnderStorage-1.7.10-1.4.7.36-universal.jar ender-storage 1.4.7.36
# add translocators?

# Cult of the Full Hub
# teamcofh.com
solderfile CoFHCore-[1.7.10]3.0.2-262.jar cofhcore 3.0.2-262
solderfile CoFHLib-[1.7.10]1.0.2-160.jar cofhlib 1.0.2-160 mods/1.7.10
solderfile MineFactoryReloaded-[1.7.10]2.8.0-104.jar mine-factory-reloaded 2.8.0-104
solderfile NetherOres-[1.7.10]2.3.0-12.jar nether-ores 2.3.0-12
solderfile ThermalDynamics-[1.7.10]1.0.0-122.jar thermal-dynamics 1.0.0-122
solderfile ThermalExpansion-[1.7.10]4.0.1-182.jar thermal-expansion 4.0.1-182
solderfile ThermalFoundation-[1.7.10]1.0.0-81.jar thermal-foundation 1.0.0-81
solderfile CoFHTweaks-[1.7.10]0.1.0B2-30.jar cofh-tweaks 0.1.0B2-30

# Adubbz, Forstride
# http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/1286162-biomes-o-plenty-over-75-new-biomes-plants-and-more
solderfile BiomesOPlenty-1.7.10-2.1.0.1274-universal.jar biomes-o-plenty 2.1.0.1274 # remove/replace?

# Prof Mobius
# http://minecraft.curseforge.com/members/ProfMobius/projects
solderfile AdminCommandsToolbox-0.0.2a_1.7.10.jar admin-commands-toolbox 0.0.2a
solderfile Decocraft-v1.12b_1.7.10.jar decocraft v1.12b
#solderfile Evoc_1.0.0a.jar evoc 1.0.0a
solderfile Jabba-1.2.1a_1.7.10.jar jabba 1.2.1a
solderfile MobiusCore-1.2.5_1.7.10.jar mobius-core 1.2.5
solderfile Opis-1.2.5_1.7.10.jar opis 1.2.5
solderfile RPGAdvMod-1.0.0_1.7.10.jar rpg-adv-mod 1.0.0
solderfile Waila-1.5.10_1.7.10.jar waila 1.5.10

# bspkrs
# http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/1282347-bspkrs-mods-armorstatushud-directionhud
solderfile [1.7.10]bspkrsCore-universal-6.16.jar bspkrs-core 6.16 mods/1.7.10
solderfile --client [1.7.10]ArmorStatusHUD-client-1.28.jar armor-status-hud 1.28
solderfile --client [1.7.10]StatusEffectHUD-client-1.27.jar status-effect-hud 1.27

# DaftPVF, bspkrs
#http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/1281180-daftpvfs-mods-treecapitator-crystalwing
solderfile [1.7.10]Treecapitator-universal-2.0.4.jar treecapitator 2.0.4

# Aroma1997
# http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/1287828-aroma1997s-mods-betterchests-mining-world-mod
solderfile Aroma1997Core-1.7.10-1.0.2.13.jar aroma-core 1.0.2.13 # remove?
solderfile BetterChests-1.7.10-1.1.1.8.jar better-chests 1.1.1.8 # remove?

# Team Metallurgy
# http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/1295123-metallurgy-4
solderfile Metallurgy-1.7.10-4.0.8.97.jar metallurgy 4.0.8.97 # remove?
solderfile MetallurgyCore-1.7.10-4.0.4.18.jar metallurgy-core 4.0.4.18 # remove?

# mDiyo, boni
# http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/2218638-tinkers-construct
solderfile Mantle-1.7.10-0.3.2.jar mantle 0.3.2
solderfile TConstruct-1.7.10-1.8.4a.jar tinkers-construct 1.8.4a

# Iguana, TheOldOne, boni
# http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/2176855-iguanas-tinker-tweaks
solderfile IguanaTinkerTweaks-1.7.10-2.1.4.jar iguana-tinker-tweaks 2.1.4

# Glassmaker
# http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/wip-mods/1445212-extratic-tinkers-construct-mod-support-add-on
solderfile ExtraTiC-1.7.10-1.4.1.jar extra-tic 1.4.1

# mDiyo, progwml6
# http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/1294968-natura
solderfile natura-1.7.10-2.2.0.1.jar natura 2.2.0.1

# myrathi
# http://forum.feed-the-beast.com/threads/myrathis-mod-compendium.18505/
solderfile FlatSigns-1.7.10-universal-2.1.0.19.jar flat-signs 2.1.0.19 # remove?
solderfile ObsidiPlates-1.7.10-universal-3.0.0.18.jar obsidiplates 3.0.0.18

# AlgorithmX2
# http://ae-mod.info/
solderfile appliedenergistics2-rv2-beta-33.jar applied-energistics 2-rv2-beta-33

# M3gaFr3ak, drummermc, leonelf
# http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/1289077-ae-add-on-m3gas-extracells-2-1-x-2-2-x
solderfile ExtraCells-1.7.10-2.2.69bNIGHTLY.jar extra-cells 2.2.69bNIGHTLY

# Azanor
# http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/1292130-thaumcraft-4-2-3-5-updated-2015-2-17
solderfile Thaumcraft-1.7.10-4.2.3.5.jar thaumcraft 4.2.3.5
# http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/1294623-baubles-1-1-1-0-updated-2015-3-2
solderfile Baubles-1.7.10-1.0.1.10.jar baubles 1.0.1.10 mods/1.7.10

# Nividica
# http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/wip-mods/2150151-1-7-10-tc4-ae2-thaumic-energistics
solderfile thaumicenergistics-0.8.9.3a-rv2.jar thaumic-energistics 0.8.9.3a-rv2

# The flogat
# http://minecraft.curseforge.com/mc-mods/229912-technomancy
#solderfile "1.7.10 Technomancy 0.8.1-cropped-apis.jar" technomancy 0.8.1-cropped
solderfile "Technomancy - 0.10.h - 1.7.10.jar" technomancy 0.10.h

# Gustonia Eagle
# http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/2153132-adventurers-amulets-v-1-5-0b-who-needs-diamonds
solderfile AdventurersAmulets-1.7.10-1.5.0c.jar adventurers-amulets 1.5.0c # remove?

# Joshiejack
# http://minecraft.curseforge.com/mc-mods/76612-enchiridion
solderfile "Enchiridion 2-1.7.10-2.0.1.jar" enchiridion 2.0.1

# jaredlll08
# http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/2210357-0-54-fluxed-trinkets-rf-powered-baubles
solderfile "Fluxed Trinkets-1.7.10-1.0.54.jar" fluxed-trinkets 1.0.54 # remove?

# SpitefulFox
# http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/wip-mods/1445828-tc4-addon-forbidden-magic-v0-562-prerelease
solderfile "Forbidden Magic-1.7.10-0.562.jar" forbidden-magic 0.562

# Ganymedes01
# http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/1292852-thaumcraftgates-tc4-bc6-thaumium-pipes
solderfile ThaumcraftGates-1.4.0.jar thaumcraft-gates 1.4.0

# Flaxbeard
# http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/wip-mods/1445786-1-6-4-1-7-10-thaumic-exploration-0-6-0-thaumcraft
solderfile ThaumicExploration-1.7.10-1.1-37.jar thaumic-exploration 1.1-37

# Th3 DrunkenMafia
# http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/wip-mods/1445452-tc-add-on-thaumic-infusion-4-stable-public
solderfile ThaumicInfusion-4.jar thaumic-infusion 4

# Vazkii, Pixlepix, Nekosune
# http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/1289299-thaumic-tinkerer-thaumcraft-addon-evolve-knowledge
solderfile ThaumicTinkerer-2.5-1.7.10-470.jar thaumic-tinkerer 2.5-1.7.10-470

# DjGiannuzz
# http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/2237271-1-6-4-1-7-10-thaumcraft-nei-plugin-nei
solderfile thaumcraftneiplugin-1.7.10-1.7.jar thaumcraft-nei-plugin 1.7

# zot201
# http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/wip-mods/2235815-thaumcarpentry-0-0-1-5
solderfile Thaumcarpentry-0.0.1.5-1.7.10.jar thaumcarpentry 0.0.1.5

# dyonovan
# http://www.curse.com/mc-mods/minecraft/227328-thaumcraft-node-tracker
solderfile tcnodetracker-1.7.10-1.1.0.jar thaumcraft-nodetracker 1.1.0

# TheKentington
# http://www.curse.com/mc-mods/minecraft/227914-thaumic-horizons
solderfile thaumichorizons-1.7.10-1.1.1.jar thaumic-horizons 1.1.1

# Vazkii
# http://botaniamod.net/
solderfile "Botania r1.6-187.jar" botania r1.6-187

# WayofTime
# http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/1290532-1-7-10-2-1-6-4-blood-magic-v1-3-2-1-updated-apr
solderfile BloodMagic-1.7.10-1.3.2-1.jar blood-magic 1.3.2-1

# Benimatic
# http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/1276258-the-twilight-forest-v2-3-5-wrecking-block
solderfile twilightforest-1.7.10-2.3.5.jar twilight-forest 2.3.5 # remove?

# XCompWiz
# http://binarymage.com/wiki/doku.php?id=start
solderfile mystcraft-1.7.10-0.11.0.00.jar mystcraft 0.11.0.00 # remove?

# Mark719
#http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/1287451-magical-crops-farm-your-resources-3-2-0-who-stole
solderfile magicalcrops-4.0.0_PUBLIC_BETA_3.jar magical-craps 4.0.0b3 # remove?

# Emoniph
# https://sites.google.com/site/witcherymod/
solderfile witchery-1.7.10-0.24.1.jar witchery 0.24.1

# SirSengir, CovertJaguar, MysteriousAges, mezz
# http://forestry.sengir.net/wiki.new/doku.php
solderfile forestry_1.7.10-3.5.4.13.jar forestry 3.5.4.13

# Binnie
# http://binnie.mods.wiki/wiki/Main_Page http://minecraft.curseforge.com/mc-mods/223525-binnies-mods
solderfile binnie-mods-2.0-pre8.jar binnie-mods 2.0-pre8

# Arkandos
# https://bitbucket.org/Arkandos/magic-bees
solderfile magicbees-1.7.10-2.1.22.jar magic-bees 2.1.22

# BDew
# http://bdew.net/
solderfile bdlib-mc1710-1.7.1.71.jar bdlib 1.7.1.71
solderfile gendustry-mc1710-1.4.10.77.jar gendustry 1.4.10.77
solderfile generators-mc1710-0.9.12.64.jar generators 0.9.12.64 # remove?
solderfile neiaddons-mc1710-1.12.7.21.jar neiaddons 1.12.7.21
solderfile pressure-mc1710-1.1.1.89.jar pressure 1.1.1.89 # remove?

# CovertJaguar
# http://www.railcraft.info/
solderfile Railcraft_1.7.10-9.6.1.0.jar railcraft 9.6.1.0

# copygirl
# http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/wip-mods/1442380-betterstorage-0-13-1-126-wip
solderfile BetterStorage-1.7.10-0.13.1.126.jar better-storage 0.13.1.126

# SpaceToad, asie, Vexatos
# http://mod-buildcraft.com/
solderfile buildcraft-6.4.14.jar buildcraft 6.4.3
solderfile buildcraft-compat-6.4.2.jar buildcraft-compat 6.4.2

# asie, Vexatos
# http://wiki.vex.tty.sh/start
#solderfile AsieLib-1.7.10-0.3.9.jar asie-lib 0.3.9
#solderfile Computronics-1.7.10-1.4.2.jar computronics 1.4.2

# MrTJP, Chickenbones
# http://projectredwiki.com/wiki/Main_Page
solderfile MrTJPCore-1.7.10-1.0.6.13-universal.jar mr-tjp-core 1.0.6.13 mods/1.7.10
PROJREDVER=4.6.0.79
solderfile ProjectRed-1.7.10-$PROJREDVER-Base.jar projectred-base $PROJREDVER
solderfile ProjectRed-1.7.10-$PROJREDVER-Compat.jar projectred-compat $PROJREDVER
solderfile ProjectRed-1.7.10-$PROJREDVER-Integration.jar projectred-integration $PROJREDVER
solderfile ProjectRed-1.7.10-$PROJREDVER-Lighting.jar projectred-lighting $PROJREDVER
solderfile ProjectRed-1.7.10-$PROJREDVER-Mechanical_beta.jar projectred-mechanical-beta $PROJREDVER
solderfile ProjectRed-1.7.10-$PROJREDVER-World.jar projectred-world $PROJREDVER

# Kobata
# https://inventory-tweaks.readthedocs.org/en/latest/
solderfile InventoryTweaks-1.58-147.jar inventory-tweaks 1.58-147

# Erogenous Beef
# http://www.big-reactors.com/#/
solderfile BigReactors-0.4.3A.jar big-reactors 0.4.3A # remove?

# Sangar
# http://www.curse.com/mc-mods/minecraft/223008-opencomputers
solderfile OpenComputers-MC1.7.10-1.5.9.21-universal.jar open-computers 1.5.9.21

# Dan200
# http://www.computercraft.info/
solderfile ComputerCraft1.73.jar computer-craft 1.73 # remove?

# AUTOMATIC_MAIDEN, PokeFenn TheCricket26
solderfile Chisel2-2.3.10.37.jar chisel2 2.3.10.37

# Choonster
# http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/2158261-chisel-facades
solderfile ChiselFacades-1.7.10-2.10-cricket.jar chisel-facades 2.10 # out of date, remove?

# Mineshopper
# http://www.carpentersblocks.com/
solderfile "Carpenter's Blocks v3.3.6 - MC 1.7.10.jar" carpenters-blocks 3.3.6

# Nuchaz
# http://www.bibliocraftmod.com/
solderfile BiblioCraft[v1.10.4][MC1.7.10].jar bibliocraft v1.10.4
solderfile BiblioWoods[Forestry][v1.7].jar bibliowoods-forestry v1.7
solderfile BiblioWoods[BiomesOPlenty][v1.9].jar bibliowoods-bop v1.9
solderfile BiblioWoods[Natura][v1.5].jar bibliowoods-natura v1.5

# Alz454
# http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/1292751-enhancedportals-3
solderfile EnhancedPortals_1.7.10-universal-3.0.10.jar enhanced-portals 3.0.10 # remove?

# RWTema
# http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/wip-mods/1443963-extra-utilities-v1-1-0k
solderfile extrautilities-1.2.4c.jar extra-utilities 1.2.4c

# Ganymedes01
# http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/1293528-aobd-2-process-all-the-ores
solderfile AOBD-2.6.0.jar aobd 2.6.0
# http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/1291095-ganys-nether-miscellaneous-nether-themed-additions
solderfile "Ganys Nether-1.8.0.jar" ganys-nether 1.8.0
# http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/2184837-headcrumbs-celebrities-heads-as-dungeon-loot-heads
solderfile Headcrumbs-1.5.1.jar headcrumbs 1.5.1 # remove?
# add surface?  end?

# subaraki
# http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/1288510-1-7-2-smp-ssp-minecraft-graves-die-classy
solderfile GraveStones-1.7.2_1.4.jar gravestones 1.4

# aidancbrady
MEKVER=8.1.2.229
solderfile Mekanism-1.7.10-$MEKVER.jar mekanism $MEKVER
solderfile MekanismGenerators-1.7.10-$MEKVER.jar mekanism-generators $MEKVER # remove?
solderfile MekanismTools-1.7.10-$MEKVER.jar mekanism-tools $MEKVER # remove?

# Mikemoo
# http://www.openmods.info/
solderfile OpenModsLib-1.7.10-0.7.3.jar open-mods-lib 0.7.3
solderfile OpenBlocks-1.7.10-1.4.3.jar open-blocks 1.4.3
solderfile OpenEye-0.6-1.7.10.jar open-eye 0.6
solderfile OpenPeripheral-1.7.10-AIO-4.jar open-peripheral-aio aio-4

# Lumien231
# http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/1289551-1-6-x-1-7-2-1-7-10-random-things-2-1-5
solderfile RandomThings-2.2.4.jar random-things 2.2.4

# CrazyPants, tterrag1098
# http://enderio.com/
solderfile EnderIO-1.7.10-2.2.8.367.jar enderio 2.2.8.367
solderfile EnderZoo-1.7.10-1.0.11.28.jar enderzoo 1.0.11.28

# MrCrayfish
# http://www.mrcrayfish.com/
solderfile 'MrCrayfishFurnitureModv3.4.7(1.7.10).jar' crayfish-furniture 3.4.7 # remove

# MatrexsVigil (Pam)
# http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/1294413-pams-mods-april-8th-harvestcraft-1-7-10h-random
solderfile "Pam's HarvestCraft 1.7.10h.jar" pams-harvestcraft 1.7.10h
solderfile "Pam's BoneCraft 1.7.2b.zip" pams-bonecraft 1.7.2b # remove
solderfile "Pam's Clay Spawn 1.7.2a.zip" pams-clay-spawn 1.7.2a # remove
solderfile "Pam's DesertCraft 1.7.10a.zip" pams-desertcraft 1.7.10a
solderfile "Pam's Get all the Seeds 1.7.2a.zip" pams-get-all-the-seeds 1.7.2a
solderfile "Pam's Mob Drop Crops 1.7.10a.zip" pams-mob-drop-crops 1.7.10a
solderfile "Pam's Random Pants 1.7.2a.zip" pams-random-pants 1.7.2a
solderfile "Pam's Simple Recipes 1.7.2a.zip" pams-simple-recipes 1.7.2a
solderfile "Pam's Temperate Plants 1.7.2b.zip" pams-temperate-plants 1.7.2b
solderfile "Pam's WeeeFlowers 1.7.2b.zip" pams-weeeflowers 1.7.2b # remove

# Squeek502
# http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/2222837-applecore-an-api-for-modifying-the-food-and-hunger
solderfile AppleCore-mc1.7.10-1.1.0.jar apple-core 1.1.0
# http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/1289305-1-6-x-hunger-overhaul
solderfile HungerOverhaul-1.7.10-beta.5.jar hunger-overhaul beta.5
# http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/1295067-waila-harvestability-how-can-i-harvest-what-im
solderfile WailaHarvestability-mc1.7.x-1.1.2.jar waila-harvestability 1.1.2
# http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/2091809-the-spice-of-life-encouraging-dietary-variety
solderfile SpiceOfLife-mc1.7.10-1.2.3.jar spice-of-life 1.2.3
# http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/2181009-squeedometer-adds-a-speedometer-to-your-hud
solderfile Squeedometer-mc1.7.x-1.0.3.jar squeedometer 1.0.3
# http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/2339963-the-vegan-option-adds-vegan-alternatives-for-all
solderfile VeganOption-mc1.7.10-0.1.1.jar vegan-option 0.1.1
# http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/1294501-tic-tooltips-in-game-tinkers-construct-tool
solderfile TiCTooltips-mc1.7.10-1.2.4.jar tic-tooltips 1.2.4

# Iguanaman, Parker8283, Squeek502
http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/2222904-1-7-10-hunger-overhaul

# Divisor
# http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/1274224-smart-moving
stagezipdata "MC 1.7.10 - Smart Moving 15.5.zip"
solderfile --staged SmartMoving-1.7.10-15.5.jar smart-moving 15.5
solderfile --staged SmartRender-1.7.10-2.1.jar smart-moving-render 2.1
# http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/1277996-player-api
stagezipdata "MC 1.7.10 - Player API core 1.3.zip"
solderfile --staged PlayerAPI-1.7.10-1.3.jar player-api-core 1.3
# http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/1283669-render-player-api
stagezipdata "MC 1.7.10 - Render Player API core 1.3.zip"
solderfile --staged --client RenderPlayerAPI-1.7.10-1.3.jar render-player-api-core 1.3
stagezipdata "MC 1.7.10 - Render Player API enhancer 1.3.zip"
solderfile --staged --client RenderPlayerAPIEnhancer-1.7.10-1.3.jar render-player-api-enhancer 1.3

# RiskyKen
# http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/wip-mods/2309193-wip-alpha-armourers-workshop-weapon-armour-skins
solderfile Armourers-Workshop-1.7.10-0.31.2.82.jar amrourers-workshop 0.31.2.82

# Gwafu
# http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/1286298-growthcraft-jul-15-2014-proper-1-7-10-release
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
# remove?

#solderfile MorePlayerModels_1.7.10b.jar more-player-models 1.7.10b

# Mumfrey
# http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/1290155-liteloader-for-minecraft-1-7-10
stagezipdata liteloader-installer-1.7.10-04.jar
solderfile --staged --client liteloader-1.7.10.jar liteloader 1.7.10-04

# Mamiya Otaru
# http://www.liteloader.com/mod/voxelmap
solderfile --client mod_voxelMap_1.5.13_for_1.7.10.litemod voxel-map 1.5.13

# EasyMFnE
# http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/2230009-potioncolorizer-change-the-way-potions-are
solderfile --client mod_PotionColorizer_1.1.0_mc1.7.10.litemod potion-colorizer 1.1.0

# xaero_
# http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/1288520-note-block-display-with-gui
solderfile --client mod_noteblockdisplay_1.3.2_mc1.7.10.litemod note-block-display 1.3.2

# Verdana
# http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/2178137-mine-little-pony-friendship-is-crafting-v1-7-10-1
#solderfile --client mod_minelp_1.7.10.1_mc1.7.10.litemod mine-little-pony 1.7.10.1

# Killjoy1221
# http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/2181597-tabbychat-v1-11-2-smp-chat-overhaul-new-maintainer
solderfile --client TabbyChat-1.7.10-1.11.2.2-fml.jar tabby-chat 1.11.2.2

# Player
# http://forum.industrial-craft.net/index.php?page=Thread&threadID=10820
#solderfile fastcraft-1.21.jar fastcraft 1.21

# Scott Killen
# http://minecraft.curseforge.com/mc-mods/229624-kore-sample
solderfile KoreSample-1.7.10-1.2.5.jar kore-sample 1.2.5
# http://www.curse.com/mc-mods/minecraft/229626-ancient-trees
solderfile AncientTrees-1.7.10-1.3.1.jar ancient-trees 1.3.1
# http://minecraft.curseforge.com/mc-mods/229627-scotts-tweaks
solderfile ScottsTweaks-1.7.10-1.3.0.jar scotts-tweaks 1.3.0


# Thomassu
# http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/1292144-oceancraft-mod-with-whales-sharks-crabs-and-more-1
solderfile Oceancraft-1.4.1.jar oceancraft 1.4.1

# Jiraiyah, css_maya
# http://www.curse.com/mc-mods/minecraft/224220-more-pistons-jiraiyah-version
solderfile MorePistons-1.7.10-1.5.2.0.jar more-pistons 1.5.2.0 # remove

#RadixCore-1.7.x-1.3.3-universal.jar
#SpiderQueenReborn-1.7.10-1.2.2-universal.jar

# John Smith team
# http://js-legacy.net/jstr-modded/
# don't use --client so servermods can do colorsampling if need be
solderfile JSTR-Univ-1.7-0.1.13.zip john-smith-technicians-remix-universal 1.7-0.1.13 resourcepacks

# StanH
# http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/1290366-1-6-4-1-7-x-minetweaker-3-customize-your
solderfile 'MineTweaker3-1.7.10-3.0.9C.jar' mine-tweaker 3.0.9C
# http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/2364943-modtweaker-0-7-x
solderfile 'ModTweaker 2-0.8.1.jar' mod-tweaker2 0.8.1

#solderfile 'coroutil-1.1.2 for MC v1.7.10.jar' coro-util 1.1.2

#stagezipdata 'weather2 v2.3.7 for MC v1.7.10.zip'
#solderfile --staged 'put folder contents in .minecraft or main server path/mods/Weather-2.3.7.jar' weather 2.3.7 mods Weather-2.3.7.jar

#stagezipdata 'zombieawareness v1.9.6 for MC v1.7.10.zip'
#solderfile --staged 'put folder contents in .minecraft or main server path/mods/ZombieAwareness-1.9.6.jar' zombie-awareness 1.9.6 mods ZombieAwareness-1.9.6.jar

# GreatOrator, Brandon3055
# http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/2093099-draconic-evolution-1-0-1rc4
solderfile Draconic-Evolution-1.7.10-v1.0.1a.jar draconic-evolution v1.0.1a # remove

# Tonius
# http://minecraft.curseforge.com/mc-mods/225251-nei-integration
solderfile NEIIntegration-MC1.7.10-1.0.9.jar nei-integration 1.0.9

# DarkHax
# http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/2169830-wawla-what-are-we-looking-at
solderfile Wawla-1.2.1_1.7.10.jar wawla 1.2.1

# Tuhljin
# http://www.curse.com/mc-mods/minecraft/222153-automagy
solderfile Automagy-1.7.10-0.23.jar automagy 0.23

# McJty
# http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/2229562-rftools-dimension-builder-teleportation-crafter
solderfile rftools-2.83.jar rftools 2.83

# BluSunrize
# http://www.curse.com/mc-mods/minecraft/224440-travellers-gear
solderfile TravellersGear-1.7.10-1.16.2.jar travellers-gear 1.16.2 # remove
# http://www.curse.com/mc-mods/minecraft/228268-witching-gadgets
#solderfile WitchingGadgets-1.7.10-1.1.6.jar witching-gadgets 1.1.6


#solderfile CartLivery-1.7.10-0.11.1.jar cart-livery 0.11.1

# tterag1098
# http://www.curse.com/mc-mods/minecraft/226082-ttcore
solderfile ttCore-MC1.7.10-0.1.0-67.jar ttcore 0.1.0-67
# http://www.curse.com/mc-mods/minecraft/226119-waila-plugins
solderfile WAILAPlugins-MC1.7.10-0.0.1-15.jar waila-plugins 0.0.1-15

# Hilburn, Way2muchnoise
# http://minecraft.curseforge.com/mc-mods/225815-notenoughresources
solderfile NotEnoughResources-1.7.10-0.1.0.95.jar not-enough-resources 0.1.0.95

#solderfile NBTEdit_1.7.10.jar nbt-edit 1.7.10-0
#solderfile WailaNBT-1.7.10-1.4.jar waila-nbt 1.4

# ShaneDarkholme
# http://minecraft.curseforge.com/mc-mods/230170-tardis-mod
solderfile tardismod-1.7.10-0.97-48.jar tardismod 0.97-48
# http://www.curse.com/mc-mods/minecraft/230156-darkcore
solderfile darkcore-0.2-16.jar dark-core 0.2-16

# Streuner91
# http://www.curse.com/mc-mods/minecraft/226797-magical-crops-compat-minefactory-reloaded
solderfile "MFR Compat - Magical Crops v1-2-1.jar" mine-factory-reloaded-compat-magical-crops 1.7.10-1.2.1
#solderfile MineFactoryReloaded-CompatMagicalCrops.jar mine-factory-reloaded-compat-magical-crops 1.7.10

) #| egrep '^[0-9]+$' | zenity --progress --auto-close --auto-kill --text 'Generating TechnicSolder packages and SQL from simple JARs'

if [ $? -ne 0 ]; then
    echo -e "\\033[1;31mExiting because build failed\\033[0m" >& 2
    exit 1
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
    recommended='$MPVERSION',
    latest='$MPVERSION',
    updated_at=now();

EOF

rsync -acvzP --bwlimit=256k $p/ mcmods@kuu.accela.net:/var/www/mcmods/TechnicSolder/public/repo/mods

ssh mcmods@kuu.accela.net sh -c 'mysql < /var/www/mcmods/TechnicSolder/public/repo/mods/mod.sql'

# end
