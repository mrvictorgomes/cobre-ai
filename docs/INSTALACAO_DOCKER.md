# Instalação do Docker - macOS

## 🐳 Instalar Docker Desktop

### Opção 1: Homebrew (Recomendado)

```bash
# Instalar Docker Desktop via Homebrew
brew install --cask docker

# Ou se preferir usar o Homebrew Cask diretamente
brew install docker
```

Depois da instalação:
1. Abra o Docker Desktop pela aplicação
2. Aguarde inicializar (ícone da baleia no menu superior)
3. Teste: `docker --version`

### Opção 2: Download Manual

1. Acesse: https://www.docker.com/products/docker-desktop/
2. Baixe Docker Desktop para Mac
3. Instale o arquivo `.dmg`
4. Arraste Docker para a pasta Applications
5. Abra Docker Desktop e aguarde inicializar

## ✅ Verificar Instalação

```bash
# Verificar Docker
docker --version

# Verificar Docker Compose (versão nova usa "docker compose" sem hífen)
docker compose version

# Ou versão antiga (se ainda usar)
docker-compose --version
```

## 🚀 Usar Docker Compose

**Versão Nova (Docker Desktop recente):**
```bash
docker compose up -d
```

**Versão Antiga:**
```bash
docker-compose up -d
```

## 🔧 Troubleshooting

### Docker não inicia

```bash
# Verificar se Docker está rodando
docker ps

# Se der erro, abra Docker Desktop manualmente
# Procure por "Docker" no Spotlight (Cmd+Space)
```

### Permissões

Se der erro de permissão:
1. Abra Docker Desktop
2. Vá em Settings > General
3. Marque "Use the new Virtualization framework" (se disponível)

### Reiniciar Docker

```bash
# Parar todos os containers
docker stop $(docker ps -q)

# Ou reiniciar Docker Desktop pela aplicação
```

## 📚 Recursos

- [Docker Desktop Docs](https://docs.docker.com/desktop/)
- [Docker Compose Docs](https://docs.docker.com/compose/)
