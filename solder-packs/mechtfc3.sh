#! /bin/bash

MPNAME=mechtfc3
MPSLUG=mechtfc3
MPVERSION=0.1.28

s=../mods-as-distributed
st=staging
u=unpacked
p=mods
sv=servermods

sjtotal=$(( $(egrep '^(solder|git)file ' $0 |wc -l) + 3 ))
sjdone=0

. pkg-mod-lib.sh

rm -rf $u $p $st $sv
mkdir -p $p

if [ "$1" = "reset" ]; then
    ( cd $HOME/git/mechtfc3-conf.git; git tag -d mechtfc3-$MPVERSION )
    ( cd $HOME/git/mechanipus-resource-pack.git; git tag -d mechtfc3-$MPVERSION )
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
( cd $HOME/git/mechtfc3-conf.git; git tag mechtfc3-$MPVERSION )
if [ $? -ne 0 ]; then
    echo tag failed >&2
    exit 1
fi
gitfile "$HOME/git/mechtfc3-conf.git" mechtfc3-config "$MPVERSION"
( cd $HOME/git/mechanipus-resource-pack.git; git tag mechtfc3-$MPVERSION )
if [ $? -ne 0 ]; then
    echo tag failed >&2
    exit 1
fi
stagegitfile "$HOME/git/mechanipus-resource-pack.git" mechanipus "$MPVERSION"
solderfile --staged --client mechanipus.zip mechanipus-resource-pack-mechtfc3 "$MPVERSION" resourcepacks mechanipus.zip
setauthors "lex manos"
seturl http://files.minecraftforge.net/
solderfile --server forge-1.7.10-10.13.4.1614-1.7.10-installer.jar forge-installer 10.13.4.1614 .
solderfile --client forge-1.7.10-10.13.4.1614-1.7.10-universal.jar forge 10.13.4.1614 bin modpack.jar

setauthors "bioxx, kittychanley"
seturl http://terrafirmacraft.com/f/download.html/
#solderfile '[1.7.10]TerraFirmaCraft-0.79.29.922.jar' terra-firma-craft 0.79.29.922
solderfile '[1.7.10]TerraFirmaCraft-0.79.29-local6.jar' terra-firma-craft 0.79.29.922-local6

setauthors "bletch, udary"
seturl http://terrafirmacraft.com/f/topic/7587-tfc-07926-udary-mod-galenalimonite-extraction-ingame-alloy-calculator-tucker-bag-evaporator-pan-drying-mat/
solderfile '[1.7.10]TFCUdaryMod-0.2.31.jar' tfc-udary 0.2.31

setauthors sladki
seturl http://terrafirmacraft.com/f/topic/7990-tfc-07924-automated-bellows-addon/
solderfile '[1.7.10]TFCAutomatedBellowsAddon-1.03.jar' tfc-automated-bellows 1.03
seturl http://terrafirmacraft.com/f/topic/8083-tfc-07924-cellars-addon/
solderfile '[1.7.10]TFCCellarsAddon-1.010.jar' tfc-cellars 1.010

setauthors "bunsan, anodecathode, copygirl"
seturl http://terrafirmacraft.com/f/topic/8891-tfc-07926betterstorage-tfc/
solderfile BetterStorage-1.7.10-0.13.1.131-TFC.jar better-storage-tfc 0.13.1.131-tfc
setauthors "bunsan, anodecathode"
seturl http://terrafirmacraft.com/f/topic/8944-07926-toomuchtime-tfc/
solderfile TooMuchTime-1.7.10-2.4.0.tnfc-4-universal.jar too-much-time 2.4.0.tnfc-4

setauthors vidaj
seturl http://terrafirmacraft.com/f/topic/8288-tfc-07925-tfcrailcraft/
solderfile tfcrailcraft-0.2.0.jar tfc-railcraft 0.2.0

#setauthors hunternif
#seturl http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/1292324-antique-atlas
#solderfile antiqueatlas-1.7.10-4.2.10.jar antique-atlas 4.2.10

setauthors delvr
seturl http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/2346379-streams-real-flowing-rivers
solderfile Streams-0.2.jar streams 0.2
solderfile Farseek-1.0.11.jar farseek 1.0.11

setauthors awger
seturl http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/wip-mods/1442761-wip-small-boats-elegant-punt-whitehall
solderfile smallboats-1.7.10-10.13.0-16.1.jar smallboats 10.13.0-16.1

setauthors raymondbh
seturl http://terrafirmacraft.com/f/topic/8498-tfc-07923-tfc-additions-104/
solderfile '[1.7.10][0.79.23+]TFC-Additions-1.0.4.jar' tfc-additions 1.0.4

setauthors JAWolfe
seturl http://terrafirmacraft.com/f/topic/9297-tfc-07928-tfc-tweaker-minetweaker-compatibility-for-tfc/
solderfile TFCTweaker-1.7.10-0.01.01.jar tfc-tweaker 0.01.01

setauthors miamia
seturl http://terrafirmacraft.com/f/topic/8389-tfc-07923-tfc-scales-divide-your-food-precisely/
solderfile '[1.7.10]TFCScales-1.0.2.jar' tfc-scales 1.0.2

setauthors Dries007
seturl http://terrafirmacraft.com/f/topic/8578-tfc-07926-tfc-tweaks-unifies-water-auto-food-merge-on-pickup/
solderfile TFC-Tweaks-1.7.10-0.4.0.17.jar tfc-tweaks 0.4.0.17
seturl http://terrafirmacraft.com/f/topic/6733-tfc-07923-terrafirmacraft-nei-plugin/
solderfile TerraFirmaCraftNEIplugin-1.7.10-1.5.3.25.jar tfc-nei-plugin 1.5.3.25

setauthors bunsan
seturl http://terrafirmacraft.com/f/topic/9153-07928-terrafirmastuff/
solderfile '[1.7.10]terrafirmastuff-0.1.4.jar' terrafirma-stuff 0.1.4

setauthors TaeoG
seturl http://terrafirmacraft.com/f/topic/8687-tfc-07924-animal-crate/
solderfile animalcrate-0.1.jar animal-crate 0.1

setauthors Emris
seturl http://terrafirmacraft.com/f/topic/3460-tfc-07923-leather-water-sac-for-tfc/
solderfile '[1.7.10]LeatherWaterSac-3.9.B79.jar' leather-water-sac 3.9.B79

setauthors aleksey_t
seturl http://terrafirmacraft.com/f/topic/7694-tfc-07923-decorations-addon-for-tfc/
solderfile '[1.7.10]Decorations-1.0.20.jar' tfc-decorations 1.0.20
seturl http://terrafirmacraft.com/f/topic/7563-tfc-07923-merchants-addon-for-tfc/
solderfile '[1.7.10]Merchants-1.1.3.jar' tfc-merchants 1.1.3
solderfile '[1.7.10]Merchants-Containers-1.0.1.jar' tfc-merchants-containers 1.0.1

# I love this, but it's kinda buggy and source doesn't seem to be available
#setauthors powerman913717
#seturl http://terrafirmacraft.com/f/topic/8401-tfc-079260111terramisc-random-stuff-and-things-for-tfc/
#solderfile '[1.7.10]TerraMisc-0.11.1.jar' terra-misc 0.11.1

setauthors konlii
seturl http://terrafirmacraft.com/f/topic/8041-tfc-07928-fingerinthewind-so-you-know-how-hot-it-is/
solderfile --client '[TFC-79.28]FingerInTheWind-1.2.1.jar' tfc-finger-in-the-wind 1.2.1

setauthors chickenbones
seturl http://files.minecraftforge.net/CodeChickenLib/
solderfile CodeChickenLib-1.7.10-1.1.3.140-universal.jar code-chicken-lib 1.1.3.140 mods/1.7.10
seturl http://files.minecraftforge.net/ForgeMultipart/
solderfile ForgeMultipart-1.7.10-1.2.0.345-universal.jar forge-multi-part 1.2.0.345 mods/1.7.10
seturl http://chickenbones.net/Pages/links.html
solderfile CodeChickenCore-1.7.10-1.0.7.47-universal.jar code-chicken-core 1.0.7.47
solderfile NotEnoughItems-1.7.10-1.0.5.120-universal.jar not-enough-items 1.0.5.120
solderfile ChickenChunks-1.7.10-1.3.4.19-universal.jar chicken-chunks 1.3.4.19
#solderfile EnderStorage-1.7.10-1.4.7.38-universal.jar ender-storage 1.4.7.38
solderfile Translocator-1.7.10-1.1.2.16-universal.jar translocator 1.1.2.16

setauthors "Cult of the Full Hub"
seturl http://teamcofh.com/
solderfile CoFHCore-[1.7.10]3.1.3-327.jar cofhcore 3.1.3-327
#solderfile ThermalDynamics-[1.7.10]1.1.0-161.jar thermal-dynamics 1.1.0-161
#solderfile ThermalExpansion-[1.7.10]4.1.1-237.jar thermal-expansion 4.1.1-237
solderfile ThermalFoundation-[1.7.10]1.2.5-115.jar thermal-foundation 1.2.5-115
#solderfile MineFactoryReloaded-[1.7.10]2.8.1-174.jar mine-factory-reloaded 2.8.1-174
#solderfile NetherOres-[1.7.10]2.3.1-22.jar nether-ores 2.3.1-22
solderfile CoFHLib-[1.7.10]1.1.2-182.jar cofh-lib 1.1.2-182 mods/1.7.10
#solderfile TabulaRasa-[1.7.10]1.0.1-3.jar tabula-rasa 1.0.1-3

setauthors "Prof Mobius"
seturl http://minecraft.curseforge.com/members/ProfMobius/projects
solderfile AdminCommandsToolbox-0.0.2a_1.7.10.jar admin-commands-toolbox 0.0.2a
#/pregen <dim> <minX> <maxX> <minZ> <maxZ> : Generate a portion of world between chunk coordinates [minX,maxX] and [minZ,maxZ]
#/purgechunks : This command will try to free as many chunks as possible.
#/setspawn <x> <y> <z> : Set the default spawn position at [x,y,z]
#/pregenspawn <nchunks> : Will generate nchunks in all directions centered on spawn (Overworld only)
#solderfile Jabba-1.2.1a_1.7.10.jar jabba 1.2.1a
solderfile MobiusCore-1.2.5_1.7.10.jar mobius-core 1.2.5
solderfile Waila-1.5.10_1.7.10.jar waila 1.5.10
#solderfile Evoc_1.0.0a.jar evoc 1.0.0a
solderfile Opis-1.2.5_1.7.10.jar opis 1.2.5
#solderfile RPGAdvMod-1.0.0_1.7.10.jar rpg-adv-mod 1.0.0

setauthors AlgorithmX2
seturl http://ae-mod.info/
solderfile appliedenergistics2-rv2-stable-10.jar applied-energistics 2-rv2-stable-10

#setauthors "M3gaFr3ak, drummermc, leonelf"
#seturl http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/1289077-ae-add-on-m3gas-extracells-2-1-x-2-2-x
#solderfile ExtraCells-1.7.10-2.3.8b185.jar extra-cells 2.3.8b185

#setauthors Azanor
#seturl http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/1294623-baubles-1-1-1-0-updated-2015-3-2
#solderfile Baubles-1.7.10-1.0.1.10.jar baubles 1.0.1.10 mods/1.7.10

#setauthors Vazkii
#seturl http://botaniamod.net/
#solderfile "Botania r1.8-248.jar" botania r1.8-248

#setauthors WayofTime
#seturl http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/1290532-1-7-10-2-1-6-4-blood-magic-v1-3-2-1-updated-apr
#solderfile BloodMagic-1.7.10-1.3.3-17.jar blood-magic 1.3.3-17

#setauthors BDew
#seturl http://bdew.net/
#solderfile bdlib-1.9.4.109-mc1.7.10.jar bdlib 1.9.4.109
##solderfile gendustry-1.6.3.132-mc1.7.10.jar gendustry 1.6.3.132
#solderfile neiaddons-1.12.13.38-mc1.7.10.jar neiaddons 1.12.13.38
#solderfile pressure-1.2.5.125-mc1.7.10.jar pressure 1.2.5.125
#solderfile generators-0.9.19.120-mc1.7.10.jar generators 0.9.19.120
#solderfile ae2stuff-0.5.0.56-mc1.7.10.jar ae2stuff 0.5.0.56

setauthors CovertJaguar
seturl http://www.railcraft.info/
solderfile Railcraft_1.7.10-9.12.2.0.jar railcraft 9.12.2.0

#setauthors "SpaceToad, asie, Vexatos"
#seturl http://mod-buildcraft.com/
#solderfile buildcraft-7.1.14.jar buildcraft 7.1.14
#solderfile buildcraft-compat-7.1.3.jar buildcraft-compat 7.1.3

setauthors "MrTJP, Chickenbones"
seturl http://projectredwiki.com/wiki/Main_Page
#solderfile ForgeRelocation-0.0.1.4-universal.jar forge-relocation 0.0.1.4a mods/1.7.10
#solderfile ForgeRelocationFMP-0.0.1.2-universal.jar forge-relocation-fmp 0.0.1.2a mods/1.7.10
solderfile MrTJPCore-1.1.0.33-universal.jar mr-tjp-core 1.1.0.33 mods/1.7.10
PROJREDVER=4.7.0pre12.95
for redmod in Base Compat Integration ; do
    solderfile ProjectRed-1.7.10-$PROJREDVER-$redmod.jar projectred-$(echo $redmod | tr A-Z a-z) $PROJREDVER
done

setauthors Sangar
seturl http://www.curse.com/mc-mods/minecraft/223008-opencomputers
solderfile OpenComputers-MC1.7.10-1.6.0.6-beta.4-universal.jar open-computers 1.6.0.6-beta.4
seturl http://minecraft.curseforge.com/projects/tis-3d
solderfile TIS-3D-MC1.7.10-0.9.0.66.jar tis-3d 0.9.0.66

setauthors "AUTOMATIC_MAIDEN, asie, PokeFenn, TheCricket26, Drullkus, tterrag1098, parcel31u, Minecreatr"
seturl http://minecraft.curseforge.com/projects/chisel
solderfile Chisel-2.9.4.10.jar chisel 2.9.4.10

setauthors Mineshopper
seturl http://www.carpentersblocks.com/
solderfile "Carpenter's Blocks v3.3.7 - MC 1.7.10.jar" carpenters-blocks 3.3.7

setauthors Nuchaz
seturl http://www.bibliocraftmod.com/
solderfile BiblioCraft[v1.11.5][MC1.7.10].jar bibliocraft v1.11.5
solderfile BiblioWoods[TerraFirmaCraftV0.79.23][v1.2].jar bibliowoods-tfc v1.2

setauthors Mikemoo
seturl http://www.openmods.info/
solderfile OpenModsLib-1.7.10-0.9.jar open-mods-lib 0.9
solderfile OpenBlocks-1.7.10-1.5.jar open-blocks 1.5
seturl http://openeye.openmods.info/download
solderfile OpenEye-0.6-1.7.10.jar open-eye 0.6

#setauthors Lumien231
#seturl http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/1289551-1-6-x-1-7-2-1-7-10-random-things-2-1-5
#solderfile RandomThings-2.2.4.jar random-things 2.2.4

setauthors Squeek502
seturl http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/1295067-waila-harvestability-how-can-i-harvest-what-im
solderfile WailaHarvestability-mc1.7.10-1.1.6.jar waila-harvestability 1.1.6
setauthors "Iguanaman, Parker8283"
seturl http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/1295224-1-7-10-iguana-tweaks
solderfile IguanaTweaks-1.7.10-2B.jar iguana-tweaks 1.7.10-2B

# awesome idea.  Buggy as hell.
# http://www.kodevelopment.nl/minecraft/moreplayermodels/downloads/
setauthors Noppes
seturl http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/1291730-more-player-models-2-adds-a-character-creation
solderfile MorePlayerModels_1.7.10b.jar more-player-models 1.7.10b

setauthors Mumfrey
seturl http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/1290155-liteloader-for-minecraft-1-7-10
stagezipdata liteloader-installer-1.7.10-04.jar
solderfile --staged --client liteloader-1.7.10.jar liteloader 1.7.10-04

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
solderfile fastcraft-1.23.jar fastcraft 1.23

setauthors "John Smith team"
seturl http://js-legacy.net/jstr-modded/
solderfile --client JSTR-Univ-1.7-0.1.17.zip john-smith-technicians-remix-universal 1.7-0.1.17 resourcepacks

setauthors "Vattic, faithful"
seturl tfc-forum
solderfile --client '[79.8] Faithful TFC.zip' vattic-faithful-tfc 79.8 resourcepacks

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

setauthors Tonius
seturl http://minecraft.curseforge.com/mc-mods/225251-nei-integration
solderfile NEIIntegration-MC1.7.10-1.1.2.jar nei-integration 1.1.2

setauthors DarkHax
seturl http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/2169830-wawla-what-are-we-looking-at
solderfile Wawla-1.0.5.120.jar wawla 1.0.5.120

setauthors "Hilburn, Way2muchnoise"
seturl http://minecraft.curseforge.com/mc-mods/225815-notenoughresources
solderfile NotEnoughResources-1.7.10-0.1.0-121.jar not-enough-resources 0.1.0-121

setauthors jaquadro
seturl http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/2198533-storage-drawers-v1-6-2-v2-1-9-updated-sep-23-15
solderfile StorageDrawers-1.7.10-1.9.8.jar storage-drawers 1.9.8

setauthors Zeno410
seturl http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/1292179-1-8-1-7-x-1-6-x-1-5-2-explorercraft-0-9-multimap
solderfile ExplorerCraft-0.9.8f.jar explorer-craft 0.9.8f

setauthors EdgarAllen
seturl http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/1290201-edgarallens-mods-super-crafting-frame
solderfile supercraftingframe-1.7.10.3.jar super-crafting-frame 1.7.10.3

#setauthors "CyanideX, lorddusk"
#seturl http://minecraft.curseforge.com/projects/bagginses
#solderfile Bagginses-2.1.1.jar bagginses 2.1.1

setauthors wirsbo
seturl http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/2134067-better-rain-v0-15-bug-fixes
stagezipdata betterrain-1.7.2-1.7.10_0.15.zip
solderfile --staged betterrain-1.7.2-1.7.10_0.15.jar betterrain 0.15a
solderfile --staged betterrain-1.7.2-1.7.10_0.15-core.jar betterrain-core 0.15a

#setauthors thehippomaster21
#seturl http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/1289836-animationapi-animate-your-entities-v1-2-3
#solderfile AnimationAPI-1.7.10-1.2.4.jar animation-api 1.2.4

#setauthors abastro
#seturl http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/wip-mods/1444983-wip-stellar-mods-real-constellations-sun-moon
#solderfile "SciAPI v0.5.2.jar" sci-api v0.5.2
#solderfile "Stellarium v0.1.5 [1.7.10].jar" stellarium v0.1.5
#solderfile "Stellar Sky-v0.1.14[1.7.10].jar" stellar-sky v0.1.14

#setauthors iPixeli
#seturl http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/1273164-ipixelis-gender-mod
#solderfile [1.7.10]Gender-1.0.2.jar gender 1.0.2

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
solderfile ImmersiveEngineering-0.7.7.jar immersive-engineering 0.7.7
setauthors UnwrittenFun
seturl http://minecraft.curseforge.com/projects/immersive-integration
solderfile immersiveintegration-0.6.8.jar immersive-integration 0.6.8

#setauthors victorious3
#seturl http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/wip-mods/2352247-integrated-circuits-alpha-ics-for-minecraft
#solderfile integratedcircuits-1.7.10-0.9r37c.jar integrated-circuits 0.9.r37c

setauthors ordinastie
seturl http://minecraft.curseforge.com/projects/malisiscore
solderfile malisiscore-1.7.10-0.14.1.jar malisis-core 0.14.1
seturl http://minecraft.curseforge.com/projects/malisisdoors
solderfile malisisdoors-1.7.10-1.13.0.jar malisis-doors 1.13.0

#setauthors "d00dv4d3r, kolt666, AtomicStryker"
#seturl http://atomicstryker.net/ruins.php
#stagezipdata Ruins-1.7.10.zip
#solderfile --staged mods/Ruins-1.7.10.jar ruins 1.7.10-baremod mods Ruins-1.7.10.jar
#solderfile --staged mods/resources ruins-resources 1.7.10 mods resources

setauthors AtomicStryker
seturl http://atomicstryker.net/dynamiclights.php
stagezipdata DynamicLights-1.7.10.zip
solderfile --staged --client mods/DynamicLights-1.7.10.jar dynamic-lights 1.7.10 mods DynamicLights-1.7.10.jar

setauthors Octarine_noise
seturl http://minecraft.curseforge.com/projects/better-foliage
solderfile BetterFoliage-MC1.7.10-2.0.9.jar better-foliage 2.0.9

setauthors Dolu1990
seturl http://electrical-age.net/
solderfile ElectricalAge_BETA-1.11_r51.jar electrical-age beta-1.11_r51

setauthors cout970
seturl http://minecraft.curseforge.com/projects/magneticraft
solderfile magneticraft-0.6.1-final.jar magneticraft 0.6.1

setauthors ZLainSama
seturl http://minecraft.curseforge.com/projects/peacefulsurface
solderfile PeacefulSurface-1.7.x-v7.jar peaceful-surface 1.7.x-v7

setauthors CreativeMD
seturl http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/2076336-itemphysic-1-3-1-updated-1-9-4-more-realtistic
solderfile 'ItemPhysic Full 1.2.4 mc1.7.10.jar' item-phsyic-full 1.2.4
seturl https://github.com/CreativeMD/CreativeCore
solderfile 'CreativeCore v1.3.24 mc1.7.10.jar' creative-core 1.3.24

setauthors "id_miner, Parker8283, superckl, Blargerist"
# http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/1283267-blockphysics-mod
seturl http://mods.curse.com/mc-mods/minecraft/229921-blockphysics
solderfile BlockPhysics-0.9.5.jar block-physics 0.9.5
seturl http://mods.curse.com/mc-mods/minecraft/229587-bnbgaminglib
solderfile BNBGamingLib-2.3.2.jar bnb-gaming-lib 2.3.2

setauthors 10paktimbits
seturl http://10paksmods.net/
solderfile plantmegapack-4.33-1.7.10-1492.jar plant-mega-pack 1.7.10-4.33-1492

#setauthors denoflions
#seturl http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/2196459-1-7-10-inpure-projects-denoflions-mods
#solderfile INpureCore-[1.7.10]1.0.0B9-62.jar inpure-core 1.0.0B9-62
#solderfile CreeperCollateral-[1.7.10]1.0.0B3-15.jar

setauthors davidee
seturl http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/1286750-in-game-nbtedit-edit-mob-spawners-attributes-in
solderfile NBTEdit_1.7.10.jar nbt-edit 1.7.10

#setauthors Jaquadro
#seturl http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/2163513-garden-stuff-v-1-7-0-updated-dec-06-15
#solderfile GardenStuff-local0.jar garden-stuff local0

setauthors OreCruncher
seturl http://minecraft.curseforge.com/projects/dynamic-surroundings
solderfile DynamicSurroundings-1.7.10-1.0.5.6.jar dynamic-surroundings 1.0.5.6

setauthors Tmtravlr
seturl http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/2158080-sound-filters-a-client-side-mod-adds-reverb-to
solderfile --client SoundFilters-0.8_for_1.7.X.jar sound-filters 0.8

setauthors Hurricaaane
seturl http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/1290546-presence-footsteps-an-overly-complicated-sound
stagezipdata PresenceFootsteps_r5b__1_7_10.zip
solderfile --staged --client mods/1.7.10/PresenceFootsteps_r5b__1.7.10.litemod presence-footsteps 1.7.10-r5b-2 1.7.10 PresenceFootsteps_r5b__1.7.10.litemod
solderfile --staged --client resourcepacks/PresenceFootstepsOfficial.zip presence-footsteps-resourcepack 1.7.10-r5b resourcepacks PresenceFootstepsOfficial.zip

setauthors Cirom
seturl http://terrafirmacraft.com/f/topic/7230-tfc-07915-presence-footsteps-r5-terrafirmacraft-block-addon-v11/
solderfile 'TerraFirmaCraft Custom Footsteps 1.1.zip' tfc-custom-footsteps 1.1 resourcepacks

setauthors sk89q
seturl https://minecraft.curseforge.com/projects/worldedit
# wiki at http://wiki.sk89q.com/wiki/WorldEdit
solderfile worldedit-forge-mc1.7.10-6.1.1-dist.jar world-edit 1.7.10-6.1.1

setauthors mumfrey
seturl http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/1292886-worldeditcui
solderfile --client mod_worldeditcui_1.7.10_00_mc1.7.10.litemod world-edit-cui 1.7.10_00

setauthors ivorforce
seturl https://mods.curse.com/mc-mods/minecraft/224600-ye-gamol-chattels
solderfile YeGamolChattels-1.1.2.jar ye-gamol-chattels 1.1.2
seturl https://mods.curse.com/mc-mods/minecraft/224535-ivtoolkit
solderfile IvToolkit-1.2.1.jar iv-toolkit 1.2.1

setauthors RazzleberryFox
seturl http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/1292016-decocraft-2-2-decorations-for-minecraft-finally
solderfile Decocraft-2.3.3_1.7.10.jar decocraft 2.3.3

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

