# k-KISSME
[Kernel Distance Metric Learning using Pairwise Constraints for Person Re-Identification](https://doi.org/10.1109/TIP.2018.2870941)

k-KISSME contains the implementation of Kernel distance metric learning using pairwise constraints for person re-identification.
For any question, please contact [Bac Nguyen](mailto:Bac.NguyenCong@ugent.be).

## Abstract
Person re-identification is a fundamental task in many computer vision and image understanding systems. Due to appearance variations from different camera views, person re-identification still poses an important challenge. In the literature, KISSME has already been introduced as an effective distance metric learning method using pairwise constraints to  improve the re-identification performance. Computationally, it only requires two inverse covariance matrix estimations. However, the linear transformation induced by KISSME is not powerful enough for more complex problems. We show that KISSME can be kernelized, resulting in a nonlinear transformation, which is suitable for many real-world applications. Moreover, the proposed kernel method can be used for learning distance metrics from structured objects without having a vectorial representation. The effectiveness of our method is validated on five publicly available data sets. To further apply the proposed kernel method efficiently when data are collected sequentially, we introduce a fast incremental version that learns a dissimilarity function in the feature space without estimating the inverse covariance matrices. The experiments show that the latter variant can obtain competitive results in a computationally efficient manner.

### Prerequisites
This has been tested using MATLAB 2010A and later on Windows and Linux (Mac should be fine).

### Installation
Download the folder "k-KISSME" into the directory of your choice. Then within MATLAB go to file >> Set path... and add the directory containing "k-KISSME" to the list (if it isn't already). That's it.

### Usage

Please run (inside the matlab console)
```matlab
demo  % demo of k-KISSME
```

## Authors

* [Bac Nguyen Cong](https://github.com/bacnguyencong)

## Acknowledgments
If you find this code useful in your research, please consider citing:
``` bibtex
@Article{Nguyen2019,
  Title       = {Kernel Distance Metric Learning using Pairwise Constraints for Person Re-Identification},
  Author      = {Bac Nguyen and De Baets, Bernard},
  Journal     = {IEEE Transactions on Image Processing},
  Year        = {2018},
  doi         = {https://doi.org/10.1109/TIP.2018.2870941}
}
```
