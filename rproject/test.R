library(data.table)

library(torch)
torch_tensor(1,device = 'cuda')

library(reticulate)
# reticulate 패키지: R 과 python를 연결하는데 콘다 환경으로 
# 파이썬 케라스(의 백엔드 > 텐서플로우)와 R 케라스
# docker exec -it 도커이미지 //도커이미지의 환경으로 들어감
reticulate::py_config()
