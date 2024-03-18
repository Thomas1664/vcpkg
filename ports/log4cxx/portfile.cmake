vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO apache/logging-log4cxx
    REF "rel/v${VERSION}"
    SHA512 8ef1de065608ed80b4de2398729a78fdf223d1f0bd2dee03e8c6a55ca0acd0f7ad110f123681198ef3e7ff4d568029999819041370f49767dba8360cb770878d
    HEAD_REF master
    PATCHES
        fix-find-package.patch
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        -DLOG4CXX_INSTALL_PDB=OFF # Installing pdbs failed on debug static. So, disable it and let vcpkg_copy_pdbs() do it
        -DBUILD_TESTING=OFF
        -DCMAKE_DISABLE_FIND_PACKAGE_fmt=ON
)

vcpkg_cmake_install()
vcpkg_copy_pdbs()

vcpkg_cmake_config_fixup(CONFIG_PATH lib/cmake/log4cxx)

if(VCPKG_TARGET_IS_LINUX OR VCPKG_TARGET_IS_OSX)
    vcpkg_fixup_pkgconfig()
endif()

file(READ "${CURRENT_PACKAGES_DIR}/share/${PORT}/log4cxxConfig.cmake" _contents)
file(WRITE "${CURRENT_PACKAGES_DIR}/share/${PORT}/log4cxxConfig.cmake"
    "include(CMakeFindDependencyMacro)
find_dependency(expat CONFIG)
${_contents}"
)

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include" "${CURRENT_PACKAGES_DIR}/debug/share")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
