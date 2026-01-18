from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from app.config import settings
from app.database import engine, Base

# Criar tabelas (em produção, usar migrations com Alembic)
# Base.metadata.create_all(bind=engine)

app = FastAPI(
    title=settings.APP_NAME,
    description="API para cobrança recorrente de profissionais autônomos",
    version=settings.APP_VERSION,
    docs_url="/docs",
    redoc_url="/redoc",
)

# CORS
app.add_middleware(
    CORSMiddleware,
    allow_origins=settings.CORS_ORIGINS,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


@app.get("/")
async def root():
    """Endpoint raiz da API"""
    return {
        "message": settings.APP_NAME,
        "version": settings.APP_VERSION,
        "status": "ok"
    }


@app.get("/health")
async def health():
    """Health check endpoint para monitoramento"""
    return {
        "status": "ok",
        "service": "backend",
        "version": settings.APP_VERSION
    }
