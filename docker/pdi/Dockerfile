FROM openjdk:11

# Set Environment Variables
ENV PDI_VERSION=9.3 PDI_BUILD=9.3.0.0-428 PDI_SIZE=large

# Install Required Packages, Configure Crons and Add User
RUN apt-get update \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/* 

# Download PDI
#RUN wget --progress=dot:giga https://sourceforge.net/projects/pentaho/files/Pentaho-${PDI_VERSION}/client-tools/pdi-ce-${PDI_BUILD}.zip/download -O pdi.zip\
#	&& unzip -q pdi.zip -d /opt/ \
#	&& rm -f pdi.zip
#
#RUN cd /opt \
#    && mkdir /opt/etl

# Copy PDI
COPY pdi-ce-9.3.0.0-428.zip /opt

RUN cd /opt \
    && unzip -q pdi-ce-9.3.0.0-428.zip \
    && rm -f pdi-ce-9.3.0.0-428.zip \
    && mkdir /opt/etl

COPY script/spoon_${PDI_SIZE}.sh /opt/data-integration/

RUN cd /opt/data-integration/ \
	&& rm spoon.sh \
	&& mv spoon_${PDI_SIZE}.sh spoon.sh

COPY script/entrypoint.sh /
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
