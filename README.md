# Prácticas de n8n

## 📚 Información Académica

- **Asignatura:** Integración de Tecnologías y Servicios Informáticos
- **Programa:** Máster en Ingeniería Informática
- **Universidad:** Universidad de Almería

## 📋 Contenido del Repositorio

Este repositorio contiene las prácticas realizadas con **n8n**, una plataforma de automatización de flujos de trabajo.

### Prácticas

| # | Práctica | Descripción | Estado |
|---|----------|-------------|--------|
| 1 | Introducción a n8n | Fundamentos, Docker, primer flujo de trabajo | 🔄 En progreso |

## 🛠️ Requisitos

- Docker Desktop o Docker Engine
- n8n (se ejecuta via Docker)

## 🚀 Cómo ejecutar n8n

```bash
docker run -it --rm --name n8n -p 5678:5678 -v .n8n:/home/node/.n8n n8nio/n8n
```

Luego acceder a: http://localhost:5678

## 📁 Estructura del Repositorio

```
PracticasN8N/
├── README.md
├── practica-01/          # Introducción a n8n
│   └── workflows/        # Flujos de trabajo exportados en JSON
├── practica-02/          # (Próximamente)
└── ...
```

## 📝 Notas

Los flujos de trabajo se exportan en formato JSON y pueden importarse directamente en n8n.

