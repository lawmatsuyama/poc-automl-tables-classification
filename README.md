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
