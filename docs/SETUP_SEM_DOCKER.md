# Setup sem Docker - PostgreSQL Local

Se você não tem Docker instalado ou prefere usar PostgreSQL local, siga este guia.

---

## 📋 Pré-requisitos

- **PostgreSQL 15+** instalado localmente
- **Python 3.11+**
- **Node.js 18+** (para frontend depois)

---

## 🗄️ Instalar PostgreSQL no macOS

### Opção 1: Homebrew (Recomendado)

```bash
# Instalar PostgreSQL
brew install postgresql@15

# Iniciar serviço
brew services start postgresql@15

# Criar banco de dados
createdb mvp_cobranca_dev

# Ou criar manualmente
psql postgres
# Dentro do psql:
CREATE DATABASE mvp_cobranca_dev;
\q
```

### Opção 2: Postgres.app

1. Baixe: https://postgresapp.com/
2. Instale e abra o app
3. Clique em "Initialize" para criar um servidor
4. Use o terminal integrado ou configure PATH

---

## ⚙️ Configurar Backend

### 1. Criar arquivo `.env`

```bash
cd backend
cp env.template .env
```

### 2. Editar `.env` com conexão local

```env
# Database (PostgreSQL local)
DATABASE_URL=postgresql://seu_usuario:senha@localhost:5432/mvp_cobranca_dev

# Exemplo comum (usuário padrão do macOS):
DATABASE_URL=postgresql://postgres@localhost:5432/mvp_cobranca_dev

# Ou se tiver senha:
DATABASE_URL=postgresql://postgres:senha@localhost:5432/mvp_cobranca_dev
```

**Descobrir seu usuário PostgreSQL:**
```bash
# Ver usuário atual
whoami

# Testar conexão
psql -d mvp_cobranca_dev
```

### 3. Testar Conexão

```bash
cd backend
source venv/bin/activate

# Testar conexão Python
python -c "from app.database import engine; engine.connect(); print('✅ Conexão OK!')"
```

---

## 🚀 Rodar Backend

```bash
cd backend
source venv/bin/activate
uvicorn app.main:app --reload
```

---

## 🔄 Redis (Opcional)

Se precisar de Redis (para jobs agendados depois):

### Opção 1: Homebrew

```bash
brew install redis
brew services start redis
```

### Opção 2: Sem Redis

Por enquanto, você pode desenvolver sem Redis. Os jobs agendados podem usar APScheduler sem Redis.

---

## ✅ Checklist

- [ ] PostgreSQL instalado e rodando
- [ ] Banco `mvp_cobranca_dev` criado
- [ ] Arquivo `.env` configurado com `DATABASE_URL` correto
- [ ] Teste de conexão funcionando
- [ ] Backend rodando em http://localhost:8000

---

## 🐛 Troubleshooting

### Erro: "database does not exist"

```bash
# Criar banco
createdb mvp_cobranca_dev

# Ou via psql
psql postgres
CREATE DATABASE mvp_cobranca_dev;
\q
```

### Erro: "password authentication failed"

```bash
# Verificar usuário
whoami

# Usar usuário correto no DATABASE_URL
# Ou criar usuário:
psql postgres
CREATE USER seu_usuario WITH PASSWORD 'senha';
GRANT ALL PRIVILEGES ON DATABASE mvp_cobranca_dev TO seu_usuario;
\q
```

### Erro: "could not connect to server"

```bash
# Verificar se PostgreSQL está rodando
brew services list | grep postgresql

# Iniciar se não estiver
brew services start postgresql@15

# Verificar porta
lsof -i :5432
```

---

## 📝 Nota sobre Docker

Se quiser usar Docker depois (recomendado para desenvolvimento):
- Veja: [INSTALACAO_DOCKER.md](./INSTALACAO_DOCKER.md)
- Docker facilita gerenciar PostgreSQL e Redis juntos
- Mas desenvolvimento local também funciona bem!
