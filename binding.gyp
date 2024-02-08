{
    "conditions": [
        ["OS == 'win'",
            {
                "variables": {
                    "glfw_libname%":"glfw3",
                }
            },
            {
                "variables": {
                    "glfw_libname%":"glfw3",
                }
            }
        ]
    ],
    "variables": {
        "glfw%":"internal",
        "module_name": "node_glfw",
    },
    "targets": [
        {
            "target_name": "<(module_name)",
            "cflags!": [ "-fno-exceptions" ],
            "cflags_cc!": [ "-fno-exceptions" ],
            "xcode_settings": {
                "GCC_ENABLE_CPP_EXCEPTIONS": "YES",
                "CLANG_CXX_LIBRARY": "libc++",
                "MACOSX_DEPLOYMENT_TARGET": "10.7",
            },
            "msvs_settings": {
                "VCCLCompilerTool": {
                    "ExceptionHandling": 1
                },
                "VCLinkerTool": {
                    "AdditionalLibraryDirectories": [
                        "<(glfw)/lib"
                    ]
                }
            },
            "conditions": [
                ["'<(glfw)' == 'internal'",
                    {
                        "dependencies": [
                            "deps/glfw.gyp:glfw"
                        ],
                        "libraries": [
                            "-l<(glfw_libname)"
                        ]
                    },
                    {
                        "include_dirs": [
                            "<(glfw)/include"
                        ],
                        "libraries": [
                            "-l<(glfw_libname)"
                        ],
                        "conditions": [
                            ["OS == 'linux'",
                                {
                                    "libraries+": [
                                        "-Wl,-rpath=<@(glfw)/lib"
                                    ]
                                }
                            ],
                            ["OS != 'win'",
                                {
                                    "libraries+": [
                                        "-L<@(glfw)/lib"
                                    ]
                                }
                            ]
                        ]
                    }
                ]
            ],
            "sources": [
                "./src/native/addon.cpp"
            ],
            "defines": [
                "NAPI_VERSION=<(napi_build_version)",
                "NAPI_DISABLE_CPP_EXCEPTIONS=1"
            ]
        }
    ]
}
