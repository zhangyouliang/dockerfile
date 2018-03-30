FROM python:3.6.3

WORKDIR /app
COPY . /app

RUN pip install --trusted-host pypi.python.org -r requirements.txt \
    && pip install virtualenv \
    && virtualenv --system-site-packages -p python2.7 /opt/python2.7 \
    && /opt/python2.7/bin/pip install supervisor \
    && /opt/python2.7/bin/echo_supervisord_conf > /etc/supervisord.conf

# ------------------------------------------------------------------------------
# Provision the server
# ------------------------------------------------------------------------------

RUN chmod a+x /docker/*.sh

# Use Supervisor to run and manage all other services
CMD ["/docker/start.sh"]
