FROM python:3.9-buster


RUN mkdir -p /opt/app
RUN mkdir -p /opt/app/pip_cache
COPY requirements.txt manage.py /opt/app/
COPY  * /opt/app
WORKDIR /opt/app
RUN pip install -r requirements.txt --cache-dir /opt/app/pip_cache
RUN chown -R www-data:www-data /opt/app


# start server
EXPOSE 8020
STOPSIGNAL SIGTERM
CMD ["python manage.py runserver"]
