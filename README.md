# Dashboard Premium Analítico de Churn (R / Shiny)

Un dashboard interactivo y reactivo construido con **R** y **Shiny**, enfocado en el análisis de retención de clientes bancarios. Este proyecto demuestra que Shiny no solo sirve para aplicaciones académicas, sino que puede presentar interfaces estéticas de nivel ejecutivo (Premium/Glassmorphism) con **reactividad en tiempo real** utilizando el ecosistema `tidyverse`.

## 🛠️ Tecnologías Empleadas

- **Shiny:** Framework de R para construir aplicaciones web interactivas mediante el patrón UI/Server.
- **Plotly (R):** Integración nativa de `plotly` en R para renderizar las gráficas vectoriales interactivas con tooltips asíncronos y zoom.
- **dplyr (Tidyverse):** Motor analítico para manipulación de datos, utilizado en expresiones `reactive({...})` para filtrar (`filter`), agrupar (`group_by`) y resumir (`summarise`) los datos al instante según las selecciones del usuario.
- **HTML/CSS Nativo:** Estilización personalizada mediante inyección de `tags$style` y clases CSS customizadas (Glassmorphism, Grid Layout) para escapar del diseño convencional de Bootstrap que Shiny usa por defecto.

## 🚀 Cómo Ejecutar Localmente

1. Asegúrate de tener **R** y **RStudio** instalados en tu computadora.
2. Abre RStudio e instala los paquetes necesarios ejecutando en la consola:
   ```R
   install.packages(c("shiny", "plotly", "dplyr"))
   ```
3. Abre el archivo `app.R` ubicado en esta carpeta.
4. Haz clic en el botón **"Run App"** en la barra superior del editor de RStudio (o ejecuta `shiny::runApp()` en la consola).
5. Se abrirá una ventana interactiva (puedes hacer clic en "Open in Browser" para verlo a pantalla completa).

---

## 📊 Arquitectura de Visualizaciones (Analíticas)

La interfaz utiliza el modelo reactivo de Shiny (`selectInput` y `reactive`) para filtrar dinámicamente los países y reconstruir la narrativa y gráficas instantáneamente:

### 1. Resumen Global (Donut Chart KPI)
- **Visualización:** Gráfico de anillo interactivo con panel lateral de indicadores KPI de clientes que permanecen y que abandonan.
- **Objetivo:** Establecer la tasa base de abandono (20.4%) del corporativo como el punto crítico de referencia. Incluye un *Banner de Impacto* introductorio.

### 2. Tasa de Churn por País (Bar Chart Semaforizado)
- **Visualización:** Barras ordenadas por urgencia con colorimetría semafórica.
- **Objetivo:** Exponer disparidades regionales brutales que justifican enfocar campañas de retención en mercados de altísimo riesgo como el alemán.

### 3. Tasa de Churn por Rango de Edad (Histograma Interactivo)
- **Visualización:** Histograma interactivo con `selectInput` de país. Área focalizada remarcando el tramo crítico (40-55 años).
- **Objetivo:** Quebrar el mito del volumen y focalizar la demografía específica para personalizar incentivos, ajustando el análisis al país seleccionado en tiempo real.

### 4. Perfil Financiero (Heatmap de Riesgo 3×3)
- **Visualización:** Matriz cruzando nivel de salario (terciles calculados en R) y score crediticio.
- **Objetivo:** Demostrar que el factor destructor absoluto es puramente crediticio, sin importar su ingreso (las métricas y leyendas se recalculan dinámicamente al cambiar de país).

### 5. Tenencia Evolutiva (Time-Series con Reactividad)
- **Visualización:** Línea spline suavizada con marcadores que cambian de color si superan el promedio reactivo (`global_rate`).
- **Objetivo:** Radiografiar el ciclo de vida del cliente, señalando la "Falla de Onboarding" inicial y el riesgo tardío.

### 6. Conclusión Estratégica (Accionabilidad Data-Driven)
- **Visualización:** Diseño en Grid de 3 columnas (UI inyectada en HTML) con diseño oscuro de tarjetas de campaña.
- **Objetivo:** Transformar los datos en 3 planes de acción directos: *Onboarding Seguro*, *Fidelización Senior* y *Alivio Financiero*.

---

## 📁 Estructura del Proyecto

```
graficas_churn/
├── app.R                  # Aplicación Shiny (UI, CSS, Lógica Reactiva y Renderizado Plotly)
├── Churn_Modelling.csv    # Dataset fuente (10,000 registros)
└── README.md              # Documentación
```
