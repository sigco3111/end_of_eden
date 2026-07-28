#!/bin/bash
# verify_ko.sh — verifies that the Korean (ko) localization loads correctly
# and returns Korean strings for all keys that have Korean translations.
#
# Usage: ./verify_ko.sh [path/to/end_of_eden]
#
# Requires: go (any 1.21+ version)
# Run from the repo root (or pass the path as the first argument).

set -e

REPO_ROOT="${1:-$(pwd)}"
if [ ! -d "$REPO_ROOT/assets/locals/ko" ]; then
    echo "ERROR: $REPO_ROOT/assets/locals/ko not found."
    echo "Run this script from the end_of_eden repo root or pass the path."
    exit 1
fi

WORK=$(mktemp -d)
trap "rm -rf $WORK" EXIT

cat > "$WORK/main.go" <<EOF
package main

import (
	"fmt"
	"os"
	"strings"

	"github.com/BigJk/end_of_eden/system/localization"
)

func main() {
	if err := localization.Global.AddFolder("$REPO_ROOT/assets/locals"); err != nil {
		fmt.Println("AddFolder error:", err)
		os.Exit(1)
	}

	koKeys := []string{
		"basics.on","basics.off",
		"settings.audio.title","settings.volume.description",
		"settings.language.title","settings.crt.title","settings.fps.title",
		"cards.MELEE_HIT.name","cards.MELEE_HIT.description","cards.MELEE_HIT.state",
		"cards.ARM_MOUNTED_GUN.name","cards.ARM_MOUNTED_GUN.description","cards.ARM_MOUNTED_GUN.state",
		"cards.CROWBAR.name","cards.VIBRO_KNIFE.name","cards.LZR_PISTOL.name","cards.HAR-II.name",
		"cards.ADRENALINE_SHOT.name","cards.ADRENALINE_SHOT.description",
		"cards.ENRGY_DRINK_X91.name","cards.ENRGY_DRINK_X92.name","cards.ENRGY_DRINK_X93.name",
		"cards.BLOCK.name","cards.BLOCK.description","cards.BLOCK.state",
		"cards.BOUNCE_SHIELD.name","cards.BOUNCE_SHIELD.description","cards.BOUNCE_SHIELD.state",
		"cards.FLASH_BANG.name","cards.FLASH_BANG.description",
		"cards.FLASH_SHIELD.name","cards.FLASH_SHIELD.description","cards.FLASH_SHIELD.state",
		"cards.KNOCK_OUT.name","cards.KNOCK_OUT.description",
		"cards.LONG_REST.name","cards.LONG_REST.description","cards.LONG_REST.state",
		"cards.NANO_CHARGER.name","cards.NANO_CHARGER.description","cards.NANO_CHARGER.state",
		"cards.NULLIFY.name","cards.NULLIFY.description","cards.NULLIFY.state",
		"cards.REST.name","cards.REST.description","cards.REST.state",
		"cards.SMOKE_BOMB.name","cards.SMOKE_BOMB.description","cards.SMOKE_BOMB.state",
		"cards.STIM_PACK.name","cards.STIM_PACK.description","cards.STIM_PACK.state",
		"cards.ULTRA_FLASH_SHIELD.name","cards.ULTRA_FLASH_SHIELD.description","cards.ULTRA_FLASH_SHIELD.state",
		"status_effects.ADRENALINE_SHOT.name","status_effects.ADRENALINE_SHOT.description",
		"status_effects.BLOCK.name","status_effects.BLOCK.description",
		"status_effects.BOUNCE_SHIELD.name","status_effects.BOUNCE_SHIELD.description",
		"status_effects.FLASH_BANG.name","status_effects.FLASH_BANG.description",
		"status_effects.FLASH_SHIELD.name","status_effects.FLASH_SHIELD.description",
		"status_effects.KNOCK_OUT.name","status_effects.KNOCK_OUT.description",
		"status_effects.NANO_CHARGER.name","status_effects.NANO_CHARGER.description",
		"status_effects.NULLIFY.name","status_effects.NULLIFY.description",
		"status_effects.SMOKE_BOMB.name","status_effects.SMOKE_BOMB.description",
		"status_effects.ULTRA_FLASH_SHIELD.name","status_effects.ULTRA_FLASH_SHIELD.description",
		"status_effects.CHARGED.name","status_effects.CHARGED.description",
		"status_effects.CHARGING.name","status_effects.CHARGING.description",
		"artifacts.ARM_MOUNTED_GUN.name","artifacts.ARM_MOUNTED_GUN.description",
		"artifacts.BIO_RECYCLER.name","artifacts.BIO_RECYCLER.description",
		"artifacts.COMBAT_GLASSES.name","artifacts.COMBAT_GLASSES.description",
		"artifacts.COMBAT_GLOVES.name","artifacts.COMBAT_GLOVES.description",
		"artifacts.GOLD_SCRAPPER.name","artifacts.GOLD_SCRAPPER.description",
		"artifacts.HEADBUT_HELMET.name","artifacts.HEADBUT_HELMET.description",
		"artifacts.INTERVA_JUICER.name","artifacts.INTERVA_JUICER.description",
		"artifacts.PORTABLE_BUFFER.name","artifacts.PORTABLE_BUFFER.description",
		"artifacts.REFLECTIVE_ARMOR.name","artifacts.REFLECTIVE_ARMOR.description",
		"artifacts.SPEED_ENHANCER.name","artifacts.SPEED_ENHANCER.description",
		"enemies.RUST_MITE.name","enemies.RUST_MITE.description",
		"enemies.CLEAN_BOT.name","enemies.CLEAN_BOT.description",
		"enemies.LASER_DRONE.name","enemies.LASER_DRONE.description",
		"enemies.NANOBOT_SWARM.name","enemies.NANOBOT_SWARM.description",
		"enemies.CYBER_SLIME.name","enemies.CYBER_SLIME.description",
		"enemies.CYBER_SLIME_MINION.name","enemies.CYBER_SLIME_MINION.description",
		"enemies.CYBER_SPIDER.name","enemies.CYBER_SPIDER.description",
		"enemies.PLASMA_GOLEM.name","enemies.PLASMA_GOLEM.description",
		"enemies.REPAIR_DRONE.name","enemies.REPAIR_DRONE.description",
	}

	pass, fail := 0, 0
	var missing []string
	for _, k := range koKeys {
		v := localization.Global.Get("ko", k)
		if v == k || strings.HasPrefix(v, k) {
			fail++
			missing = append(missing, k)
		} else {
			pass++
		}
	}
	fmt.Printf("\n========== Korean (ko) localization check ==========\n")
	fmt.Printf("PASS: %d\nFAIL: %d\nTOTAL: %d\n", pass, fail, len(koKeys))
	if fail > 0 {
		fmt.Println("\nMissing keys (fell back to en or returned the key):")
		for _, k := range missing {
			fmt.Println("  -", k)
		}
		os.Exit(1)
	}
	fmt.Println("\nAll Korean keys load correctly.")
}
EOF

cd "$REPO_ROOT"
go run "$WORK/main.go"