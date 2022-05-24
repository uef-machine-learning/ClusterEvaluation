# CentroidIndex
Implementation of Centroid index: Cluster level similarity measure [1,2] and other cluster validity indices.

# Generalized Centroid Index (Ruby implementation)
Takes as input two .pa cluster partition files (header can be omitted)
```
git clone https://github.com/uef-machine-learning/CentroidIndex.git
cd src
./generalized_ci.rb example_data/s4-gt.pa example_data/s4-result.pa
```

# C implementation of Centroid Index and other metrics
This project's depends on the CBModules package as a dependency. So for compiling this project, you need to run these commands:
```
git clone https://github.com/uef-machine-learning/CBModules.git
git clone https://github.com/uef-machine-learning/CentroidIndex.git
cd CentroidIndex/src
cp -r ../../CBModules/src/modules/ .
make
```

# References
[1] P. Fränti, M. Rezaei, Q. Zhao
Centroid index: cluster level similarity measure
Pattern Recognit., 47 (9) (2014), pp. 3034-3045 https://doi.org/10.1016/j.patcog.2014.03.017
[2] Fränti, Pasi, Mohammad Rezaei, and Qinpei Zhao. "Centroid index: cluster level similarity measure." Pattern Recognition 47.9 (2014): 3034-3045.
