# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

DREAM is a Tandy Color Computer 3 (CoCo 3) emulator for Windows, forked from VCC. It's written in C++20 using Visual Studio 2022 with MSBuild.

## Build Commands

**Requirements**: Developer Command Prompt for VS 2022

```batch
# Full build (Release, x86)
nuget restore
msbuild vcc.sln /m /p:Configuration=Release /p:Platform=x86

# Debug build
msbuild vcc.sln /m /p:Configuration=Debug /p:Platform=x86

# Build single project
msbuild libcommon\libcommon.vcxproj /p:Configuration=Debug /p:Platform=x86
```

**Output locations**:
- Main executable: `build\Win32\Release\bin\vcc.exe`
- Cartridge DLLs: `build\Win32\Release\bin\cartridges\`

## Running Tests

```batch
build\Win32\Debug\bin\libcommon-test.exe
```

Test framework: Google Test 1.8.1.7 (via NuGet)

## Architecture

### Cartridge Plugin System
Cartridges are DLLs loaded at runtime. Each cartridge project outputs to `build\[Platform]\[Config]\bin\cartridges\`:
- **FD502**: Floppy disk controller with Becker Port
- **HardDisk**: Hard disk controller
- **mpi**: Multi-Pak Interface (4 expansion slots)
- **orch90**: Orchestra-90 CC (5-voice music sequencer)
- **Ramdisk**: RAM disk expansion
- **SuperIDE**: IDE interface
- **becker**: Becker Port for DriveWire
- **GMC**: Game Master Cartridge with SN-76496 PSG
- **acia**: Serial communication chip

### Core Emulation (root directory)
- `coco3.cpp/h`: CoCo 3 system emulation
- `mc6809.cpp`, `hd6309.cpp`: CPU emulation (Motorola 6809 and Hitachi 6309)
- `tcc1014*.cpp`: GIME chip (graphics, MMU, registers)
- `mc6821.cpp`: Peripheral Interface Adapter (PIA)
- `Vcc.cpp`: Main application/window management

### Shared Library (libcommon/)
Common functionality used by all projects:
- `vcc/ui/menu/`: Menu building system
- `vcc/media/disk_images/`: Disk format handlers (DMK, JVC, VDK)
- `vcc/devices/`: Device abstractions (ROM, RTC, PSG, serial)
- `vcc/utils/`: File operations, dialog operations

### Build Configuration
MSBuild property sheets in project root:
- `vcc-base.props`: Base settings (C++20, warnings as errors)
- `vcc-debug.props`: Debug configuration
- `vss-release.props`: Release configuration
- `vcc-cartridge.props`: Cartridge-specific settings

## Key Constraints

- **All warnings are errors**: Projects use `/WX` (TreatWarningAsError)
- **Windows-only**: Uses DirectDraw, DirectSound, DirectInput
- **x86 primary target**: Win32 platform, though x64 is supported

## 6309 CPU Emulation Status

Some Hitachi 6309 instructions are unemulated or untested. See `docs/VCC-Notes.md` for the complete list. Reference documentation in `docs/The_6309_Book.pdf`.
