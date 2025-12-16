const std = @import("std");

pub fn build(b: *std.Build) void {
    // 标准目标选项（允许通过命令行指定目标平台）
    const target = b.standardTargetOptions(.{});
    // 标准优化选项（Debug/ReleaseSafe/ReleaseFast/ReleaseSmall）
    const optimize = b.standardOptimizeOption(.{});

    // 创建可执行文件
    const exe = b.addExecutable(.{
        .name = "hello",
        .root_module = b.createModule(.{
            .target = target,
            .optimize = optimize,
            .link_libc = true, // 链接 C 标准库
        }),
    });

    // 添加 C 源文件
    exe.addCSourceFiles(.{
        .files = &.{
            "src/main.c",
            "src/foo.c",
        },
        .flags = &.{
            "-Wall", // 开启所有警告
            "-Wextra", // 开启额外警告
            "-std=c11", // 使用 C11 标准
        },
    });

    // 头文件搜索路径
    exe.addIncludePath(b.path("include"));

    // 安装构建产物
    b.installArtifact(exe);

    // 添加 run 命令
    const run_cmd = b.addRunArtifact(exe);
    run_cmd.step.dependOn(b.getInstallStep());

    // 允许传递命令行参数
    if (b.args) |args| {
        run_cmd.addArgs(args);
    }

    // 创建 "zig build run" 步骤
    const run_step = b.step("run", "Run the application");
    run_step.dependOn(&run_cmd.step);

    // ==========================================
    // 2. 构建测试 (Zig 测试 C 代码)
    // ==========================================
    const lib_unit_tests = b.addTest(.{
        .root_module = b.createModule(.{
            .root_source_file = b.path("tests/test_leetcode.zig"),
            .target = target,
            .optimize = optimize,
        }),
    });

    // 链接 LibC
    lib_unit_tests.linkLibC();

    // 添加头文件路径 (让 Zig 测试文件能 @cInclude)
    lib_unit_tests.addIncludePath(b.path("include"));

    // 添加被测试的 C 源文件 (leetcode.c)
    // 这里使用单数 addCSourceFile，因为通常测试只需要链接特定的实现文件
    lib_unit_tests.addCSourceFile(.{
        .file = b.path("src/leetcode.c"),
        .flags = &.{
            "-std=c99",
            "-Wall",
        },
    });

    // ==========================================
    // Test 命令配置
    // ==========================================
    const run_lib_unit_tests = b.addRunArtifact(lib_unit_tests);

    const test_step = b.step("test", "Run unit tests");
    test_step.dependOn(&run_lib_unit_tests.step);

    // ==========================================
    // 3. Rust 构建与测试
    // ==========================================
    const cargo_run = b.addSystemCommand(&.{ "cargo", "run" });
    cargo_run.cwd = b.path("rust");

    const cargo_build = b.addSystemCommand(&.{ "cargo", "build" });
    cargo_build.cwd = b.path("rust");

    const cargo_test = b.addSystemCommand(&.{ "cargo", "test" });
    cargo_test.cwd = b.path("rust");

    const rust_step = b.step("rust", "Build and test Rust code");
    rust_step.dependOn(&cargo_run.step);
    rust_step.dependOn(&cargo_build.step);
    rust_step.dependOn(&cargo_test.step);

    // 让标准 test 步骤也包含 Rust 测试
    test_step.dependOn(&cargo_test.step);

    // Check 步骤 (给 ZLS 用的)
    const check_step = b.step("check", "Check compilation");
    check_step.dependOn(&exe.step);
    check_step.dependOn(&lib_unit_tests.step);
}
