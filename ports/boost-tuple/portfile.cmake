# Automatically generated by scripts/boost/generate-ports.ps1

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO boostorg/tuple
    REF boost-${VERSION}
    SHA512 11ea811ce559c3cd810aed21362e5bb3e9aaadc01f08289f4f1b9db9b48d8ffdfbf158596fa54513e4f53e97da3a6344f80c0e6de5c992dfe2cc91e087fa5def
    HEAD_REF master
)

set(FEATURE_OPTIONS "")
boost_configure_and_install(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS ${FEATURE_OPTIONS}
)
