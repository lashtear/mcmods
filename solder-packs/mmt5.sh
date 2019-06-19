#! /bin/bash

MPNAME=mmt5
MPSLUG=mmt5
MPVERSION=0.2.0
MCVERSION=1.12.2

TAG="$MPNAME-$MPVERSION"

s=../mods-as-distributed
st=staging
u=unpacked
p=mods
sv=servermods

sjtotal=$(( $(egrep '^(solder|git)file ' $0 |wc -l) ))
sjdone=0

. pkg-mod-lib.sh

rm -rf $u $p $st $sv
mkdir -p $p

if [ "$1" = "reset" ]; then
    ( cd $HOME/git/$MPNAME-conf.git; git tag -d "$TAG" )
    ( cd $HOME/git/mechanipus-resource-pack.git; git tag -d "$TAG" )
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
      '$MCVERSION', NULL, 1, 0,
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
( cd $HOME/git/$MPNAME-conf.git; git tag "$TAG" )
if [ $? -ne 0 ]; then
    echo tag failed >&2
    exit 1
fi
gitfile "$HOME/git/$MPNAME-conf.git" $MPNAME-config "$MPVERSION"
( cd $HOME/git/mechanipus-resource-pack.git; git tag "$TAG" )
if [ $? -ne 0 ]; then
    echo tag failed >&2
    exit 1
fi
stagegitfile "$HOME/git/mechanipus-resource-pack.git" mechanipus "$MPVERSION"
solderfile --staged --client mechanipus.zip mechanipus-resource-pack-$MPNAME "$MPVERSION" resourcepacks mechanipus.zip

setauthors "lex manos"
seturl http://files.minecraftforge.net/
solderfile --server forge-1.12.2-14.23.4.2705-installer.jar forge-installer 14.23.4.2705 .
solderfile --client forge-1.12.2-14.23.4.2705-universal.jar forge 14.23.4.2705 bin modpack.jar

setauthors "chicken_bones, covers1624"
seturl https://www.curseforge.com/minecraft/mc-mods/codechicken-lib-1-8
solderfile ChickenChunks-1.12.2-2.4.1.71-universal.jar chicken-chunks 2.4.1.71
solderfile CodeChickenLib-1.12.2-3.2.0.345-universal.jar code-chicken-lib 3.2.0.345
#solderfile NotEnoughItems-1.12.2-2.4.1.233-universal.jar not-enough-items 2.4.1.233
#solderfile Translocators-1.12.2-2.5.0.73-universal.jar translocators 2.5.0.73
solderfile EnderStorage-1.12.2-2.4.4.132-universal.jar ender-storage 2.4.4.132
solderfile ForgeMultipart-1.12.2-2.4.2.60-universal.jar forge-multipart 2.4.2.60

setauthors TeamCOFH
seturl https://teamcofh.com/
solderfile RedstoneFlux-1.12-2.0.2.3-universal.jar redstone-flux 2.0.2.3
solderfile CoFHCore-1.12.2-4.5.2.19-universal.jar cofh-core 4.5.2.19
solderfile CoFHWorld-1.12.2-1.2.0.5-universal.jar cofh-world 1.2.0.5
solderfile ThermalCultivation-1.12.2-0.3.0.7-universal.jar thermal-cultivation 0.3.0.7
solderfile ThermalDynamics-1.12.2-2.5.1.14-universal.jar thermal-dynamics 2.5.1.14
solderfile ThermalExpansion-1.12.2-5.5.0.29-universal.jar thermal-expansion 5.5.0.29
solderfile ThermalFoundation-1.12.2-2.5.0.19-universal.jar thermal-foundation 2.5.0.19
# solderfile RedstoneArsenal-1.12.2-2.5.1.13-universal.jar redstone-arsenal 2.5.1.13
solderfile NoNVFlash-1.12.2-1.2.0.3-universal.jar no-nv-flash 1.2.0.3

setauthors "tterrag1098, Drullkus, Minecreatr"
seturl https://minecraft.curseforge.com/projects/ctm
solderfile CTM-MC1.12-0.3.0.15.jar connected-textures 0.3.0.15
seturl https://minecraft.curseforge.com/projects/chisel
solderfile Chisel-MC1.12.2-0.2.0.31.jar chisel 0.2.0.31

setauthors "mDiyo, boni, et al"
seturl https://minecraft.curseforge.com/projects/mantle
solderfile Mantle-1.12-1.3.2.24.jar mantle 1.3.2.24
seturl https://minecraft.curseforge.com/projects/natura
solderfile natura-1.12.2-4.3.2.49.jar natura 4.3.2.49
seturl https://minecraft.curseforge.com/projects/tinkers-construct
solderfile TConstruct-1.12.2-2.10.1.87.jar tinkers-construct 2.10.1.87

setauthors TheIllusiveC4
seturl https://minecraft.curseforge.com/projects/constructs-armory
solderfile conarm-1.12.2-1.0.1.1.jar constructs-armor 1.0.1.1

setauthors boni
seturl https://minecraft.curseforge.com/projects/harvest-tweaks
solderfile HarvestTweaks-1.12-0.1.5.jar harvest-tweaks 0.1.5
# seturl https://minecraft.curseforge.com/projects/tinkers-skyblock
# solderfile TinkerSkyblock-1.12-0.3.jar tinker-skyblock 0.3
seturl https://minecraft.curseforge.com/projects/tinkers-tool-leveling
solderfile TinkerToolLeveling-1.12.2-1.0.5.jar tinker-tool-leveling 1.0.5

setauthors Landmaster_phuong0429
seturl https://minecraft.curseforge.com/projects/plustic
solderfile plustic-6.5.2.0.jar plus-tic 6.5.2.0

# maybe
#setauthors LakMoore
#seturl https://minecraft.curseforge.com/projects/infini-tic
#solderfile Infini-TiC-1.12-0.1.42.jar infini-tic 0.1.42

# setauthors wendall911
# seturl https://minecraft.curseforge.com/projects/tinkersurvival
# solderfile TinkerSurvival-1.12.2-1.1.0.4.jar tinker-survival 1.1.0.4

setauthors "Adubbz and Forstride"
seturl https://www.minecraftforum.net/forums/mapping-and-modding-java-edition/minecraft-mods/1286162-biomes-o-plenty-over-50-new-biomes-with-new-trees
solderfile BiomesOPlenty-1.12.2-7.0.1.2384-universal.jar biomes-o-plenty 7.0.1.2384
# seturl https://www.minecraftforum.net/forums/mapping-and-modding-java-edition/minecraft-mods/2696397-tough-as-nails-difficulty-through-realism-seasons
# solderfile ToughAsNails-1.12.2-3.1.0.115-universal.jar tough-as-nails 3.1.0.115

setauthors Octarine_Noise
seturl https://minecraft.curseforge.com/projects/better-foliage
solderfile BetterFoliage-MC1.12-2.1.10.jar better-foliage 2.1.10

setauthors techbrew
seturl https://minecraft.curseforge.com/projects/journeymap
solderfile journeymap-1.12.2-5.5.2.jar journey-map 5.5.2

setauthors jacquadro
seturl https://minecraft.curseforge.com/projects/chameleon
solderfile Chameleon-1.12-4.1.3.jar chameleon 4.1.3
seturl https://minecraft.curseforge.com/projects/storage-drawers
solderfile StorageDrawers-1.12.2-5.3.7.jar storage-drawers 5.3.7
seturl https://minecraft.curseforge.com/projects/storage-drawers-extras
solderfile StorageDrawersExtras-1.12-3.1.0.jar storage-drawers-extras 3.1.0

setauthors mezz
seturl https://minecraft.curseforge.com/projects/jei
solderfile jei_1.12.2-4.10.0.198.jar just-enough-items 4.10.0.198

setauthors feldim2425
seturl https://minecraft.curseforge.com/projects/more-overlays
solderfile moreoverlays-1.13-mc1.12.1.jar more-overlays 1.13

setauthors "progwml6, Alexbegt"
seturl https://minecraft.curseforge.com/projects/iron-chests
solderfile ironchest-1.12.2-7.0.40.824.jar iron-chest 7.0.40.824
xxx consider https://minecraft.curseforge.com/projects/metalchests

setauthors Azanor
seturl https://www.minecraftforum.net/forums/mapping-and-modding-java-edition/minecraft-mods/1294623-baubles-1-4-6-1-5-2-updated-2018-1-10
solderfile Baubles-1.12-1.5.2.jar baubles 1.5.2
# seturl https://www.minecraftforum.net/forums/mapping-and-modding-java-edition/minecraft-mods/1292130-thaumcraft-6-1-beta16
# solderfile Thaumcraft-1.12.2-6.1.BETA16.jar thaumcraft 6.1.BETA16

setauthors vazkii
seturl https://botaniamod.net/index.php
solderfile "Botania r1.10-354.jar" botania 1.10-354
seturl https://minecraft.curseforge.com/projects/akashic-tome
solderfile AkashicTome-1.2-10.jar akashic-tome 1.2-10
seturl https://minecraft.curseforge.com/projects/autoreglib
solderfile AutoRegLib-1.3-18.jar auto-reg-lib 1.3-18
seturl https://minecraft.curseforge.com/projects/quark
solderfile Quark-r1.4-125.jar quark 1.4-125
seturl https://psi.vazkii.us/
solderfile Psi-r1.1-59.jar psi 1.1-59

setauthors Buuz135
seturl https://minecraft.curseforge.com/projects/industrial-foregoing
solderfile industrialforegoing-1.12.2-1.10.2-178.jar industrial-foregoing 1.10.2-178

setauthors "Jackyy, Buuz135"
seturl https://minecraft.curseforge.com/projects/integration-foregoing
solderfile IntegrationForegoing-1.12.2-1.7.1.jar integration-foregoing 1.7.1

# setauthors "modmuss50, drcrazy, Gigabit101, Ourten, ProfessorProspector, Yulife"
# seturl https://minecraft.curseforge.com/projects/reborncore
# solderfile RebornCore-1.12.2-3.9.2.319-universal.jar reborn-core 3.9.2.319
# seturl https://minecraft.curseforge.com/projects/techreborn
# solderfile TechReborn-1.12.2-2.16.0.746-universal.jar tech-reborn 2.16.0.746

# setauthors "modmuss50, CyanideX, EwyBoy, Vswe"
# seturl https://minecraft.curseforge.com/projects/engineers-workshop-reborn
# solderfile EngineersWorkshopReborn-1.12.2-1.0.8.37.jar engineers-workshop-reborn 1.0.8.37

# setauthors asiekierka
# seturl https://minecraft.curseforge.com/projects/smoothwater
# solderfile SmoothWater-0.1.4.jar smooth-water 0.1.4

setauthors "PuppetzMedia, asiekierka, buildcraftchildsplay, copygirl, InsomniaKitten, mindlesspuppetz"
seturl https://minecraft.curseforge.com/projects/wearable-backpacks
solderfile WearableBackpacks-1.12.2-3.1.3.jar wearable-backpacks 3.1.3

setauthors Darkhax
seturl https://minecraft.curseforge.com/projects/dark-utilities
solderfile DarkUtils-1.12.2-1.8.211.jar dark-utilities 1.8.211
seturl https://minecraft.curseforge.com/projects/bookshelf
solderfile Bookshelf-1.12.2-2.3.552.jar bookshelf 2.3.552
seturl https://minecraft.curseforge.com/projects/wawla-what-are-we-looking-at
solderfile Wawla-1.12.2-2.5.257.jar wawla 2.5.257
seturl https://minecraft.curseforge.com/projects/oldjavawarning
solderfile OldJavaWarning-1.12.2-1.0.2.jar old-java-warning 1.0.2
# seturl https://minecraft.curseforge.com/projects/kelpie
# solderfile Kelpie-1.12.2-1.0.2.jar kelpie 1.0.2

setauthors Lothrazar
seturl https://minecraft.curseforge.com/projects/cyclic
solderfile Cyclic-1.12.2-1.15.15.jar cyclic 1.15.15

setauthors abab9579
seturl https://minecraft.curseforge.com/projects/stellar-api
solderfile Stellar+API-1.12.2-0.4.2.9.jar stellar-api 0.4.2.9
seturl https://minecraft.curseforge.com/projects/stellar-sky
solderfile Stellar+Sky-1.12.2-0.5.2.8.jar stellar-sky 0.5.2.8
seturl https://minecraft.curseforge.com/projects/photoptics
solderfile Photoptics-1.12.2-0.1.1.1.jar photoptics 0.1.1.1

setauthors Tmtravlr
seturl https://minecraft.curseforge.com/projects/sound-filters
solderfile SoundFilters-0.10_for_1.12.jar sound-filters 0.10

setauthors mangoose3039
seturl https://minecraft.curseforge.com/projects/rustic
solderfile rustic-1.0.6.jar rustic 1.0.6
seturl https://minecraft.curseforge.com/projects/dynamictrees
solderfile DynamicTrees-1.12.2-0.7.8.jar dynamic-trees 0.7.8
seturl https://minecraft.curseforge.com/projects/dtbop
solderfile DynamicTreesBOP-1.12.2-1.2.jar dynamic-trees-bop 1.2
# seturl https://minecraft.curseforge.com/projects/dttc
# solderfile DynamicTreesTC-1.12.2-1.0.jar dynamic-trees-thaumcraft 1.0
seturl https://minecraft.curseforge.com/projects/nether-chest
solderfile netherchest-0.2.3.jar nether-chest 0.2.3
# seturl https://minecraft.curseforge.com/projects/thaumic-periphery
# solderfile thaumicperiphery-0.2.3.jar thaumic-periphery 0.2.3

setauthors OreCruncher
seturl https://minecraft.curseforge.com/projects/dynamic-surroundings
solderfile DynamicSurroundings-1.12.2-3.4.9.14.jar dynamic-surroundings 3.4.9.14

# setauthors konwboj
# seturl https://minecraft.curseforge.com/projects/tumbleweed
# solderfile tumbleweed-1.11-0.4.5.jar tumbleweed 0.4.5

setauthors "kroeser, josephcsible, Yulife"
seturl https://minecraft.curseforge.com/projects/cyclops-core
solderfile CyclopsCore-1.12.2-0.11.6.jar cyclops-core 0.11.6
seturl https://minecraft.curseforge.com/projects/integrated-dynamics
solderfile IntegratedDynamics-1.12.2-0.11.13.jar integrated-dynamics 0.11.13
seturl https://minecraft.curseforge.com/projects/integrated-tunnels
solderfile IntegratedTunnels-1.12.2-1.5.6.jar integrated-tunnels 1.5.6
seturl https://minecraft.curseforge.com/projects/evilcraft
solderfile EvilCraft-1.12.2-0.10.59.jar evil-craft 0.10.59
seturl https://minecraft.curseforge.com/projects/colossal-chests
solderfile ColossalChests-1.12.2-1.6.11.jar colossal-chests 1.6.11
# seturl https://minecraft.curseforge.com/projects/flopper
# solderfile Flopper-1.12.2-1.0.2.jar flopper 1.0.2
# seturl https://minecraft.curseforge.com/projects/structured-crafting
# solderfile StructuredCrafting-1.12.2-0.1.14.jar structured-crafting 0.1.14
seturl https://minecraft.curseforge.com/projects/fluidconverters
solderfile FluidConverters-1.12.2-2.2.8.jar fluid-converters 2.2.8
seturl https://minecraft.curseforge.com/projects/common-capabilities
solderfile CommonCapabilities-1.12-1.4.0.jar common-capabilities 1.4.0

setauthors josephcsible
# seturl https://minecraft.curseforge.com/projects/oreberries
# solderfile oreberries-1.12.x-0.5.0.jar oreberries 0.5.0
seturl https://minecraft.curseforge.com/projects/expandedbonemeal
solderfile expandedbonemeal-1.11-1.2.1.jar expanded-bonemeal 1.2.1
seturl https://minecraft.curseforge.com/projects/infinitefluids
solderfile infinitefluids-1.11-1.2.0.jar infinite-fluids 1.2.0
# seturl https://minecraft.curseforge.com/projects/pistoncompression
# solderfile pistoncompression-1.11.2-1.1.1.jar piston-compression 1.1.1

setauthors stormwind
seturl https://minecraft.curseforge.com/projects/web-slinger
solderfile webslinger-1.12.2-1.1.1.jar web-slinger 1.1.1
seturl https://minecraft.curseforge.com/projects/pantography
https://minecraft.curseforge.com/projects/palimpsest
https://minecraft.curseforge.com/projects/daring-debug

# setauthors "ShadowGamerXY, Alexismachina, elucent, werty1125, Yulife"
# seturl https://minecraft.curseforge.com/projects/adventurebags
# solderfile ab-1.12.2-0.8r.jar adventure-bags 0.8r

setauthors "P3pp3rF1y, Yulife"
seturl https://minecraft.curseforge.com/projects/reliquary-v1-3
solderfile Reliquary-1.12.2-1.3.4.767.jar reliquary 1.3.4.767

setauthors "TehNut, Tombenpotter"
seturl https://minecraft.curseforge.com/projects/guide-api
solderfile Guide-API-1.12-2.1.5-60.jar guide-api 2.1.5-60

setauthors WayOfTime
seturl https://minecraft.curseforge.com/projects/blood-magic
solderfile BloodMagic-1.12.2-2.2.12-97.jar blood-magic 2.2.12-97

setauthors AlgorithmX2
seturl https://ae-mod.info/
solderfile appliedenergistics2-rv5-stable-11.jar applied-energistics 2-rv5-stable11
seturl https://minecraft.curseforge.com/projects/chisels-bits
solderfile chiselsandbits-14.17.jar chisels-and-bits 14.17
seturl https://minecraft.curseforge.com/projects/flat-colored-blocks
solderfile flatcoloredblocks-mc1.12-6.6.jar flat-colored-blocks 6.6

setauthors phylogeny
seturl https://minecraft.curseforge.com/projects/extra-bit-manipulation
solderfile ExtraBitManipulation-1.12-3.2.1.jar extra-bit-manipulation 3.2.1

setauthors CubeX2
seturl https://minecraft.curseforge.com/projects/truetype-font-replacement
solderfile --client TTFR-1.12.1-1.9.1.jar truetype-font-replacement 1.9.1

setauthors MatrexsVigil
seturl https://minecraft.curseforge.com/projects/pams-harvestcraft
solderfile "Pam's+HarvestCraft+1.12.2u.jar" pams-harvestcraft 1.12.2u

# setauthors "Team_otg, MC_Pitman, PeeGee85"
# seturl https://minecraft.curseforge.com/projects/open-terrain-generator
# solderfile OpenTerrainGenerator-1.12.2+-+v6.jar open-terrain-generator 6
# seturl https://minecraft.curseforge.com/projects/biome-bundle
# solderfile Biome_Bundle-1.12.2-v6.1.jar otg-biome-bundle 6.1
# seturl https://minecraft.curseforge.com/projects/otg-dungeons
# solderfile OTG-Dungeons-1.12.2-v1.jar otg-dungeons 1
# seturl https://minecraft.curseforge.com/projects/otg-skylands
# solderfile OTG-Skylands-1.12.2-v5.jar otg-skylands 5
# seturl https://minecraft.curseforge.com/projects/otg-the-void
# solderfile OTG-Void-1.12.2-v4.jar otg-void 4

setauthors Mr_TJP
seturl https://minecraft.curseforge.com/projects/mrtjpcore
solderfile MrTJPCore-1.12.2-2.1.3.35-universal.jar mr-tjp-core 2.1.3.35
seturl https://minecraft.curseforge.com/projects/project-red-base
solderfile ProjectRed-1.12.2-4.9.1.92-Base.jar project-red-base 4.9.1.92
seturl https://minecraft.curseforge.com/projects/project-red-integration
solderfile ProjectRed-1.12.2-4.9.1.92-integration.jar project-red-integration 4.9.1.92
seturl https://minecraft.curseforge.com/projects/project-red-fabrication
solderfile ProjectRed-1.12.2-4.9.1.92-fabrication.jar project-red-fabrication 4.9.1.92
seturl https://minecraft.curseforge.com/projects/project-red-compat
solderfile ProjectRed-1.12.2-4.9.1.92-compat.jar project-red-compatibility 4.9.1.92
# seturl https://minecraft.curseforge.com/projects/project-red-world
# solderfile ProjectRed-1.12.2-4.9.1.92-world.jar project-red-world 4.9.1.92
seturl https://minecraft.curseforge.com/projects/project-red-lighting
solderfile ProjectRed-1.12.2-4.9.1.92-lighting.jar project-red-lighting 4.9.1.92

setauthors "tterrag1098, CrazyPants, Henry_Loenwind"
seturl https://minecraft.curseforge.com/projects/endercore
solderfile EnderCore-1.12.2-0.5.31.jar ender-core 0.5.31
seturl https://minecraft.curseforge.com/projects/ender-io
solderfile EnderIO-1.12.2-5.0.26.jar ender-io 5.0.26
seturl https://minecraft.curseforge.com/projects/ender-zoo
solderfile EnderZoo-1.12.1-1.4.0.49.jar ender-zoo 1.4.0.49
xxx add that other one

setauthors Elec332
seturl https://minecraft.curseforge.com/projects/eleccore
solderfile ElecCore-1.12.2-1.8.434.jar elec-core 1.8.434

setauthors McJty
seturl https://minecraft.curseforge.com/projects/mcjtylib
solderfile mcjtylib-1.12-3.0.2.jar mcjtylib 3.0.2
seturl https://minecraft.curseforge.com/projects/rftools
solderfile rftools-1.12-7.54.jar rf-tools 7.54
seturl https://minecraft.curseforge.com/projects/deep-resonance
solderfile deepresonance-1.12-1.7.0.jar deep-resonance 1.7.0
# seturl https://minecraft.curseforge.com/projects/restrictions
# solderfile restrictions-1.12-1.2.0.jar restrictions 1.2.0
seturl https://minecraft.curseforge.com/projects/not-enough-wands
solderfile notenoughwands-1.12-1.7.0.jar not-enough-wands 1.7.0
seturl https://minecraft.curseforge.com/projects/rftools-dimensions
solderfile rftoolsdim-1.12-5.60.jar rf-tools-dimensions 5.60
# seturl https://minecraft.curseforge.com/projects/rf-lux
# solderfile rflux-1.12-0.3.0.jar rf-lux 0.3.0
seturl https://minecraft.curseforge.com/projects/rftools-power
solderfile rftoolspower-1.12-1.1.0.jar rf-tools-power 1.1.0
seturl https://minecraft.curseforge.com/projects/rftools-control
solderfile rftoolsctrl-1.12-1.9.1.jar rf-tools-control 1.9.1

setauthors Davenonymous
seturl https://minecraft.curseforge.com/projects/compact-machines
solderfile compactmachines3-1.12.2-3.0.12-b215.jar compact-machines-3 3.0.12-b215

setauthors RWTema
seturl https://minecraft.curseforge.com/projects/extra-utilities
solderfile extrautils2-1.12-1.7.6.jar extra-utils-2 1.7.6
seturl https://minecraft.curseforge.com/projects/diet-hoppers
solderfile diethopper-1.1.jar diet-hopper 1.1

setauthors bdew
seturl https://minecraft.curseforge.com/projects/bdlib
solderfile bdlib-1.14.3.12-mc1.12.2.jar bdew-lib 1.14.3.12
seturl https://minecraft.curseforge.com/projects/advanced-generators
solderfile generators-0.9.20.12-mc1.12.2.jar advanced-generators 0.9.20.12
seturl https://minecraft.curseforge.com/projects/pressure-pipes
solderfile pressure-1.3.1.6-mc1.12.1.jar pressure-pipes 1.3.1.6
seturl https://minecraft.curseforge.com/projects/ae2-stuff
solderfile ae2stuff-0.7.0.4-mc1.12.2.jar ae2-stuff 0.7.0.4
seturl https://minecraft.curseforge.com/projects/proxy
solderfile proxy-0.9.1.5-mc1.12.jar proxy 0.9.1.5
seturl https://minecraft.curseforge.com/projects/compacter
solderfile compacter-1.3.0.3-mc1.12.2.jar compacter 1.3.0.3
seturl https://minecraft.curseforge.com/projects/jei-bees
solderfile jeibees-0.9.0.5-mc1.12.2.jar jei-bees 0.9.0.5

setauthors TehNut
seturl https://minecraft.curseforge.com/projects/hwyla
solderfile Hwyla-1.8.26-B41_1.12.2.jar hwyla 1.8.25-B41

setauthors "BluSunrize, malte0811, Mr_Hazard"
seturl https://minecraft.curseforge.com/projects/immersive-engineering
solderfile ImmersiveEngineering-0.12-82.jar immersive-engineering 0.12-82

setauthors SanAndreasP
seturl https://minecraft.curseforge.com/projects/immersive-cables
solderfile ImmersiveCables-1.12.2-1.3.0.jar immersive-cables 1.3.0
seturl https://minecraft.curseforge.com/projects/sanlib
solderfile SanLib-1.12.2-1.4.4.jar san-lib 1.4.4
# seturl https://minecraft.curseforge.com/projects/clay-soldiers-mod
# solderfile ClaySoldiersMod-1.12.2-3.0.0-alpha.9.1.jar clay-soldiers 3.0.0-alpha.9.1

# setauthors Kihira
# seturl https://minecraft.curseforge.com/projects/tails
# solderfile Tails-1.12-1.10.0.jar tails 1.10.0

setauthors FerroO2000
seturl https://minecraft.curseforge.com/projects/immersive-tech
solderfile immersivetech-1.12-1.3.10.jar immersive-tech 1.3.10

setauthors Flaxbeard
seturl https://minecraft.curseforge.com/projects/questionably-immersive
solderfile questionablyimmersive-1.12.2-0.1.0.jar questionably-immersive 0.1.0
seturl https://minecraft.curseforge.com/projects/immersive-petroleum
solderfile immersivepetroleum-1.12.2-1.1.9.jar immersive-petroleum 1.1.9

setauthors Nihiltres
seturl https://minecraft.curseforge.com/projects/engineers-doors
solderfile engineersdoors-0.7.2.jar engineers-doors 0.7.2

# setauthors cam72cam
# seturl https://minecraft.curseforge.com/projects/track-api
# solderfile TrackAPI-1.1_1.12.jar track-api 1.1

# setauthors "cam72cam, trainman264"
# seturl https://minecraft.curseforge.com/projects/immersive-railroading
# solderfile ImmersiveRailroading-1.2.1_1.12.jar immersive-railroading 1.2.1

# setauthors Angelimar
# seturl https://minecraft.curseforge.com/projects/ir-heavy-industrial-resourcepack
# solderfile Heavy+Industrial+1.3.2.1+by+adam+r+k.zip ir-heavy-industrial 1.3.2.1 conf#ig/immersiveengineering

setauthors "Purplicious_Cow, raptorfarian, RazzleberryFox, Tschipp"
seturl https://minecraft.curseforge.com/projects/animania
solderfile animania-1.12.2-1.4.8.jar animania 1.4.8

# setauthors "ZeAmateis, Timmypote"
# seturl https://www.curseforge.com/minecraft/mc-mods/craftstudio-api
# solderfile CraftStudio-1.0.0.93-mc1.12-alpha.jar craft-studio 1.0.0.93-alpha

# setauthors "RazzleberryFox, Cojomax99, ProfMobius"
# seturl https://minecraft.curseforge.com/projects/camera-obscura
# solderfile CameraObscura-1.0.3.jar camera-obscura 1.0.3

# setauthors "RazzleberryFox, ProfMobius, taelnia"
# seturl https://minecraft.curseforge.com/projects/ptrlib
# solderfile PTRLib-1.0.2.jar ptr-lib 1.0.2
# seturl https://minecraft.curseforge.com/projects/decocraft2
# solderfile Decocraft-2.6.0_1.12.2.jar decocraft 2.6.0

setauthors ZLainSama
seturl https://minecraft.curseforge.com/projects/peacefulsurface
solderfile PeacefulSurface-1.12.2-v1.jar peaceful-surface 1.12.2-v1

setauthors lumien
seturl https://minecraft.curseforge.com/projects/random-things
solderfile RandomThings-MC1.12.2-4.1.9.jar random-things 4.1.9

setauthors "SirSengir, CovertJaguar, mezz, MysteriousAges"
seturl https://minecraft.curseforge.com/projects/forestry
solderfile forestry_1.12.2-5.8.0.311.jar forestry 5.8.0.311

setauthors "Binnie567, mezz"
seturl https://minecraft.curseforge.com/projects/binnies-mods
solderfile binnie-mods-1.12.2-2.5.0.167.jar binnies-mods 2.5.0.167

setauthors Sangar
seturl https://minecraft.curseforge.com/projects/opencomputers
solderfile OpenComputers-MC1.12.2-1.7.2.67.jar open-computers 1.7.2.67

setauthors iChun
seturl https://minecraft.curseforge.com/projects/ichunutil
solderfile iChunUtil-1.12.2-7.1.4.jar ichun-util 7.1.4
# seturl https://minecraft.curseforge.com/projects/mob-amputation
# solderfile MobAmputation-1.12.2-7.0.0.jar mob-amputation 7.0.0
seturl https://minecraft.curseforge.com/projects/ding
solderfile Ding-1.12.1-1.0.1.jar ding 1.0.1
seturl https://minecraft.curseforge.com/projects/general-laymans-aesthetic-spying-screen-glass
solderfile GeneralLaymansAestheticSpyingScreen-1.12.2-7.0.0.jar glass 7.0.0
seturl https://minecraft.curseforge.com/projects/morph
solderfile Morph-1.12.2-7.1.2.jar morph 7.1.2
# seturl https://minecraft.curseforge.com/projects/hats
# solderfile Hats-1.12.2-7.0.2.jar hats 7.0.2

setauthors corosus
seturl https://coros.us/mods/
solderfile coroutil-1.12.1-1.2.11.jar coro-util 1.2.11
solderfile weather2-1.12.1-2.6.10.jar weather2 2.6.10

setauthors "Destroyer7128, DrummerMC, Nedelosk, Pwnie2012"
seturl https://minecraft.curseforge.com/projects/extracells2
solderfile ExtraCells-1.12.2-2.5.13a60.jar extra-cells 2.5.13a60

setauthors "Matthew Prenger"
seturl https://minecraft.curseforge.com/projects/helpfixer
solderfile HelpFixer-1.12.1-1.5.18.jar help-fixer 1.5.18

setauthors "Amadornes, MRebhan"
seturl https://minecraft.curseforge.com/projects/mcmultipart
solderfile MCMultiPart-2.5.1.jar mc-multi-part 2.5.1

setauthors "Agent Epsilon"
seturl https://minecraft.curseforge.com/projects/fmp-to-c-b
solderfile fmp_to_cb-1.0.1.jar fmp-to-cb 1.0.1

setauthors Nuchaz
seturl https://minecraft.curseforge.com/projects/bibliocraft
solderfile BiblioCraft[v2.4.5][MC1.12.2].jar bibliocraft 2.4.5
# seturl https://minecraft.curseforge.com/projects/bibliocraft-bibliowoods-forestry-edition
# solderfile BiblioWoods[Forestry][v2.0][MC1.11.2].jar bibliowoods-forestry 2.0
# seturl https://minecraft.curseforge.com/projects/bibliocraft-bibliowoods-natura-edition
# solderfile BiblioWoods[Natura][v2.0][MC1.11.2].jar bibliowoods-natura 2.0

setauthors Ordinastie
seturl https://minecraft.curseforge.com/projects/malisiscore
solderfile malisiscore-1.12.2-6.4.0.jar malisis-core 6.4.0
seturl https://minecraft.curseforge.com/projects/malisisdoors
solderfile malisisdoors-1.12.2-7.3.0.jar malisis-doors 7.3.0
seturl https://minecraft.curseforge.com/projects/malisisblocks
solderfile malisisblocks-1.12.2-6.1.0.jar malisis-blocks 6.1.0
seturl https://minecraft.curseforge.com/projects/malisisswitches
solderfile malisisswitches-1.12.2-5.1.0.jar malisis-switches 5.1.0

setauthors AtomicStryker
seturl https://minecraft.curseforge.com/projects/dynamic-lights
solderfile DynamicLights-1.12.2.jar dynamic-lights 1.12.2

setauthors CreativeMD
seturl https://minecraft.curseforge.com/projects/creativecore
solderfile CreativeCore_v1.9.22_mc1.12.2.jar creative-core 1.9.22
seturl https://minecraft.curseforge.com/projects/itemphysic
solderfile ItemPhysic_Full_1.4.12_mc1.12.2.jar item-physic-full 1.4.12

setauthors 10paktimbits
seturl http://10paksmods.net/
#solderfile realworld-1.17.jar realworld 1.17
xxx plant mega pack, decoration megapack

setauthors "BlayTheNinth, Zero9010"
seturl https://minecraft.curseforge.com/projects/cooking-for-blockheads
solderfile CookingForBlockheads_1.12.2-6.4.40.jar cooking-for-blockheads 6.4.40

setauthors sk89q
seturl https://minecraft.curseforge.com/projects/worldedit
solderfile worldedit-forge-mc1.12-6.1.8-dist.jar world-edit 6.1.8

# setauthors "JS Community"
# seturl https://github.com/John-Smith-Modded/JSTR-Modded-1.12.x/releases
# solderfile --client JSTR-1.12.x-1.1.5.zip john-smith-tr 1.12-1.1.5 resourcepacks
xxx grab new jstr

setauthors "elucent, epicsquid"
seturl https://minecraft.curseforge.com/projects/roots
solderfile roots-2-0.104.jar roots2 2-0.104
# seturl https://minecraft.curseforge.com/projects/flowing-blocks
# solderfile flowingblocks-0.1.1.jar flowing-blocks 0.1.1
seturl https://minecraft.curseforge.com/projects/clarity
solderfile clarity-1.1.jar clarity 1.1
seturl https://minecraft.curseforge.com/projects/embers
xxx switch to https://minecraft.curseforge.com/projects/embers-rekindled
solderfile embers-0.230.jar embers 0.230
seturl https://minecraft.curseforge.com/projects/mysticallib
solderfile elulib-0.1.12.jar mystical-lib 0.1.12
seturl https://minecraft.curseforge.com/projects/mystic-world
solderfile mysticalworld-0.1.1.jar mystical-world 0.1.1
# seturl https://minecraft.curseforge.com/projects/crissaegrim
# solderfile crissaegrim-0.1.1.jar crissaegrim 0.1.1

setauthors Mikemoo
seturl https://minecraft.curseforge.com/projects/openblocks
solderfile OpenBlocks-1.12.2-1.7.6.jar open-blocks 1.7.6
seturl https://minecraft.curseforge.com/projects/openmodslib
solderfile OpenModsLib-1.12.2-0.11.5.jar open-mods-lib 0.11.5

setauthors "Ellpeck, canitzp, Shadows_Of_Fire"
seturl https://minecraft.curseforge.com/projects/actually-additions
solderfile ActuallyAdditions-1.12.2-r135.jar actually-additions 1.12.2-r135

setauthors Shadowfacts
seturl https://minecraft.curseforge.com/projects/shadowfacts-forgelin
solderfile Forgelin-1.7.4.jar forgelin 1.7.4

setauthors Face_of_Cat
seturl https://minecraft.curseforge.com/projects/tesla-core-lib
solderfile tesla-core-lib-1.12.2-1.0.14.jar tesla-core-lib 1.0.14

setauthors "fewizz, Adaptivity, Player, TheSilentium"
seturl https://minecraft.curseforge.com/projects/notenoughids
solderfile NotEnoughIDs-1.5.4.2.jar not-enough-ids 1.5.4.2

setauthors delvr
seturl https://minecraft.curseforge.com/projects/streams
solderfile Streams-1.12-0.4.4.jar streams 1.12-0.4.4
seturl https://minecraft.curseforge.com/projects/farseek
solderfile Farseek-1.12-2.3.jar farseek 1.12-2.3

setauthors Lumien
seturl https://minecraft.curseforge.com/projects/custom-main-menu
solderfile CustomMainMenu-MC1.12.2-2.0.8.jar custom-main-menu 2.0.8

setauthors squeek502
seturl https://minecraft.curseforge.com/projects/appleskin
solderfile AppleSkin-mc1.12-1.0.9.jar apple-skin 1.0.9

setauthors "squeek502, Girafi"
seturl https://minecraft.curseforge.com/projects/applecore
solderfile AppleCore-mc1.12.2-3.1.3.jar apple-core 3.1.3

xxx these need BASE now
setauthors jaredlll08
seturl https://minecraft.curseforge.com/projects/initial-inventory
solderfile InitialInventory-3.0.0.jar initial-inventory 3.0.0
seturl https://minecraft.curseforge.com/projects/clumps
solderfile Clumps-3.1.1.jar clumps 3.1.1
seturl https://minecraft.curseforge.com/projects/modtweaker
solderfile modtweaker-4.0.12.jar mod-tweaker 4.0.12
seturl https://minecraft.curseforge.com/projects/controlling
solderfile Controlling-3.0.6.jar controlling 3.0.6
seturl https://minecraft.curseforge.com/projects/mtlib
solderfile MTLib-3.0.5.jar mt-lib 3.0.5

setauthors "jaredlll08, kindlich, StanH"
seturl https://minecraft.curseforge.com/projects/crafttweaker
solderfile CraftTweaker2-1.12-4.1.9.jar craft-tweaker2 4.1.9

xxx Need to remove defaults, possibly load custom generation pack
setauthors Ivorius
seturl https://minecraft.curseforge.com/projects/recurrent-complex
solderfile RecurrentComplex-1.4.7.jar recurrent-complex 1.4.7
seturl https://minecraft.curseforge.com/projects/ivtoolkit
solderfile IvToolkit-1.3.3-1.12.jar iv-toolkit 1.3.3

setauthors Terminator_NL_44352929
seturl https://minecraft.curseforge.com/projects/laggoggles
solderfile LagGoggles-FORGE-1.12.2-4.1.jar lag-goggles 4.1

setauthors Olafski
seturl https://minecraft.curseforge.com/projects/fast-leaf-decay
solderfile FastLeafDecay-v14.jar fast-leaf-decay 14

setauthors BordListian
xxx embers rekindled goes here
seturl https://minecraft.curseforge.com/projects/soot
solderfile Soot-0.18hotfix.jar soot 0.18-hotfix

# disabled in favor of stellarsky etc!
# setauthors "HellFirePvP wiiv"
# seturl https://minecraft.curseforge.com/projects/astral-sorcery
# solderfile astralsorcery-1.12.2-1.9.4.jar astral-sorcery 1.9.4

xxx consider https://minecraft.curseforge.com/projects/bwm-suite
xxx https://minecraft.curseforge.com/projects/superior-shields


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
      '$MCVERSION', NULL, 1, 0,
      ' '
  FROM solder_modpacks
  WHERE name='$MPNAME'
  ON DUPLICATE KEY UPDATE
    minecraft='$MCVERSION',
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
