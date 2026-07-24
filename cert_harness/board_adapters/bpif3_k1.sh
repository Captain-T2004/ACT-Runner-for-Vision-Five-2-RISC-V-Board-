#!/usr/bin/env bash

# Banana Pi BPI-F3 / SpacemiT K1 board adapter.

board_flash_image() {
  local repo_root="$1"
  local image="$2"
  local sd_dev="$3"

  : "$repo_root"
  : "$sd_dev"
  echo "TODO(bpif3_k1): SD offset for the firmware image is not confirmed yet." >&2
  echo "  Image to place: $image" >&2
  echo "  Do not assume VF2's offset (0x2000 blocks) or touch eMMC without confirming first." >&2
  return 2
}

board_write_pack() {
  local repo_root="$1"
  local pack="$2"
  local sd_dev="$3"

  (cd "$repo_root" && ./write_pack_to_sd_tail.sh "$pack" "$sd_dev")
}

board_capture_uart() {
  local repo_root="$1"
  local serial_dev="$2"
  local log_path="$3"
  local cooldown_sec="$4"
  local boot_cooldown_sec="$5"
  local boot_retries="$6"
  local boot_backoff_sec="$7"
  local cycle_delay="$8"
  local start_cycle="$9"

  : "$repo_root"
  : "$cooldown_sec"
  : "$boot_cooldown_sec"
  : "$boot_retries"
  : "$boot_backoff_sec"
  : "$cycle_delay"
  : "$start_cycle"

  mkdir -p "$(dirname "$log_path")"
  stty -F "$serial_dev" 115200 cs8 -cstopb -parenb -ixon -ixoff -icanon -echo raw
  cat "$serial_dev" | tee -a "$log_path"
}
