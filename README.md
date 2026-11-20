# aeon6735_66_d_n (unknown MT6735 tablet)

Stock: Android 7.0 NRD90M, build K1035P3_V1.0.0_20230214, board K1035, Linux 3.18.35 arm64.
Real hardware: MT6735, 1.5 GB RAM, 16 GB eMMC. The `ro.ty.fake.*` props in stock firmware are fake specs.

## Flashing (no usable fastboot, use MTKClient)
    python mtk rl backup/          # full backup first (keep nvram, nvdata, proinfo, seccfg, secro, protect1/2)
    python mtk w recovery twrp.img

Keep `bootopt=64S3,32N2,64N2` in the boot image cmdline, LK needs it to pick the 64-bit kernel.

## Notes
- Panel: 800x1280 portrait, density 210, ro.sf.hwrotation=180 (TW_ROTATION := 180 in BoardConfig).
- Stock sets ro.expect.recovery_id, so /system may restore the stock recovery on boot
  (install-recovery.sh / recovery-from-boot.p). Remove or rename them after flashing TWRP.
- Hardware HALs are named after ro.board.platform=mt6735 (gralloc, hwcomposer, audio, lights, power);
  sensors use ro.hardware.sensors=aeon6735_66_d_n.

## Blobs
`proprietary-files.txt` was generated from the stock /system file list (570 files: Mali-T720 EGL, gralloc/hwcomposer.mt6735,
audio, camera, WCN/Bluetooth, firmware, MTK RIL/IMS). Run `./extract-files.sh` against a device over adb or a dumped /system.
The modem/RIL section is second phase work. Stock init scripts are in `rootdir/` and need porting to the target Android version.
