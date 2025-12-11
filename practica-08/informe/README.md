# Informe de la Práctica 8 - DevOps y GitOps

## 📄 Descripción

Este directorio contiene el informe en LaTeX de la Práctica 8: DevOps y GitOps - Despliegue y Versionado de Flujos de Trabajo.

## 📁 Archivos

- `main.tex` - Documento principal del informe en LaTeX
- `README.md` - Este archivo

## 🔧 Compilación

### Opción 1: Overleaf (Recomendado)

1. Ir a [Overleaf](https://www.overleaf.com/)
2. Crear un nuevo proyecto
3. Subir el archivo `main.tex`
4. Compilar automáticamente

### Opción 2: LaTeX Local

**Requisitos:**
- Distribución de LaTeX (TeX Live, MiKTeX, etc.)
- Paquetes: `babel`, `graphicx`, `hyperref`, `geometry`, `fancyhdr`, `listings`, `xcolor`, `float`

**Compilar:**

```bash
# En Windows (PowerShell)
cd practica-08/informe
pdflatex main.tex
pdflatex main.tex  # Segunda vez para índice

# En Linux/Mac
cd practica-08/informe
pdflatex main.tex
pdflatex main.tex
```

### Opción 3: Docker

```bash
docker run --rm -v ${PWD}:/workspace -w /workspace texlive/texlive pdflatex main.tex
```

## 📊 Contenido del Informe

1. **Introducción** - Objetivos y contexto de la práctica
2. **Fundamentos Teóricos** - Variables de entorno, Git, n8n-cli, GitOps, CI/CD
3. **Parte Guiada** - Refactorización del flujo de Google Sheets
4. **Ejercicio 1** - Refactorización PostgreSQL + RabbitMQ
5. **Ejercicio 2** - Docker Compose con variables de entorno
6. **Ejercicio 3** - Pipeline CI/CD con GitHub Actions
7. **Scripts de Despliegue** - Automatización del despliegue
8. **Pruebas y Verificación** - Validación de la implementación
9. **Conclusiones** - Reflexión sobre los objetivos alcanzados
10. **Anexos** - Comandos útiles y referencias

## 📝 Notas

- El informe está en español
- Usa la misma estructura y portada que las prácticas anteriores
- Incluye ejemplos de código en JSON, YAML y Bash
- Total: ~30 páginas aproximadamente

## 🎓 Autor

**Johan Eduardo Cala Torra**  
Máster en Ingeniería Informática  
Universidad de Almería  
Curso 2024-2025

