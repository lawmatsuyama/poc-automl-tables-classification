# poc-automl-tables-classification

Poc automl tables para classificar gastos e recebimentos de extrato de conta bancária

### Como executar:

```
git clone git@github.com:lawmatsuyama/poc-automl-tables-classification.git
cd poc-automl-tables-classification
docker build -t automl-classifier . && docker run -d -p 8080:8080 automl-classifier
```

### Como usar:
Com o container do docker em execução, podemos realizar um HTTP POST conforme abaixo

`curl -X POST --data @teste.json http://localhost:8080/predict`

teste.json é um payload que pode ser definido com várias transações a serem classificadas

```json
{
    "instances":[
        {
            "transaction":"1ubereats"
        },
        {
            "transaction":"Escola Mariana EE96119"
        }
    ]
}
```

O response é um array de predictions contendo os scores de cada categoria para as transações informadas

```json
{
    "predictions": [
        {
            "scores": [
                0.998468816280365,
                0.0007391551043838263,
                0.0007919555064290762
            ],
            "classes": [
                "alimentacao",
                "servicos",
                "educacao"
            ]
        },
        {
            "scores": [
                0.00027913309168070555,
                0.001325673540122807,
                0.9983951449394226
            ],
            "classes": [
                "alimentacao",
                "servicos",
                "educacao"
            ]
        }
    ]
}
```

### Visualizar o modelo no tensor board
Os comandos abaixo foram extraídos da página https://www.tensorflow.org/install/pip#2.-create-a-virtual-environment-recommended

Se não tiver o python instalado, usar os comandos abaixo
```
sudo apt update
sudo apt install python3-dev python3-pip python3-venv
```

Criar o diretório abaixo na raiz do projeto:
```
mkdir converted_export
```

Criar o ambiente virtual com Python (recomendado):
```
python3 -m venv --system-site-packages ./venv
```

Ativar ambiente virtual:
```
source ./venv/bin/activate
```

Upgrade do pip
```
pip install --upgrade pip
```

Instalar o tensorflow no ambiente virtual
```
pip install --upgrade tensorflow
```

Verificar versão:
```
python -c "import tensorflow as tf;print(tf.reduce_sum(tf.random.normal([1000, 1000])))"
```

No diretório raiz do projeto, usar o comando abaixo:
```
python ./convert_oss.py --saved_model ./model-export/tbl/tf_saved_model/saved_model.pb --output_dir converted_export
```

Apontar o tensorboard para o modelo convertido
```
tensorboard --logdir=converted_export
```

No browser, acessar a url:
http://localhost:6006/
