
Visual Studio Code for C++ Development
======================================

These are the problems I had to overcome stting up VS Code for C++ and the weblinks I used.

Support for C++ in VS Code is documented here;

* https://code.visualstudio.com/docs/languages/cpp

This article is also a great overview that goes into further details of settin up C++ support in VS Code; 

* https://blogs.msdn.microsoft.com/vcblog/2016/03/31/cc-extension-for-visual-studio-code/

Configuring `c_cpp_properties.json`
-----------------------------------

* https://github.com/Microsoft/vscode-cpptools/blob/master/Documentation/LanguageServer/c_cpp_properties.json.md

Configuring VS Code User / Workspace Settings `settings.json`
-------------------------------------------------------------

I had a problem getting the error squiggles to appear in the source file (on Windows)
The error squiggles were not appearing because the intellisense engine was defaulting back to Tag Parser
which provides Fuzzy intellisense which removes the error squiggles. The solution was to set the value

```json
"C_Cpp.intelliSenseEngineFallback": "Disabled"
```

For some reason this does not seem to be required in Mac OS.  

* https://github.com/Microsoft/vscode-cpptools/blob/master/Documentation/Getting%20started%20with%20IntelliSense%20configuration.md

Compile / Link Errors on Mac OS
-------------------------------

```
Undefined symbols for architecture x86_64:
ld: symbol(s) not found for architecture x86_64
```

The error is caused because you're compiling with `gcc`, which only default-links libc.
You need to compile with `g++` so that `libstdc++` is auto-linked in too.

* https://stackoverflow.com/questions/8034568/undefined-symbols-for-architecture-x86-64-which-architecture-should-i-use

Configuring `launch.json` for C/C++ debugging
-------------------------------------------
Once I had built the executable the VS Code debugger would not step into the source code or stop on breakpoints. 
This was easy to fix because I had forgotten to compile with debug symbols. 

Simply a matter of compiling with the `-g` compiler option.
In fact I found out that it is better to compile with `clang++` and not `g++` on Mac OS

* https://www.quora.com/Why-does-the-gcc-command-on-MacOS-execute-clang
* https://github.com/Microsoft/vscode-cpptools/blob/master/launch.md

Compile the Current File
------------------------

I wanted to be able to compile the single current file I was working on (like CTRL+F7 in Visual Studio 2015)
The key to this was being able to pass the current active filename to the build task. 

The answer is to use the `${file}` and `${fileBasenameNoExtension}` variables in the `tasks.json`
Variable `${fileBasenameNoExtension}` does not appear to be documented but it is mentioned in the GitHub issue.

* https://github.com/Microsoft/vscode/issues/1104
* https://code.visualstudio.com/docs/editor/tasks#_variable-substitution
