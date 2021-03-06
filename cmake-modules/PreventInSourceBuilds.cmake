#
# This function will prevent in-source builds
function(AssureOutOfSourceBuilds project_name)
  # make sure the user doesn't play dirty with symlinks
  get_filename_component(srcdir "${CMAKE_SOURCE_DIR}" REALPATH)
  get_filename_component(bindir "${CMAKE_BINARY_DIR}" REALPATH)

  # disallow in-source builds
  if("${srcdir}" STREQUAL "${bindir}")
    message("###########################################################################")
    message("# ${project_name} should not be configured & built in the ${project_name} source directory")
    message("# You must run cmake in a build directory.")
    message("# For example:")
    message("#")
    message("#     mkdir ${project_name}-Sandbox ; cd ${project_name}-sandbox")
    message("#")
    message("# Check out source code in ${project_name}-sandbox")
    message("#")
    message("#     mkdir ${project_name}-build")
    message("#")
    message("# this will create the following directory structure")
    message("#")
    message("# ${project_name}-Sandbox")
    message("#  +--${project_name}")
    message("#  +--${project_name}-build")
    message("#")
    message("# Then you can proceed to configure and build")
    message("# by using the following commands")
    message("#")
    message("#     cd ${project_name}-build")
    message("#     cmake ../${project_name} # or ccmake, or cmake-gui")
    message("#     make")
    message("#")
    message("# NOTE: Given that you already tried to make an in-source build")
    message("#       CMake have already created several files & directories")
    message("#       in your source tree.")
    message("#")
    message("# The following command will show you all files not part of ${project_name}")
    message("#       cd ${project_name}-Sandbox/${project_name}")
    message("#       svn status | grep '[^?]' | awk '{print \$2}'")
    message("#")
    message("# WARNING: if you have added files to ${project_name} but not used svn add")
    message("# to add them to SVN's version control, this command will display them")
    message("# along with the files CMake created during configuration.  You will need")
    message("# to either save them outside the ${project_name} source tree, or run svn add")
    message("# to let SVN know they are legitimate source files.")
    message("# Once you've verified that all unknown files are the result of CMake")
    message("# configuration, you can run this command to clean them up")
    message("#       svn status | grep '[^?]' | awk '{print \$2}' | xargs rm -fr")
    message("###########################################################################")
    message(FATAL_ERROR "Quitting configuration")
  endif()
endfunction()

AssureOutOfSourceBuilds(${CMAKE_PROJECT_NAME})
