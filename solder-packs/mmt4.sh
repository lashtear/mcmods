#! /bin/bash

MPNAME=mmt4
MPSLUG=mmt4
MPVERSION=0.8.6

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

if [ "$1" = "reset" ]; then
    ( cd $HOME/git/mmt4-conf.git; git tag -d mmt4-$MPVERSION )
    ( cd $HOME/git/mechanipus-resource-pack.git; git tag -d mmt4-$MPVERSION )
    exit 0
fi

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
setauthors Lashtear
seturl http://mechanipus.com/
( cd $HOME/git/mmt4-conf.git; git tag mmt4-$MPVERSION )
if [ $? -ne 0 ]; then
    echo tag failed >&2
    exit 1
fi
gitfile "$HOME/git/mmt4-conf.git" magitech-config "$MPVERSION"
( cd $HOME/git/mechanipus-resource-pack.git; git tag mmt4-$MPVERSION )
if [ $? -ne 0 ]; then
    echo tag failed >&2
    exit 1
fi
stagegitfile "$HOME/git/mechanipus-resource-pack.git" mechanipus "$MPVERSION"
solderfile --staged --client mechanipus.zip mechanipus-resource-pack-mmt4 "$MPVERSION" resourcepacks mechanipus.zip
setauthors "lex manos"
seturl http://files.minecraftforge.net/
solderfile --server forge-1.7.10-10.13.4.1614-1.7.10-installer.jar forge-installer 10.13.4.1614 .
solderfile --client forge-1.7.10-10.13.4.1614-1.7.10-universal.jar forge 10.13.4.1614 bin modpack.jar

setauthors chickenbones
seturl http://files.minecraftforge.net/CodeChickenLib/
solderfile CodeChickenLib-1.7.10-1.1.3.140-universal.jar code-chicken-lib 1.1.3.140 mods/1.7.10
seturl http://files.minecraftforge.net/ForgeMultipart/
solderfile ForgeMultipart-1.7.10-1.2.0.345-universal.jar forge-multi-part 1.2.0.345 mods/1.7.10
seturl http://chickenbones.net/Pages/links.html
solderfile CodeChickenCore-1.7.10-1.0.7.47-universal.jar code-chicken-core 1.0.7.47
solderfile NotEnoughItems-1.7.10-1.0.5.118-universal.jar not-enough-items 1.0.5.118
solderfile ChickenChunks-1.7.10-1.3.4.19-universal.jar chicken-chunks 1.3.4.19
solderfile EnderStorage-1.7.10-1.4.7.38-universal.jar ender-storage 1.4.7.38
solderfile Translocator-1.7.10-1.1.2.16-universal.jar translocator 1.1.2.16

setauthors "Cult of the Full Hub"
seturl http://teamcofh.com/
solderfile CoFHCore-[1.7.10]3.1.1-324.jar cofhcore 3.1.1-324
solderfile ThermalDynamics-[1.7.10]1.1.0-161.jar thermal-dynamics 1.1.0-161
solderfile ThermalExpansion-[1.7.10]4.1.1-237.jar thermal-expansion 4.1.1-237
solderfile ThermalFoundation-[1.7.10]1.2.2-111.jar thermal-foundation 1.2.2-111
solderfile MineFactoryReloaded-[1.7.10]2.8.1-174.jar mine-factory-reloaded 2.8.1-174
solderfile NetherOres-[1.7.10]2.3.1-22.jar nether-ores 2.3.1-22
solderfile CoFHLib-[1.7.10]1.1.1-181.jar cofh-lib 1.1.1-181 mods/1.7.10

setauthors "Adubbz and Forstride"
seturl http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/1286162-biomes-o-plenty-over-75-new-biomes-plants-and-more
solderfile BiomesOPlenty-1.7.10-2.1.0.1640-universal.jar biomes-o-plenty 2.1.0.1640

#setauthors "MisterFiber, Forstride, Annysia, Allaryin, et al"
#seturl http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/1282126-extrabiomesxl-universal-3-16-2-for-mc-1-7-10
#solderfile extrabiomesxl_1.7.10-3.16.2.jar extrabiomes-xl 3.16.2

#setauthors "sdj64, zombiepig, Fabricator77"
#seturl http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/2104582-forge-highlands-2-2-3-updated-february-19
#solderfile Highlands-1.7.2-v-2.2.3.jar highlands 2.2.3

#setauthors TTFTCUTS
#seturl http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/1291067-atg-alternate-terrain-generation
#solderfile ATG-1.7.10-0.12.0.jar atg 0.12.0

setauthors "Prof Mobius"
seturl http://minecraft.curseforge.com/members/ProfMobius/projects
solderfile AdminCommandsToolbox-0.0.2a_1.7.10.jar admin-commands-toolbox 0.0.2a
#/pregen <dim> <minX> <maxX> <minZ> <maxZ> : Generate a portion of world between chunk coordinates [minX,maxX] and [minZ,maxZ]
#/purgechunks : This command will try to free as many chunks as possible.
#/setspawn <x> <y> <z> : Set the default spawn position at [x,y,z]
#/pregenspawn <nchunks> : Will generate nchunks in all directions centered on spawn (Overworld only)
solderfile Jabba-1.2.1a_1.7.10.jar jabba 1.2.1a
solderfile MobiusCore-1.2.5_1.7.10.jar mobius-core 1.2.5
solderfile Waila-1.5.10_1.7.10.jar waila 1.5.10
#solderfile Evoc_1.0.0a.jar evoc 1.0.0a
solderfile Opis-1.2.5_1.7.10.jar opis 1.2.5
#solderfile RPGAdvMod-1.0.0_1.7.10.jar rpg-adv-mod 1.0.0

#setauthors "RazzleberryFox"
#seturl http://minecraft.curseforge.com/mc-mods/79616-decocraft2
#solderfile Decocraft-2.2.1_1.7.10.jar decocraft 2.2.1

#setauthors bspkrs
#seturl http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/1282347-bspkrs-mods-armorstatushud-directionhud
#solderfile [1.7.10]bspkrsCore-universal-6.16.jar bspkrs-core 6.16 mods/1.7.10
#solderfile --client [1.7.10]ArmorStatusHUD-client-1.28.jar armor-status-hud 1.28
#solderfile --client [1.7.10]StatusEffectHUD-client-1.27.jar status-effect-hud 1.27

#setauthors "DaftPVF, bspkrs"
#seturl http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/1281180-daftpvfs-mods-treecapitator-crystalwing
#solderfile [1.7.10]Treecapitator-universal-2.0.4.jar treecapitator 2.0.4

setauthors Aroma1997
seturl http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/1287828-aroma1997s-mods-betterchests-mining-world-mod
solderfile Aroma1997Core-1.7.10-1.0.2.16.jar aroma-core 1.0.2.16
solderfile AromaBackup-1.7.10-0.0.0.6.jar aroma-backup 0.0.0.6
solderfile BetterChests-1.7.10-1.1.1.9.jar better-chests 1.1.1.9
solderfile Aroma1997s-Dimensional-World-1.7.10-1.1.0.1.jar dimensional-world 1.1.0.1

setauthors "Team Metallurgy"
seturl http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/1295123-metallurgy-4
solderfile Metallurgy-1.7.10-4.0.8.97.jar metallurgy 4.0.8.97
solderfile MetallurgyCore-1.7.10-4.0.4.18.jar metallurgy-core 4.0.4.18

setauthors Glassmaker
seturl http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/2529492-metallurgychisel
solderfile MetallurgyChisel-1.7.10-1.0.0.11.jar metallurgy-chisel 1.0.0.11

setauthors "mDiyo, boni"
seturl http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/2218638-tinkers-construct
solderfile Mantle-1.7.10-0.3.2b.jar mantle 0.3.2b
solderfile TConstruct-1.7.10-1.8.8.jar tinkers-construct 1.8.8

setauthors "Iguana, TheOldOne, boni"
seturl http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/2176855-iguanas-tinker-tweaks
solderfile IguanaTinkerTweaks-1.7.10-2.1.5.jar iguana-tinker-tweaks 2.1.5
#/dumpTools
#Dumps all tools items it can find into a file to use for the Override module.

setauthors Glassmaker
seturl http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/wip-mods/1445212-extratic-tinkers-construct-mod-support-add-on
solderfile ExtraTiC-1.7.10-1.4.5.jar extra-tic 1.4.5

setauthors "mDiyo, progwml6"
seturl http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/1294968-natura
solderfile natura-1.7.10-2.2.0.1.jar natura 2.2.0.1

setauthors myrathi
seturl http://forum.feed-the-beast.com/threads/myrathis-mod-compendium.18505/
#solderfile FlatSigns-1.7.10-universal-2.1.0.19.jar flat-signs 2.1.0.19
solderfile ObsidiPlates-1.7.10-universal-3.0.0.18.jar obsidiplates 3.0.0.18

setauthors AlgorithmX2
seturl http://ae-mod.info/
solderfile appliedenergistics2-rv2-stable-10.jar applied-energistics 2-rv2-stable-10

setauthors "M3gaFr3ak, drummermc, leonelf"
seturl http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/1289077-ae-add-on-m3gas-extracells-2-1-x-2-2-x
solderfile ExtraCells-1.7.10-2.3.8b185.jar extra-cells 2.3.8b185

#setauthors Azanor
#seturl http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/1292130-thaumcraft-4-2-3-5-updated-2015-2-17
#solderfile Thaumcraft-1.7.10-4.2.3.5.jar thaumcraft 4.2.3.5
#seturl http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/1294623-baubles-1-1-1-0-updated-2015-3-2
solderfile Baubles-1.7.10-1.0.1.10.jar baubles 1.0.1.10 mods/1.7.10

#setauthors Nividica
#seturl http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/wip-mods/2150151-1-7-10-tc4-ae2-thaumic-energistics
#solderfile thaumicenergistics-1.0.0.1-RV2.jar thaumic-energistics 1.0.0.1-RV2

#setauthors "The flogat, Mordenkainen3141"
#seturl http://minecraft.curseforge.com/mc-mods/229912-technomancy
#solderfile "Technomancy - 0.12.4 - 1.7.10.jar" technomancy 0.12.4

# setauthors Joshiejack
# seturl http://minecraft.curseforge.com/mc-mods/76612-enchiridion
# solderfile "Enchiridion 2-1.7.10-2.0.1.jar" enchiridion 2.0.1
# needed for mariculture, has a nice book binder thing

#setauthors SpitefulFox
#seturl http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/wip-mods/1445828-tc4-addon-forbidden-magic-v0-562-prerelease
#solderfile "Forbidden Magic-1.7.10-0.573.jar" forbidden-magic 0.573

#setauthors Ganymedes01
#seturl http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/1292852-thaumcraftgates-tc4-bc6-thaumium-pipes
#solderfile ThaumcraftGates-1.4.0.jar thaumcraft-gates 1.4.0

#setauthors Flaxbeard
#seturl http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/wip-mods/1445786-1-6-4-1-7-10-thaumic-exploration-0-6-0-thaumcraft
#solderfile ThaumicExploration-1.7.10-1.1-53.jar thaumic-exploration 1.1-53

#setauthors "Vazkii, Pixlepix, Nekosune"
#seturl http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/1289299-thaumic-tinkerer-thaumcraft-addon-evolve-knowledge
#solderfile ThaumicTinkerer-2.5-1.7.10-470.jar thaumic-tinkerer 2.5-1.7.10-470

#setauthors DjGiannuzz
#seturl http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/2237271-1-6-4-1-7-10-thaumcraft-nei-plugin-nei
#solderfile thaumcraftneiplugin-1.7.10-1.7a.jar thaumcraft-nei-plugin 1.7a

#setauthors dyonovan
#seturl http://www.curse.com/mc-mods/minecraft/227328-thaumcraft-node-tracker
#solderfile tcnodetracker-1.7.10-1.1.2.jar thaumcraft-nodetracker 1.1.2

#setauthors TheKentington
#seturl http://www.curse.com/mc-mods/minecraft/227914-thaumic-horizons
#solderfile thaumichorizons-1.7.10-1.1.9.jar thaumic-horizons 1.1.9

setauthors Vazkii
seturl http://botaniamod.net/
solderfile "Botania r1.8-248.jar" botania r1.8-248

#setauthors WayofTime
#seturl http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/1290532-1-7-10-2-1-6-4-blood-magic-v1-3-2-1-updated-apr
#solderfile BloodMagic-1.7.10-1.3.3-17.jar blood-magic 1.3.3-17

# Benimatic
# http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/1276258-the-twilight-forest-v2-3-5-wrecking-block
#solderfile twilightforest-1.7.10-2.3.5.jar twilight-forest 2.3.5 # remove?

# XCompWiz
# http://binarymage.com/wiki/doku.php?id=start
#solderfile mystcraft-1.7.10-0.11.0.00.jar mystcraft 0.11.0.00 # remove?

#setauthors Mark719
#seturl http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/1287451-magical-crops-farm-your-resources-3-2-0-who-stole
#seturl http://www.curse.com/mc-mods/minecraft/228834-magical-crops
#solderfile magicalcrops-4.0.0_PUBLIC_BETA_3.jar magical-craps 4.0.0b3 # remove?

setauthors Emoniph
seturl https://sites.google.com/site/witcherymod/
solderfile witchery-1.7.10-0.24.1.jar witchery 0.24.1

#setauthors "SirSengir, CovertJaguar, MysteriousAges, mezz"
#seturl http://forestry.sengir.net/wiki.new/doku.php
#solderfile forestry_1.7.10-3.6.9.28.jar forestry 3.6.9.28
#seturl http://forestryforminecraft.info/
#solderfile forestry_1.7.10-4.2.6.54.jar forestry 4.2.6.54

#setauthors Binnie
#seturl http://binnie.mods.wiki/wiki/Main_Page http://minecraft.curseforge.com/mc-mods/223525-binnies-mods
#solderfile binnie-mods-2.0-pre14.jar binnie-mods 2.0-pre14

#setauthors Arkandos
#seturl https://bitbucket.org/Arkandos/magic-bees
#solderfile magicbees-1.7.10-2.1.22.jar magic-bees 2.1.22

setauthors BDew
seturl http://bdew.net/
solderfile bdlib-1.9.4.109-mc1.7.10.jar bdlib 1.9.4.109
#solderfile gendustry-1.6.3.132-mc1.7.10.jar gendustry 1.6.3.132
solderfile neiaddons-1.12.13.38-mc1.7.10.jar neiaddons 1.12.13.38
solderfile pressure-1.2.5.125-mc1.7.10.jar pressure 1.2.5.125
solderfile generators-0.9.19.120-mc1.7.10.jar generators 0.9.19.120
solderfile ae2stuff-0.5.0.56-mc1.7.10.jar ae2stuff 0.5.0.56

setauthors CovertJaguar
seturl http://www.railcraft.info/
solderfile Railcraft_1.7.10-9.8.0.0.jar railcraft 9.8.0.0

#setauthors copygirl
#seturl http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/wip-mods/1442380-betterstorage-0-13-1-126-wip
#solderfile BetterStorage-1.7.10-0.13.1.127.jar better-storage 0.13.1.127

#setauthors "SpaceToad, asie, Vexatos"
seturl http://mod-buildcraft.com/
solderfile buildcraft-7.1.14.jar buildcraft 7.1.14
solderfile buildcraft-compat-7.1.3.jar buildcraft-compat 7.1.3

# these have been persistently buggy
setauthors "asie, Vexatos"
seturl http://wiki.vex.tty.sh/start
solderfile AsieLib-1.7.10-0.4.5.jar asie-lib 0.4.5
solderfile Computronics-1.7.10-1.6.0.jar computronics 1.6.0

setauthors "MrTJP, Chickenbones"
seturl http://projectredwiki.com/wiki/Main_Page
#solderfile ForgeRelocation-0.0.1.4-universal.jar forge-relocation 0.0.1.4a mods/1.7.10
#solderfile ForgeRelocationFMP-0.0.1.2-universal.jar forge-relocation-fmp 0.0.1.2a mods/1.7.10
solderfile MrTJPCore-1.1.0.33-universal.jar mr-tjp-core 1.1.0.33 mods/1.7.10
PROJREDVER=4.7.0pre12.95
for redmod in Base Compat Fabrication Integration Lighting; do
    solderfile ProjectRed-1.7.10-$PROJREDVER-$redmod.jar projectred-$(echo $redmod | tr A-Z a-z) $PROJREDVER
done

setauthors Kobata
seturl https://inventory-tweaks.readthedocs.org/en/latest/
solderfile InventoryTweaks-1.58-147.jar inventory-tweaks 1.58-147

#setauthors Erogenous Beef
#seturl http://www.big-reactors.com/#/
#solderfile BigReactors-0.4.3A.jar big-reactors 0.4.3A

setauthors Sangar
seturl http://www.curse.com/mc-mods/minecraft/223008-opencomputers
solderfile OpenComputers-MC1.7.10-1.5.22.43-universal.jar open-computers 1.5.22.43

setauthors Sangar
seturl http://minecraft.curseforge.com/projects/tis-3d
solderfile TIS-3D-MC1.7.10-0.8.2.62.jar tis-3d 0.8.2.62

setauthors "AUTOMATIC_MAIDEN, asie, PokeFenn, TheCricket26, Drullkus, tterrag1098, parcel31u, Minecreatr"
seturl http://minecraft.curseforge.com/projects/chisel
solderfile Chisel-2.9.4.10.jar chisel 2.9.4.10

setauthors Mineshopper
seturl http://www.carpentersblocks.com/
solderfile "Carpenter's Blocks v3.3.7 - MC 1.7.10.jar" carpenters-blocks 3.3.7

#setauthors LordMau5
#seturl http://minecraft.curseforge.com/projects/ffs-fancy-fluid-storage
#solderfile "Fancy Fluid Storage-1.7.10-1.3.5.60.jar" fancy-fluid-storage 1.3.5.60

setauthors Nuchaz
seturl http://www.bibliocraftmod.com/
solderfile BiblioCraft[v1.11.4][MC1.7.10].jar bibliocraft v1.11.4
solderfile BiblioWoods[BiomesOPlenty][v1.9].jar bibliowoods-bop v1.9
#solderfile BiblioWoods[ExtraBiomesXL][v1.4].jar bibliowoods-extrabiomes-xl v1.4
#solderfile BiblioWoods[Forestry][v1.7].jar bibliowoods-forestry v1.7
#solderfile BiblioWoods[Highlands][v1.4].jar bibliowoods-highlands v1.4
solderfile BiblioWoods[Natura][v1.5].jar bibliowoods-natura v1.5

#setauthors Alz454
#seturl http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/1292751-enhancedportals-3
#solderfile EnhancedPortals_1.7.10-universal-3.0.12.jar enhanced-portals 3.0.12

setauthors RWTema
seturl http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/wip-mods/1443963-extra-utilities-v1-1-0k
solderfile extrautilities-1.2.12.jar extra-utilities 1.2.12

setauthors Ganymedes01
seturl http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/1293528-aobd-2-process-all-the-ores
solderfile AOBD-2.9.1.jar aobd 2.9.1
#seturl http://www.curse.com/mc-mods/minecraft/230292-another-one-bites-the-dust-berry-bushes
#solderfile AOBDBB-1.0.5.jar aobd-bb 1.0.5
seturl http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/1291095-ganys-nether-miscellaneous-nether-themed-additions
solderfile "Ganys Nether-1.8.3.jar" ganys-nether 1.8.3

#setauthors subaraki
#seturl http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/1288510-1-7-2-smp-ssp-minecraft-graves-die-classy
# GraveStones-1.7.2_1.4.jar gravestones 1.4

setauthors aidancbrady
seturl http://aidancbrady.com/mekanism/download/
MEKVER=8.1.8.258
solderfile Mekanism-1.7.10-$MEKVER.jar mekanism $MEKVER
solderfile MekanismGenerators-1.7.10-$MEKVER.jar mekanism-generators $MEKVER
#solderfile MekanismTools-1.7.10-$MEKVER.jar mekanism-tools $MEKVER # remove?

setauthors Mikemoo
seturl http://www.openmods.info/
solderfile OpenModsLib-1.7.10-0.9.jar open-mods-lib 0.9
solderfile OpenBlocks-1.7.10-1.5.jar open-blocks 1.5
solderfile OpenPeripheral-1.7.10-AIO-6.jar open-peripheral-aio aio-6
seturl http://openeye.openmods.info/download
solderfile OpenEye-0.6-1.7.10.jar open-eye 0.6

setauthors Lumien231
seturl http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/1289551-1-6-x-1-7-2-1-7-10-random-things-2-1-5
solderfile RandomThings-2.2.4.jar random-things 2.2.4
seturl http://minecraft.curseforge.com/projects/extended-potions
solderfile ExtendedPotions-MC1.7.10-1.2.jar extended-potions 1.2

setauthors "CrazyPants, tterrag1098"
seturl http://enderio.com/
solderfile EnderIO-1.7.10-2.3.0.422_beta.jar enderio 2.3.0.422_beta
seturl http://minecraft.curseforge.com/projects/endercore
solderfile EnderCore-1.7.10-0.2.0.31_beta.jar endercore 0.2.0.31_beta mods/1.7.10
#solderfile EnderZoo-1.7.10-1.0.15.32.jar enderzoo 1.0.15.32

#setauthors tterrag1098
#seturl http://minecraft.curseforge.com/projects/super-massive-tech
#solderfile SuperMassiveTech-MC1.7.10-0.4.0-beta-114.jar super-massive-tech 0.4.0-beta-114

setauthors "Henry Loenwind"
seturl http://minecraft.curseforge.com/projects/ender-io-addons
solderfile EnderIOAddons-1.7.10-2.3.0.422_beta-0.10.3.046_beta.jar enderio-addons 2.3.0.422_beta-0.10.3.046_beta

setauthors "MatrexsVigil (Pam)"
seturl http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/1294413-pams-mods-april-8th-harvestcraft-1-7-10h-random
solderfile "Pam's HarvestCraft 1.7.10Lb.jar" pams-harvestcraft 1.7.10Lb
solderfile "Pam's Simple Recipes 1.7.10a.jar" pams-simple-recipes 1.7.10a
solderfile "Pam's Harvest the Nether 1.7.10a.jar" pams-harvest-the-nether 1.7.10a

setauthors Squeek502
seturl http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/2222837-applecore-an-api-for-modifying-the-food-and-hunger
solderfile AppleCore-mc1.7.10-1.3.0.jar apple-core 1.3.0
seturl http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/1295067-waila-harvestability-how-can-i-harvest-what-im
solderfile WailaHarvestability-mc1.7.10-1.1.6.jar waila-harvestability 1.1.6
#seturl http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/2091809-the-spice-of-life-encouraging-dietary-variety
#solderfile SpiceOfLife-mc1.7.10-1.2.4.jar spice-of-life 1.2.4
#seturl http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/2181009-squeedometer-adds-a-speedometer-to-your-hud
#solderfile Squeedometer-mc1.7.x-1.0.3.jar squeedometer 1.0.3
seturl http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/2339963-the-vegan-option-adds-vegan-alternatives-for-all
solderfile VeganOption-mc1.7.10-0.1.2.jar vegan-option 0.1.2
seturl http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/1294501-tic-tooltips-in-game-tinkers-construct-tool
solderfile TiCTooltips-mc1.7.10-1.2.5.jar tic-tooltips 1.2.5
#setauthors "Iguanaman, Parker8283, Squeek502"
#seturl http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/2222904-1-7-10-hunger-overhaul
#solderfile HungerOverhaul-1.7.10-1.0.0.jar hunger-overhaul 1.0.0
setauthors "Iguanaman, Parker8283"
seturl http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/1295224-1-7-10-iguana-tweaks
solderfile IguanaTweaks-1.7.10-2B.jar iguana-tweaks 1.7.10-2B

setauthors Divisor
seturl http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/1274224-smart-moving
stagezipdata "MC 1.7.10 - Smart Moving 15.6.zip"
solderfile --staged SmartMoving-1.7.10-15.6.jar smart-moving 15.6
solderfile --staged SmartRender-1.7.10-2.1.jar smart-moving-render 2.1
seturl http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/1277996-player-api
stagezipdata "MC 1.7.10 - Player API core 1.4.zip"
solderfile --staged PlayerAPI-1.7.10-1.4.jar player-api-core 1.4
seturl http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/1283669-render-player-api
stagezipdata "MC 1.7.10 - Render Player API core 1.4.zip"
solderfile --staged --client RenderPlayerAPI-1.7.10-1.4.jar render-player-api-core 1.4
stagezipdata "MC 1.7.10 - Render Player API enhancer 1.4.zip"
solderfile --staged --client RenderPlayerAPIEnhancer-1.7.10-1.4.jar render-player-api-enhancer 1.4

#setauthors RiskyKen
#seturl http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/wip-mods/2309193-wip-alpha-armourers-workshop-weapon-armour-skins
#solderfile Armourers-Workshop-1.7.10-0.31.2.82.jar armourers-workshop 0.31.2.82

#setauthors Gwafu
#seturl http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/1286298-growthcraft-jul-15-2014-proper-1-7-10-release
#stagezipdata Growthcraft-1.7.10.zip
#solderfile --staged growthcraft-core-1.7.10-2.1.0a.jar growthcraft-core 2.1.0a
#solderfile --staged growthcraft-bamboo-1.7.10-2.1.0.jar growthcraft-bamboo 2.1.0
#solderfile --staged growthcraft-bees-1.7.10-2.1.0.jar growthcraft-bees 2.1.0
#solderfile --staged growthcraft-cellar-1.7.10-2.1.0a.jar growthcraft-cellar 2.1.0a
#solderfile --staged growthcraft-fishtrap-1.7.10-2.1.0a.jar growthcraft-fishtrap 2.1.0a
#solderfile --staged growthcraft-grapes-1.7.10-2.1.0.jar growthcraft-grapes 2.1.0
#solderfile --staged growthcraft-hops-1.7.10-2.1.0.jar growthcraft-hops 2.1.0
#solderfile --staged growthcraft-rice-1.7.10-2.1.0a.jar growthcraft-rice 2.1.0a
#solderfile --staged growthcraft-apples-1.7.10-2.1.0.jar growthcraft-apples 2.1.0
# disabled because of forge incompatibilities and author on hiatus :(

# Noppes
# http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/1291730-more-player-models-2-adds-a-character-creation
#solderfile MorePlayerModels_1.7.10b.jar more-player-models 1.7.10b
# awesome idea.  Buggy as hell.

#setauthors Mumfrey
#seturl http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/1290155-liteloader-for-minecraft-1-7-10
#stagezipdata liteloader-installer-1.7.10-04.jar
#solderfile --staged --client liteloader-1.7.10.jar liteloader 1.7.10-04

#setauthors Mamiya Otaru
#seturl http://www.liteloader.com/mod/voxelmap
#solderfile --client mod_voxelMap_1.5.13_for_1.7.10.litemod voxel-map 1.5.13

#setauthors xaero_
#seturl http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/1288520-note-block-display-with-gui
#solderfile --client mod_noteblockdisplay_1.3.2_mc1.7.10.litemod note-block-display 1.3.2

#setauthors Verdana
#seturl http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/2178137-mine-little-pony-friendship-is-crafting-v1-7-10-1
#solderfile --client mod_minelp_1.7.10.1_mc1.7.10.litemod mine-little-pony 1.7.10.1
# it's commented out, chill :P

setauthors Player
seturl 'http://forum.industrial-craft.net/index.php?page=Thread&threadID=10820'
solderfile fastcraft-1.21.jar fastcraft 1.21

setauthors "Scott Killen"
seturl http://minecraft.curseforge.com/mc-mods/229624-kore-sample
solderfile KoreSample-1.7.10-1.3.2.jar kore-sample 1.3.2
seturl http://www.curse.com/mc-mods/minecraft/229626-ancient-trees
solderfile AncientTrees-1.7.10-1.6.4.jar ancient-trees 1.6.4
seturl http://minecraft.curseforge.com/mc-mods/229627-scotts-tweaks
solderfile ScottsTweaks-1.7.10-1.3.1.jar scotts-tweaks 1.3.1

# Thomassu
# http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/1292144-oceancraft-mod-with-whales-sharks-crabs-and-more-1
#solderfile Oceancraft-1.4.1.jar oceancraft 1.4.1

# Jiraiyah, css_maya
# http://www.curse.com/mc-mods/minecraft/224220-more-pistons-jiraiyah-version
#solderfile MorePistons-1.7.10-1.5.2.0.jar more-pistons 1.5.2.0 # remove
# we have pistronics instead

setauthors "John Smith team"
seturl http://js-legacy.net/jstr-modded/
solderfile --client JSTR-Univ-1.7-0.1.17.zip john-smith-technicians-remix-universal 1.7-0.1.17 resourcepacks

setauthors StanH
seturl http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/1290366-1-6-4-1-7-x-minetweaker-3-customize-your
solderfile MineTweaker3-1.7.10-3.0.10B.jar mine-tweaker 3.0.10B
seturl http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/2364943-modtweaker-0-7-x
solderfile ModTweaker2-0.9.5.jar mod-tweaker2 0.9.5

#solderfile 'coroutil-1.1.2 for MC v1.7.10.jar' coro-util 1.1.2

#stagezipdata 'weather2 v2.3.7 for MC v1.7.10.zip'
#solderfile --staged 'put folder contents in .minecraft or main server path/mods/Weather-2.3.7.jar' weather 2.3.7 mods Weather-2.3.7.jar

#stagezipdata 'zombieawareness v1.9.6 for MC v1.7.10.zip'
#solderfile --staged 'put folder contents in .minecraft or main server path/mods/ZombieAwareness-1.9.6.jar' zombie-awareness 1.9.6 mods ZombieAwareness-1.9.6.jar

# GreatOrator, Brandon3055
# http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/2093099-draconic-evolution-1-0-1rc4
#solderfile Draconic-Evolution-1.7.10-v1.0.1a.jar draconic-evolution v1.0.1a # remove

setauthors Tonius
seturl http://minecraft.curseforge.com/mc-mods/225251-nei-integration
solderfile NEIIntegration-MC1.7.10-1.1.1.jar nei-integration 1.1.1

setauthors DarkHax
seturl http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/2169830-wawla-what-are-we-looking-at
solderfile Wawla-1.3.3-1.7.10.jar wawla 1.3.3

#setauthors Tuhljin
#seturl http://www.curse.com/mc-mods/minecraft/222153-automagy
#solderfile Automagy-1.7.10-0.27.1.jar automagy 0.27.1

setauthors McJty
seturl http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/2229562-rftools-dimension-builder-teleportation-crafter
solderfile mcjtylib-1.8.1.jar mcjtylib 1.8.1 mods/1.7.10
solderfile rftools-4.21.jar rftools 4.21

#setauthors BluSunrize
#seturl http://www.curse.com/mc-mods/minecraft/224440-travellers-gear
#solderfile TravellersGear-1.7.10-1.16.4.jar travellers-gear 1.16.4
#seturl http://www.curse.com/mc-mods/minecraft/228268-witching-gadgets
#solderfile WitchingGadgets-1.7.10-1.1.9.jar witching-gadgets 1.1.9

setauthors tterag1098
# endercore supercedes and implements ttCore
seturl http://www.curse.com/mc-mods/minecraft/226119-waila-plugins
solderfile WAILAPlugins-MC1.7.10-0.2.0-23.jar waila-plugins 0.2.0-23

setauthors "Hilburn, Way2muchnoise"
seturl http://minecraft.curseforge.com/mc-mods/225815-notenoughresources
solderfile NotEnoughResources-1.7.10-0.1.0-121.jar not-enough-resources 0.1.0-121

setauthors ShaneDarkholme
seturl http://minecraft.curseforge.com/mc-mods/230170-tardis-mod
solderfile tardismod-1.7.10-0.994-124-DS.jar tardismod 0.994-124-DS
seturl http://www.curse.com/mc-mods/minecraft/230156-darkcore
solderfile darkcore-0.3-86.jar dark-core 0.3-86

setauthors jaquadro
seturl http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/2198533-storage-drawers-v1-6-2-v2-1-9-updated-sep-23-15
solderfile StorageDrawers-1.7.10-1.7.7.jar storage-drawers 1.7.7
solderfile StorageDrawers-BiomesOPlenty-1.7.10-1.1.1.jar storage-drawers-bop 1.1.1
#solderfile StorageDrawers-Forestry-1.7.10-1.1.1.jar storage-drawers-forestry 1.1.1
solderfile StorageDrawers-Misc-1.7.10-1.1.1.jar storage-drawers-misc 1.1.1
solderfile StorageDrawers-Natura-1.7.10-1.1.1.jar storage-drawers-natura 1.1.1

seturl http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/2163513-garden-stuff-v-1-6-3-updated-june-01-15
solderfile GardenStuff-1.7.10-1.7.0.jar garden-stuff 1.7.0

#setauthors "fossils revival team"
#seturl http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/2398119-fossils-and-archeology-revival-build-7-2-1-the
# https://www.skydaz.com/fossils-and-archeology-revival-mod-installer-for-minecraft-1-7-10/
#solderfile Fossils_Archeology_Revival-1.7.10_Build-7.2.1.jar fossils-archeology-revival 7.2.1

#setauthor Funwayguy
#seturl https://github.com/Funwayguy/EnviroMine/wiki/Downloads
#solderfile EnviroMine-1.3.122.jar enviromine 1.3.122

#setauthors SanAndreasP
#seturl http://azminecraft.info/clay-soldiers-mod-for-mc/
#solderfile SAPManPack-1.7.10-2.5.1.jar sap-man-pack 2.5.1
#solderfile Clay-Soldiers-Mod-1.7.10.zip clay-soldiers 1.7.10

#setauthors InfinityRaider
#seturl http://minecraft.curseforge.com/projects/agricraft
#solderfile AgriCraft-1.7.10-1.4.6-hotfix.jar agricraft 1.4.6-hotfix

setauthors Zeno410
seturl http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/1292179-1-8-1-7-x-1-6-x-1-5-2-explorercraft-0-9-multimap
solderfile ExplorerCraft-0.9.8f.jar explorer-craft 0.9.8f
seturl http://minecraft.curseforge.com/projects/undergroundbiomesconstructs/files/2225709
solderfile UndergroundBiomesConstructs-1.7.2-0.7.jar underground-biomes-constructs 0.7

#setauthors EdgarAllen
#seturl http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/1290201-edgarallens-mods-super-crafting-frame
#solderfile supercraftingframe-1.7.10.3.jar super-crafting-frame 1.7.10.3

#setauthors "CyanideX, lorddusk"
#seturl http://minecraft.curseforge.com/projects/bagginses
#solderfile Bagginses-2.1.1.jar bagginses 2.1.1

setauthors WhiskyTangoFox
seturl http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/2365907-whiskytangofoxs-mods-cavebiomes-wtfs-tweaks-now

solderfile "WTFCore-1.7.10_v1.66.jar" wtf-core 1.66
solderfile "TextureGeneratorLib-1.7.10_vBeta2.jar" texture-generator-lib Beta2
solderfile "WTFCaveBiomes-1.7.10_v1.53.jar" wtf-cave-biomes 1.53
solderfile "WTFOres-1.7.10v1.46.jar" wtf-ores 1.46
solderfile "WTFTweaks-1.7.10_v1.3.jar" wtf-tweaks 1.3
#solderfile "ClashsoftLib-1.7.10-2.7.3.jar" clashsoft-lib 2.7.3
#solderfile "WTFCrops-1.7.10_Beta1.jar" wtf-crops Beta1

setauthors ted80
seturl http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/1281910-teds-world-gen-mods-realistic-world-gen-alpha-1-3
solderfile RWG-alpha-1.3.2.jar realistic-world-gen alpha-1.3.2

setauthors wirsbo
seturl http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/2134067-better-rain-v0-15-bug-fixes
stagezipdata betterrain-1.7.2-1.7.10_0.15.zip
solderfile --staged betterrain-1.7.2-1.7.10_0.15.jar betterrain 0.15a
solderfile --staged betterrain-1.7.2-1.7.10_0.15-core.jar betterrain-core 0.15a

#setauthors mithion
#seturl http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/1292222-ars-magica-2-version-1-4-0-008-updated-february-6
#solderfile "1.7.10_AM2-1.4.0.008.jar" ars-magica2 1.4.0.008

#setauthors thehippomaster21
#seturl http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/1289836-animationapi-animate-your-entities-v1-2-3
#solderfile AnimationAPI-1.7.10-1.2.4.jar animation-api 1.2.4

#setauthors pixlepix
#seturl http://minecraft.curseforge.com/projects/aura-cascade
#solderfile AuraCascade-557.jar aura-cascade 557

#setauthors 4headtiger
#seturl http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/wip-mods/2158282-realistic-fluids-overhaul-finite-water-and-stuff
#solderfile "FiniteFluids 1.7.10 Concept Mod.jar" finite-fluids 1.7.10-concept

#setauthors Lumaceon
#seturl http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/2288839-clockwork-phase-1-7-10_1-0-time-magic-all-wrapped
#solderfile "clockworkphase-1.7.10_1.0f.jar" clockworkphase 1.0f

#setauthors mikeprimm
#seturl http://minecraft.curseforge.com/projects/dynmapforge
#solderfile --server Dynmap-2.2-forge-1.7.10.jar dynmap-forge 2.2

#setauthors abastro
#seturl http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/wip-mods/1444983-wip-stellar-mods-real-constellations-sun-moon
#solderfile "SciAPI v0.5.2.jar" sci-api v0.5.2
#solderfile "Stellarium v0.1.5 [1.7.10].jar" stellarium v0.1.5
#solderfile "Stellar Sky-v0.1.14[1.7.10].jar" stellar-sky v0.1.14

setauthors draco18s
seturl http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/1291999-unique-artifacts-powerful-randomly-generated-items
solderfile Artifacts-1.1.3.jar artifacts 1.1.3
solderfile --client "Artifacts 32x Icons.zip" artifacts-32x-icons 0 resourcepacks
#seturl http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/2379886-micromod-rail-bridges
#solderfile 1.7.10-RailBridges-3.0.0.jar rail-bridges 3.0.0
#seturl http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/1288280-1-4-7-1-6-x-1-7-10-phase-stone-updated-to-v4-1
#solderfile 1.7.10-PhaseBlocks-4.1.0.jar phase-blocks 4.1.0

#setauthors popsnorkle
#seturl http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/2425859-ore-dowsing-mod-dowsing-rods-highlight-nearby-ores
#solderfile OreDowsing-1.7.10-0.6.jar ore-dowsing 0.6

#setauthors "Jeff Martin"
#seturl https://www.cuchazinteractive.com/ships/
#solderfile shipsMod-v1.7.10-1.0.4.jar ships-mod 1.0.4

#GALACTICVER=3.0.11.333
#setauthors MicDoodle8
#seturl http://micdoodle8.com/mods/galacticraft/downloads
#solderfile GalacticraftCore-1.7-$GALACTICVER.jar galacticraft-core $GALACTICVER
#solderfile Galacticraft-Planets-1.7-$GALACTICVER.jar galacticraft-planets $GALACTICVER
#solderfile MicdoodleCore-1.7-$GALACTICVER.jar micdoodle-core $GALACTICVER

setauthors Karob
seturl http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/1278469-the-bigtrees-mod
solderfile BigTrees-172b-forge1060.jar bigtrees mc172b-f1060

#setauthors iPixeli
#seturl http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/1273164-ipixelis-gender-mod
#solderfile [1.7.10]Gender-1.0.2.jar gender 1.0.2

#setauthors FyberOptic
#seturl http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/1291075-1-5-x-1-6-x-1-7-x-1-8-hopper-ducts-mod
#solderfile hopperductmod-1.7.10-1.3.2.jar hopper-duct-mod 1.3.2

setauthors "Matthew Prenger"
seturl http://www.curse.com/mc-mods/minecraft/223797-helpfixer
solderfile HelpFixer-1.0.7.jar help-fixer 1.0.7

setauthors Letiu
seturl http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/1294844-pistronics-2-modular-pistons-rotators-and-statues
solderfile 1.7.10-Pistronics2-v0.5.8.jar pistronics2 v0.5.8

setauthors nakranoth
seturl http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/1287964-herdcraft-1-0-making-mobs-smarter-since-2012
solderfile HerdCraft-1.7.10-1.1.jar herdcraft 1.1

setauthors "Mr_Hazard, BluSunrize"
seturl http://minecraft.curseforge.com/projects/immersive-engineering
solderfile ImmersiveEngineering-0.7.1.2.jar immersive-engineering 0.7.1.2
setauthors UnwrittenFun
seturl http://minecraft.curseforge.com/projects/immersive-integration
solderfile immersiveintegration-0.6.6.jar immersive-integration 0.6.6
#setauthors "Mangoose, HuggableCreep"
#seturl http://minecraft.curseforge.com/projects/arcane-engineering
#solderfile arcane_engineering-0.2.6.jar arcane-engineering 0.2.6

setauthors victorious3
seturl http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/wip-mods/2352247-integrated-circuits-alpha-ics-for-minecraft
solderfile integratedcircuits-1.7.10-0.9r37c.jar integrated-circuits 0.9.r37c

setauthors ordinastie
seturl http://minecraft.curseforge.com/projects/malisiscore
solderfile malisiscore-1.7.10-0.14.1.jar malisis-core 0.14.1
seturl http://minecraft.curseforge.com/projects/malisisdoors
solderfile malisisdoors-1.7.10-1.13.0.jar malisis-doors 1.13.0

#setauthors "andykuo1 et al"
#seturl http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/mod-packs/1289173-mc-mods-satchels-turtles-quivers-and-more
#solderfile "[1.7.10][1.5] MC+ ModPack - Development I.jar" mcplus 1.5

setauthors delvr
seturl http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/2346379-streams-real-flowing-rivers
solderfile Streams-0.1.6.jar streams 0.1.6
solderfile Farseek-1.0.10.jar farseek 1.0.10
#solderfile Repose-1.2.4.jar repose 1.2.4

setauthors "d00dv4d3r, kolt666, AtomikStryker"
seturl http://atomicstryker.net/ruins.php
stagezipdata Ruins-1.7.10.zip
solderfile --staged mods/Ruins-1.7.10.jar ruins 1.7.10 mods Ruins-1.7.10.jar
solderfile --staged mods/resources ruins-resources 1.7.10 mods resources

#setauthors wildbamaboy
#seturl http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/2467085-spider-queen-v1-0-2-spider-queen-is-back-the-way
#solderfile RadixCore-1.7.10-2.0.3-universal.jar radix-core 2.0.3
#solderfile SpiderQueen-1.7.10-1.0.2-universal.jar spider-queen 1.0.2
# soooon

setauthors Octarine_noise
seturl http://minecraft.curseforge.com/projects/better-foliage
solderfile BetterFoliage-MC1.7.10-2.0.3.jar better-foliage 2.0.3

#setauthors "danxnitro, karyonix"
#seturl http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/1286604-shaders-mod-updated-by-karyonix
#solderfile ShadersModCore-v2.3.28-mc1.7.10-f.jar shaders-mod v2.3.28

#setauthors Dolu1990
#seturl http://electrical-age.net/
#solderfile ElectricalAge_BETA-1.10_r50.jar electrical-age beta-1.10_r50

setauthors JakimFett
seturl https://jakimfett.github.io/Minechem/
solderfile Minechem-1.7.10-5.0.5.406.jar minechem 5.0.5.406

#setauthors MineMaarten
#seturl http://www.curse.com/mc-mods/minecraft/223815-in-game-wiki-mod
#solderfile IGW-Mod-1.7.10-1.1.11-32-universal.jar in-game-wiki 1.1.11-32

#setauthors Click_me
#seturl http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/1294958-no-cubes-1-0-realistic-graphics
#solderfile noCubes-1.0.jar nocubes 1.0

#setauthors ReikaKalseki
#seturl https://sites.google.com/site/reikasminecraft/
#solderfile 'DragonAPI 1.7.10 V10d.jar' dragonapi V10d
#solderfile 'ElectriCraft 1.7.10 V10b.jar' electricraft V10b
#solderfile 'ReactorCraft 1.7.10 V10d.jar' reactorcraft V10d
#solderfile 'RotaryCraft 1.7.10 V10d.jar' rotarycraft V10d
#solderfile 'VoidMonster 1.7.10 V10a.jar' voidmonster V10a

# ==== tail

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

#/tp ~ ~ ~ 0 0 for panorama_0
#/tp ~ ~ ~ 90 0 for 1
#/tp ~ ~ ~ 180 0 for 2
#/tp ~ ~ ~ 270 0 for 3
#/tp ~ ~ ~ 0 -90 for 4
#/tp ~ ~ ~ 0 90 for 5

# end

