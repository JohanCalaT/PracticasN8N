# ========================================
# Script de Despliegue para Práctica 8 (PowerShell)
# ========================================
# Este script automatiza el despliegue de workflows a n8n en Windows

$ErrorActionPreference = "Stop"

# Colores
function Write-ColorOutput($ForegroundColor) {
    $fc = $host.UI.RawUI.ForegroundColor
    $host.UI.RawUI.ForegroundColor = $ForegroundColor
    if ($args) {
        Write-Output $args
    }
    $host.UI.RawUI.ForegroundColor = $fc
}

Write-ColorOutput Blue "========================================"
Write-ColorOutput Blue "  Despliegue de Workflows - Práctica 8"
Write-ColorOutput Blue "========================================"
Write-Output ""

# ========================================
# Verificar que existe el archivo .env
# ========================================
if (-Not (Test-Path .env)) {
    Write-ColorOutput Red "❌ Error: No se encontró el archivo .env"
    Write-ColorOutput Yellow "💡 Copia .env.example a .env y configura tus valores"
    Write-Output "   Copy-Item .env.example .env"
    exit 1
}

Write-ColorOutput Green "✅ Archivo .env encontrado"

# ========================================
# Verificar que n8n está corriendo
# ========================================
Write-ColorOutput Blue "🔍 Verificando que n8n esté corriendo..."

$n8nRunning = docker ps --filter "name=n8n-practica-08" --format "{{.Names}}"

if (-Not $n8nRunning) {
    Write-ColorOutput Yellow "⚠️  n8n no está corriendo. Iniciando..."
    docker-compose up -d
    Write-ColorOutput Green "✅ n8n iniciado"
    Write-ColorOutput Yellow "⏳ Esperando 10 segundos para que n8n esté listo..."
    Start-Sleep -Seconds 10
} else {
    Write-ColorOutput Green "✅ n8n está corriendo"
}

# ========================================
# Verificar que n8n-cli está instalado
# ========================================
Write-ColorOutput Blue "🔍 Verificando n8n-cli..."

try {
    $null = Get-Command n8n -ErrorAction Stop
    Write-ColorOutput Green "✅ n8n-cli ya está instalado"
} catch {
    Write-ColorOutput Yellow "⚠️  n8n-cli no está instalado. Instalando..."
    npm install n8n -g
    Write-ColorOutput Green "✅ n8n-cli instalado"
}

# ========================================
# Configurar variables de entorno para n8n-cli
# ========================================
Write-ColorOutput Blue "🔧 Configurando n8n-cli..."

$env:N8N_HOST = "http://localhost:5678"

# Leer API Key desde .env
$envContent = Get-Content .env
$apiKeyLine = $envContent | Where-Object { $_ -match "^N8N_API_KEY=" }

if ($apiKeyLine) {
    $env:N8N_API_KEY = $apiKeyLine.Split('=')[1].Trim()
    Write-ColorOutput Green "✅ API Key cargada desde .env"
} else {
    Write-ColorOutput Red "❌ Error: N8N_API_KEY no encontrada en .env"
    Write-ColorOutput Yellow "💡 Genera una API Key en n8n:"
    Write-Output "   1. Accede a http://localhost:5678"
    Write-Output "   2. Ve a Settings > API"
    Write-Output "   3. Crea una API Key"
    Write-Output "   4. Añádela a .env: N8N_API_KEY=tu-api-key-aqui"
    exit 1
}

# ========================================
# Desplegar workflows
# ========================================
Write-Output ""
Write-ColorOutput Blue "========================================"
Write-ColorOutput Blue "  Desplegando Workflows"
Write-ColorOutput Blue "========================================"
Write-Output ""

$workflowsDir = ".\workflows"

if (-Not (Test-Path $workflowsDir)) {
    Write-ColorOutput Red "❌ Error: Directorio workflows\ no encontrado"
    exit 1
}

# Obtener workflows
$workflows = Get-ChildItem -Path $workflowsDir -Filter "*.json"
$workflowCount = $workflows.Count

if ($workflowCount -eq 0) {
    Write-ColorOutput Yellow "⚠️  No se encontraron workflows para desplegar"
    exit 0
}

Write-ColorOutput Blue "📦 Encontrados $workflowCount workflows"
Write-Output ""

# Desplegar cada workflow
foreach ($workflow in $workflows) {
    Write-ColorOutput Blue "🚀 Desplegando: $($workflow.Name)"
    
    try {
        n8n import:workflow --input="$($workflow.FullName)"
        Write-ColorOutput Green "✅ Desplegado: $($workflow.Name)"
    } catch {
        Write-ColorOutput Red "❌ Error al desplegar: $($workflow.Name)"
    }
    Write-Output ""
}

# ========================================
# Resumen final
# ========================================
Write-ColorOutput Blue "========================================"
Write-ColorOutput Green "🎉 Despliegue completado"
Write-ColorOutput Blue "========================================"
Write-Output ""
Write-ColorOutput Blue "📊 Resumen:"
Write-Output "   - Workflows desplegados: $workflowCount"
Write-Output "   - n8n URL: http://localhost:5678"
Write-Output "   - Usuario: admin"
Write-Output "   - Contraseña: admin123"
Write-Output ""
Write-ColorOutput Yellow "💡 Próximos pasos:"
Write-Output "   1. Accede a http://localhost:5678"
Write-Output "   2. Verifica que los workflows estén importados"
Write-Output "   3. Crea las credenciales refactorizadas (ver INSTRUCCIONES-CREDENCIALES.md)"
Write-Output "   4. Prueba los workflows"
Write-Output ""

