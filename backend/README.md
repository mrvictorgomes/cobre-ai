# Backend - MVP Cobrança Recorrente

Backend FastAPI para sistema de cobrança recorrente.

## 🚀 Início Rápido

```bash
# Criar ambiente virtual
python3 -m venv venv
source venv/bin/activate

# Instalar dependências
pip install -r requirements.txt

# Configurar variáveis de ambiente
cp .env.example .env
# Editar .env com suas configurações

# Rodar servidor
uvicorn app.main:app --reload
```

Acessar:
- **API:** http://localhost:8000
- **Swagger:** http://localhost:8000/docs
- **ReDoc:** http://localhost:8000/redoc

## 📁 Estrutura

```
backend/
├── app/
│   ├── api/          # Rotas da API
│   ├── models/       # Models SQLAlchemy
│   ├── schemas/      # Schemas Pydantic
│   ├── services/     # Lógica de negócio
│   ├── integrations/ # Integrações (Stripe)
│   ├── jobs/         # Jobs agendados
│   ├── utils/        # Utilitários
│   ├── config.py     # Configurações
│   ├── database.py   # Database setup
│   └── main.py       # FastAPI app
├── alembic/          # Migrations
├── requirements.txt
└── Dockerfile
```

## 🗄️ Migrations

```bash
# Criar migration
alembic revision --autogenerate -m "descrição"

# Aplicar migrations
alembic upgrade head

# Reverter
alembic downgrade -1
```

## 🔧 Desenvolvimento

Ver documentação completa em [`docs/SETUP.md`](../docs/SETUP.md).
