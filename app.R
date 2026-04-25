library(shiny)
library(plotly)
library(dplyr)

# ===== DATA =====
data <- read.csv("Churn_Modelling.csv")

# ===== UI =====
ui <- fluidPage(
  
  tags$head(
    tags$style(HTML("
      body { background-color: #0f172a; color: white; }
      .card { background-color: #1e293b; border-radius: 12px; padding: 20px; margin-bottom:20px; }
      .insight-banner {
        background: rgba(30, 41, 59, 0.6);
        border-left: 4px solid #f43f5e;
        padding: 20px;
        border-radius: 8px;
        margin-bottom: 25px;
        font-size: 16px;
        line-height: 1.6;
      }
      .campaign-card {
        background: rgba(30, 41, 59, 0.4);
        border: 1px solid rgba(255, 255, 255, 0.05);
        border-radius: 16px;
        padding: 24px;
        box-shadow: 0 4px 6px -1px rgba(0,0,0,0.1);
        margin-bottom: 20px;
      }
      .campaign-icon {
        font-size: 40px;
        margin-bottom: 15px;
      }
      .campaign-target {
        background: rgba(16, 185, 129, 0.1);
        color: #34d399;
        padding: 8px 12px;
        border-radius: 8px;
        font-size: 14px;
        border-left: 3px solid #10b981;
        margin-bottom: 15px;
      }
      /* Estilo oscuro para selectInputs de Shiny */
      .selectize-input { background-color: #1e293b !important; color: white !important; border: 1px solid #334155 !important; }
      .selectize-dropdown { background-color: #1e293b !important; color: white !important; border: 1px solid #334155 !important; }
      .selectize-dropdown .active { background-color: #334155 !important; }
    "))
  ),
  
  titlePanel(HTML("<strong>Dashboard de Churn Bancario</strong><br><small style='font-size:18px; color:#cbd5e1;'>Obrian Sanchez y Andres Cardoso</small>")),
  
  # ===== PORTADA (CONTEXTO GENERAL) =====
  fluidRow(
    column(12,
           div(style="background: rgba(30, 41, 59, 0.6); border-left: 4px solid #3b82f6; padding: 20px; border-radius: 8px; margin-bottom: 25px;",
               h3("📖 Contexto del Proyecto", style="margin-top:0; color:#60a5fa;"),
               p(HTML("<strong>Dataset:</strong> Análisis de 10,000 perfiles de clientes ubicados en Francia, España y Alemania.<br>
                      <strong>Objetivo Principal:</strong> Implementar una campaña de retención efectiva identificando los segmentos de mayor riesgo a través del análisis de datos (Data-Driven)."))
           )
    )
  ),

  # ===== PRIMERA FILA =====
  fluidRow(
    
    column(4,
           div(class="card",
               
               h4("Permanecen", style="color:#10b981"),
               textOutput("stay"),
               
               br(),
               
               h4("Abandonan", style="color:#f43f5e"),
               textOutput("exit")
           )
    ),
    
    column(8,
           div(class="card",
               plotlyOutput("donut", height = "400px")
           )
    )
  ),
  
  fluidRow(
    column(12,
           div(class="insight-banner",
               h4("📉 Tasa de Abandono Global", style="margin-top:0; color:#f43f5e;"),
               htmlOutput("analysis")
           )
    )
  ),
  
  # ===== SEGUNDA FILA =====
  fluidRow(
    column(12,
           div(class="card",
               
               h3("Tasa de Churn por País"),
               
               plotlyOutput("bar_churn")
           )
    )
  ),
  
  fluidRow(
    column(12,
           div(class="insight-banner",
               h4("🌍 Impacto Geográfico", style="margin-top:0; color:#f43f5e;"),
               htmlOutput("analysis_geo")
           )
    )
  ),
  
  # ===== TERCERA FILA =====
  fluidRow(
    column(12,
           div(class="card",
               
               h3("Tasa de Churn por Rango de Edad"),
               
               fluidRow(
                 column(4, 
                        selectInput("age_filter", "Filtrar por País:",
                                    choices = c("Todos los Países", "France", "Spain", "Germany"))
                 )
               ),
               
               plotlyOutput("age_plot", height = "500px")
           )
    )
  ),

  fluidRow(
    column(12,
           div(class="insight-banner",
               h4("👥 Impacto Demográfico", style="margin-top:0; color:#f43f5e;"),
               htmlOutput("analysis_age")
           )
    )
  ),

  # ===== CUARTA FILA =====
  fluidRow(
    column(12,
           div(class="card",

               h3("Tasa de Churn por Perfil Financiero"),

               fluidRow(
                 column(4, 
                        selectInput("heat_filter", "Filtrar por País:",
                                    choices = c("Todos los Países", "France", "Spain", "Germany"))
                 )
               ),

               plotlyOutput("heatmap", height = "500px")
           )
    )
  ),

  fluidRow(
    column(12,
           div(class="insight-banner",
               h4("💰 Impacto Económico", style="margin-top:0; color:#f43f5e;"),
               htmlOutput("analysis_heat")
           )
    )
  ),

  # ===== QUINTA FILA =====
  fluidRow(
    column(12,
           div(class="card",

               h3("Tasa de Churn según Años de Tenencia"),

               fluidRow(
                 column(4, 
                        selectInput("tenure_filter", "Filtrar por País:",
                                    choices = c("Todos los Países", "France", "Spain", "Germany"))
                 )
               ),

               plotlyOutput("line_churn", height = "500px")
           )
    )
  ),

  fluidRow(
    column(12,
           div(class="insight-banner",
               h4("⏳ Ciclo de Vida del Cliente", style="margin-top:0; color:#f43f5e;"),
               htmlOutput("analysis_tenure")
           )
    )
  ),

  # ===== SEXTA FILA: CONCLUSIÓN ESTRATÉGICA =====
  fluidRow(
    column(12,
           div(style = "padding: 20px;",
               h2("💡 Conclusión Estratégica"),
               p(HTML("<strong>Síntesis del Proyecto:</strong> En base al análisis visual realizado, hemos cruzado Geografía, Edad, Perfil Financiero y Tenencia.<br>
                      <strong>Plan de Acción:</strong> A continuación se proponen 3 campañas de retención fundamentadas en datos (Data-Driven) para mitigar el Churn.")),
               br(),
               fluidRow(
                 column(4,
                        div(class="campaign-card",
                            div(class="campaign-icon", "🛡️"),
                            h3("Campaña 1: Onboarding Seguro", style="margin-top:0;"),
                            div(class="campaign-target", strong("Público Objetivo: Nuevos clientes (Año 0)")),
                            p("Nuestra gráfica de Tenencia demostró un pico drástico de abandono en el primer año. Se propone un programa de acompañamiento y eliminación de cobros durante los primeros 12 meses.", style="color:#94a3b8;")
                        )
                 ),
                 column(4,
                        div(class="campaign-card",
                            div(class="campaign-icon", "🎯"),
                            h3("Campaña 2: Fidelización Senior", style="margin-top:0;"),
                            div(class="campaign-target", strong("Público Objetivo: 40 a 55 años, Alemanes")),
                            p("El cruce de Edad y Geografía reveló que los adultos maduros alemanes son los más propensos a irse. Proponemos ofrecer productos de inversión con tasas preferenciales o seguros.", style="color:#94a3b8;")
                        )
                 ),
                 column(4,
                        div(class="campaign-card",
                            div(class="campaign-icon", "💳"),
                            h3("Campaña 3: Alivio Financiero", style="margin-top:0;"),
                            div(class="campaign-target", strong("Público Objetivo: Score Crediticio Bajo (300-500)")),
                            p("El mapa de calor confirmó que el bajo puntaje impulsa el abandono sin importar el salario. Implementaremos un plan reestructurando sus deudas para evitar la fuga a la competencia.", style="color:#94a3b8;")
                        )
                 )
               )
           )
    )
  )
)

# ===== SERVER =====
server <- function(input, output) {
  
  # ===== KPI =====
  total <- nrow(data)
  stay <- sum(data$Exited == 0)
  exit <- sum(data$Exited == 1)
  
  df <- data.frame(
    name = c("Permanecen", "Abandonan"),
    value = c(stay, exit)
  )
  
  output$stay <- renderText({
    paste0(format(stay, big.mark=".")," = ",round(stay/total*100,1),"%")
  })
  
  output$exit <- renderText({
    paste0(format(exit, big.mark=".")," = ",round(exit/total*100,1),"%")
  })
  
  output$analysis <- renderUI({
    HTML(paste0("El <strong>", round(exit/total*100,1), "%</strong> de los clientes ha abandonado el banco. Esta fuga representa una pérdida crítica de capital, estableciendo la necesidad urgente de estrategias de retención."))
  })
  
  # ===== DONUT =====
  output$donut <- renderPlotly({
    
    plot_ly(
      data = df,
      labels = ~name,
      values = ~value,
      type = "pie",
      hole = 0.6,
      textinfo = "none",
      marker = list(colors = c("#10b981", "#f43f5e"))
    ) %>%
      
      layout(
        paper_bgcolor = "#0f172a",
        plot_bgcolor = "#0f172a",
        font = list(color = "white"),
        showlegend = TRUE,
        annotations = list(
          list(
            text = paste0("<b>", format(total, big.mark="."), "</b><br>Total Clientes"),
            x = 0.5,
            y = 0.5,
            showarrow = FALSE
          )
        )
      )
  })
  
  # ===== GEO =====
  geo <- data %>%
    group_by(Geography) %>%
    summarise(
      total = n(),
      exited = sum(Exited == 1),
      rate = exited / total
    ) %>%
    arrange(desc(rate))
  
  geo$label_txt <- paste0(round(geo$rate * 100, 1), "%")
  
  geo$risk <- ifelse(geo$rate > 0.25, "Riesgo Alto (>25%)",
                     ifelse(geo$rate >= 0.15, "Riesgo Medio (15-25%)", "Riesgo Bajo (<15%)"))
  
  output$analysis_geo <- renderUI({
    HTML("Alemania presenta la tasa de abandono más alta (32.4%), duplicando a Francia y España. Identificar el país con mayor tasa de fuga nos permite priorizar la asignación de recursos y localizar la campaña de retención.")
  })
  
  output$bar_churn <- renderPlotly({
    
    p <- plot_ly()
    
    data_alto <- geo %>% filter(risk == "Riesgo Alto (>25%)")
    p <- p %>% add_trace(
      data = data_alto,
      x = ~Geography,
      y = ~rate,
      type = "bar",
      name = "Riesgo Alto (>25%)",
      marker = list(color = "#f43f5e"),
      text = ~label_txt,
      textposition = "outside"
    )
    
    data_medio <- geo %>% filter(risk == "Riesgo Medio (15-25%)")
    p <- p %>% add_trace(
      data = data_medio,
      x = ~Geography,
      y = ~rate,
      type = "bar",
      name = "Riesgo Medio (15-25%)",
      marker = list(color = "#f59e0b"),
      text = ~label_txt,
      textposition = "outside"
    )
    
    data_bajo <- geo %>% filter(risk == "Riesgo Bajo (<15%)")
    
    if(nrow(data_bajo) == 0){
      p <- p %>% add_trace(
        x = "",
        y = 0,
        type = "bar",
        name = "Riesgo Bajo (<15%)",
        marker = list(color = "#10b981"),
        showlegend = TRUE,
        hoverinfo = "none",
        opacity = 0
      )
    } else {
      p <- p %>% add_trace(
        data = data_bajo,
        x = ~Geography,
        y = ~rate,
        type = "bar",
        name = "Riesgo Bajo (<15%)",
        marker = list(color = "#10b981"),
        text = ~label_txt,
        textposition = "outside"
      )
    }
    
    p %>% layout(
      paper_bgcolor = "#0f172a",
      plot_bgcolor = "#0f172a",
      font = list(color = "white"),
      
      yaxis = list(
        title = "Tasa Relativa de Abandono (Churn %)",
        tickformat = ".0%",
        range = c(0, 0.4)
      ),
      
      xaxis = list(title = "Países"),
      
      legend = list(x = 1, y = 1)
    )
  })
  
  # ===== EDAD =====
  filtered_age_data <- reactive({
    req(input$age_filter)
    if(input$age_filter == "Todos los Países") {
      data
    } else {
      data %>% filter(Geography == input$age_filter)
    }
  })
  
  output$analysis_age <- renderUI({
    req(input$age_filter)
    country_label <- if(input$age_filter == "Todos los Países") "a nivel global" else paste0("en ", ifelse(input$age_filter == "France", "Francia", ifelse(input$age_filter == "Spain", "España", "Alemania")))
    HTML(paste0("Los clientes entre 40 y 55 años <strong>", country_label, "</strong> presentan la mayor tasa de abandono. Determinar qué generaciones son más vulnerables nos permite personalizar el mensaje y los incentivos de la campaña."))
  })
  
  age_df_reactive <- reactive({
    data_age <- filtered_age_data()
    data_age$bin_min <- floor(data_age$Age / 2) * 2
    data_age$bin_max <- data_age$bin_min + 2
    
    df_res <- data_age %>%
    group_by(bin_min, bin_max) %>%
    summarise(
      total = n(),
      exited = sum(Exited == 1),
      stay = total - exited,
      rate = exited / total
    ) %>%
    filter(total > 20)
    
    df_res$x <- (df_res$bin_min + df_res$bin_max) / 2
    df_res
  })
  
  output$age_plot <- renderPlotly({
    
    age_df <- age_df_reactive()
    
    age_df$tooltip <- paste0(
      "Rango Etario: ", age_df$bin_min, " - ", age_df$bin_max, " años<br>",
      "Tasa Churn: ", round(age_df$rate*100,1), "%<br>",
      "Permanecen: ", age_df$stay, "<br>",
      "Abandonan: ", age_df$exited, "<br>",
      "Total: ", age_df$total
    )

    plot_ly() %>%
      
      add_bars(
        data = age_df,
        x = ~x,
        y = ~1,
        name = "Permanecen",
        marker = list(color = "#10b981"),
        opacity = 0.15,
        hoverinfo = "none"
      ) %>%
      
      add_bars(
        data = age_df,
        x = ~x,
        y = ~rate,
        name = "Abandonan (% Churn)",
        marker = list(color = "#f43f5e"),
        hovertext = ~tooltip,
        hoverinfo = "text"
      ) %>%
      
      layout(
        barmode = "overlay",
        paper_bgcolor = "#0f172a",
        plot_bgcolor = "#0f172a",
        font = list(color = "white"),
        
        xaxis = list(
          title = "Edad del Cliente (Años)",
          tickvals = c(20,30,40,50,55,60,70,80)
        ),
        
        yaxis = list(
          title = "Tasa de Churn (%)",
          tickformat = ".0%",
          range = c(0,1)
        ),
        
        shapes = list(
          list(
            type = "rect",
            x0 = 40,
            x1 = 55,
            y0 = 0,
            y1 = 1,
            fillcolor = "rgba(244,63,94,0.08)",
            line = list(color = "#f43f5e", dash = "dash")
          )
        ),
        
        annotations = list(
          list(
            x = 47.5,
            y = 1.00,
            text = "Zona de Alto Riesgo (40-55)",
            showarrow = FALSE,
            font = list(color = "#f43f5e", size = 16),
            xanchor = "center",
            yanchor = "bottom"
          )
        )
      )
  })

  # ===== HEATMAP: CHURN POR PERFIL FINANCIERO =====

  filtered_heat_data <- reactive({
    req(input$heat_filter)
    if(input$heat_filter == "Todos los Países") {
      data
    } else {
      data %>% filter(Geography == input$heat_filter)
    }
  })
  
  # --- Texto de análisis ---
  output$analysis_heat <- renderUI({
    req(input$heat_filter)
    country_label <- if(input$heat_filter == "Todos los Países") "a nivel global" else paste0("en ", ifelse(input$heat_filter == "France", "Francia", ifelse(input$heat_filter == "Spain", "España", "Alemania")))
    HTML(paste0("El churn <strong>", country_label, "</strong> se concentra en los clientes con Bajo Score Crediticio (300-500), sin importar su nivel de ingresos. Revelar los cuadrantes de alto riesgo nos permite crear ofertas económicas específicas."))
  })

  heat_reactive <- reactive({
    data_heat <- filtered_heat_data()
    
    # --- Terciles de salario ---
    q1_sal <- quantile(data_heat$EstimatedSalary, 1/3)
    q2_sal <- quantile(data_heat$EstimatedSalary, 2/3)

    data_heat$sal_group <- ifelse(data_heat$EstimatedSalary <= q1_sal, "Bajo",
                                  ifelse(data_heat$EstimatedSalary <= q2_sal, "Medio", "Alto"))

    # --- Grupos de score crediticio ---
    data_heat$score_group <- ifelse(data_heat$CreditScore < 500, "Bajo (300-500)",
                                    ifelse(data_heat$CreditScore <= 700, "Medio (500-700)", "Alto (700-850)"))

    # --- Tabla agregada ---
    heat <- data_heat %>%
    group_by(score_group, sal_group) %>%
    summarise(
      total   = n(),
      exited  = sum(Exited == 1),
      rate    = exited / total,
      .groups = "drop"
    )

  # --- Clasificación de riesgo ---
  heat$risk  <- ifelse(heat$rate >= 0.25, "Alto",
                       ifelse(heat$rate >= 0.18, "Medio", "Bajo"))

  heat$color <- ifelse(heat$risk == "Alto",  "#f43f5e",
                       ifelse(heat$risk == "Medio", "#f59e0b", "#10b981"))

  # --- Orden de factores ---
  heat$score_group <- factor(heat$score_group,
                             levels = c("Bajo (300-500)", "Medio (500-700)", "Alto (700-850)"))

  heat$sal_group <- factor(heat$sal_group,
                           levels = c("Bajo", "Medio", "Alto"),
                           labels = c(paste0("Bajo (< $", round(q1_sal/1000), "k)"), 
                                      paste0("Medio ($", round(q1_sal/1000), "k - $", round(q2_sal/1000), "k)"), 
                                      paste0("Alto (> $", round(q2_sal/1000), "k)")))
    heat
  })

  # --- Gráfica ---
  output$heatmap <- renderPlotly({

    heat_plot <- heat_reactive()
    # Los factores ya vienen configurados dinámicamente de heat_reactive()

    p <- plot_ly()

    # Cuadros del heatmap
    # Obtener etiquetas dinámicas para el orden
    sal_labels <- levels(heat_plot$sal_group)
    
    p <- p %>% add_trace(
      data         = heat_plot,
      x            = ~sal_group,
      y            = ~score_group,
      type         = "scatter",
      mode         = "markers+text",
      marker       = list(size = 140, symbol = "square", color = heat_plot$color),
      text         = ~paste0(round(rate * 100, 1), "%"),
      textfont     = list(size = 20, color = "white"),
      hoverinfo    = "text",
      textposition = "middle center",
      hovertext    = ~paste0(
        "<b>", score_group, "</b><br>",
        "Salario: ", sal_group, "<br>",
        "Churn: ", round(rate * 100, 1), "%"
      ),
      showlegend = FALSE
    )

    # Leyenda de colores
    p <- p %>%
      add_trace(
        x = sal_labels[1], y = "Bajo (300-500)",
        type = "scatter", mode = "markers",
        marker = list(size = 12, color = "#f43f5e"),
        name = "Alto Riesgo (>25%)",
        showlegend = TRUE, hoverinfo = "none", visible = "legendonly"
      ) %>%
      add_trace(
        x = sal_labels[1], y = "Medio (500-700)",
        type = "scatter", mode = "markers",
        marker = list(size = 12, color = "#f59e0b"),
        name = "Medio Riesgo (18-25%)",
        showlegend = TRUE, hoverinfo = "none", visible = "legendonly"
      ) %>%
      add_trace(
        x = sal_labels[1], y = "Alto (700-850)",
        type = "scatter", mode = "markers",
        marker = list(size = 12, color = "#10b981"),
        name = "Riesgo Saludable (<18%)",
        showlegend = TRUE, hoverinfo = "none", visible = "legendonly"
      )

    p %>% layout(
      paper_bgcolor = "#0f172a",
      plot_bgcolor  = "#0f172a",
      font          = list(color = "white"),
      xaxis = list(
        title         = "Nivel de Salario",
        categoryorder = "array",
        categoryarray = sal_labels
      ),
      yaxis = list(
        title         = "Nivel de Score Crediticio",
        categoryorder = "array",
        categoryarray = c("Bajo (300-500)", "Medio (500-700)", "Alto (700-850)")
      ),
      legend = list(orientation = "v", x = 1, y = 1)
    )
  })

  # ===== TENENCIA: CHURN POR AÑOS DE TENENCIA =====

  filtered_tenure_data <- reactive({
    req(input$tenure_filter)
    if(input$tenure_filter == "Todos los Países") {
      data
    } else {
      data %>% filter(Geography == input$tenure_filter)
    }
  })

  # --- Texto de análisis ---
  output$analysis_tenure <- renderUI({
    req(input$tenure_filter)
    country_label <- if(input$tenure_filter == "Todos los Países") "a nivel global" else paste0("en ", ifelse(input$tenure_filter == "France", "Francia", ifelse(input$tenure_filter == "Spain", "España", "Alemania")))
    HTML(paste0("El abandono <strong>", country_label, "</strong> es drástico en el Año Cero, indicando un fallo en el Onboarding. Posteriormente la tasa desciende demostrando estabilidad, solo para volver a fracturarse tras 8 años. Esto dicta exactamente en qué año de vida lanzar la campaña."))
  })
  
  tenure_reactive <- reactive({
    data_ten <- filtered_tenure_data()
    # --- Cálculo agregado ---
    tenure_df <- data_ten %>%
      group_by(Tenure) %>%
      summarise(
        total  = n(),
        exited = sum(Exited == 1),
        rate   = exited / total
      ) %>%
      arrange(Tenure)

    # --- Promedio global ---
    global_rate <- mean(data_ten$Exited)

    # --- Color por punto ---
    tenure_df$color <- ifelse(
      tenure_df$rate > global_rate + 0.005, "#f43f5e",
      ifelse(tenure_df$rate < global_rate - 0.005, "#10b981", "#f59e0b")
    )
    
    list(df = tenure_df, g_rate = global_rate)
  })

  # --- Gráfica ---
  output$line_churn <- renderPlotly({

    ten_data <- tenure_reactive()
    tenure_df <- ten_data$df
    global_rate <- ten_data$g_rate

    plot_ly(
      tenure_df,
      x    = ~Tenure,
      y    = ~rate,
      type = "scatter",
      mode = "lines+markers",

      line = list(
        color = "rgba(99,102,241,0.6)",
        width = 4,
        shape = "spline"
      ),

      marker = list(
        size  = 10,
        color = tenure_df$color,
        line  = list(color = "#0f172a", width = 2)
      ),

      text = ~paste0(
        "Tenencia: ", Tenure, " años<br>",
        "Churn: ",    round(rate * 100, 1), "%<br>",
        "Clientes: ", total, "<br>",
        "Abandono: ", exited
      ),

      hoverinfo = "text"
    ) %>%

      layout(
        paper_bgcolor = "#0f172a",
        plot_bgcolor  = "#0f172a",
        font          = list(color = "white"),

        xaxis = list(
          title = "Años de Tenencia en el Banco",
          dtick = 1
        ),

        yaxis = list(
          title      = "Tasa de Abandono (Churn %)",
          tickformat = ".0%",
          range      = c(
            min(tenure_df$rate) * 0.85,
            max(tenure_df$rate) * 1.15
          )
        ),

        # Línea de promedio base
        shapes = list(
          list(
            type = "line",
            x0   = min(tenure_df$Tenure),
            x1   = max(tenure_df$Tenure),
            y0   = global_rate,
            y1   = global_rate,
            line = list(dash = "dash", color = "#94a3b8", width = 2)
          )
        ),

        # Anotaciones
        annotations = list(

          # Promedio base
          list(
            x       = max(tenure_df$Tenure),
            y       = global_rate,
            text    = paste0("Promedio Base (", round(global_rate * 100, 1), "%)"),
            showarrow = FALSE,
            xanchor = "right",
            yanchor = "bottom",
            font    = list(color = "#94a3b8", size = 14)
          ),

          # Riesgo de Onboarding
          list(
            x          = 0,
            y          = tenure_df$rate[1],
            text       = "Riesgo de Onboarding",
            showarrow  = TRUE,
            arrowcolor = "#f43f5e",
            font       = list(color = "#f43f5e")
          ),

          # Zona estable
          list(
            x          = 5,
            y          = tenure_df$rate[6],
            text       = "Zona Estable",
            showarrow  = TRUE,
            arrowcolor = "#10b981",
            font       = list(color = "#10b981")
          ),

          # Riesgo tardío
          list(
            x          = 9,
            y          = tenure_df$rate[10],
            text       = "Riesgo Tardío",
            showarrow  = TRUE,
            arrowcolor = "#f43f5e",
            font       = list(color = "#f43f5e")
          )
        )
      )
  })
}

shinyApp(ui, server)