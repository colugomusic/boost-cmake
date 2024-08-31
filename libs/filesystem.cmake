_add_boost_lib(
  NAME filesystem
  SOURCES
    ${BOOST_SOURCE}/libs/filesystem/src/codecvt_error_category.cpp
    ${BOOST_SOURCE}/libs/filesystem/src/directory.cpp
    ${BOOST_SOURCE}/libs/filesystem/src/exception.cpp
    ${BOOST_SOURCE}/libs/filesystem/src/operations.cpp
    ${BOOST_SOURCE}/libs/filesystem/src/path.cpp
    ${BOOST_SOURCE}/libs/filesystem/src/path_traits.cpp
    ${BOOST_SOURCE}/libs/filesystem/src/portability.cpp
    ${BOOST_SOURCE}/libs/filesystem/src/unique_path.cpp
    ${BOOST_SOURCE}/libs/filesystem/src/utf8_codecvt_facet.cpp
    ${BOOST_SOURCE}/libs/filesystem/src/windows_file_codecvt.cpp
  DEFINE_PRIVATE
    BOOST_FILESYSTEM_STATIC_LINK=1
)

_add_boost_test(
  NAME filesystem_test
  LINK
    Boost::filesystem
  TESTS
    RUN ${BOOST_SOURCE}/libs/filesystem/test/convenience_test.cpp
    RUN ${BOOST_SOURCE}/libs/filesystem/test/macro_default_test.cpp
    RUN ${BOOST_SOURCE}/libs/filesystem/test/odr1_test.cpp
        ${BOOST_SOURCE}/libs/filesystem/test/odr2_test.cpp
    RUN ${BOOST_SOURCE}/libs/filesystem/test/deprecated_test.cpp
    RUN ${BOOST_SOURCE}/libs/filesystem/test/fstream_test.cpp
    RUN ${BOOST_SOURCE}/libs/filesystem/test/large_file_support_test.cpp
    RUN ${BOOST_SOURCE}/libs/filesystem/test/locale_info.cpp
    #RUN ${BOOST_SOURCE}/libs/filesystem/test/operations_test.cpp
    RUN ${BOOST_SOURCE}/libs/filesystem/test/path_test.cpp
    RUN ${BOOST_SOURCE}/libs/filesystem/test/path_unit_test.cpp
    RUN ${BOOST_SOURCE}/libs/filesystem/test/relative_test.cpp
    RUN ${BOOST_SOURCE}/libs/filesystem/example/simple_ls.cpp
    RUN ${BOOST_SOURCE}/libs/filesystem/example/file_status.cpp
)

if (CMAKE_SYSTEM_NAME STREQUAL DARWIN)
	target_compile_definitions(Boost_filesystem PRIVATE
		BOOST_FILESYSTEM_NO_CXX20_ATOMIC_REF=1
		BOOST_FILESYSTEM_HAS_POSIX_AT_APIS=0
	)
else()
	check_cxx_source_compiles("#include <${BOOST_SOURCE}/libs/filesystem/config/has_cxx20_atomic_ref.cpp>" BOOST_FILESYSTEM_HAS_CXX20_ATOMIC_REF)
	check_cxx_source_compiles("#include <${BOOST_SOURCE}/libs/filesystem/config/has_posix_at_apis.cpp>" BOOST_FILESYSTEM_HAS_POSIX_AT_APIS)
	target_compile_definitions(Boost_filesystem PRIVATE
		BOOST_FILESYSTEM_NO_CXX20_ATOMIC_REF=${BOOST_FILESYSTEM_HAS_CXX20_ATOMIC_REF}
		BOOST_FILESYSTEM_HAS_POSIX_AT_APIS=${BOOST_FILESYSTEM_HAS_POSIX_AT_APIS}
	)
endif()