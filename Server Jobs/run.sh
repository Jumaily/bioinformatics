#!/bin/bash

perl MDA_-SELECT-calculate.pl 4 cg 1 -1 > ln4_CG_1_-1.csv
perl MDA_-SELECT-calculate.pl 4 cg 1 0 > ln4_CG_1_0.csv
perl MDA_-SELECT-calculate.pl 4 cg 10 -1 > ln4_CG_10_-1.csv
perl MDA_-SELECT-calculate.pl 4 cg 10 0 > ln4_CG_10_0.csv

perl MDA_-SELECT-calculate.pl 5 cg 1 -1 > ln5_CG_1_-1.csv
perl MDA_-SELECT-calculate.pl 5 cg 1 0 > ln5_CG_1_0.csv
perl MDA_-SELECT-calculate.pl 5 cg 10 -1 > ln5_CG_10_-1.csv
perl MDA_-SELECT-calculate.pl 5 cg 10 0 > ln5_CG_10_0.csv

