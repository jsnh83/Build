FROM registry.access.redhat.com/ubi8/ubi:8.0
LABEL version=”1.0”
LABEL description=”this is Containerfile”

MAINTAINER Red Hat Training <training@redhat.com>

# DocumentRoot for Apache
ENV DOCROOT=/var/www/html

RUN yum install -y --no-docs --disableplugin=subscription-manager httpd 

RUN yum clean all --disableplugin=subscription-manager -y 

RUN echo "Hello from the httpd-parent container!" > ${DOCROOT}/index.html

# Allows child images to inject their own content into DocumentRoot

EXPOSE 80

# This stuff is needed to ensure a clean start

RUN rm -rf /run/httpd && mkdir /run/httpd

# Run as the root user
USER root

# Launch httpd
CMD /usr/sbin/httpd -DFOREGROUND
