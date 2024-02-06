{
    "targets": [
        {
            "target_name": "configure_glfw",
            "type": "none",
            "actions": [
                {
                    "action_name": "configure_glfw",
                    "inputs": [
                        "./glfw/CMakeLists.txt"
                    ],
                    "outputs": [
                        "<(SHARED_INTERMEDIATE_DIR)/glfw-build/CMakeCache.txt"
                    ],
                    "action": [
                        "cmake",
                        "-S",
                        "./glfw/",
                        "-B",
                        "<(SHARED_INTERMEDIATE_DIR)/glfw-build/",
                        "-DCMAKE_INSTALL_PREFIX=<(SHARED_INTERMEDIATE_DIR)/glfw/",
                        "-DCMAKE_BUILD_TYPE=Release",
                        "-DBUILD_SHARED_LIBS=OFF",
                        "-DGLFW_BUILD_EXAMPLES=OFF",
                        "-DGLFW_BUILD_TESTS=OFF",
                        "-DGLFW_BUILD_DOCS=OFF",
                        "-DGLFW_INSTALL=ON"
                    ]
                }
            ]
        },
        {
            "target_name": "build_glfw",
            "type": "none",
            "dependencies": [
                "configure_glfw"
            ],
            "actions": [
                {
                    "action_name": "build_glfw",
                    "inputs": [
                        "<(SHARED_INTERMEDIATE_DIR)/glfw-build/CMakeCache.txt"
                    ],
                    "outputs": [
                        "<(SHARED_INTERMEDIATE_DIR)/glfw-build/src/libglfw3.a"
                    ],
                    "action": [
                        "cmake",
                        "--build",
                        "<(SHARED_INTERMEDIATE_DIR)/glfw-build/",
                        "--config",
                        "Release"
                    ]
                }
            ]
        },
        {
            "target_name": "install_glfw",
            "type": "none",
            "dependencies": [
                "build_glfw"
            ],
            "actions": [
                {
                    "action_name": "install_glfw",
                    "inputs": [
                        "<(SHARED_INTERMEDIATE_DIR)/glfw-build/src/libglfw3.a"
                    ],
                    "outputs": [
                        "<(SHARED_INTERMEDIATE_DIR)/glfw/lib/libglfw3.a"
                    ],
                    "action": [
                        "cmake",
                        "--install",
                        "<(SHARED_INTERMEDIATE_DIR)/glfw-build/",
                        "--config",
                        "Release"
                    ]
                }
            ]
        },
        {
            "target_name": "glfw",
            "type": "none",
            "hard_dependency": 1,
            "dependencies": [
                "install_glfw"
            ],
            "direct_dependent_settings": {
                "include_dirs": [
                    "<(SHARED_INTERMEDIATE_DIR)/glfw/include/"
                ],
                "conditions": [
                    ["OS == 'linux'",
                        {
                            "libraries+": [
                                "-Wl,-rpath=<(SHARED_INTERMEDIATE_DIR)/glfw/lib"
                            ]
                        }
                    ],
                    ["OS != 'win'",
                        {
                            "libraries+": [
                                "-L<(SHARED_INTERMEDIATE_DIR)/glfw/lib"
                            ]
                        }
                    ]
                ]
            }
        }
    ]
}
