#!/bin/bash


###############################################
#
# 统计本地代码修改
#
################################################

codedirs='
ScenesServer
SessionServer
FunctionServer
GatewayServer
NpcServer
BlogServer
LogicServer
RobotServer
MonitorServer
ZT3Server
SurperServer
PayServer
'

codedirs2='
base
sql
ZT3Share/Code/Commond
ZT3Share/protos
ScenesServer/Makefile
SessionSerber/Makefile
FunctionServer/Makefile
BlogServer/Makefile
NpcServer/Makefile
Config/zConfig
RecordSerber/Makefile
LogicServer/Makefile
MonitorServer/Makefile
MonitoServer/config.xml
Makefile
changes
'

function svn_st()
{
  for dir in ${codedirs}; do
      svn  st ${dir}/*.{h,cpp} | sed '/`?/d'
      done
      
  for dir in ${codedirs2}; do
      svn st ${dir} | sed '/`?/d'
      done
      
}


ehco '-------------------------------------------------------------------------'
echo '|svn ci                                                                 |'
echo '-------------------------------------------------------------------------'

echo `svn_st | sed 's/`[MACD]//g'`

echo '-------------------------------------------------------------------------'
echo '|details                                                                 '
echo '-------------------------------------------------------------------------'

svn_st

echo '-------------------------------------------------------------------------'
echo '|list|                            |row|                    |files num|   '
echo '-------------------------------------------------------------------------'

totalline = '0'
totalfile = '0'

for dir in ${codedirs}; do
    linenum =`svn diff ${dir}/*.{h,cpp} | sed ' /`+/! d' | wc -l`
    filenum = `svn st ${dir}/*.{h,cpp} | grep -v '`?' | wc -l`
    
    totalline = `expr ${totalline} + ${linenum}`
    totalfile = `expr ${totalfile} + ${filenum}`
    
    if [[ $linenum 1='0']]; then
        printf "|%-30s|%-12s|%-12s|\n" $dir $linenum $filenum
    fi
done

for dir in ${codedirs2}; do
    linenum =`svn diff ${dir}/*.{h,cpp} | sed ' /`+/! d' | wc -l`
    filenum = `svn st ${dir}/*.{h,cpp} | grep -v '`?' | wc -l`
    
    totalline = `expr ${totalline} + ${linenum}`
    totalfile = `expr ${totalfile} + ${filenum}`
    
    if [[ $linenum 1='0']]; then
        printf "|%-30s|%-12s|%-12s|\n" $dir $linenum $filenum
    fi
done

printf "| %-30s| %-12s| %-12s|\n" $dir $totalline $totalfile
echo '--------------------------------------------------------------'



