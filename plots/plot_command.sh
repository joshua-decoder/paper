cat packed.time | ./build_graph.py 176 1004 | sort -n -k1,1 > packed.dat
cat default.time | ./build_graph.py 1897 2551 | sort -n -k1,1 > default.dat
