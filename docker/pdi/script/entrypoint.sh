#!/bin/bash
# *************************************************************
# Data Criacao..: 18/12/2019  Autor: Lucas V. I. Schulmeister
# Versao 1.0....: lucasvis 09/12/2019 Scrip Docker PDI
# *************************************************************
dc=$(date +%Y%m%d%H%M)
da=$(date +%Y%m%d)
par1=$1
par2=$2
par3=$3
vtr="tr"
vjb="jb"
di=$(date +%Y%m%d%H%M)
logp=/opt/logs/$par2
varq=${par3##/*/}
vdir=$logp${par3/$varq/}

Task () {	
	df=$(date +%Y%m%d%H%M)
#	echo "Inicio: $di ">>$logp/tasks/$da.log
#	echo "Tarefa: $par3">>$logp/tasks/$da.log
#	echo "Log:    $logp${par3/.kjb/}$dc.log">>$logp/tasks/$da.log
#	echo "Fim: $df ">>$logp/tasks/$da.log
#	echo "">>$logp/tasks/$da.log
}

MEC1 () {
	echo ''
	echo ''
	echo '###################################################################################'
	echo '#                              		                                        	#'
	echo '#                      Errors occurred during processing                    		#'
	echo '#                                                                                 #'
	echo '###################################################################################'
	echo ''
	echo ''
}


MEC2 () {
	echo ''
	echo ''
	echo '###################################################################################'
	echo '#                              		                                        	#'
	echo '#  An unexpected error occurred during loading/running of the transformation/job  #'
	echo '#                                                                                 #'
	echo '###################################################################################'
	echo ''
	echo ''
}


MEC3 () {
	echo ''
	echo ''
	echo '###################################################################################'
	echo '#                              		                                        	#'
	echo '#      Unable to prepare and initialize the transformation (only in Pan)          #'
	echo '#                                                                                 #'
	echo '###################################################################################'
	echo ''
	echo ''
}


MEC7 () {
	echo ''
	echo ''
	echo '###################################################################################'
	echo '#																					#'
	echo '#               The Transformation/job couldn|t be loaded from XML                #'
	echo '#                                                                                 #'
	echo '###################################################################################'
	echo ''
	echo ''
}


if [[ ! -e $vdir ]]; then
 mkdir -p $vdir
fi

if [ $par1 == $vtr ]; then

 tr="/opt/data-integration/pan.sh"
 sh $tr -file:"/opt/$par2$par3" -level:Detailed
 case $? in
  0) ;;
  1) MEC1 ; exit 1;;
  2) MEC2 ; exit 1;;
  3) MEC3 ; exit 1;;
  7) MEC7 ; exit 1;;
  *)  exit 1;;
 esac

elif [ $par1 == $vjb ]; then
 
 jb="/opt/data-integration/kitchen.sh"
 sh $jb -file:"/opt/$par2$par3" -level:Detailed

 case $? in
  0) ;;
  1) MEC1 ; exit 1;;
  2) MEC2 ; exit 1;;
  3) MEC3 ; exit 1;;
  7) MEC7 ; exit 1;;
  *)  exit 1;;
 esac
 
else

 exit

fi	
