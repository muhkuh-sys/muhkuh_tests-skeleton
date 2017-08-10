# -*- coding: utf-8 -*-
#-------------------------------------------------------------------------#
#   Copyright (C) 2017 by Christoph Thelen                                #
#   doc_bacardi@users.sourceforge.net                                     #
#                                                                         #
#   This program is free software; you can redistribute it and/or modify  #
#   it under the terms of the GNU General Public License as published by  #
#   the Free Software Foundation; either version 2 of the License, or     #
#   (at your option) any later version.                                   #
#                                                                         #
#   This program is distributed in the hope that it will be useful,       #
#   but WITHOUT ANY WARRANTY; without even the implied warranty of        #
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the         #
#   GNU General Public License for more details.                          #
#                                                                         #
#   You should have received a copy of the GNU General Public License     #
#   along with this program; if not, write to the                         #
#   Free Software Foundation, Inc.,                                       #
#   59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.             #
#-------------------------------------------------------------------------#


#----------------------------------------------------------------------------
#
# Set up the Muhkuh Build System.
#
SConscript('mbs/SConscript')
Import('atEnv')


#----------------------------------------------------------------------------
#
# Create the build environments.
#
# Create a build environment for the ARM9 based netX chips.
env_arm9 = atEnv.DEFAULT.CreateEnvironment(['gcc-arm-none-eabi-4.7', 'asciidoc'])
# TODO: comment the next line out if no netX500 version should be build.
env_arm9.CreateCompilerEnv('NETX500', ['arch=armv5te'])
# TODO: comment the next line out if no netX51/52 version should be build.
env_arm9.CreateCompilerEnv('NETX56', ['arch=armv5te'])
# TODO: comment the next line out if no netX50 version should be build.
env_arm9.CreateCompilerEnv('NETX50', ['arch=armv5te'])
# TODO: comment the next line out if no netX10 version should be build.
env_arm9.CreateCompilerEnv('NETX10', ['arch=armv5te'])

# Create a build environment for the Cortex-R7 and Cortex-A9 based netX chips.
env_cortexR7 = atEnv.DEFAULT.CreateEnvironment(['gcc-arm-none-eabi-4.9', 'asciidoc'])
# TODO: comment the next line out if no netX4000 RELAXED version should be build.
env_cortexR7.CreateCompilerEnv('NETX4000_RELAXED', ['arch=armv7', 'thumb'], ['arch=armv7-r', 'thumb'])

# Create a build environment for the Cortex-M4 based netX chips.
env_cortexM4 = atEnv.DEFAULT.CreateEnvironment(['gcc-arm-none-eabi-4.9', 'asciidoc'])
# TODO: comment the next line out if no netX90 MPW version should be build.
env_cortexM4.CreateCompilerEnv('NETX90_MPW', ['arch=armv7', 'thumb'], ['arch=armv7e-m', 'thumb'])


#----------------------------------------------------------------------------
#
# Build the platform library.
#
SConscript('platform/SConscript')


#----------------------------------------------------------------------------
#
# Get the source code version from the VCS.
#
atEnv.DEFAULT.Version('targets/version/version.h', 'templates/version.h')


#----------------------------------------------------------------------------
#
# This is the list of sources. The elements must be separated with whitespace
# (i.e. spaces, tabs, newlines). The amount of whitespace does not matter.
#
# The list sources_common is used for all netX versions.
# The other lists like sources_netx500 contain special sources for this netX.
#
sources_common = """
        src/header.c
        src/init.S
        src/test_main.c
"""

sources_netx500 = """
"""

sources_netx56 = """
"""

sources_netx50 = """
"""

sources_netx10 = """
"""


#----------------------------------------------------------------------------
#
# Build the netX executables.
#

# Define the include paths for all builds.
aCppPath = ['src', '#platform/src', '#platform/src/lib', '#targets/version']

# The test name is used to build the file name of the executable.
# A test name of "skeleton" results in "skeleton_netx500.bin", "skeleton_netx56.bin" and so on.
strTestName = "skeleton"

# Build the netX500 executable.
if hasattr(atEnv, 'NETX500') == True:
    tEnv = atEnv.NETX500.Clone()
    tEnv.Replace(LDFILE = 'src/netx500/netx500.ld')
    tEnv.Append(CPPPATH = aCppPath)
    tSrc = tEnv.SetBuildPath('targets/netx500', 'src', sources_common + sources_netx500)
    tElf = tEnv.Elf('targets/netx500/test.elf', tSrc + tEnv['PLATFORM_LIBRARY'])
    tTxt = tEnv.ObjDump('targets/netx500/test.txt', tElf, OBJDUMP_FLAGS=['--disassemble', '--source', '--all-headers', '--wide'])
    test_netx500 = tEnv.ObjCopy('targets/netx500/%s_netx500.bin' % strTestName, tElf)


# Build the netX51/52 executable.
if hasattr(atEnv, 'NETX56') == True:
    tEnv = atEnv.NETX56.Clone()
    tEnv.Replace(LDFILE = 'src/netx56/netx56.ld')
    tEnv.Append(CPPPATH = aCppPath)
    tSrc = tEnv.SetBuildPath('targets/netx56', 'src', sources_common + sources_netx56)
    tElf = tEnv.Elf('targets/netx56/test.elf', tSrc + tEnv['PLATFORM_LIBRARY'])
    tTxt = tEnv.ObjDump('targets/netx56/test.txt', tElf, OBJDUMP_FLAGS=['--disassemble', '--source', '--all-headers', '--wide'])
    test_netx56 = tEnv.ObjCopy('targets/netx56/%s_netx56.bin' % strTestName, tElf)


# Build the netX50 executable.
if hasattr(atEnv, 'NETX50') == True:
    tEnv = atEnv.NETX50.Clone()
    tEnv.Replace(LDFILE = 'src/netx50/netx50.ld')
    tEnv.Append(CPPPATH = aCppPath)
    tSrc = tEnv.SetBuildPath('targets/netx50', 'src', sources_common + sources_netx50)
    tElf = tEnv.Elf('targets/netx50/test.elf', tSrc + tEnv['PLATFORM_LIBRARY'])
    tTxt = tEnv.ObjDump('targets/netx50/test.txt', tElf, OBJDUMP_FLAGS=['--disassemble', '--source', '--all-headers', '--wide'])
    test_netx50 = tEnv.ObjCopy('targets/netx50/%s_netx50.bin' % strTestName, tElf)


# Build the netX10 executable.
if hasattr(atEnv, 'NETX10') == True:
    tEnv = atEnv.NETX10.Clone()
    tEnv.Replace(LDFILE = 'src/netx10/netx10.ld')
    tEnv.Append(CPPPATH = aCppPath)
    tSrc = tEnv.SetBuildPath('targets/netx10', 'src', sources_common + sources_netx10)
    tElf = tEnv.Elf('targets/netx10/test.elf', tSrc + tEnv['PLATFORM_LIBRARY'])
    tTxt = tEnv.ObjDump('targets/netx10/test.txt', tElf, OBJDUMP_FLAGS=['--disassemble', '--source', '--all-headers', '--wide'])
    test_netx10 = tEnv.ObjCopy('targets/netx10/%s_netx10.bin' % strTestName, tElf)


#----------------------------------------------------------------------------
#
# Build the documentation.
#

# Get the default attributes.
aAttribs = atEnv.DEFAULT['ASCIIDOC_ATTRIBUTES']
# Add some custom attributes.
aAttribs.update(dict({
    # Use ASCIIMath formulas.
    'asciimath': True,

    # Embed images into the HTML file as data URIs.
    'data-uri': True,

    # Use icons instead of text for markers and callouts.
    'icons': True,

    # Use numbers in the table of contents.
    'numbered': True,

    # Generate a scrollable table of contents on the left of the text.
    'toc2': True,

    # Use 4 levels in the table of contents.
    'toclevels': 4
}))

tDoc = atEnv.DEFAULT.Asciidoc('targets/doc/skeleton.html', 'README.asciidoc', ASCIIDOC_BACKEND='html5', ASCIIDOC_ATTRIBUTES=aAttribs)


#----------------------------------------------------------------------------
#
# Make a local demo installation.
#

# Copy all executables.
if hasattr(atEnv, 'NETX500') == True:
    Install('targets/testbench/netx/', test_netx500)
if hasattr(atEnv, 'NETX56') == True:
    Install('targets/testbench/netx/', test_netx56)
if hasattr(atEnv, 'NETX50') == True:
    Install('targets/testbench/netx/', test_netx50)
if hasattr(atEnv, 'NETX10') == True:
    Install('targets/testbench/netx/', test_netx10)

# Copy the test template and fill out the ID and NAME fields.
# This will be done by the jonchki environment for real tests.
tTest = atEnv.DEFAULT.Filter('targets/tests/test01.lua', 'templates/test.lua', SUBSTITUTIONS={'ID':'01', 'NAME':'TestSkeleton'})
Install('targets/testbench/', tTest)
