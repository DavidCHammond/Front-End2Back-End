#!/bin/bash
tar -C /usr/local/lib/python3.7/site-packages/airflow/www/static/ -xvf /opt/david/dags/example_form.tar

airflow initdb
airflow webserver & airflow scheduler
