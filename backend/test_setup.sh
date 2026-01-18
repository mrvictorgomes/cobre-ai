#!/bin/bash

echo "🧪 Testando setup do backend..."
echo ""

# Verificar se está na pasta backend
if [ ! -f "app/main.py" ]; then
    echo "❌ Execute este script na pasta backend"
    exit 1
fi

# Verificar se venv existe
if [ ! -d "venv" ]; then
    echo "❌ Ambiente virtual não encontrado. Crie com: python3 -m venv venv"
    exit 1
fi

# Ativar venv e testar
source venv/bin/activate

echo "✅ Ambiente virtual ativado"
echo ""

# Verificar Python
echo "📦 Python: $(python --version)"
echo ""

# Verificar dependências
echo "📚 Verificando dependências..."
if python -c "import fastapi" 2>/dev/null; then
    echo "✅ FastAPI instalado"
else
    echo "❌ FastAPI não instalado. Execute: pip install -r requirements.txt"
    exit 1
fi

if python -c "import sqlalchemy" 2>/dev/null; then
    echo "✅ SQLAlchemy instalado"
else
    echo "❌ SQLAlchemy não instalado"
    exit 1
fi

echo ""

# Verificar .env
echo "🔐 Verificando .env..."
if [ -f ".env" ]; then
    if grep -q "JWT_SECRET=your-secret-key" .env; then
        echo "⚠️  JWT_SECRET ainda tem valor placeholder. Atualize no .env"
    else
        echo "✅ Arquivo .env encontrado"
    fi
    
    if grep -q "DATABASE_URL=" .env; then
        echo "✅ DATABASE_URL configurado"
    else
        echo "❌ DATABASE_URL não encontrado no .env"
    fi
else
    echo "❌ Arquivo .env não encontrado"
    exit 1
fi

echo ""

# Testar importação
echo "🔍 Testando importações..."
if python -c "from app.main import app; print('✅ App importado com sucesso')" 2>/dev/null; then
    echo ""
    echo "🎉 Setup básico OK!"
    echo ""
    echo "Próximos passos:"
    echo "1. Certifique-se que Docker está rodando: docker compose ps"
    echo "2. Inicie o servidor: uvicorn app.main:app --reload"
    echo "3. Acesse: http://localhost:8000/docs"
else
    echo "❌ Erro ao importar app"
    python -c "from app.main import app" 2>&1
    exit 1
fi
