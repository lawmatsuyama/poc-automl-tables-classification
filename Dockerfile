FROM gcr.io/cloud-automl-tables-public/model_server
ADD model-export/tbl/tf_saved_model /models/default/0000001
