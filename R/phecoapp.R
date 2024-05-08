#' interactive table of all ICD10 codes in PheCode map
#' @rawNamespace import(shiny, except=c(renderDataTable, dataTableOutput))
#' @import DT
#' @export
phecotab = function() {
 data("phe.icd10", package="phecopack")
 DT::datatable(phe.icd10[, c("ICD10", "ICD10.String",
   "Phenotype", "PheCode")])
}

#' app for exploring mappings
#' @note Work in progress.  Intent was to allow a 
#' number of regexps to generate tables in tabs.
#' Currently just one table shown for one ICD10.String value.
phecoapp = function() {
 data("phe.icd10", package="phecopack")
 ui = fluidPage(
  sidebarLayout(
   sidebarPanel(
    helpText("select ICD10.Strings"),
    selectInput("conds", "conds", choices=
     sort(unique(phe.icd10$ICD10.String)))
    ),
   mainPanel(
    uiOutput("tabs")
    )
   )
  )
server = function(input, output) {
  gettabs = reactive({
   get_icd10(input$conds)
  })
  output$t1 = DT::renderDT({
   tt = gettabs()
   tt[[1]]
   })
  output$tabs = renderUI({
   tbs = gettabs()
   tn = input$conds
   tabsetPanel(
    tabPanel(tn[1], DT::dataTableOutput("t1"))
    )
   })
  }
 shiny::runApp(list(ui=ui, server=server))
}
