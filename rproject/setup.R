MINICONDA_PATH="/home/rstudio/.local/share/r-miniconda"
ENV_NAME="r-reticulate"
PYTHON_VERSION="3.10"


reticulate::install_miniconda(path = MINICONDA_PATH, update = TRUE, force = TRUE)
reticulate::conda_create(envname = ENV_NAME, conda = "auto", required = TRUE, python_version = PYTHON_VERSION)
Sys.setenv(RETICULATE_PYTHON="/home/rstudio/.local/share/r-miniconda/envs/r-reticulate/bin/python")
#Sys.setenv( ) => ENV 설정하는 부분임
TENSORFLOW_VERSION="2.11.0-gpu"
keras::install_keras(version = TENSORFLOW_VERSION, method = "conda", conda = "auto", envname=ENV_NAME)
