# Pentaho Data Integration

Container contendo o Pentaho Data Integration para execução de transformations e jobs.

###### PDI

Devido a descontinuação do PDI, será necessário copiar o arquivo para a pasta pdi. \
Versão utilizada pdi-ce-9.3.0.0-428.zip

## Container PDI

Necessário alterar a variável PDI_SIZE no Dockerfile antes de fazer o build. \
Essa configuração limita a utilização de memória pelo PDI.

Parametro   |   Memoria
------------|-----------
PDI_SIZE=small  |   8 Gb
PDI_SIZE=medium  |   16 Gb
PDI_SIZE=large  |   24 Gb

~~~ cmd
# Set Environment Variables
ENV PDI_VERSION=9.3 PDI_BUILD=9.3.0.0-428 PDI_SIZE=large
~~~

PDI_SIZE=small
~~~cmd
docker build . -t lschulmeister/pdi:9.3-small
~~~

PDI_SIZE=medium
~~~cmd
docker build . -t lschulmeister/pdi:9.3-medium
~~~

PDI_SIZE=large
~~~cmd
docker build . -t lschulmeister/pdi:9.3-large
~~~

## Executando

Montagem:
- path_local:/root/.kettle - local do kettle.properties
- path_pdi_files:/opt/etl  - local dos jobs e transformations

#### Transformation
~~~cmd
docker container run -v /root/.kettle:/root/.kettle -v /opt/local/etl:/opt/etl --rm lschulmeister/pdi tr etl /dimensao/exemplo.ktr
~~~

#### Job
~~~cmd
docker container run -v /root/.kettle:/root/.kettle -v /opt/local/etl:/opt/etl --rm lschulmeister/pdi jb etl /job/exemplo.kjb
~~~