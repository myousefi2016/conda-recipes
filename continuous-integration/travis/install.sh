# Install and set up miniconda.
if [ $TRAVIS_OS_NAME == "linux" ]; then sudo apt-get update; fi
if [ $TRAVIS_OS_NAME == "linux" ]; then sudo apt-get install -yqq git wget build-essential libxt-dev libgl1-mesa-glx libgl1-mesa-dev \
                                        libglapi-mesa libosmesa-dev libglu-dev libglw1-mesa elfutils gamin libglw1-mesa-dev mesa-utils \ 
                                        libglu1-mesa libglu1-mesa-dev glew-utils libglewmx-dev libglew1.10 libglewmx-dbg libglewmx1.10; fi
if [ $TRAVIS_OS_NAME == "linux" ]; then wget http://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -O miniconda.sh; fi
if [ $TRAVIS_OS_NAME == "osx" ]; then wget http://repo.continuum.io/miniconda/Miniconda3-latest-MacOSX-x86_64.sh -O miniconda.sh; fi
if [ $TRAVIS_OS_NAME == "osx" ]; then cd $HOME && git clone https://github.com/phracker/MacOSX-SDKs.git && cd $TRAVIS_BUILD_DIR; fi
bash miniconda.sh -b -p $CONDA_INSTALL_LOCN
export PATH=${CONDA_INSTALL_LOCN}/bin:$PATH
conda config --set always_yes true

conda install --quiet -y conda conda-build anaconda-client jinja2

# set the ordering of additional channels
conda config --prepend channels rlizzo

# To ease debugging, list installed packages
conda info -a
conda list

# Only upload if this is NOT a pull request.
if [ "$TRAVIS_PULL_REQUEST" = "false" ] && \
    [ $TRAVIS_REPO_SLUG = "rlizzo/conda-recipes" ] && \
    [ "$TRAVIS_BRANCH" == "master" ]; then
    conda config --set anaconda_upload true
    echo "Uploading enabled";
else
    echo "Uplading disabled";
    conda config --set anaconda_upload true
fi