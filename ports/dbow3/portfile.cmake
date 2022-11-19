vcpkg_check_linkage(ONLY_DYNAMIC_LIBRARY)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO rmsalinas/DBow3
    REF v1.1-nonfree
    SHA512 7ce928a3bf66cbbef8d72fdca9585db8209cc22af60a0fdb2bc388c3723fe44db1ad70de50645decb2013a440fd60cca22680857b61e2643a94ded3548fbd9bf
    HEAD_REF master
    PATCHES
        fix_cmake.patch
)

vcpkg_from_github(
    OUT_SOURCE_PATH DLIB_SOURCE_PATH
    REPO dorian3d/DLib
    REF v1.1-nonfree
    SHA512 ab86b0f086cadb5703a1993e0ebde171626c2118f791eb214061cf3a523c4ed077049975aa865a51b0a5479c61a9029876dddb111c632775691ea1dd1d5fe38c
    HEAD_REF master
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        -DBUILD_Demo=OFF
)

vcpkg_cmake_configure(
    SOURCE_PATH "${DLIB_SOURCE_PATH}"
)

vcpkg_cmake_install()
vcpkg_cmake_install()

vcpkg_cmake_config_fixup(CONFIG_PATH cmake/DBow3)

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")

vcpkg_copy_pdbs()

file(INSTALL "${SOURCE_PATH}/LICENSE.txt" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}" RENAME copyright)
