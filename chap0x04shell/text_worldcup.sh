#!/bin/bash
AGE=$(awk -F '\t' '{print $6}' worldcupplayerinfo.tsv) 
total=0
age30=0
age20to30=0
age20=0
oldest=0
oldestname=''
youngest=100
youngestname=''

# 年龄统计
for line in $AGE
do
    if [[ $line != 'Age' ]]
    then
		total=$[$total + 1]
		if [[ $line -lt 20 ]]
		then
			age20=$[$age20 + 1]		
		fi
		if [[ $line -ge 20 && $line -le 30 ]]
		then
			age20to30=$[$age20to30 + 1]
		fi	
		if [[ $line -gt 30 ]]
		then
			age30=$[$age30 + 1]
		fi
		if [[ $line -gt $oldest ]]
		then
			oldest=$line
			oldestname=$(awk -F '\t' 'NR=='$[$total +1]' {print $9}' worldcupplayerinfo.tsv)
		fi
		if [[ $line -lt $youngest ]]
		then
			youngest=$line
			youngestname=$(awk -F '\t' 'NR=='$[$total +1]' {print $9}' worldcupplayerinfo.tsv)
		fi
	fi	
done

# 输出
echo '20岁以下的人数：'$age20' 所占比例：'$(awk 'BEGIN{printf "%.2f",'$age20*100/$total'}')'%'
echo '20岁到30岁的人数：'$age20to30' 所占比例：'$(awk 'BEGIN{printf "%.2f",'$age20to30*100/$total'}')'%'
echo '30岁以上的人数：'$age30' 所占比例：'$(awk 'BEGIN{printf "%.2f",'$age30*100/$total'}')'%'
echo ''
echo '年龄最小的球员：'$youngestname' '$youngest'岁'
echo '年龄最大的球员：'$oldestname' '$oldest'岁'
echo ''

# 位置统计
POSITIONS=$(awk -F '\t' '{print $5}' worldcupplayerinfo.tsv) 
declare -A dic

for line in $POSITIONS
do
	if [[ $line != 'Position' ]]
	then
		if [[ !${dic[$line]} ]]
		then	
			dic[$line]=$[${dic[$line]}+1]
		else
			dic[$line]=0
		fi
	fi	
done

# 输出
for key in ${!dic[@]}
do
    echo "$key : ${dic[$key]}"" 占比为："$(awk 'BEGIN{printf "%.2f",'${dic[$key]}*100/$total'}')'%'
done

# 名字统计
NAMELENGTHS=$( awk -F '\t' '{print length($9)}' worldcupplayerinfo.tsv)
max=0
min=100
lstname=''
sstname=''
COUNT=0

for length in $NAMELENGTHS
do
	COUNT=$[$COUNT + 1]	
	if [[  $length -gt $max ]]
	then
		max=$length
		lstname=$(sed -n $COUNT'p' 'worldcupplayerinfo.tsv'|awk -F '\t' '{print $9}')
	fi		
	if [[ $length -lt $min ]]
	then
		min=$length	
		sstname=$(sed -n $COUNT'p' 'worldcupplayerinfo.tsv'|awk -F '\t' '{print $9}')
	fi
done 

# 输出
echo ''
echo '名字最短的球员：'$sstname
echo '名字最长的球员：'$lstname
