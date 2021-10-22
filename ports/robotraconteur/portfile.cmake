include(vcpkg_common_functions)

if(MSVC)
set(VCPKG_CXX_FLAGS_DEBUG "${VCPKG_CXX_FLAGS_DEBUG} /bigobj")
set(VCPKG_C_FLAGS_DEBUG "${VCPKG_C_FLAGS_DEBUG} /bigobj")
endif()

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
	REPO johnwason/robotraconteur
	REF v0.15.3-rc3
	SHA512 8a4e43c25e3c4ca1e5fa59e3aaf6fb8f5de3b794dd6187fc4890c00cdc843ceb6494583f8b1d48e7c058cadabe7981a25d0457d5752b1df64b6170c9c0dd2f4f
	HEAD_REF master
	PATCHES
	  static-build.patch
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
	OPTIONS
	    -DBUILD_GEN=ON
		-DBUILD_SHARED_LIBS=OFF
)

vcpkg_install_cmake()

#vcpkg_fixup_cmake_targets(CONFIG_PATH "lib/cmake/robotraconteur")

if(CMAKE_HOST_WIN32)
file(INSTALL ${CURRENT_PACKAGES_DIR}/bin/RobotRaconteurGen.exe DESTINATION ${CURRENT_PACKAGES_DIR}/tools/robotraconteur)
else()
file(INSTALL ${CURRENT_PACKAGES_DIR}/bin/RobotRaconteurGen DESTINATION ${CURRENT_PACKAGES_DIR}/tools/robotraconteur)
endif()
vcpkg_copy_tool_dependencies(${CURRENT_PACKAGES_DIR}/tools/robotraconteur)

vcpkg_fixup_cmake_targets(CONFIG_PATH "lib/cmake/RobotRaconteur")

vcpkg_copy_pdbs()

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/bin/)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/bin)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/share)

file(COPY ${SOURCE_PATH}/LICENSE.txt DESTINATION ${CURRENT_PACKAGES_DIR}/share/robotraconteur/copyright)
