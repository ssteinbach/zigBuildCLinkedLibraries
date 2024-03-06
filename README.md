# zigBuildCLinkedLibraries

This repo demonstrates a question about zig build that we ran into, where an
executable that links against a zig module/library that in turn links against c
code ALSO needs to have the CSourceFile and include path added to it.  I'm
wondering how to encapsulate c dependencies correctly.  See `build.zig` for
more info.

Thanks!
