
# --- local/mygtest                                        [deploy][setup.cmake]
# [2023-08-05][19:00:00] 007 Kartonagnick PRE
#   --- WorkSpace project (CastleOfDreams)                 [deploy][setup.cmake]
#   [2022-06-18][19:00:00] 006 Kartonagnick
#   [2022-06-09][19:00:00] 005 Kartonagnick BUG   
#   [2022-05-24][19:00:00] 004 Kartonagnick
#   [2022-05-20][19:00:00] 003 Kartonagnick BUG 
#   [2022-05-10][19:00:00] 002 Kartonagnick BUG
#   [2022-04-15][19:00:00] 001 Kartonagnick BUG
################################################################################
#
#  Mission:
#    Search path to directory by symptoms
#
#  Usage: 
#    check_symptoms(result "C:\project", "docs;deploy")
#      if success -> "C:\project"
#      else -> ""
#
#    find_symptoms(result "C:\project", "docs;deploy", "LICENSE;README.md")
#      if success -> path to detected directory
#      else -> ""
#
################################################################################
#
#  Mission:
#    Search paths to work directories
#
#  Usage: 
#    detect_dir_workspace()      if success -> set value: gDIR_WORKSPACE
#    detect_dir_scenario()       if success -> set value: gDIR_SCENARIO
#    detect_dir_scripts()        if success -> set value: gDIR_SCRIPTS
#    detect_dir_source()         if success -> set value: gDIR_SOURCE
#    detect_name_project()       if success -> set value: gNAME_PROJECT
#
################################################################################

function(has_value variable result)
  if("${${variable}}" STREQUAL "")
    set(${result} "" PARENT_SCOPE)
  else()
    set(${result} ON PARENT_SCOPE)
  endif()
endfunction()

################################################################################
################################################################################

function(check_symptoms d_where symptoms var_output)
  foreach(symptom ${symptoms})
    if(EXISTS "${d_where}/${symptom}")
      set(${var_output} "ON" PARENT_SCOPE)
      return()
    endif()
  endforeach()
  set(${var_output} "" PARENT_SCOPE)
endfunction()

function(find_symptoms var_output where)  # ${ARGN}
  math(EXPR n "${ARGC} - 1")
  foreach(d_cur ${where})
    while("ON")
      foreach(i RANGE 2 ${n})
        set(symptoms ${ARGV${i}})
        check_symptoms("${d_cur}" "${symptoms}" result)
        if(NOT result)
          break()
        endif()
      endforeach()
      if(result) 
        set(${var_output} "${d_cur}" PARENT_SCOPE)
        return()
      endif()
      get_filename_component(parent "${d_cur}/.." ABSOLUTE)
      if(parent STREQUAL d_cur)
        break()
      endif()
      set(d_cur "${parent}")
    endwhile()
  endforeach()
  set(${var_output} "" PARENT_SCOPE)
endfunction()

################################################################################
################################################################################

function(detect_dir_source)
  set(eDIR_SOURCE "$ENV{eDIR_SOURCE}")
  if(NOT eDIR_SOURCE STREQUAL "")
    if(NOT IS_DIRECTORY "${eDIR_SOURCE}")
      message("eDIR_SOURCE: ${eDIR_SOURCE}")
      message(FATAL_ERROR "eDIR_SOURCE: must be real directory")
    endif()
    file(TO_CMAKE_PATH "${eDIR_SOURCE}" gDIR_SOURCE)
  else()
    find_symptoms(gDIR_SOURCE 
      "${CMAKE_CURRENT_SOURCE_DIR}" 
      "src;source;sources;project.root;.git;.gitignore"
      "README.md;LICENSE" 
      "include;deploy;docs" 
    )
    if(gDIR_SOURCE STREQUAL "")
      message(FATAL_ERROR "gDIR_SOURCE: not found")
    endif()
    set(ENV{eDIR_SOURCE} "${gDIR_SOURCE}")
  endif()
  set(gDIR_SOURCE "${gDIR_SOURCE}" PARENT_SCOPE)
endfunction()

################################################################################

function(detect_dir_workspace)
  set(eDIR_WORKSPACE "$ENV{eDIR_WORKSPACE}")
  if(NOT eDIR_WORKSPACE STREQUAL "")
    if(NOT IS_DIRECTORY "${eDIR_WORKSPACE}")
      message("eDIR_WORKSPACE: ${eDIR_WORKSPACE}")
      message(FATAL_ERROR "eDIR_WORKSPACE: must be real directory")
    endif()
    file(TO_CMAKE_PATH "${eDIR_WORKSPACE}" gDIR_WORKSPACE)
  else()
    if(NOT gDIR_SOURCE STREQUAL "")
      set(d_start "${gDIR_SOURCE}")
    else()
      set(d_start "${CMAKE_SOURCE_DIR}")
    endif()
    if(NOT IS_DIRECTORY "${d_start}")
      message("d_start: ${d_start}")
      message(FATAL_ERROR "d_start: must be real directory")
    endif()

    if(WIN32)
      list(APPEND  d_start 
        "C:/workspace" "C:/home/workspace" 
        "D:/workspace" "D:/home/workspace"
      )
    endif()

    find_symptoms(gDIR_WORKSPACE "${d_start}" "3rd_party" "scripts")
    set(ENV{eDIR_WORKSPACE} "${gDIR_WORKSPACE}")
  endif()
  set(gDIR_WORKSPACE "${gDIR_WORKSPACE}" PARENT_SCOPE)
endfunction()

################################################################################

function(detect_dir_scripts)
  set(eDIR_SCRIPTS "$ENV{eDIR_SCRIPTS}")
  if(NOT eDIR_SCRIPTS STREQUAL "")
    if(NOT IS_DIRECTORY "${eDIR_SCRIPTS}")
      message("gDIR_SCRIPTS: ${gDIR_SCRIPTS}")
      message(FATAL_ERROR "eDIR_SCRIPTS: must be real directory")
    endif()
    file(TO_CMAKE_PATH "${eDIR_SCRIPTS}" gDIR_SCRIPTS)
  else()
    if(NOT gDIR_WORKSPACE STREQUAL "")
      if(IS_DIRECTORY "${gDIR_WORKSPACE}/scripts")
        get_filename_component(gDIR_SCRIPTS "${gDIR_WORKSPACE}/scripts" ABSOLUTE)
        set(ENV{eDIR_SCRIPTS} "${gDIR_SCRIPTS}")
      endif()    
    endif()    
  endif()
  set(gDIR_SCRIPTS "${gDIR_SCRIPTS}" PARENT_SCOPE)
endfunction()

################################################################################

macro(check_scenario_ dir name)
  if(EXISTS  "${dir}/${name}.cmake")
    get_filename_component(gDIR_SCENARIO "${dir}" ABSOLUTE)

  elseif(EXISTS "${dir}/${name}/${name}.cmake")
    get_filename_component(gDIR_SCENARIO "${dir}/${name}" ABSOLUTE)

  elseif(EXISTS "${dir}/cmake-${name}/${name}.cmake")
    get_filename_component(gDIR_SCENARIO "${dir}/cmake-${name}" ABSOLUTE)

  elseif(EXISTS "${dir}/cmake/${name}/${name}.cmake")
    get_filename_component(gDIR_SCENARIO "${dir}/cmake/${name}" ABSOLUTE)

  elseif(EXISTS "${dir}/cmake/${name}.cmake")
    get_filename_component(gDIR_SCENARIO "${dir}/cmake" ABSOLUTE)
  endif()

  if(NOT "${gDIR_SCENARIO}" STREQUAL "")
    set(ENV{eDIR_SCENARIO} "${gDIR_SCENARIO}")
    set(gDIR_SCENARIO "${gDIR_SCENARIO}" PARENT_SCOPE)
    return()
  endif()
endmacro()

function(detect_dir_scenario name)
  set(eDIR_SCENARIO "$ENV{eDIR_SCENARIO}")
  if(NOT eDIR_SCENARIO STREQUAL "")
    if(NOT IS_DIRECTORY "${eDIR_SCENARIO}")
      message("eDIR_SCENARIO: ${eDIR_SCENARIO}")
      message(FATAL_ERROR "eDIR_SCENARIO: must be real directory")
    endif()
    file(TO_CMAKE_PATH "${eDIR_SCENARIO}" gDIR_SCENARIO)
  else()
    set(xDIR_CURRENT ${CMAKE_CURRENT_LIST_DIR})
    check_scenario_("${xDIR_CURRENT}"  "${name}")
    check_scenario_("${gDIR_SOURCE}"   "${name}")
    check_scenario_("${gDIR_SCRIPTS}"  "${name}")
    message(FATAL_ERROR "not found: scenario '${name}'")
  endif()
endfunction()

################################################################################

function(check_eNAME_PROJECT_)
  set(eNAME_PROJECT "$ENV{eNAME_PROJECT}")
  set(ePROJECT_NAME "$ENV{ePROJECT_NAME}")

  has_value(eNAME_PROJECT eNP)
  has_value(ePROJECT_NAME ePN)

  if(NOT eNP AND ePN)
    set(ENV{eNAME_PROJECT} "${eNAME_PROJECT}")
  elseif(NOT ePN AND eNP)
    set(ENV{ePROJECT_NAME} "${eNAME_PROJECT}")
  elseif(ePN AND eNP)  
    if(NOT "${ePROJECT_NAME}" STREQUAL "${eNAME_PROJECT}")
      message("ePROJECT_NAME: ${ePROJECT_NAME}")
      message("eNAME_PROJECT: ${eNAME_PROJECT}")
      message(FATAL_ERROR "ePROJECT_NAME must be equal eNAME_PROJECT")
    endif()
  endif()
endfunction()

function(detect_name_project)
  check_eNAME_PROJECT_()
  set(gNAME_PROJECT "$ENV{eNAME_PROJECT}")
  if(gNAME_PROJECT STREQUAL "")
    get_filename_component(gNAME_PROJECT "${gDIR_SOURCE}" NAME)
    set(ENV{eNAME_PROJECT} "${gNAME_PROJECT}")
    set(ENV{ePROJECT_NAME} "${gNAME_PROJECT}")
  endif()
  set(gNAME_PROJECT "${gNAME_PROJECT}" PARENT_SCOPE)
  set(gPROJECT_NAME "${gNAME_PROJECT}" PARENT_SCOPE)
endfunction()

################################################################################

macro(cmake_scenario name)
  set(gNAME_SCENARIO "${name}")
  detect_dir_source()
  detect_dir_workspace()
  detect_dir_scripts()
  detect_dir_scenario("${name}")
  detect_name_project()
  include("${gDIR_SCENARIO}/${gNAME_SCENARIO}.cmake")
endmacro()

################################################################################
################################################################################
