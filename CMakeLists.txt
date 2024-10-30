cmake_minimum_required(VERSION 3.15)
project(CLARK)

set(CMAKE_CXX_STANDARD 11)
add_compile_options(-Wall -Wno-sign-compare -Wno-unused-parameter -Wextra -Wno-unknown-pragmas)

include_directories(src)


add_executable(CLARK src/main.cc src/analyser.cc src/file.cc src/kmersConversion.cc
        src/FileHandler.cc src/FileHandlerA.cc src/FileHandlerQ.cc)
target_link_libraries(CLARK z "-fopenmp")

add_executable(CLARK-S src/main_s.cc src/analyser.cc src/file_s.cc src/kmersConversion.cc
        src/FileHandler.cc src/FileHandlerA_s.cc src/FileHandlerQ_s.cc)
target_link_libraries(CLARK-S z "-fopenmp")

add_executable(getTargetsDef src/getTargetsDef.cc src/file.cc)
add_executable(getAccssnTaxID src/getAccssnTaxID.cc src/file.cc)
add_executable(getfilesToTaxNodes src/getfilesToTaxNodes.cc src/file.cc)
add_executable(getAbundance src/getAbundance.cc src/file.cc)
add_executable(getConfidenceDensity src/getConfidencedensity.cc src/file.cc)
add_executable(getGammaDensity src/getGammadensity.cc src/file.cc)
add_executable(makeSummaryTables src/file.cc src/makeSamplesSummaryTables.cc)
add_executable(converter src/main_spaced.cc src/kmersConversion.cc)
add_executable(binSeq src/getSeqFiles.cc src/file.cc)
add_executable(dscriptMaker src/dscriptMaker.cc src/file.cc)
add_executable(getTargetSpecificKmersStat src/file.cc src/getTargetSpecificKmersStat.cc)
add_executable(extractSeqs src/extractSequences.cc src/file.cc)
