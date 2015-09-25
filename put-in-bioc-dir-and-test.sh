#!/bin/bash

## This places the code to upload to BiC in the right place.
## The Subversion-in-BioC directory is a special directory (under svn vc)
## for the code in BioC. Yes, will eventually use
## the bridge or similar.

## If passed an additional argument, with the path of an R version, it
## builds and tests.

## Yes, works under eshell.

cp OncoSimulR/vignettes/OncoSimulR.Rnw ./Subversion-in-BioC/OncoSimulR/vignettes/.
cp OncoSimulR/vignettes/OncoSimulR.bib ./Subversion-in-BioC/OncoSimulR/vignettes/.
cp OncoSimulR/vignettes/gitsetinfo.sty ./Subversion-in-BioC/OncoSimulR/vignettes/.
cp OncoSimulR/vignettes/gitinfo.sty ./Subversion-in-BioC/OncoSimulR/vignettes/.
cp OncoSimulR/vignettes/gitHeadInfo.gin ./Subversion-in-BioC/OncoSimulR/vignettes/.

cp OncoSimulR/src/*.c ./Subversion-in-BioC/OncoSimulR/src/.
cp OncoSimulR/src/*.cpp ./Subversion-in-BioC/OncoSimulR/src/.
cp OncoSimulR/src/*.h ./Subversion-in-BioC/OncoSimulR/src/.
cp OncoSimulR/src/Makevars* ./Subversion-in-BioC/OncoSimulR/src/.

cp OncoSimulR/R/*.R ./Subversion-in-BioC/OncoSimulR/R/.

cp OncoSimulR/tests/testthat/*.R ./Subversion-in-BioC/OncoSimulR/tests/testthat/.

cp OncoSimulR/man/*.Rd ./Subversion-in-BioC/OncoSimulR/man/.

cp OncoSimulR/inst/NEWS ./Subversion-in-BioC/OncoSimulR/inst/.
cp OncoSimulR/inst/CITATION ./Subversion-in-BioC/OncoSimulR/inst/.
cp OncoSimulR/inst/miscell/example-binom-problems.cpp ./Subversion-in-BioC/OncoSimulR/inst/miscell/.

cp OncoSimulR/data/*.RData ./Subversion-in-BioC/OncoSimulR/data/.

cp OncoSimulR/NAMESPACE ./Subversion-in-BioC/OncoSimulR/.

cp OncoSimulR/DESCRIPTION ./Subversion-in-BioC/OncoSimulR/.


## should we run the tests?

if [[ $# == 1 ]]; then
    V_R=$1
    cd ~/Proyectos/OncoSimul/Subversion-in-BioC
    V_P=$(cat ./OncoSimulR/DESCRIPTION | grep Version | cut -d' ' -f2)
    rm OncoSimulR_$V_P.tar.gz
    time $V_R CMD build --keep-empty-dirs --no-resave-data OncoSimulR
    time $V_R CMD check --no-vignettes --timings OncoSimulR_$V_P.tar.gz
fi


## Check what/if things need adding
cd ~/Proyectos/OncoSimul/Subversion-in-BioC/OncoSimulR

svn status --show-updates
