
{ lib, buildUBoot, fetchFromGitHub, thead-opensbi }:

(buildUBoot rec {
  version = "2026.05.04";

  src = fetchFromGitHub {
    # https://github.com/revyos/th1520-vendor-uboot/releases/tag/20260504
    owner = "revyos";
    repo = "th1520-vendor-uboot";
    tag = "20260504";
    hash = "sha256-TivIrlwieZ6RZXNGyITTxxaURVReBhqul5Z+toCvfBg=";
  };

  defconfig = "light_lpi4a_16g_defconfig";

  extraMeta.platforms = [ "riscv64-linux" ];
  extraMakeFlags = [
    "OPENSBI=${thead-opensbi}/share/opensbi/lp64/generic/firmware/fw_dynamic.bin"
  ];

  filesToInstall = [ "u-boot-with-spl.bin" ];
}).overrideAttrs (oldAttrs: {
  patches = [
    ./patches/0001-feat-use-mmcbootpart-1-for-nixos.patch
  ];
})
