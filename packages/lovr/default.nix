##########################################################################
#                                                                        #
#  This file is part of the shackra/nur project                          #
#                                                                        #
#  Copyright (C) 2025 Jorge Javier Araya Navarro                         #
#                                                                        #
#  SPDX-License-Identifier: MIT                                          #
#                                                                        #
##########################################################################

{
  stdenv,
  fetchFromGitHub,
  lib,
  pkgs,
  pkg-config,
}:
stdenv.mkDerivation rec {
  pname = "lovr";
  version = "0.18.0";

  src = fetchFromGitHub {
    fetchSubmodules = true;
    owner = "bjornbytes";
    repo = "lovr";
    rev = "v0.18.0";
    sha256 = "sha256-SyKJv9FmJyLGc3CT0JBNewvjtsmXKxiqaptysWiY4co=";
  };

  nativeBuildInputs = [
    pkgs.cmake
    pkg-config
    pkgs.gcc
    pkgs.python3
  ];

  buildInputs = [
    pkgs.luajit
    pkgs.glfw
    pkgs.glslang
    pkgs.vulkan-loader
    pkgs.vulkan-headers
    pkgs.monado
    pkgs.xorg.libX11.dev
    pkgs.curl.dev
    pkgs.xorg.libxcb.dev
    pkgs.xorg.libXdmcp.dev
    pkgs.xorg.libXrandr.dev
    pkgs.xorg.libXinerama.dev
    pkgs.xorg.libXcursor.dev
    pkgs.xorg.libXi.dev
    pkgs.jsoncpp.dev
  ];

  joltSrc = fetchFromGitHub {
    owner = "jrouwe";
    repo = "JoltPhysics";
    rev = "v5.3.0";
    sha256 = "sha256-Vh4SLRyA9EtYCaulA7kI3CtCioJvEoSyuAXZJmDRTB8=";
  };

  cmakeFlags = [
    "-DCMAKE_BUILD_TYPE=Release"
    "-DFETCHCONTENT_FULLY_DISCONNECTED=ON"
    "-DFETCHCONTENT_SOURCE_DIR_JOLTPHYSICS=${joltSrc}"
    "-DBUILD_WITH_WAYLAND_HEADERS=ON"
  ];

  meta = with lib; {
    description = "An open source Lua framework for building 3D games and VR experiences";
    homepage = "https://lovr.org/";
    license = licenses.mit;
    maintainers = with maintainers; [ shackra ];
    platforms = platforms.linux;
  };
}
