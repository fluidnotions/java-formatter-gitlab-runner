FROM amazoncorretto:21

RUN yum install -y git && yum clean all

COPY google-java-format-1.25.2-all-deps.jar ./
COPY format-and-commit.sh /usr/local/bin/format-and-commit.sh
RUN chmod +x /usr/local/bin/format-and-commit.sh

WORKDIR /repo

ENTRYPOINT ["/usr/local/bin/format-and-commit.sh"]