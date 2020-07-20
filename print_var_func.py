import logging


def print_var(**kwargs):
    if kwargs['dag_run'].conf:
        logging.info("Running via API call")
        string_thing = kwargs['dag_run'].conf['string_thing']
    else:
        logging.info("Not submitted via API, using sample run")
        string_thing = 'Only a sample'

    logging.info(string_thing)