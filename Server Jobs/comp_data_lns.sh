#!/bin/sh

#sbatch --share -p FatComp ~/jobs/comp_data_lns.sh 

date

perl /home/talju0/EnsGene_vs_Meth.pl \<
perl /home/talju0/EnsGene_vs_Meth.pl \>=

#perl /home/talju0/EnsGene_vs_MDAMB.pl 1 cg -1
#perl /home/talju0/EnsGene_vs_MDAMB.pl 1 cg 0
#perl /home/talju0/EnsGene_vs_MDAMB.pl 1 cwg -1
#perl /home/talju0/EnsGene_vs_MDAMB.pl 1 cwg 0
#perl /home/talju0/EnsGene_vs_MDAMB.pl 10 cg -1
#perl /home/talju0/EnsGene_vs_MDAMB.pl 10 cg 0
#perl /home/talju0/EnsGene_vs_MDAMB.pl 10 cwg -1
#perl /home/talju0/EnsGene_vs_MDAMB.pl 10 cwg 0


cat `ls /home/talju0/slurms -rt |tail -1` > /home/talju0/slurms/output-log.txt
mail -s "DLX Job Complete" talju0@uky.edu < /home/talju0/slurms/output-log.txt
rm /home/talju0/slurms/output-log.txt
