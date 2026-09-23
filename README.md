[![CI](https://github.com/KornnerStudios/Vita/actions/workflows/continuous_integration.yml/badge.svg)](https://github.com/KornnerStudios/Vita/actions/workflows/continuous_integration.yml)

[![Build status - main](https://ci.appveyor.com/api/projects/status/xhbxf0u5udky4t11/branch/main?svg=true)](https://ci.appveyor.com/project/kornman00/vita/branch/main)

# What is Vita?

Vita _was_ the codename for what are now just the KSoft libraries.

Vita is the logical amalgatmation of many related and dependent codebases, primarily written in C++ and C#.NET, which are produced and developed by Kornner Studios.

Vita began as a closed source project back in November of 2009 (so we predate the [PS Vita][WikiPSVita]). It wasn't until the beginning of 2014 when it was transitioned to an open source product.

As of 2020, we've switched to git. Previously, many of the projects were using Hg for source control. Since the move to git, we setup this monolithic repository to link together everything via the power of submodules!

Etymologically speaking, "Vita" is the Latin word for "life". If you're reading this, then it is very likely that coding is a part of your life, as it is to Vita's developers.

[WikiPSVita]: http://en.wikipedia.org/wiki/PlayStation_Vita#Post-announcement

# What is KSoft?
KSoft is the codename of the C#/.NET-centric part of the Vita codebase.

The [KSoft.BCL][KSoftBCL] (Base Class Libraries) embodies many generalized systems that we have developed to supplement our specialized projects (which are located in external repositories).

Some projects are open source (eg, [KSoft.Blam][KSoftBlam], for targeting the [Halo][WikiHaloFPS] engine), some closed (eg, KSoft.XDK, for targeting multi-generation [Xbox Development Kits][WikiXDK]).

[KSoftBCL]: https://github.com/KornnerStudios/KSoft
[KSoftBlam]: https://github.com/KornnerStudios/KSoft.Blam
[WikiHaloFPS]: http://en.wikipedia.org/wiki/Halo_%28series%29#Original_trilogy
[WikiXDK]: http://en.wikipedia.org/wiki/Xbox_Development_Kit

# License?
The default license of Vita projects is the [MIT License][LicenseMIT]

[LicenseMIT]: http://www.linfo.org/mitlicense.html

# KSoft.BCL Goals
The [KSoft Base Class Library][KSoftBCL] aims to provide a compartmentalized framework which provides functionality not present, or at least efficiently, in the .NET framework proper.

"Compartmentalized", in that non-critical systems like KSoft.Security are outside the actual root assembly, just named "KSoft".

Examples include stream-based bit-level I/O and readable helpers for generic enum flag mutation.

KSoft uses Roslyn source generators for repeated C# surfaces such as numeric overload matrices. The former T4 assets are preserved in Git history and the KSoft `pre-t4-removal` tag.

## Our BitStream
You will actually be hard pressed to find a decent, comprehensive BitStream class for .NET anywhere on The 'Net. The most comprehensive one that I know of is featured in [a CodeProject article][CodeProjectBitStream]. To compare the two:

* **They** require a complete, internal copy of the stream's bytes; **KSoft** supports actual streaming (using a BaseStream) and use a configurable (at compile time) cache 'word' (32 or 64 bits) where bits reside until being flushed to the BaseStream

* **They** were last updated in 2005 and have unpatched bugs; **KSoft** has a tried and tested class. Tested in both regular use and with Unit Tests to validate core operations. A patched version of the article is used in our Unit Testing to check compatibility

* **They** have a #region infested, monolithic .cs file; **KSoft** makes use of partial classes and Roslyn source generators to keep the files _bite_-sized and copy&paste code to a minimum

[CodeProjectBitStream]: http://www.codeproject.com/Articles/12261/A-BitStream-Class-for-the-NET-Framework

## [Flags]Enum++
Vita uses the .NET APIs for enum flag testing and comparison, while KSoft retains helpers for readable flag mutation. See the enum section in `KSoft\README.md` for details.

## Building
Before you try building any of the projects, first [read the requirements][VitaRequirements] you may need.

[VitaRequirements]: https://github.com/KornnerStudios/Vita/wiki/Requirements
