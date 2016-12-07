#!/bin/bash
# Created by vsplitmodule
echo "**********************************************************************"
echo Lint 51_vrename_kwd
vlint --brief $* 51_vrename_kwd.v
echo "**********************************************************************"
echo Lint a
vlint --brief $* a.v
echo "**********************************************************************"
echo Lint b
vlint --brief $* b.v
