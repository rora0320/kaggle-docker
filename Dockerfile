# Use the Kaggle Python Docker image as the base image
FROM gcr.io/kaggle-gpu-images/python:v150

# The Kaggle Python Docker image includes some commonly-used Python packages
# You can add more packages later as needed

# Upgrade PyTorch and torchvision
# RUN pip install --upgrade torch torchvision

# # Upgrade torchdata
# RUN pip install --upgrade torchdata

# # install yfinance
RUN pip install yfinance
# RUN pip install yfinance \
#     && pip install xgboost \
#     && pip install pandas_ta

# # install ib_insync
# # RUN pip install ib_insync

# # install next_asyncio
# # RUN pip install nest_asyncio

# # install itables to render the pandas dataframe in jupyter
# RUN pip install itables

# The rest of your Dockerfile, such as copying your code files
# COPY ./your_code /path/in/container