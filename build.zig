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
            .link_libc = true,  // 链接 C 标准库
        }),
    });

    // 添加 C 源文件
    exe.addCSourceFiles(.{
        .files = &.{
            "src/main.c",
            "src/foo.c",
        },
        .flags = &.{
            "-Wall",      // 开启所有警告
            "-Wextra",    // 开启额外警告
            "-std=c11",   // 使用 C11 标准
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
}
