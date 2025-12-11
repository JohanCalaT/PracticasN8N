#!/bin/bash

# ========================================
# Script de Despliegue para Práctica 8
# ========================================
# Este script automatiza el despliegue de workflows a n8n

set -e  # Salir si hay algún error

# Colores para output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${BLUE}========================================${NC}"
echo -e "${BLUE}  Despliegue de Workflows - Práctica 8${NC}"
echo -e "${BLUE}========================================${NC}"
echo ""

# ========================================
# Verificar que existe el archivo .env
# ========================================
if [ ! -f .env ]; then
    echo -e "${RED}❌ Error: No se encontró el archivo .env${NC}"
    echo -e "${YELLOW}💡 Copia .env.example a .env y configura tus valores${NC}"
    echo -e "   cp .env.example .env"
    exit 1
fi

echo -e "${GREEN}✅ Archivo .env encontrado${NC}"

# ========================================
# Verificar que n8n está corriendo
# ========================================
echo -e "${BLUE}🔍 Verificando que n8n esté corriendo...${NC}"

if ! docker ps | grep -q "n8n-practica-08"; then
    echo -e "${YELLOW}⚠️  n8n no está corriendo. Iniciando...${NC}"
    docker-compose up -d
    echo -e "${GREEN}✅ n8n iniciado${NC}"
    echo -e "${YELLOW}⏳ Esperando 10 segundos para que n8n esté listo...${NC}"
    sleep 10
else
    echo -e "${GREEN}✅ n8n está corriendo${NC}"
fi

# ========================================
# Verificar que n8n-cli está instalado
# ========================================
echo -e "${BLUE}🔍 Verificando n8n-cli...${NC}"

if ! command -v n8n &> /dev/null; then
    echo -e "${YELLOW}⚠️  n8n-cli no está instalado. Instalando...${NC}"
    npm install n8n -g
    echo -e "${GREEN}✅ n8n-cli instalado${NC}"
else
    echo -e "${GREEN}✅ n8n-cli ya está instalado${NC}"
fi

# ========================================
# Configurar variables de entorno para n8n-cli
# ========================================
echo -e "${BLUE}🔧 Configurando n8n-cli...${NC}"

export N8N_HOST="http://localhost:5678"

# Verificar si existe N8N_API_KEY en .env
if grep -q "N8N_API_KEY=" .env; then
    export N8N_API_KEY=$(grep "N8N_API_KEY=" .env | cut -d '=' -f2)
    echo -e "${GREEN}✅ API Key cargada desde .env${NC}"
else
    echo -e "${RED}❌ Error: N8N_API_KEY no encontrada en .env${NC}"
    echo -e "${YELLOW}💡 Genera una API Key en n8n:${NC}"
    echo -e "   1. Accede a http://localhost:5678"
    echo -e "   2. Ve a Settings > API"
    echo -e "   3. Crea una API Key"
    echo -e "   4. Añádela a .env: N8N_API_KEY=tu-api-key-aqui"
    exit 1
fi

# ========================================
# Desplegar workflows
# ========================================
echo ""
echo -e "${BLUE}========================================${NC}"
echo -e "${BLUE}  Desplegando Workflows${NC}"
echo -e "${BLUE}========================================${NC}"
echo ""

WORKFLOWS_DIR="./workflows"

if [ ! -d "$WORKFLOWS_DIR" ]; then
    echo -e "${RED}❌ Error: Directorio workflows/ no encontrado${NC}"
    exit 1
fi

# Contar workflows
WORKFLOW_COUNT=$(ls -1 $WORKFLOWS_DIR/*.json 2>/dev/null | wc -l)

if [ $WORKFLOW_COUNT -eq 0 ]; then
    echo -e "${YELLOW}⚠️  No se encontraron workflows para desplegar${NC}"
    exit 0
fi

echo -e "${BLUE}📦 Encontrados $WORKFLOW_COUNT workflows${NC}"
echo ""

# Desplegar cada workflow
for workflow in $WORKFLOWS_DIR/*.json; do
    filename=$(basename "$workflow")
    echo -e "${BLUE}🚀 Desplegando: ${filename}${NC}"
    
    if n8n import:workflow --input="$workflow"; then
        echo -e "${GREEN}✅ Desplegado: ${filename}${NC}"
    else
        echo -e "${RED}❌ Error al desplegar: ${filename}${NC}"
    fi
    echo ""
done

# ========================================
# Resumen final
# ========================================
echo -e "${BLUE}========================================${NC}"
echo -e "${GREEN}🎉 Despliegue completado${NC}"
echo -e "${BLUE}========================================${NC}"
echo ""
echo -e "${BLUE}📊 Resumen:${NC}"
echo -e "   - Workflows desplegados: $WORKFLOW_COUNT"
echo -e "   - n8n URL: http://localhost:5678"
echo -e "   - Usuario: admin"
echo -e "   - Contraseña: admin123"
echo ""
echo -e "${YELLOW}💡 Próximos pasos:${NC}"
echo -e "   1. Accede a http://localhost:5678"
echo -e "   2. Verifica que los workflows estén importados"
echo -e "   3. Crea las credenciales refactorizadas (ver INSTRUCCIONES-CREDENCIALES.md)"
echo -e "   4. Prueba los workflows"
echo ""

