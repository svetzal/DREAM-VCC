## DREAM - The Tandy Color Computer 3 Emulator
DREAM is a Tandy Color computer 3 Emulator for Microsoft Windows. It is a fork of [VCC](https://github.com/VCCE/VCC) with the primary goal of improving the overall quality of the code and providing accurate emulation of the original hardware. DREAM, much like VCC, is in very active development and is not considered stable or accurate in ts emulation. In spite of that DREAM does currently work and function quite well with a very broad range of software written for the Tandy Color Computer.

For DREAM usage, see the User Guide at [DREAM Wiki](https://github.com/ChetSimpson/DREAM-VCC/wiki). The wiki also contains release notes and additional documents. Online documentation may reflect some features not available in earlier versions or that are pre-release.

DREAM is licensed under the GNU General Public License v3.0. See the [LICENSE](COPYING) file for more details.

## Features

DREAM emulates a stock 128k CoCo 3 and additional products, including:

- **Tandy Multi-Pak Interface**. Includes rour expansion slots selectable from both hardware and software.
- **Tandy FD-502 Floppy Disk Drive Controller with integrated Becker Port**. Includes Disk Extended BASIC, four configurable virtual disk drives, and a built-in Becker Port for connecting to DriveWire Servers.
- **Orchestra-90 CC**. A five-voice music sequencer with stereo 8-bit DACs.
- **Becker Port**. Simple serial device for connecting to DriveWire servers.
- **Game Master Cartridge**. ROM cartridge with built-in SN-76496 programmable sound generator and paged ROM banks.
- **Memory Expansions**: Up to 8192k.
- **CPU Replacement**: Swap the Motorola 6809 CPU with a Hitachi 6309.




## Obtaining DREAM

Sources and binaries for DREAM can be found at [DREAM Releases](https://github.com/ChetSimpson/DREAM-VCC/releases). It is recommended to use the "latest" release.

Please be aware that the binaries provided with DREAM releases, including the installers, are not digitally signed. It is likely you will be presented with Windows security warnings when you first run them. Alternatively, you can build the version of your choice from the sources available with the release.

Occasionally Virus detection software might flag DREAM binaries due to false positives, even if you build from sources. If you encounter these issues you may be able to add an exception for DREAM in the protection software you are using. Every effort is taken to keep DREAM safe to use but be aware there is no warranty that the instance of DREAM you are running actually is.

## Building DREAM
DREAM is written in C++ and can be built using the Microsoft Build Tools or Microsoft Visual Studio 2022 or later.

## Contributing to DREAM
We welcome contributions that are consistent with our goals. We are working on a more comprehensive guide to provide details, check back in the future.
