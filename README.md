# Tricholomopsis
Scripts, data matrices, and phylogenetic trees of Tricholomopsidiaceae

author: Gengshen Wang

version: v1.0

Update：2023.3.13

This script is used to install all softwares carrying on phylognetic analysis. They can be used in Linux and Windows Sublinux System on personal laptop. It hasn't been tested on Macos.

# 1. install miniconda3
```shell
wget -c https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh
chmod 777 Miniconda3-latest-Linux-x86_64.sh
bash Miniconda3-latest-Linux-x86_64.sh

cd miniconda3/bin
chmod 777 activate
. ./activate
conda list

# 添加镜像
conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/free/
conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/main/
conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/conda-forge/
conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/bioconda/
```

# 2. install fastp 0.20.1
```shell
conda install fastp
```

# 3. install spades v3.15.5
```shell
conda install spades=3.15.5
```
# 4. instal busco
```shell
conda create buscoEnv python=python3.7
conda activate buscoEnv
conda install -y -c condaforge biopython=1.77
conda install -y -c bioconda busco=4.1.2
conda deactivate
```
remember to activate/deactivate your buscoEnv every time you use it.
Then you can use the code:
```shell
conda activate buscoEnv
busco --list-datasets
conda deactivate
```
download your aimed database from https://busco-data.ezlab.org/v5/data/lineages/, unzip and put it in your data file folder. For example, if I study species, genus or family in Agaricales, agaricales_odb10 can be download and put in the file folder.

# 5. phylogenetic analysis softwares
```shell
conda install mafft
conda install gblocks
conda install seqkit
conda install iqtree
```
