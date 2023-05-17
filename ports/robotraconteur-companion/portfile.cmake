vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO robotraconteur/robotraconteur_companion
    REF v0.2.0
    SHA512 68c76bdecc784a6087135fd96ed88de4a0588f67b1561e6f3b59cd9ee5045ba57dde6078fdf91b6df7c1278e2b92c1233ac5a88cfb2b3dacea233e533235e5c1
    HEAD_REF master
)

vcpkg_from_github(
    OUT_SOURCE_PATH ROBDEF_SOURCE_PATH
    REPO robotraconteur/robotraconteur_standard_robdef
    REF group1-v1
    SHA512 84724717e57c6e7ceefa957a8d94ee68db189e9a114564662d37b16a307735feea2a01c5622140118f537e6c084437d4bf11d0eb1e015b475fb3b636ed5009aa
    HEAD_REF master
)

file(COPY ${ROBDEF_SOURCE_PATH}/group1 DESTINATION ${SOURCE_PATH}/robdef/)

vcpkg_cmake_configure(
    SOURCE_PATH ${SOURCE_PATH}
)

vcpkg_cmake_install()

vcpkg_fixup_cmake_targets(CONFIG_PATH "lib/cmake/RobotRaconteurCompanion")

vcpkg_copy_pdbs()

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/share)

file(INSTALL "${SOURCE_PATH}/LICENSE.txt" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}" RENAME copyright)
