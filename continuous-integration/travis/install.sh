# Install and set up miniconda.
if [ $TRAVIS_OS_NAME == "linux" ]; then sudo apt-get update && sudo apt-get install -yqq git wget libxt-dev libgl1-mesa-glx libgl1-mesa-dev \
                                        libosmesa-dev libglew-dev freeglut3 freeglut3-dev libfftw3-dev libwxgtk3.0-dev \
                                        libpulse-dev mesa-utils xvfb libgl1-mesa-dri build-essential \
                                        mesa-common-dev libpng-dev libjpeg-dev libxi-dev libxrandr-dev; fi
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