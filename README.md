# 🚀 Prácticas de n8n - Integración de Tecnologías y Servicios Informáticos

<div align="center">

![n8n](https://img.shields.io/badge/n8n-Workflow%20Automation-EA4B71?style=for-the-badge&logo=n8n)
![Docker](https://img.shields.io/badge/Docker-Container-2496ED?style=for-the-badge&logo=docker&logoColor=white)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-Database-336791?style=for-the-badge&logo=postgresql&logoColor=white)
![RabbitMQ](https://img.shields.io/badge/RabbitMQ-Messaging-FF6600?style=for-the-badge&logo=rabbitmq&logoColor=white)
![Google Gemini](https://img.shields.io/badge/Google%20Gemini-AI-4285F4?style=for-the-badge&logo=google&logoColor=white)

**Máster en Ingeniería Informática**
Universidad de Almería | Curso 2024-2025

</div>

---

## 📚 Información Académica

- **Asignatura:** Integración de Tecnologías y Servicios Informáticos
- **Programa:** Máster en Ingeniería Informática
- **Universidad:** Universidad de Almería
- **Autor:** Johan Eduardo Cala Torra
- **Curso:** 2024-2025

---

## 📋 Descripción del Proyecto

Este repositorio contiene las **8 prácticas completas** del curso de Integración de Tecnologías y Servicios Informáticos, enfocadas en la automatización de procesos con **n8n**, integración de microservicios, inteligencia artificial y prácticas de DevOps/GitOps.

El proyecto representa un recorrido completo desde los fundamentos de automatización hasta el despliegue en producción con CI/CD, pasando por arquitecturas de microservicios e integración con servicios de IA.

---

## 🎯 Prácticas Completadas

| # | Práctica | Descripción | Tecnologías | Estado |
|---|----------|-------------|-------------|--------|
| **1** | **Introducción a n8n** | Fundamentos de automatización, Docker, primeros workflows | n8n, Docker | ✅ Completada |
| **2** | **Lógica y Control de Flujo** | Condicionales, bucles, procesamiento de datos | n8n, JavaScript | ✅ Completada |
| **3** | **Enrutamiento y Google Sheets** | Switch, Merge, integración con Google Sheets API | n8n, Google Sheets, OAuth 2.0 | ✅ Completada |
| **4** | **Manejo de Errores** | Error handling, workflows robustos, recuperación de fallos | n8n, Error Handling | ✅ Completada |
| **5** | **Microservicios con Docker** | Arquitectura de microservicios, orquestación con Docker Compose | Flask, PostgreSQL, RabbitMQ, Docker Compose | ✅ Completada |
| **6** | **Integración n8n + Microservicios** | Workflows complejos con bases de datos y mensajería | n8n, PostgreSQL, RabbitMQ | ✅ Completada |
| **7** | **Integración con IA** | Procesamiento con Google Gemini, generación de texto, extracción de entidades | n8n, Google Gemini API, IA Generativa | ✅ Completada |
| **8** | **DevOps y GitOps** | Variables de entorno, CI/CD, despliegue automatizado | Docker Compose, GitHub Actions, n8n-cli | ✅ Completada |

---

## 🏗️ Arquitectura del Proyecto

### Práctica 5-6: Sistema de Microservicios

```
┌─────────────────────────────────────────────────────────────┐
│                         n8n Workflows                        │
│  (Orquestación, Procesamiento, Integración con IA)         │
└────────────┬────────────────────────────────┬───────────────┘
             │                                │
             ▼                                ▼
    ┌────────────────┐              ┌─────────────────┐
    │   PostgreSQL   │              │    RabbitMQ     │
    │   (Base de     │              │   (Mensajería   │
    │    Datos)      │              │    Asíncrona)   │
    └────────────────┘              └─────────────────┘
             │                                │
             ▼                                ▼
    ┌────────────────┐              ┌─────────────────┐
    │  API Service   │──────────────│  Worker Service │
    │    (Flask)     │              │   (Procesador)  │
    └────────────────┘              └─────────────────┘
                                             │
                                             ▼
                                    ┌─────────────────┐
                                    │ Notifier Service│
                                    │  (Notificaciones)│
                                    └─────────────────┘
```

### Práctica 8: Pipeline CI/CD

```
┌──────────────┐     ┌──────────────┐     ┌──────────────┐
│   Git Push   │────▶│GitHub Actions│────▶│ n8n Deploy   │
│   (main)     │     │  (Pipeline)  │     │ (Producción) │
└──────────────┘     └──────────────┘     └──────────────┘
                            │
                            ▼
                    ┌──────────────┐
                    │  n8n-cli     │
                    │  (Import)    │
                    └──────────────┘
```

---

## 📁 Estructura del Repositorio

```
PracticasN8N/
│
├── README.md                          # Este archivo
├── docker-compose.yml                 # Configuración principal de n8n
├── .gitignore                         # Archivos ignorados por Git
│
├── practica-01/                       # Introducción a n8n
│   └── workflows/                     # Workflows básicos
│
├── practica-02/                       # Lógica y control de flujo
│   └── workflows/                     # Workflows con condicionales
│
├── practica-03/                       # Enrutamiento y Google Sheets
│   ├── workflows/                     # Workflows con Switch y Merge
│   └── informe/                       # Informe en LaTeX/PDF
│
├── practica-04/                       # Manejo de errores
│   └── workflows/                     # Workflows robustos
│
├── practica-05/                       # Microservicios con Docker
│   └── task-manager-service/          # Sistema completo de microservicios
│       ├── api-service/               # API REST con Flask
│       ├── worker-service/            # Worker de procesamiento
│       ├── notifier-service/          # Servicio de notificaciones
│       ├── error-handler-service/     # Manejador de errores (DLQ)
│       └── docker-compose.yml         # Orquestación de servicios
│
├── practica-06/                       # Integración n8n + Microservicios
│   └── workflows/                     # 7 workflows de integración
│       ├── Flujo 1 - PostgreSQL.json
│       ├── Flujo 2A - Productor.json
│       ├── Flujo 2B - Consumidor.json
│       └── ...
│
├── practica-07/                       # Integración con IA
│   ├── workflows/                     # Workflows con Google Gemini
│   │   ├── Flujo Guiado - Analisis Prioridad.json
│   │   ├── Ejercicio 1 - Generador Resumenes.json
│   │   ├── Ejercicio 2 - Extraccion Entidades.json
│   │   └── Ejercicio 3 - Cadena de IA.json
│   └── informe/                       # Informe en PDF
│
└── practica-08/                       # DevOps y GitOps
    ├── .github/workflows/             # Pipeline CI/CD
    │   └── deploy.yml                 # GitHub Actions
    ├── workflows/                     # Workflows refactorizados
    │   ├── p3-chistes-refactorizado.json
    │   └── p6-postgres-rabbitmq-refactorizado.json
    ├── docker-compose.yml             # Configuración con .env
    ├── .env                           # Variables de entorno
    ├── .env.example                   # Template de variables
    ├── deploy.sh                      # Script de despliegue (Linux/Mac)
    ├── deploy.ps1                     # Script de despliegue (Windows)
    └── informe/                       # Informe en LaTeX/PDF
```

---

## 🛠️ Tecnologías Utilizadas

### Automatización y Orquestación
- **n8n** - Plataforma de automatización de workflows
- **Docker** - Contenedorización de servicios
- **Docker Compose** - Orquestación de contenedores

### Backend y Bases de Datos
- **Flask** - Framework web de Python
- **PostgreSQL** - Base de datos relacional
- **RabbitMQ** - Sistema de mensajería asíncrona

### Inteligencia Artificial
- **Google Gemini API** - Modelo de IA generativa
- **Procesamiento de Lenguaje Natural** - Análisis de texto, generación, extracción

### DevOps y CI/CD
- **GitHub Actions** - Pipeline de integración continua
- **n8n-cli** - Herramienta de línea de comandos para n8n
- **Git** - Control de versiones

### APIs y Servicios Externos
- **Google Sheets API** - Integración con hojas de cálculo
- **Google Cloud Platform** - Gestión de APIs y credenciales
- **OAuth 2.0** - Autenticación y autorización

---

## 🚀 Inicio Rápido

### Requisitos Previos

- Docker Desktop o Docker Engine
- Node.js 18+ (para n8n-cli)
- Git
- Cuenta de Google (para Google Sheets y Gemini)

### Instalación y Ejecución

#### 1. Clonar el repositorio

```bash
git clone https://github.com/JohanCalaT/PracticasN8N.git
cd PracticasN8N
```

#### 2. Ejecutar n8n (Configuración básica)

```bash
docker-compose up -d
```

Acceder a: http://localhost:5678

**Credenciales por defecto:**
- Usuario: `admin`
- Contraseña: `admin123`

#### 3. Ejecutar el sistema de microservicios (Práctica 5-6)

```bash
cd practica-05/task-manager-service
docker-compose up -d
```

**Servicios disponibles:**
- API Service: http://localhost:5001
- RabbitMQ Management: http://localhost:15672 (guest/guest)
- PostgreSQL: localhost:5433

#### 4. Ejecutar n8n con variables de entorno (Práctica 8)

```bash
cd practica-08
cp .env.example .env
# Editar .env con tus valores
docker-compose up -d
```

---

## 📖 Guías por Práctica

### Práctica 1-2: Fundamentos
- Crear workflows básicos
- Usar nodos de control de flujo
- Procesar datos con JavaScript

### Práctica 3: Google Sheets
1. Configurar proyecto en Google Cloud
2. Habilitar Google Sheets API
3. Crear credenciales OAuth 2.0
4. Importar workflows de `practica-03/workflows/`

### Práctica 4: Manejo de Errores
- Implementar nodos de error
- Crear workflows robustos
- Manejar excepciones

### Práctica 5-6: Microservicios
1. Iniciar sistema de microservicios
2. Verificar que todos los servicios estén corriendo
3. Importar workflows de `practica-06/workflows/`
4. Probar integración n8n ↔ PostgreSQL ↔ RabbitMQ

### Práctica 7: IA con Google Gemini
1. Obtener API Key de Google AI Studio
2. Configurar credencial en n8n
3. Importar workflows de `practica-07/workflows/`
4. Probar generación de texto y extracción de entidades

### Práctica 8: DevOps y GitOps
1. Configurar variables de entorno en `.env`
2. Crear credenciales refactorizadas en n8n
3. Ejecutar scripts de despliegue (`deploy.ps1` o `deploy.sh`)
4. (Opcional) Configurar GitHub Actions para CI/CD

---

## 🧪 Pruebas y Validación

### Verificar n8n
```bash
curl http://localhost:5678
```

### Verificar PostgreSQL
```bash
docker exec -it postgres-db psql -U user -d taskdb -c "SELECT * FROM tasks;"
```

### Verificar RabbitMQ
```bash
curl -u guest:guest http://localhost:15672/api/queues
```

### Verificar API Service
```bash
curl http://localhost:5001/tasks
```

---

## 📊 Estadísticas del Proyecto

- **Total de Prácticas:** 8
- **Total de Workflows:** 30+
- **Microservicios Implementados:** 5
- **Integraciones con APIs:** 3 (Google Sheets, Google Gemini, PostgreSQL)
- **Líneas de Código:** 2,500+
- **Informes Generados:** 8 (LaTeX/PDF)

---

## 🎓 Competencias Desarrolladas

### Técnicas
- ✅ Automatización de procesos con n8n
- ✅ Diseño de arquitecturas de microservicios
- ✅ Integración con APIs REST y servicios externos
- ✅ Gestión de bases de datos relacionales (PostgreSQL)
- ✅ Sistemas de mensajería asíncrona (RabbitMQ)
- ✅ Integración con servicios de IA (Google Gemini)
- ✅ Prácticas de DevOps y GitOps
- ✅ CI/CD con GitHub Actions
- ✅ Contenedorización con Docker

### Metodológicas
- ✅ Control de versiones con Git
- ✅ Documentación técnica profesional
- ✅ Gestión de configuración y secretos
- ✅ Diseño de pipelines de despliegue
- ✅ Manejo de errores y recuperación de fallos

---

## 📝 Documentación Adicional

Cada práctica incluye su propia documentación:

- **README.md** - Instrucciones específicas de la práctica
- **Informe PDF** - Documentación completa en formato académico
- **Workflows JSON** - Flujos de trabajo exportados e importables

---

## 🔗 Enlaces Útiles

- [Documentación oficial de n8n](https://docs.n8n.io/)
- [n8n Community](https://community.n8n.io/)
- [Google Gemini API](https://ai.google.dev/)
- [Docker Documentation](https://docs.docker.com/)
- [RabbitMQ Tutorials](https://www.rabbitmq.com/tutorials)

---

## 📄 Licencia

Este proyecto es material académico desarrollado para el Máster en Ingeniería Informática de la Universidad de Almería.

---

## 👤 Autor

**Johan Eduardo Cala Torra**
Máster en Ingeniería Informática
Universidad de Almería
Curso 2024-2025

---

## 🙏 Agradecimientos

- Universidad de Almería - Máster en Ingeniería Informática
- Profesores de la asignatura Integración de Tecnologías y Servicios Informáticos
- Comunidad de n8n por la excelente plataforma de automatización

---

<div align="center">

**⭐ Si este repositorio te ha sido útil, considera darle una estrella ⭐**

![GitHub stars](https://img.shields.io/github/stars/JohanCalaT/PracticasN8N?style=social)
![GitHub forks](https://img.shields.io/github/forks/JohanCalaT/PracticasN8N?style=social)

</div>
