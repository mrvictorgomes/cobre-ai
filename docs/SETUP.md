# Setup do Projeto - MVP Cobrança Recorrente

Este guia cobre o setup completo do projeto para desenvolvimento local.

---

## 📋 Pré-requisitos

Antes de começar, certifique-se de ter instalado:

- **Python 3.11+** - [Download](https://www.python.org/downloads/)
- **Node.js 18+** - [Download](https://nodejs.org/)
- **Docker e Docker Compose** - [Download](https://www.docker.com/get-started/)
- **Git** - [Download](https://git-scm.com/downloads)

Verificar versões:
```bash
python3 --version  # Precisa ser 3.11+
node --version     # Precisa ser 18+
docker --version
git --version
```

---

## 🚀 Setup Rápido

### 1. Clonar e entrar no projeto

```bash
cd /Users/victor/dev/cobre-ai
```

### 2. Iniciar serviços (PostgreSQL e Redis)

**Opção A: Com Docker (Recomendado)**

```bash
# Na raiz do projeto
docker compose up -d
# Ou se usar versão antiga: docker-compose up -d
```

Isso inicia:
- PostgreSQL na porta `5432`
- Redis na porta `6379`

Verificar se estão rodando:
```bash
docker compose ps
```

**Opção B: Sem Docker (PostgreSQL Local)**

Se não tiver Docker instalado, veja: [SETUP_SEM_DOCKER.md](./SETUP_SEM_DOCKER.md)

**Instalar Docker:** Veja: [INSTALACAO_DOCKER.md](./INSTALACAO_DOCKER.md)

### 3. Setup do Backend

```bash
cd backend

# Criar ambiente virtual
python3 -m venv venv

# Ativar ambiente virtual
source venv/bin/activate  # No Windows: venv\Scripts\activate

# Instalar dependências
pip install --upgrade pip
pip install -r requirements.txt

# Copiar arquivo de ambiente
cp .env.example .env

# Editar .env com suas configurações
# (Principalmente: DATABASE_URL, JWT_SECRET, STRIPE_SECRET_KEY)
```

**Configurar `.env`:**
```env
DATABASE_URL=postgresql://postgres:postgres@localhost:5432/mvp_cobranca_dev
JWT_SECRET=seu-secret-super-seguro-aqui-min-32-chars
STRIPE_SECRET_KEY=sk_test_sua_chave_aqui
```

### 4. Rodar o Backend

```bash
# Com ambiente virtual ativado
uvicorn app.main:app --reload --port 8000
```

Acessar:
- **API:** http://localhost:8000
- **Swagger Docs:** http://localhost:8000/docs
- **ReDoc:** http://localhost:8000/redoc
- **Health Check:** http://localhost:8000/health

### 5. Setup do Frontend (quando necessário)

```bash
cd frontend

# Instalar dependências
npm install

# Rodar em desenvolvimento
npm run dev
```

Acessar: http://localhost:3000

---

## 🗄️ Banco de Dados

### Migrations com Alembic

```bash
cd backend
source venv/bin/activate

# Criar primeira migration (quando tiver models)
alembic revision --autogenerate -m "Initial migration"

# Aplicar migrations
alembic upgrade head

# Reverter última migration
alembic downgrade -1
```

### Conectar ao PostgreSQL

```bash
# Via Docker
docker exec -it mvp_cobranca_postgres psql -U postgres -d mvp_cobranca_dev

# Ou via cliente local
psql postgresql://postgres:postgres@localhost:5432/mvp_cobranca_dev
```

---

## 🔧 Comandos Úteis

### Docker Compose

```bash
# Iniciar serviços
docker-compose up -d

# Parar serviços
docker-compose down

# Ver logs
docker-compose logs -f

# Parar e remover volumes (limpar dados)
docker-compose down -v
```

### Backend

```bash
# Ativar ambiente virtual
source venv/bin/activate

# Rodar servidor
uvicorn app.main:app --reload

# Rodar com porta customizada
uvicorn app.main:app --reload --port 8001

# Verificar linting (quando configurado)
flake8 app/
black app/
```

### Frontend

```bash
# Instalar dependências
npm install

# Rodar em desenvolvimento
npm run dev

# Build para produção
npm run build

# Rodar produção local
npm start
```

---

## 🐛 Troubleshooting

### Problema: Porta 5432 já em uso

```bash
# Verificar o que está usando a porta
lsof -i :5432

# Parar serviço local do PostgreSQL (se houver)
brew services stop postgresql  # macOS
# ou
sudo systemctl stop postgresql  # Linux
```

### Problema: Erro de conexão com banco

```bash
# Verificar se Docker está rodando
docker-compose ps

# Verificar logs do PostgreSQL
docker-compose logs postgres

# Reiniciar serviços
docker-compose restart
```

### Problema: Dependências Python não instalam

```bash
# Atualizar pip
pip install --upgrade pip setuptools wheel

# Limpar cache
pip cache purge

# Reinstalar
pip install -r requirements.txt --no-cache-dir
```

### Problema: Ambiente virtual não ativa

```bash
# Remover e recriar
rm -rf venv
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
```

---

## 📝 Estrutura do Projeto

```
cobre-ai/
├── backend/
│   ├── app/
│   │   ├── api/          # Rotas da API
│   │   ├── models/       # Models do SQLAlchemy
│   │   ├── schemas/      # Schemas do Pydantic
│   │   ├── services/     # Lógica de negócio
│   │   ├── integrations/ # Integrações (Stripe, etc.)
│   │   ├── jobs/         # Jobs agendados
│   │   ├── utils/        # Utilitários
│   │   ├── config.py     # Configurações
│   │   ├── database.py   # Configuração do banco
│   │   └── main.py       # Aplicação FastAPI
│   ├── alembic/          # Migrations
│   ├── requirements.txt
│   ├── Dockerfile
│   └── fly.toml
├── frontend/
│   └── ...
├── docs/
│   └── SETUP.md
└── docker-compose.yml
```

---

## ✅ Checklist de Setup

### Backend
- [ ] Python 3.11+ instalado
- [ ] Ambiente virtual criado e ativado
- [ ] Dependências instaladas (`pip install -r requirements.txt`)
- [ ] Arquivo `.env` criado e configurado
- [ ] Backend rodando em http://localhost:8000
- [ ] Swagger acessível em http://localhost:8000/docs
- [ ] Health check funcionando

### Banco de Dados
- [ ] Docker Compose rodando (`docker-compose up -d`)
- [ ] PostgreSQL acessível na porta 5432
- [ ] Redis acessível na porta 6379
- [ ] Conexão do backend com banco funcionando

### Frontend (quando necessário)
- [ ] Node.js 18+ instalado
- [ ] Dependências instaladas (`npm install`)
- [ ] Frontend rodando em http://localhost:3000

---

## 🔗 Próximos Passos

1. **Configurar Stripe:**
   - Criar conta no Stripe (modo sandbox)
   - Obter chaves de API
   - Adicionar ao `.env`

2. **Criar primeira migration:**
   - Criar models (Professional, Client, etc.)
   - Gerar migration com Alembic
   - Aplicar migration

3. **Implementar autenticação:**
   - Seguir Sprint 1 do planejamento
   - Criar rotas de cadastro e login

---

## 📚 Recursos

- [FastAPI Docs](https://fastapi.tiangolo.com/)
- [SQLAlchemy Docs](https://docs.sqlalchemy.org/)
- [Alembic Docs](https://alembic.sqlalchemy.org/)
- [Stripe Docs](https://stripe.com/docs)
- [Docker Compose Docs](https://docs.docker.com/compose/)

---

**Dúvidas?** Consulte a documentação de planejamento em `/Users/victor/dev/product/` ou abra uma issue no repositório.
