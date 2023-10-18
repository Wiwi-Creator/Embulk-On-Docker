# Embulk

***
### OverView :
```
撰寫 Dockerfile ， 並將需要加裝的套件/語言，可以新增在其中。
```
### Definition :
```markdown
Embulk is a bulk data loader. 

It helps data transfer between types of databases, storages, file formats, cloud services, and else.

Embulk supports:

- Combination of input and output from varieties of plugins
- Plugins released in Maven and Ruby gem repositories
- Automated guess of input file formats
- Parallel execution to deal with big data sets
- Transaction control to guarantee all-or-nothing
```
#### Prepare :
```markdown
須先確認是否已安裝OpenJDK。
```
***

#### Building  :
取得該Dockerfile後，執行Docker build建立image
```
docker build -t ${image_name} .
```
檢視本地當下的images
```
docker images
```
進入Container中
```
docker exec -it ${image_name} /bin/bash
```
試run範例的dig檔

``$ embulk run ${templates.yml.liquid}``
