const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    // library that links against the C code
    //////////////////////////////////////////
    const c_library_example = b.addStaticLibrary(
        .{
            .name = "cliblinkage",
            .root_source_file = .{ .path = "src/lib_that_calls_c.zig" },
            .target = target,
            .optimize = optimize,
        }
    );
    {
        c_library_example.addCSourceFile(
            .{ 
                .file = .{ .path = "src/foo.c" },
                .flags = &[_][]const u8{
            },
        }
        );
        c_library_example.addIncludePath(.{ .path = "src" });
        b.installArtifact(c_library_example);
    }

    // executable that links against the zig library - which ALSO needs link
    // information for the C code (??) even though it doesn't directly call or
    // use the c code
    ///////////////////////////////////////////////////////////////////////////
    const main_tests = b.addTest(
        .{
            .root_source_file = .{ .path = "src/exe_thing.zig" },
            .target = target,
            .optimize = optimize,
        }
    );
    main_tests.root_module.addImport(
        "clibLinkage",
        &c_library_example.root_module
    );

    const run_main_tests = b.addRunArtifact(main_tests);
    const test_step = b.step("test", "Run library tests");
    test_step.dependOn(&run_main_tests.step);
}
