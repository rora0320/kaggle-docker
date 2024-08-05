# Dockerfile의 구성요소
# Docker Container와 Image는 Operating System을 가지고 있는 하나의 독립된 컴퓨터라고 인식하는 것이 중요합니다.
# 1. Base Image (이미지 생성의 기반이 되는 이미지)
# 2. LABEL (이미지에 대한 설명, Metadata) 
    # docker inspect --format='{{json .Config.Labels}}' <이미지명>
# 3. RUN (이미지를 생성하기 위해 터미널에서 실행할 명령어)
# 4. WORKDIR (이미지를 생성할 때 기본 작업 디렉토리)
    # dot (.)은 현재 디렉토리 (WORKDIR) 를 의미
# 5. COPY or ADD (파일 복사, ADD는 압축파일을 풀 수 있음 그리고 URL도 가능)
# 6. ARG (Docker Build 과정에서 입력하는 변수)
    # It's used to pass configuration to the Dockerfile when building the Docker Image.
    # docker build --build-arg rstats_version=v57 --build-arg rstudio_version=2023.12.0-369 -t rstudio-kaggle-image .
# 7. ENV (Docker Container가 실행되었을 때 환경변수, 기본적으로 Software의 Configuration)
    # It's used to pass configuration to the software inside the container. 
# 8. EXPOSE (컨테이너가 실행되었을 때 노출할 포트)
# 9. USER (RUN, CMD, ENTRYPOINT를 실행할 사용자)
# 10. CMD or ENTRYPOINT (컨테이너가 시작되었을 때 실행할 명령어)

# 목표1: Kaggle R GPU 이미지에 latest RStudio Server를 설치하여 사용할 수 있도록 한다.
# 목표2: setup.R을 실행하여 python과 keras를 rstudio가 사용할 수 있도록 한다.
# gdebi : 프로그램 설치시 추가적으로 설치되어햐 하는 필수사항 설치 후 rstudio 설치함.
# wget : 경로의 파일을 다운로드
# -y, -n : interactive 하게 묻지말고 쭉 설치할 수 있도록 함.

ARG rstats_version=v56

FROM gcr.io/kaggle-gpu-images/rstats:${rstats_version}
ARG rstudio_version=2021.09.0-351
RUN apt-get update && \
    apt-get install -y gdebi-core && \
    wget https://download2.rstudio.org/server/focal/amd64/rstudio-server-${rstudio_version}-amd64.deb && \
    gdebi -n rstudio-server-${rstudio_version}-amd64.deb && \
    apt-get clean && \
    rm rstudio-server-${rstudio_version}-amd64.deb

WORKDIR /home/rstudio
COPY setup.R ./setup.R
RUN chown rstudio:rstudio ./setup.R
RUN chmod +x ./setup.R
USER rstudio
RUN Rscript ./setup.R && \
    rm ./setup.R
USER root


EXPOSE 8787
# LABEL revised_by="Daniel Youk" \
#       revised_date="2023-12-24"
ENTRYPOINT [ "/bin/bash"]
CMD ["-c", "rstudio-server start && tail -f /dev/null"]


