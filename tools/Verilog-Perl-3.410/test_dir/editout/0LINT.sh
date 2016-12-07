#!/bin/bash
# Created by 56_editfiles.t
echo "**********************************************************************"
echo Lint a
vlint --brief $* a.v
echo "**********************************************************************"
echo Lint b
vlint --brief $* b.v
