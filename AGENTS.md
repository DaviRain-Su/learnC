# AGENTS.md

Guide for AI agents working in this C learning repository.

## Project Overview

This is a C programming learning repository built with the **Zig build system**. The project uses Zig as a build tool to compile C code, not to write Zig code. All source code is pure C11.

- **Language**: C11 standard
- **Build System**: Zig build system (minimum version 0.15.2)
- **Purpose**: Learning and practicing C programming concepts
- **Output Binary**: `hello` (name specified in build.zig)

## Essential Commands

### Build
```bash
zig build
```
Compiles all C source files. Output goes to `zig-out/bin/hello`.

### Run
```bash
zig build run
```
Builds and runs the application. Can pass arguments:
```bash
zig build run -- arg1 arg2
```

### Check (LSP/ZLS)
```bash
zig build check
```
Checks compilation without producing output. Used by Zig Language Server for IDE integration.

### Clean
```bash
rm -rf zig-out .zig-cache
```
Remove build artifacts (these directories are gitignored).

## Project Structure

```
learnC/
├── build.zig           # Zig build configuration
├── build.zig.zon       # Zig package metadata
├── compile_flags.txt   # Compiler flags for clangd/LSP
├── include/            # Header files (.h)
│   └── foo.h
├── src/                # C source files (.c)
│   ├── main.c
│   └── foo.c
└── README.md
```

### File Organization

- **Headers**: All `.h` files go in `include/` directory
- **Source**: All `.c` files go in `src/` directory
- **Build artifacts**: Generated in `zig-out/` and `.zig-cache/` (gitignored)

### Adding New Files

When adding new C source files:

1. **Source files**: Add to `src/` directory
2. **Update build.zig**: Add filename to the `.files` array in `addCSourceFiles`:
   ```zig
   exe.addCSourceFiles(.{
       .files = &.{
           "src/main.c",
           "src/foo.c",
           "src/newfile.c",  // Add here
       },
       // ...
   });
   ```
3. **Headers**: Add to `include/` directory (automatically found via `addIncludePath`)

## Code Conventions

### C Standard and Warnings

- **Standard**: C11 (`-std=c11`)
- **Warnings**: All warnings enabled (`-Wall -Wextra`)
- Always fix warnings - the codebase aims to be warning-free

### Style Patterns

Based on existing code:

1. **Header Guards**: Use traditional `#ifndef` guards
   ```c
   #ifndef FOO_H
   #define FOO_H
   // declarations
   #endif
   ```

2. **Variable Declarations**: Declare at the top of functions or blocks (C89 style, though C11 allows anywhere)
   ```c
   int power(int base, int n) {
       int i, p;  // Declared at top
       p = 1;
       for (i = 1; i <= n; ++i)
           // ...
   }
   ```

3. **Comments**: Use C++ style `//` for single-line comments and Chinese comments are present in code
   ```c
   // power: 计算 base 的 n 次方; n >= 0
   ```

4. **Braces**: K&R style for functions, but loop bodies may omit braces for single statements
   ```c
   int main() {  // Opening brace on same line
       for (i = 1; i <= n; ++i)
           p = p * base;  // Single statement, no braces
       return 0;
   }
   ```

5. **Increment/Decrement**: Mix of `++i` (prefix) and `i += 1` seen in codebase

### Naming Conventions

- **Functions**: Lowercase with underscores (e.g., `power()`)
- **Variables**: Short, descriptive names (e.g., `nc` for "number of characters", `nl` for "number of lines")
- **Headers**: Match the source file name (e.g., `foo.c` → `foo.h`)

## Build Configuration Details

### Compiler Flags (from build.zig)

- `-Wall`: Enable all warnings
- `-Wextra`: Enable extra warnings
- `-std=c11`: Use C11 standard

### LSP Configuration

The `compile_flags.txt` file provides flags for clangd/LSP:
```
-Iinclude
-Wall
-Wextra
-std=c11
```

This ensures IDE tools understand the include paths and compilation settings.

### Zig Build System Notes

- **Links libc**: The build configuration explicitly links the C standard library (`link_libc = true`)
- **Cross-compilation**: Can target different platforms using `zig build -Dtarget=...`
- **Optimization**: Can set optimization level with `-Doptimize=ReleaseFast|ReleaseSafe|ReleaseSmall|Debug`

## Common Patterns in Code

### Input Processing

The main.c demonstrates character counting pattern:
```c
int c = 0;
for(int c = 0; c != EOF; nc += 1) {
    if (c == '\n') {
        nl += 1;
    }
    c = getchar();
}
```

### Function Structure

Helper functions in separate files with headers:
- Declaration in header file (`include/foo.h`)
- Implementation in source file (`src/foo.c`)
- Include the header in both the implementation and any file that uses it

## Gotchas and Important Notes

1. **EOF Detection**: Use `!= EOF` rather than testing for negative values
2. **Character Input**: Use `getchar()` for reading standard input character by character
3. **Build System**: Don't run `gcc` or `clang` directly - always use `zig build`
4. **Include Paths**: Headers in `include/` directory are found automatically; use `#include "foo.h"` not `#include "include/foo.h"`
5. **Git Commits**: Recent commits show iterative learning approach (refactoring, fixing warnings, adding features)
6. **No Tests**: This project has no automated tests - it's for learning/experimentation

## Recent Development Patterns

Based on git history:

- Small, focused commits per concept/fix
- Commits in English with descriptive messages
- Iterative refinement (e.g., "refactor count", "fix warning")
- Each program demonstrates a specific C concept
- Progressive learning approach (hello world → variables → functions → I/O)

## Language Notes

- **Comments**: Mixed Chinese and English
- **Documentation**: Chinese comments explaining functions acceptable
- **Commit messages**: English

## When Making Changes

1. ✅ Read existing code to understand current patterns
2. ✅ Match existing style (K&R braces, C11 standard)
3. ✅ Keep warnings clean (`zig build` should show no warnings)
4. ✅ Update build.zig if adding new source files
5. ✅ Test with `zig build run`
6. ❌ Don't add complex tooling (this is a learning repo)
7. ❌ Don't change the build system unnecessarily
8. ❌ Don't fix style retroactively unless asked
