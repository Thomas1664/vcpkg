set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)
set(VCPKG_BUILD_TYPE release)

vcpkg_download_distfile(ARCHIVE
    URLS
        "http://eddylab.org/software/hmmer/hmmer-${VERSION}.tar.gz"
    FILENAME "hmmer-${VERSION}.tar.gz"
    SHA512 94a26f47e29a896d666bf10b7ce756f76f3fd883ed3d8901602c600cfe3e87f5575968950d655b6c625a9803ef4a56af0de13c6e14db04d8bfa4cefe91f807d8
)

vcpkg_extract_source_archive(
    SOURCE_PATH
    ARCHIVE "${ARCHIVE}"
)

if(VCPKG_TARGET_IS_OSX)
    # This ensures that vcpkg-fixup-macho-rpath succeeds
    string(APPEND VCPKG_LINKER_FLAGS " -headerpad_max_install_names")
endif()

vcpkg_make_configure(
    SOURCE_PATH "${SOURCE_PATH}"
)

vcpkg_make_install(TARGETS "install")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
